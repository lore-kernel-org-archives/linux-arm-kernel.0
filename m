From: jeremy.linton@arm.com (Jeremy Linton)
Date: Mon, 9 Oct 2017 17:31:27 -0500
Subject: [PATCH v2 0/5] Switch arm64 over to qrwlock
In-Reply-To: <1507296882-18721-1-git-send-email-will.deacon@arm.com>
References: <1507296882-18721-1-git-send-email-will.deacon@arm.com>
Message-ID: <8f3a78b0-2eb5-98a8-f7f4-95bc700d9167@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 10/06/2017 08:34 AM, Will Deacon wrote:
> Hi all,
> 
> This is version two of the patches I posted yesterday:
> 
>    http://lists.infradead.org/pipermail/linux-arm-kernel/2017-October/534666.html
> 
> I'd normally leave it longer before posting again, but Peter had a good
> suggestion to rework the layout of the lock word, so I wanted to post a
> version that follows that approach.
> 
> I've updated my branch if you're after the full patch stack:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git qrwlock
> 
> As before, all comments (particularly related to testing and performance)
> welcome!

I've been doing perf comparisons with the rwlock fairness patch I posted 
last week on a single socket thunderx and the baseline rwlock. For most 
cases where the ratio of read/writers is similar (uncontended 
readers/writers, single writer/lots readers, etc) the absolute number of 
lock acquisitions is very similar (within a few percent one way or the 
other).

In this regard both patches are light years ahead of the current arm64 
rwlock. The unfairness of the current rwlock allows significantly higher 
lock acquisition counts (say 4x at 30Readers:1Writer) at the expense of 
complete writer starvation (or a ~43k:1 ratio at a 30R:1W per 
locktorture). This is untenable.

The qrwlock does an excellent job of maintaining the ratio of 
reader/writer acquisitions proportional to the number of readers/writers 
until the total lockers exceeds the number of cores where the ratios 
start to far exceed the reader/writer ratios (440:1 acquisitions @ 96R:1W)

In comparison the other patch tends to favor the writers more, so at a 
ratio of 48R/1W, the readers are only grabbing the lock at a ratio of 
15:1. This flatter curve continues past the number of cores with the 
readers having a 48:1 advantage with 96R/1W. That said the total lock 
acquisition counts remain very similar (with maybe a slight advantage to 
the non queued patch with 1 writer and 12-30 readers) despite the writer 
acquiring the lock at a higher frequency. OTOH, if the number of writers 
is closer to the number of readers (24R:24W) then the writers have about 
a 1.5X bias over the readers independent of the number of 
reader/writers. This bias seems to be the common multiplier given a 
reader/writer ratio with those patches and doesn't account for possible 
single thread starvation.

Of course, I've been running other tests as well and the system seems to 
be behaving as expected (likely better than the rwlock patches under 
stress). I will continue to test this on a couple other platforms.

In the meantime:

Tested-by: Jeremy Linton <jeremy.linton@arm.com>


> 
> Cheers,
> 
> Will
> 
> --->8
> 
> Will Deacon (5):
>    kernel/locking: Use struct qrwlock instead of struct __qrwlock
>    locking/atomic: Add atomic_cond_read_acquire
>    kernel/locking: Use atomic_cond_read_acquire when spinning in qrwlock
>    arm64: locking: Move rwlock implementation over to qrwlocks
>    kernel/locking: Prevent slowpath writers getting held up by fastpath
> 
>   arch/arm64/Kconfig                      |  17 ++++
>   arch/arm64/include/asm/Kbuild           |   1 +
>   arch/arm64/include/asm/spinlock.h       | 164 +-------------------------------
>   arch/arm64/include/asm/spinlock_types.h |   6 +-
>   include/asm-generic/atomic-long.h       |   3 +
>   include/asm-generic/qrwlock.h           |  20 +---
>   include/asm-generic/qrwlock_types.h     |  15 ++-
>   include/linux/atomic.h                  |   4 +
>   kernel/locking/qrwlock.c                |  83 +++-------------
>   9 files changed, 58 insertions(+), 255 deletions(-)
> 
