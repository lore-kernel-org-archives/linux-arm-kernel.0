From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon,  4 Apr 2016 16:52:23 +0200
Subject: [PATCH 7/8] arm64/kernel: drop __PHYS_OFFSET register with file scope
 from head.S
In-Reply-To: <1459781544-14310-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1459781544-14310-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1459781544-14310-8-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of keeping __PHYS_OFFSET in a callee saved register with file
scope in head.S, derive the value on demand. This makes for cleaner
and more maintainable code.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/head.S | 26 +++++++++++---------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index d28fc345bec3..23d03da7ecfe 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -213,7 +213,6 @@ ENTRY(stext)
 	bl	preserve_boot_args
 	bl	el2_setup			// Drop to EL1, w0=cpu_boot_mode
 	mov	x23, xzr			// KASLR offset, defaults to 0
-	adrp	x24, __PHYS_OFFSET
 	bl	set_cpu_boot_mode_flag
 	bl	__create_page_tables
 	/*
@@ -396,7 +395,7 @@ __create_page_tables:
 	create_pgd_entry x0, x5, x3, x6
 	ldr	w6, kernel_img_size
 	add	x6, x6, x5
-	mov	x3, x24				// phys offset
+	adrp	x3, __PHYS_OFFSET
 	create_block_map x0, x7, x3, x5, x6
 
 	/*
@@ -417,7 +416,7 @@ kernel_img_size:
 	.ltorg
 
 /*
- * The following fragment of code is executed with the MMU enabled.
+ * __mmap_switched(u64 phys_offset) - virtual entry point for the boot CPU
  */
 __mmap_switched:
 	adrp	x4, init_thread_union
@@ -431,14 +430,6 @@ __mmap_switched:
 	msr	vbar_el1, x8			// vector table address
 	isb
 
-	// Clear BSS
-	adr_l	x0, __bss_start
-	mov	x1, xzr
-	adr_l	x2, __bss_stop
-	sub	x2, x2, x0
-	bl	__pi_memset
-	dsb	ishst				// Make zero page visible to PTW
-
 #ifdef CONFIG_RELOCATABLE
 
 	/*
@@ -479,8 +470,17 @@ __mmap_switched:
 #endif
 
 	ldr_l	x4, kimage_vaddr		// Save the offset between
-	sub	x4, x4, x24			// the kernel virtual and
+	sub	x4, x4, x0			// the kernel virtual and
 	str_l	x4, kimage_voffset, x5		// physical mappings
+
+	// Clear BSS
+	adr_l	x0, __bss_start
+	mov	x1, xzr
+	adr_l	x2, __bss_stop
+	sub	x2, x2, x0
+	bl	__pi_memset
+	dsb	ishst				// Make zero page visible to PTW
+
 #ifdef CONFIG_KASAN
 	bl	kasan_early_init
 #endif
@@ -774,6 +774,7 @@ __enable_mmu:
 	mov	x20, x1				// preserve branch target
 #ifdef CONFIG_RANDOMIZE_BASE
 	mov	x19, x0				// preserve new SCTLR_EL1 value
+	adrp	x0, __PHYS_OFFSET
 	blr	x1
 
 	/*
@@ -792,6 +793,7 @@ __enable_mmu:
 	isb
 	add	x20, x20, x23			// relocated __mmap_switched
 #endif
+	adrp	x0, __PHYS_OFFSET
 	br	x20
 ENDPROC(__enable_mmu)
 
-- 
2.5.0
