From: will.deacon@arm.com (Will Deacon)
Date: Thu, 26 Apr 2018 11:34:22 +0100
Subject: [PATCH v3 08/14] locking/mcs: Use smp_cond_load_acquire() in mcs spin
 loop
In-Reply-To: <1524738868-31318-1-git-send-email-will.deacon@arm.com>
References: <1524738868-31318-1-git-send-email-will.deacon@arm.com>
Message-ID: <1524738868-31318-9-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jason Low <jason.low2@hp.com>

For qspinlocks on ARM64, we would like to use WFE instead
of purely spinning. Qspinlocks internally have lock
contenders spin on an MCS lock.

Update arch_mcs_spin_lock_contended() such that it uses
the new smp_cond_load_acquire() so that ARM64 can also
override this spin loop with its own implementation using WFE.

On x86, this can also be cheaper than spinning on
smp_load_acquire().

Signed-off-by: Jason Low <jason.low2@hp.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 kernel/locking/mcs_spinlock.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/mcs_spinlock.h b/kernel/locking/mcs_spinlock.h
index f046b7ce9dd6..5e10153b4d3c 100644
--- a/kernel/locking/mcs_spinlock.h
+++ b/kernel/locking/mcs_spinlock.h
@@ -23,13 +23,15 @@ struct mcs_spinlock {
 
 #ifndef arch_mcs_spin_lock_contended
 /*
- * Using smp_load_acquire() provides a memory barrier that ensures
- * subsequent operations happen after the lock is acquired.
+ * Using smp_cond_load_acquire() provides the acquire semantics
+ * required so that subsequent operations happen after the
+ * lock is acquired. Additionally, some architectures such as
+ * ARM64 would like to do spin-waiting instead of purely
+ * spinning, and smp_cond_load_acquire() provides that behavior.
  */
 #define arch_mcs_spin_lock_contended(l)					\
 do {									\
-	while (!(smp_load_acquire(l)))					\
-		cpu_relax();						\
+	smp_cond_load_acquire(l, VAL);					\
 } while (0)
 #endif
 
-- 
2.1.4
