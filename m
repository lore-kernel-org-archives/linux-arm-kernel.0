From: will.deacon@arm.com (Will Deacon)
Date: Thu,  5 Oct 2017 13:54:51 +0100
Subject: [PATCH 0/6] Switch arm64 over to qrwlock
Message-ID: <1507208097-825-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This patch series reworks bits of the qrwlock code that it can be used
to replace the asm rwlocks currently implemented for arm64. The structure
of the series is:

  Patches 1-3	: Work WFE into qrwlock using atomic_cond_read_acquire so
		  we can avoid busy-waiting.

  Patch 4	: Enable qrwlocks for arm64

  Patch 5-6	: Ensure writer slowpath fairness. This has a potential
		  performance impact on the writer unlock path, so I've
		  kept them at the end.

The patches apply on top of my other locking cleanups:

  http://lkml.kernel.org/r/1507055129-12300-1-git-send-email-will.deacon at arm.com

although the conflict with mainline is trivial to resolve without those.
The full stack is also pushed here:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git qrwlock

All comments (particularly related to testing and performance) welcome!

Cheers,

Will

--->8

Will Deacon (6):
  kernel/locking: Use struct qrwlock instead of struct __qrwlock
  locking/atomic: Add atomic_cond_read_acquire
  kernel/locking: Use atomic_cond_read_acquire when spinning in qrwlock
  arm64: locking: Move rwlock implementation over to qrwlocks
  kernel/locking: Prevent slowpath writers getting held up by fastpath
  kernel/locking: Remove unused union members from struct qrwlock

 arch/arm64/Kconfig                      |  17 ++++
 arch/arm64/include/asm/Kbuild           |   1 +
 arch/arm64/include/asm/spinlock.h       | 164 +-------------------------------
 arch/arm64/include/asm/spinlock_types.h |   6 +-
 include/asm-generic/atomic-long.h       |   3 +
 include/asm-generic/qrwlock.h           |  14 +--
 include/asm-generic/qrwlock_types.h     |   2 +-
 include/linux/atomic.h                  |   4 +
 kernel/locking/qrwlock.c                |  83 +++-------------
 9 files changed, 43 insertions(+), 251 deletions(-)

-- 
2.1.4
