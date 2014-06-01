From: will.deacon@arm.com (Will Deacon)
Date: Sun,  1 Jun 2014 12:30:32 +0100
Subject: [PATCH v2] ARM: mcs lock: implement wfe-based polling for MCS locking
Message-ID: <1401622232-9918-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch introduces a wfe-based polling loop for spinning on contended
MCS locks and waking up corresponding waiters when the lock is released.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---

v1 => v2: Use SMP guards and dsb_sev() macro to ensure this compiles and
          runs only on CPUs that can support v6k.

 arch/arm/include/asm/mcs_spinlock.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 arch/arm/include/asm/mcs_spinlock.h

diff --git a/arch/arm/include/asm/mcs_spinlock.h b/arch/arm/include/asm/mcs_spinlock.h
new file mode 100644
index 000000000000..f652ad65840a
--- /dev/null
+++ b/arch/arm/include/asm/mcs_spinlock.h
@@ -0,0 +1,23 @@
+#ifndef __ASM_MCS_LOCK_H
+#define __ASM_MCS_LOCK_H
+
+#ifdef CONFIG_SMP
+#include <asm/spinlock.h>
+
+/* MCS spin-locking. */
+#define arch_mcs_spin_lock_contended(lock)				\
+do {									\
+	/* Ensure prior stores are observed before we enter wfe. */	\
+	smp_mb();							\
+	while (!(smp_load_acquire(lock)))				\
+		wfe();							\
+} while (0)								\
+
+#define arch_mcs_spin_unlock_contended(lock)				\
+do {									\
+	smp_store_release(lock, 1);					\
+	dsb_sev();							\
+} while (0)
+
+#endif	/* CONFIG_SMP */
+#endif	/* __ASM_MCS_LOCK_H */
-- 
1.9.2
