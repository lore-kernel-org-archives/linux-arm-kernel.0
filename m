From: will.deacon@arm.com (Will Deacon)
Date: Fri,  3 Jun 2016 19:02:04 +0100
Subject: [PATCH 1/2] arm64: spinlock: fix spin_is_locked
Message-ID: <1464976925-30525-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

spin_is_locked has grown two very different use-cases:

(1) [The sane case] API functions may require a certain lock to be held
    by the caller and can therefore use spin_is_locked as part of an
    assert statement in order to verify that the lock is indeed held.
    For example, usage of assert_spin_locked.

(2) [The insane case] There are two locks, where a CPU takes one of the
    locks and then checks whether or not the other one is held before
    accessing some shared state. For example, the "optimized locking" in
    ipc/sem.c.

In the latter case, the sequence looks like:

  spin_lock(&sem->lock);
  if (!spin_is_locked(&sma->sem_perm.lock))
    /* Access shared state */

and requires that the spin_is_locked check is ordered after taking the
sem->lock. Unfortunately, since our spinlocks are implemented using a
LDAXR/STXR sequence, the read of &sma->sem_perm.lock can be speculated
before the STXR and consequently return a stale value.

Whilst this hasn't been seen to cause issues in practice, PowerPC fixed
the same issue in 51d7d5205d33 ("powerpc: Add smp_mb() to
arch_spin_is_locked()") and we did something similar for spin_unlock_wait
in d86b8da04dfa ("arm64: spinlock: serialise spin_unlock_wait against
concurrent lockers").

This patch adds an smp_mb() to the start of our arch_spin_is_locked
routine to ensure that the lock value is always loaded after any other
locks have been taken by the current CPU.w

Reported-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/spinlock.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/include/asm/spinlock.h b/arch/arm64/include/asm/spinlock.h
index fc9682bfe002..16f6913f7dbc 100644
--- a/arch/arm64/include/asm/spinlock.h
+++ b/arch/arm64/include/asm/spinlock.h
@@ -148,6 +148,11 @@ static inline int arch_spin_value_unlocked(arch_spinlock_t lock)
 
 static inline int arch_spin_is_locked(arch_spinlock_t *lock)
 {
+	/*
+	 * Ensure prior spin_lock operations to other locks have completed
+	 * on this CPU before we test whether "lock" is locked.
+	 */
+	smp_mb();
 	return !arch_spin_value_unlocked(READ_ONCE(*lock));
 }
 
-- 
2.1.4
