From: will.deacon@arm.com (Will Deacon)
Date: Mon,  5 Sep 2016 11:56:05 +0100
Subject: [PATCH] arm64: spinlocks: implement smp_mb__before_spinlock() as
 smp_mb()
Message-ID: <1473072965-7272-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

smp_mb__before_spinlock() is intended to upgrade a spin_lock() operation
to a full barrier, such that prior stores are ordered with respect to
loads and stores occuring inside the critical section.

Unfortunately, the core code defines the barrier as smp_wmb(), which
is insufficient to provide the required ordering guarantees when used in
conjunction with our load-acquire-based spinlock implementation.

This patch overrides the arm64 definition of smp_mb__before_spinlock()
to map to a full smp_mb().

Cc: <stable@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Reported-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/spinlock.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/include/asm/spinlock.h b/arch/arm64/include/asm/spinlock.h
index e875a5a551d7..89206b568cd4 100644
--- a/arch/arm64/include/asm/spinlock.h
+++ b/arch/arm64/include/asm/spinlock.h
@@ -363,4 +363,14 @@ static inline int arch_read_trylock(arch_rwlock_t *rw)
 #define arch_read_relax(lock)	cpu_relax()
 #define arch_write_relax(lock)	cpu_relax()
 
+/*
+ * Accesses appearing in program order before a spin_lock() operation
+ * can be reordered with accesses inside the critical section, by virtue
+ * of arch_spin_lock being constructed using acquire semantics.
+ *
+ * In cases where this is problematic (e.g. try_to_wake_up), an
+ * smp_mb__before_spinlock() can restore the required ordering.
+ */
+#define smp_mb__before_spinlock()	smp_mb()
+
 #endif /* __ASM_SPINLOCK_H */
-- 
2.1.4
