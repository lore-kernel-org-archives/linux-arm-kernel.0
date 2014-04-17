From: will.deacon@arm.com (Will Deacon)
Date: Thu, 17 Apr 2014 12:27:13 +0100
Subject: [PATCH] ARM: mcs lock: implement wfe-based polling for MCS locking
Message-ID: <1397734033-11931-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch introduces a wfe-based polling loop for spinning on contended
MCS locks and waking up corresponding waiters when the lock is released.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/mcs_spinlock.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 arch/arm/include/asm/mcs_spinlock.h

diff --git a/arch/arm/include/asm/mcs_spinlock.h b/arch/arm/include/asm/mcs_spinlock.h
new file mode 100644
index 000000000000..f32f97e81471
--- /dev/null
+++ b/arch/arm/include/asm/mcs_spinlock.h
@@ -0,0 +1,20 @@
+#ifndef __ASM_MCS_LOCK_H
+#define __ASM_MCS_LOCK_H
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
+	dsb(ishst);							\
+	sev();								\
+} while (0)
+
+#endif	/* __ASM_MCS_LOCK_H */
-- 
1.9.1
