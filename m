From: will.deacon@arm.com (Will Deacon)
Date: Thu, 26 Apr 2018 11:34:14 +0100
Subject: [PATCH v3 00/14] kernel/locking: qspinlock improvements
Message-ID: <1524738868-31318-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This is version three of the qspinlock patches I posted previously:

  v1: https://lkml.org/lkml/2018/4/5/496
  v2: https://lkml.org/lkml/2018/4/11/618

Changes since v2 include:
  * Fixed bisection issues
  * Fixed x86 PV build
  * Added patch proposing me as a co-maintainer
  * Rebased onto -rc2

All feedback welcome,

Will

--->8

Jason Low (1):
  locking/mcs: Use smp_cond_load_acquire() in mcs spin loop

Waiman Long (1):
  locking/qspinlock: Add stat tracking for pending vs slowpath

Will Deacon (12):
  barriers: Introduce smp_cond_load_relaxed and atomic_cond_read_relaxed
  locking/qspinlock: Merge struct __qspinlock into struct qspinlock
  locking/qspinlock: Bound spinning on pending->locked transition in
    slowpath
  locking/qspinlock/x86: Increase _Q_PENDING_LOOPS upper bound
  locking/qspinlock: Remove unbounded cmpxchg loop from locking slowpath
  locking/qspinlock: Kill cmpxchg loop when claiming lock from head of
    queue
  locking/qspinlock: Use atomic_cond_read_acquire
  locking/qspinlock: Use smp_cond_load_relaxed to wait for next node
  locking/qspinlock: Make queued_spin_unlock use smp_store_release
  locking/qspinlock: Elide back-to-back RELEASE operations with
    smp_wmb()
  locking/qspinlock: Use try_cmpxchg instead of cmpxchg when locking
  MAINTAINERS: Add myself as a co-maintainer for LOCKING PRIMITIVES

 MAINTAINERS                               |   1 +
 arch/x86/include/asm/qspinlock.h          |  21 ++-
 arch/x86/include/asm/qspinlock_paravirt.h |   3 +-
 include/asm-generic/atomic-long.h         |   2 +
 include/asm-generic/barrier.h             |  27 +++-
 include/asm-generic/qspinlock.h           |   2 +-
 include/asm-generic/qspinlock_types.h     |  32 +++-
 include/linux/atomic.h                    |   2 +
 kernel/locking/mcs_spinlock.h             |  10 +-
 kernel/locking/qspinlock.c                | 247 ++++++++++++++----------------
 kernel/locking/qspinlock_paravirt.h       |  44 ++----
 kernel/locking/qspinlock_stat.h           |   9 +-
 12 files changed, 209 insertions(+), 191 deletions(-)

-- 
2.1.4
