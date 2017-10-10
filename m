From: awallis@codeaurora.org (Adam Wallis)
Date: Tue, 10 Oct 2017 14:20:34 -0400
Subject: [PATCH v2 0/5] Switch arm64 over to qrwlock
In-Reply-To: <1507296882-18721-1-git-send-email-will.deacon@arm.com>
References: <1507296882-18721-1-git-send-email-will.deacon@arm.com>
Message-ID: <0cd29dfc-aba7-6455-f12e-b6443826c1f8@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/6/2017 9:34 AM, Will Deacon wrote:
> Hi all,
> 
> This is version two of the patches I posted yesterday:
> 
>   http://lists.infradead.org/pipermail/linux-arm-kernel/2017-October/534666.html
> 
> I'd normally leave it longer before posting again, but Peter had a good
> suggestion to rework the layout of the lock word, so I wanted to post a
> version that follows that approach.
> 
> I've updated my branch if you're after the full patch stack:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git qrwlock
> 
> As before, all comments (particularly related to testing and performance)
> welcome!
> 
> Cheers,
> 
> Will
> 
> --->8
> 
> Will Deacon (5):
>   kernel/locking: Use struct qrwlock instead of struct __qrwlock
>   locking/atomic: Add atomic_cond_read_acquire
>   kernel/locking: Use atomic_cond_read_acquire when spinning in qrwlock
>   arm64: locking: Move rwlock implementation over to qrwlocks
>   kernel/locking: Prevent slowpath writers getting held up by fastpath
> 
>  arch/arm64/Kconfig                      |  17 ++++
>  arch/arm64/include/asm/Kbuild           |   1 +
>  arch/arm64/include/asm/spinlock.h       | 164 +-------------------------------
>  arch/arm64/include/asm/spinlock_types.h |   6 +-
>  include/asm-generic/atomic-long.h       |   3 +
>  include/asm-generic/qrwlock.h           |  20 +---
>  include/asm-generic/qrwlock_types.h     |  15 ++-
>  include/linux/atomic.h                  |   4 +
>  kernel/locking/qrwlock.c                |  83 +++-------------
>  9 files changed, 58 insertions(+), 255 deletions(-)
> 

Applied on 4.14-rc4, I tested these patches with multiple combinations of
readers:writers . These patches help prevent writer starvation in every
combination that I tested. Without these patches, when the reader:writer ratio
is 2:1, it's trivial for me to see acquisitions of 250:1 (@ 2R:1W).

After applying the qrwlock patches, I see the acquisition ratios level out to
around ~1.6:1 (@ 2R:1W), which is quite an improvement.

Thanks Will!

Tested-by: Adam Wallis <awallis@codeaurora.org>

-- 
Adam Wallis
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
