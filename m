From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed,  2 Mar 2016 18:11:51 +0100
Subject: [PATCH 2/3] arm64: kaslr: deal with physically misaligned kernel
 images
In-Reply-To: <1456938712-11089-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1456938712-11089-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1456938712-11089-3-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since KASLR requires a relocatable kernel image anyway, there is no
practical reason to refuse an image whose load address is not exactly
TEXT_OFFSET bytes above a 2 MB aligned base address, as long as the
physical and virtual misalignment with respect to the swapper block
size are equal. So treat the misalignment of the physical load address
as the initial KASLR offset, and fix up the remaining code to deal with
that.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/head.S  | 16 ++++++++++++----
 arch/arm64/kernel/kaslr.c |  6 +++---
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 1d4ae36db0bb..934d6dcd7a57 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -25,6 +25,7 @@
 #include <linux/irqchip/arm-gic-v3.h>
 
 #include <asm/assembler.h>
+#include <asm/boot.h>
 #include <asm/ptrace.h>
 #include <asm/asm-offsets.h>
 #include <asm/cache.h>
@@ -211,8 +212,12 @@ section_table:
 ENTRY(stext)
 	bl	preserve_boot_args
 	bl	el2_setup			// Drop to EL1, w20=cpu_boot_mode
-	mov	x23, xzr			// KASLR offset, defaults to 0
 	adrp	x24, __PHYS_OFFSET
+#ifdef CONFIG_RANDOMIZE_BASE
+	mov	x23, xzr			// KASLR offset, defaults to 0
+#else
+	and	x23, x24, MIN_KIMG_ALIGN - 1	// unless loaded phys misaligned
+#endif
 	bl	set_cpu_boot_mode_flag
 	bl	__create_page_tables		// x25=TTBR0, x26=TTBR1
 	/*
@@ -489,11 +494,13 @@ __mmap_switched:
 	bl	kasan_early_init
 #endif
 #ifdef CONFIG_RANDOMIZE_BASE
-	cbnz	x23, 0f				// already running randomized?
+	tst	x23, ~(MIN_KIMG_ALIGN - 1)	// already running randomized?
+	b.ne	0f
 	mov	x0, x21				// pass FDT address in x0
+	mov	x1, x23				// pass modulo offset in x1
 	bl	kaslr_early_init		// parse FDT for KASLR options
 	cbz	x0, 0f				// KASLR disabled? just proceed
-	mov	x23, x0				// record KASLR offset
+	orr	x23, x23, x0			// record KASLR offset
 	ret	x28				// we must enable KASLR, return
 						// to __enable_mmu()
 0:
@@ -753,7 +760,8 @@ __enable_mmu:
 	isb
 #ifdef CONFIG_RANDOMIZE_BASE
 	mov	x19, x0				// preserve new SCTLR_EL1 value
-	blr	x27
+	add	x30, x27, x23
+	blr	x30
 
 	/*
 	 * If we return here, we have a KASLR displacement in x23 which we need
diff --git a/arch/arm64/kernel/kaslr.c b/arch/arm64/kernel/kaslr.c
index 582983920054..b05469173ba5 100644
--- a/arch/arm64/kernel/kaslr.c
+++ b/arch/arm64/kernel/kaslr.c
@@ -74,7 +74,7 @@ extern void *__init __fixmap_remap_fdt(phys_addr_t dt_phys, int *size,
  * containing function pointers) to be reinitialized, and zero-initialized
  * .bss variables will be reset to 0.
  */
-u64 __init kaslr_early_init(u64 dt_phys)
+u64 __init kaslr_early_init(u64 dt_phys, u64 modulo_offset)
 {
 	void *fdt;
 	u64 seed, offset, mask, module_range;
@@ -132,8 +132,8 @@ u64 __init kaslr_early_init(u64 dt_phys)
 	 * boundary (for 4KB/16KB/64KB granule kernels, respectively). If this
 	 * happens, increase the KASLR offset by the size of the kernel image.
 	 */
-	if ((((u64)_text + offset) >> SWAPPER_TABLE_SHIFT) !=
-	    (((u64)_end + offset) >> SWAPPER_TABLE_SHIFT))
+	if ((((u64)_text + offset + modulo_offset) >> SWAPPER_TABLE_SHIFT) !=
+	    (((u64)_end + offset + modulo_offset) >> SWAPPER_TABLE_SHIFT))
 		offset = (offset + (u64)(_end - _text)) & mask;
 
 	if (IS_ENABLED(CONFIG_KASAN))
-- 
2.5.0
