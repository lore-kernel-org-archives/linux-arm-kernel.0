From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 18 Apr 2016 17:09:47 +0200
Subject: [PATCH 7/8] arm64: relocatable: deal with physically misaligned
 kernel images
In-Reply-To: <1460992188-23295-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1460992188-23295-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1460992188-23295-8-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When booting a relocatable kernel image, there is no practical reason
to refuse an image whose load address is not exactly TEXT_OFFSET bytes
above a 2 MB aligned base address, as long as the physical and virtual
misalignment with respect to the swapper block size are equal, and are
both aligned to THREAD_SIZE.

Since the virtual misalignment is under our control when we first enter
the kernel proper, we can simply choose its value to be equal to the
physical misalignment.

So treat the misalignment of the physical load address as the initial
KASLR offset, and fix up the remaining code to deal with that.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/head.S  | 9 ++++++---
 arch/arm64/kernel/kaslr.c | 6 +++---
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index c5e5edca6897..00a32101ab51 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -25,6 +25,7 @@
 #include <linux/irqchip/arm-gic-v3.h>
 
 #include <asm/assembler.h>
+#include <asm/boot.h>
 #include <asm/ptrace.h>
 #include <asm/asm-offsets.h>
 #include <asm/cache.h>
@@ -213,8 +214,8 @@ efi_header_end:
 ENTRY(stext)
 	bl	preserve_boot_args
 	bl	el2_setup			// Drop to EL1, w20=cpu_boot_mode
-	mov	x23, xzr			// KASLR offset, defaults to 0
 	adrp	x24, __PHYS_OFFSET
+	and	x23, x24, MIN_KIMG_ALIGN - 1	// KASLR offset, defaults to 0
 	bl	set_cpu_boot_mode_flag
 	bl	__create_page_tables		// x25=TTBR0, x26=TTBR1
 	/*
@@ -449,11 +450,13 @@ __primary_switched:
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
