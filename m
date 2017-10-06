From: will.deacon@arm.com (Will Deacon)
Date: Fri,  6 Oct 2017 14:34:37 +0100
Subject: [PATCH v2 0/5] Switch arm64 over to qrwlock
Message-ID: <1507296882-18721-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This is version two of the patches I posted yesterday:

  http://lists.infradead.org/pipermail/linux-arm-kernel/2017-October/534666.html

I'd normally leave it longer before posting again, but Peter had a good
suggestion to rework the layout of the lock word, so I wanted to post a
version that follows that approach.

I've updated my branch if you're after the full patch stack:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git qrwlock

As before, all comments (particularly related to testing and performance)
welcome!

Cheers,

Will

--->8

Will Deacon (5):
  kernel/locking: Use struct qrwlock instead of struct __qrwlock
  locking/atomic: Add atomic_cond_read_acquire
  kernel/locking: Use atomic_cond_read_acquire when spinning in qrwlock
  arm64: locking: Move rwlock implementation over to qrwlocks
  kernel/locking: Prevent slowpath writers getting held up by fastpath

 arch/arm64/Kconfig                      |  17 ++++
 arch/arm64/include/asm/Kbuild           |   1 +
 arch/arm64/include/asm/spinlock.h       | 164 +-------------------------------
 arch/arm64/include/asm/spinlock_types.h |   6 +-
 include/asm-generic/atomic-long.h       |   3 +
 include/asm-generic/qrwlock.h           |  20 +---
 include/asm-generic/qrwlock_types.h     |  15 ++-
 include/linux/atomic.h                  |   4 +
 kernel/locking/qrwlock.c                |  83 +++-------------
 9 files changed, 58 insertions(+), 255 deletions(-)

-- 
2.1.4
