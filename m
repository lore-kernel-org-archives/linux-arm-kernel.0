From: mark.rutland@arm.com (Mark Rutland)
Date: Tue,  9 Jul 2013 15:16:05 +0100
Subject: [PATCH 2/3] arm: virt: ensure visibility of __boot_cpu_mode
In-Reply-To: <1373379366-15689-1-git-send-email-mark.rutland@arm.com>
References: <1373379366-15689-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1373379366-15689-3-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Secondary CPUs write to __boot_cpu_mode with caches disabled, and thus a
cached value of __boot_cpu_mode may be incoherent with that in memory.
This could lead to a failure to detect mismatched boot modes.

This patch adds flushing to ensure that writes by secondaries to
__boot_cpu_mode are made visible before we test against it.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Dave Martin <dave.martin@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Christoffer Dall <cdall@cs.columbia.edu>
---
 arch/arm/include/asm/virt.h | 12 ++++++++++++
 arch/arm/kernel/setup.c     |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/arch/arm/include/asm/virt.h b/arch/arm/include/asm/virt.h
index 50af92b..4371f45 100644
--- a/arch/arm/include/asm/virt.h
+++ b/arch/arm/include/asm/virt.h
@@ -29,6 +29,7 @@
 #define BOOT_CPU_MODE_MISMATCH	PSR_N_BIT
 
 #ifndef __ASSEMBLY__
+#include <asm/cacheflush.h>
 
 #ifdef CONFIG_ARM_VIRT_EXT
 /*
@@ -41,10 +42,21 @@
  */
 extern int __boot_cpu_mode;
 
+static inline void sync_boot_mode(void)
+{
+	/*
+	 * As secondaries write to __boot_cpu_mode with caches disabled, we
+	 * must flush the corresponding cache entries to ensure the visibility
+	 * of their writes.
+	 */
+	sync_cache_r(&__boot_cpu_mode);
+}
+
 void __hyp_set_vectors(unsigned long phys_vector_base);
 unsigned long __hyp_get_vectors(void);
 #else
 #define __boot_cpu_mode	(SVC_MODE)
+#define sync_boot_mode()
 #endif
 
 #ifndef ZIMAGE
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index b4b1d39..4af9b38 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -744,6 +744,8 @@ static int __init meminfo_cmp(const void *_a, const void *_b)
 void __init hyp_mode_check(void)
 {
 #ifdef CONFIG_ARM_VIRT_EXT
+	sync_boot_mode();
+
 	if (is_hyp_mode_available()) {
 		pr_info("CPU: All CPU(s) started in HYP mode.\n");
 		pr_info("CPU: Virtualization extensions available.\n");
-- 
1.8.1.1
