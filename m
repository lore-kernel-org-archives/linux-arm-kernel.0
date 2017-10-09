From: longman@redhat.com (Waiman Long)
Date: Mon, 9 Oct 2017 17:19:46 -0400
Subject: [PATCH v2 0/5] Switch arm64 over to qrwlock
In-Reply-To: <1507296882-18721-1-git-send-email-will.deacon@arm.com>
References: <1507296882-18721-1-git-send-email-will.deacon@arm.com>
Message-ID: <955771a8-3c72-e816-c080-f9ffec18f049@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/06/2017 09:34 AM, Will Deacon wrote:
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
I had done some performance test of your patch on a 1 socket Cavium
CN8880 system with 32 cores. I used my locking stress test which
produced the following results with 16 locking threads at various mixes
of reader & writer threads on 4.14-rc4 based kernels. The numbers are
the minimum/average/maximum locking operations done per locking threads
in a 10 seconds period. A minimum number of 1 means there is at least 1
thread that cannot acquire the lock during the test period.

                w/o qrwlock patch               with qrwlock patch
                -----------------               ------------------
16 readers   793,024/1,169,763/1,684,751  1,060,127/1,198,583/1,331,003
        
12 readers 1,162,760/1,641,714/2,162,939  1,685,334/2,099,088/2,338,461
 4 writers         1/        1/        1     25,540/  195,975/  392,232
 
 8 readers 2,135,670/2,391,612/2,737,564  2,985,686/3,359,048/3,870,423
 8 writers         1/   19,867/   88,173    119,078/  559,604/1,112,769
 
 4 readers 1,194,917/1,250,876/1,299,304  3,611,059/4,653,775/6,268,370
12 writers   176,156/1,088,513/2,594,534      7,664/  795,393/1,841,961

16 writers    35,007/1,094,608/1,954,457  1,618,915/1,633,077/1,645,637

It can be seen that qrwlock performed much better than the original rwlock
implementation.

Tested-by: Waiman Long <longman@redhat.com>

Cheers,
Longman
