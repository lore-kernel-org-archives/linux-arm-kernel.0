From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 31 Aug 2016 12:05:15 +0100
Subject: [PATCH v3 5/7] arm64: kernel: drop use of x24 from primary boot path
In-Reply-To: <1472641517-15362-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1472641517-15362-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1472641517-15362-6-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Keeping __PHYS_OFFSET in x24 is actually less clear than simply taking
the value of __PHYS_OFFSET using an adrp instruction in the three places
that we need it. So change that.

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/head.S | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 45b865e022cc..4dee51045e79 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -211,8 +211,8 @@ efi_header_end:
 ENTRY(stext)
 	bl	preserve_boot_args
 	bl	el2_setup			// Drop to EL1, w0=cpu_boot_mode
-	adrp	x24, __PHYS_OFFSET
-	and	x23, x24, MIN_KIMG_ALIGN - 1	// KASLR offset, defaults to 0
+	adrp	x23, __PHYS_OFFSET
+	and	x23, x23, MIN_KIMG_ALIGN - 1	// KASLR offset, defaults to 0
 	bl	set_cpu_boot_mode_flag
 	bl	__create_page_tables
 	/*
@@ -412,6 +412,8 @@ ENDPROC(__create_page_tables)
 
 /*
  * The following fragment of code is executed with the MMU enabled.
+ *
+ *   x0 = __PHYS_OFFSET
  */
 	.set	initial_sp, init_thread_union + THREAD_START_SP
 __primary_switched:
@@ -420,6 +422,12 @@ __primary_switched:
 	msr	vbar_el1, x8			// vector table address
 	isb
 
+	str_l	x21, __fdt_pointer, x5		// Save FDT pointer
+
+	ldr_l	x4, kimage_vaddr		// Save the offset between
+	sub	x4, x4, x0			// the kernel virtual and
+	str_l	x4, kimage_voffset, x5		// physical mappings
+
 	// Clear BSS
 	adr_l	x0, __bss_start
 	mov	x1, xzr
@@ -432,12 +440,6 @@ __primary_switched:
 	mov	x4, sp
 	and	x4, x4, #~(THREAD_SIZE - 1)
 	msr	sp_el0, x4			// Save thread_info
-	str_l	x21, __fdt_pointer, x5		// Save FDT pointer
-
-	ldr_l	x4, kimage_vaddr		// Save the offset between
-	sub	x4, x4, x24			// the kernel virtual and
-	str_l	x4, kimage_voffset, x5		// physical mappings
-
 	mov	x29, #0
 #ifdef CONFIG_KASAN
 	bl	kasan_early_init
@@ -794,6 +796,7 @@ __primary_switch:
 	bl	__relocate_kernel
 #ifdef CONFIG_RANDOMIZE_BASE
 	ldr	x8, =__primary_switched
+	adrp	x0, __PHYS_OFFSET
 	blr	x8
 
 	/*
@@ -818,5 +821,6 @@ __primary_switch:
 #endif
 #endif
 	ldr	x8, =__primary_switched
+	adrp	x0, __PHYS_OFFSET
 	br	x8
 ENDPROC(__primary_switch)
-- 
2.7.4
