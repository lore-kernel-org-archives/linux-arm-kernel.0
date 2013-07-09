From: mark.rutland@arm.com (Mark Rutland)
Date: Tue,  9 Jul 2013 15:16:06 +0100
Subject: [PATCH 3/3] arm64: virt: ensure visibility of __boot_cpu_mode
In-Reply-To: <1373379366-15689-1-git-send-email-mark.rutland@arm.com>
References: <1373379366-15689-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1373379366-15689-4-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Secondary CPUs write to __boot_cpu_mode with caches disabled, and thus a
cached value of __boot_cpu_mode may be incoherent with that in memory.
This could lead to a failure to detect mismatched boot modes.

This patch adds flushing to ensure that writes by secondaries to
__boot_cpu_mode are made visible before we test against it.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Christoffer Dall <cdall@cs.columbia.edu>
---
 arch/arm64/include/asm/virt.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/include/asm/virt.h b/arch/arm64/include/asm/virt.h
index 4398272..24f0ae9 100644
--- a/arch/arm64/include/asm/virt.h
+++ b/arch/arm64/include/asm/virt.h
@@ -21,6 +21,7 @@
 #define BOOT_CPU_MODE_EL2	(0x0e12b007)
 
 #ifndef __ASSEMBLY__
+#include <asm/cacheflush.h>
 
 /*
  * __boot_cpu_mode records what mode CPUs were booted in.
@@ -36,9 +37,20 @@ extern u32 __boot_cpu_mode[2];
 void __hyp_set_vectors(phys_addr_t phys_vector_base);
 phys_addr_t __hyp_get_vectors(void);
 
+static inline void sync_boot_mode(void)
+{
+	/*
+	 * As secondaries write to __boot_cpu_mode with caches disabled, we
+	 * must flush the corresponding cache entries to ensure the visibility
+	 * of their writes.
+	 */
+	__flush_dcache_area(__boot_cpu_mode, sizeof(__boot_cpu_mode));
+}
+
 /* Reports the availability of HYP mode */
 static inline bool is_hyp_mode_available(void)
 {
+	sync_boot_mode();
 	return (__boot_cpu_mode[0] == BOOT_CPU_MODE_EL2 &&
 		__boot_cpu_mode[1] == BOOT_CPU_MODE_EL2);
 }
@@ -46,6 +58,7 @@ static inline bool is_hyp_mode_available(void)
 /* Check if the bootloader has booted CPUs in different modes */
 static inline bool is_hyp_mode_mismatched(void)
 {
+	sync_boot_mode();
 	return __boot_cpu_mode[0] != __boot_cpu_mode[1];
 }
 
-- 
1.8.1.1
