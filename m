From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 18 Mar 2015 15:55:22 +0100
Subject: [PATCH v5 3/8] arm64: remove processor_id
In-Reply-To: <1426690527-14258-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1426690527-14258-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1426690527-14258-4-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The global processor_id is assigned the MIDR_EL1 value of the boot
CPU in the early init code, but is never referenced afterwards.

As the relevance of the MIDR_EL1 value of the boot CPU is debatable
anyway, especially under big.LITTLE, let's remove it before anyone
starts using it.

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/head.S  | 7 +------
 arch/arm64/kernel/setup.c | 3 ---
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index c3631ec8fe4b..c9131f94be19 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -244,7 +244,6 @@ ENTRY(stext)
 	bl	el2_setup			// Drop to EL1, w20=cpu_boot_mode
 	bl	__calc_phys_offset		// x24=PHYS_OFFSET, x28=PHYS_OFFSET-PAGE_OFFSET
 	bl	set_cpu_boot_mode_flag
-	mrs	x22, midr_el1			// x22=cpuid
 
 	bl	__vet_fdt
 	bl	__create_page_tables		// x25=TTBR0, x26=TTBR1
@@ -427,7 +426,6 @@ __switch_data:
 	.quad	__mmap_switched
 	.quad	__bss_start			// x6
 	.quad	__bss_stop			// x7
-	.quad	processor_id			// x4
 	.quad	__fdt_pointer			// x5
 	.quad	memstart_addr			// x6
 	.quad	init_thread_union + THREAD_START_SP // sp
@@ -445,11 +443,10 @@ __mmap_switched:
 	str	xzr, [x6], #8			// Clear BSS
 	b	1b
 2:
-	ldp	x4, x5, [x3], #16
+	ldr	x5, [x3], #8
 	ldr	x6, [x3], #8
 	ldr	x16, [x3]
 	mov	sp, x16
-	str	x22, [x4]			// Save processor ID
 	str	x21, [x5]			// Save FDT pointer
 	str	x24, [x6]			// Save PHYS_OFFSET
 	mov	x29, #0
@@ -621,8 +618,6 @@ ENTRY(secondary_startup)
 	/*
 	 * Common entry point for secondary CPUs.
 	 */
-	mrs	x22, midr_el1			// x22=cpuid
-
 	pgtbl	x25, x26, x28			// x25=TTBR0, x26=TTBR1
 	bl	__cpu_setup			// initialise processor
 
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index a19eae29497c..6c5fb5aff325 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -62,9 +62,6 @@
 #include <asm/psci.h>
 #include <asm/efi.h>
 
-unsigned int processor_id;
-EXPORT_SYMBOL(processor_id);
-
 unsigned long elf_hwcap __read_mostly;
 EXPORT_SYMBOL_GPL(elf_hwcap);
 
-- 
1.8.3.2
