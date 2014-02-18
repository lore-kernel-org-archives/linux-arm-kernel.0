From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 18 Feb 2014 14:20:18 +0100
Subject: [PATCH] ARM: kernel: improve error message when LPAE config doesn't
 match CPU
Message-ID: <1392729618-25094-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, when the kernel is configured with LPAE support, but the
CPU doesn't support it, the error message is fairly cryptic:

  Error: unrecognized/unsupported processor variant (0x561f5811).

This messages is normally shown when there is an issue when comparing
the processor ID (CP15 0, c0, c0) with the values/masks described in
proc-v7.S. However, the same message is displayed when LPAE support is
enabled in the kernel configuration, but not available in the CPU,
after looking at ID_MMFR0 (CP15 0, c0, c1, 4). Having the same error
message is highly misleading.

This commit improves this by showing a different error message when
this situation occurs:

  Error: Kernel with LPAE support, but CPU does not support LPAE.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/kernel/head-common.S | 12 ++++++++++++
 arch/arm/kernel/head.S        |  2 +-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/head-common.S b/arch/arm/kernel/head-common.S
index 47cd974..c96ecac 100644
--- a/arch/arm/kernel/head-common.S
+++ b/arch/arm/kernel/head-common.S
@@ -177,6 +177,18 @@ __lookup_processor_type_data:
 	.long	__proc_info_end
 	.size	__lookup_processor_type_data, . - __lookup_processor_type_data
 
+__error_lpae:
+#ifdef CONFIG_DEBUG_LL
+	adr	r0, str_lpae
+	bl 	printascii
+	b	__error
+str_lpae: .asciz "\nError: Kernel with LPAE support, but CPU does not support LPAE.\n"
+#else
+	b	__error
+#endif
+	.align
+ENDPROC(__error_lpae)
+
 __error_p:
 #ifdef CONFIG_DEBUG_LL
 	adr	r0, str_p1
diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index 914616e..f5f381d 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -102,7 +102,7 @@ ENTRY(stext)
 	and	r3, r3, #0xf			@ extract VMSA support
 	cmp	r3, #5				@ long-descriptor translation table format?
  THUMB( it	lo )				@ force fixup-able long branch encoding
-	blo	__error_p			@ only classic page table format
+	blo	__error_lpae			@ only classic page table format
 #endif
 
 #ifndef CONFIG_XIP_KERNEL
-- 
1.8.3.2
