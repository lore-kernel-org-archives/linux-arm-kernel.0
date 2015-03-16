From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 16 Mar 2015 16:23:42 +0100
Subject: [RFC PATCH 2/3] arm64: add support for relocatable kernel
In-Reply-To: <1426519423-28263-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1426519423-28263-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1426519423-28263-3-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds support for runtime relocation of the kernel Image, by
building it as a PIE (ET_DYN) executable and applying the relocations
in the early boot code.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/Kconfig              |  3 +++
 arch/arm64/Makefile             |  4 +++
 arch/arm64/kernel/head.S        | 58 ++++++++++++++++++++++++++++++++++++++++-
 arch/arm64/kernel/image.h       |  8 +++++-
 arch/arm64/kernel/vmlinux.lds.S | 12 +++++++++
 scripts/sortextable.c           |  4 +--
 6 files changed, 85 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1b8e97331ffb..cc6504998f2c 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -143,6 +143,9 @@ config KERNEL_MODE_NEON
 config FIX_EARLYCON_MEM
 	def_bool y
 
+config RELOCATABLE_KERNEL
+	def_bool y
+
 source "init/Kconfig"
 
 source "kernel/Kconfig.freezer"
diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 69ceedc982a5..e3914049c389 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -15,6 +15,10 @@ CPPFLAGS_vmlinux.lds = -DTEXT_OFFSET=$(TEXT_OFFSET)
 OBJCOPYFLAGS	:=-O binary -R .note -R .note.gnu.build-id -R .comment -S
 GZFLAGS		:=-9
 
+ifneq ($(CONFIG_RELOCATABLE_KERNEL),)
+LDFLAGS_vmlinux		+= -pie
+endif
+
 KBUILD_DEFCONFIG := defconfig
 
 KBUILD_CFLAGS	+= -mgeneral-regs-only
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 1ea3cd2aba34..874754794b25 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -239,6 +239,7 @@ section_table:
 
 ENTRY(stext)
 	mov	x21, x0				// x21=FDT
+	mov	x23, x1				// x23=image offset
 	bl	el2_setup			// Drop to EL1, w20=cpu_boot_mode
 	bl	__calc_phys_offset		// x24=PHYS_OFFSET, x28=PHYS_OFFSET-PAGE_OFFSET
 	bl	set_cpu_boot_mode_flag
@@ -249,8 +250,12 @@ ENTRY(stext)
 	 * On return, the CPU will be ready for the MMU to be turned on and
 	 * the TCR will have been set.
 	 */
+#ifndef CONFIG_RELOCATABLE_KERNEL
 	ldr	x27, =__mmap_switched		// address to jump to after
 						// MMU has been enabled
+#else
+	adr	x27, __relocate_kernel
+#endif
 	adrp	lr, __enable_mmu		// return (PIC) address
 	add	lr, lr, #:lo12:__enable_mmu
 	b	 __cpu_setup			// initialise processor
@@ -397,9 +402,10 @@ __create_page_tables:
 	 */
 	mov	x0, x26				// swapper_pg_dir
 	mov	x5, #PAGE_OFFSET
+	add	x5, x5, x23			// __va(KERNEL_START)
 	create_pgd_entry x0, x5, x3, x6
 	adr_l	x6, KERNEL_END
-	mov	x3, x24				// phys offset
+	add	x3, x23, x24			// phys offset + image offset
 	sub	x6, x6, x3			// kernel memsize
 	add	x6, x6, x5			// __va(KERNEL_END)
 	create_block_map x0, x7, x3, x5, x6
@@ -438,6 +444,55 @@ __mmap_switched:
 	b	start_kernel
 ENDPROC(__mmap_switched)
 
+#ifdef CONFIG_RELOCATABLE_KERNEL
+
+#define R_AARCH64_RELATIVE	0x403
+#define R_AARCH64_ABS64		0x101
+
+	/*
+	 * Iterate over each entry in the relocation table, and apply the
+	 * relocations in place.
+	 */
+__relocate_kernel:
+	adr_l	x8, __dynsym_start		// start of symbol table
+	adr_l	x9, __reloc_start		// start of reloc table
+	adr_l	x10, __reloc_end		// end of reloc table
+0:	cmp	x9, x10
+	b.hs	2f
+	ldp	x11, x12, [x9], #24
+	cmp	x12, #R_AARCH64_RELATIVE
+	b.ne	1f
+	ldr	x12, [x9, #-8]
+	add	x12, x12, x23			// relocate
+	str	x12, [x11, x28]
+	b	0b
+
+1:	ubfx	x13, x12, #0, #32
+	cmp	x13, #R_AARCH64_ABS64
+	b.ne	0b
+	lsr	x13, x12, #32			// symbol index
+	ldr	x12, [x9, #-8]
+	add	x13, x13, x13, lsl #1		// x 3
+	add	x13, x8, x13, lsl #3		// x 8
+	ldrsh	w14, [x13, #6]			// Elf64_Sym::st_shndx
+	ldr	x15, [x13, #8]			// Elf64_Sym::st_value
+	cmp	w14, #-0xf			// SHN_ABS (0xfff1) ?
+	add	x14, x15, x23			// relocate
+	csel	x15, x14, x15, ne
+	add	x15, x12, x15
+	str	x15, [x11, x28]
+	b	0b
+
+2:	ldr	x8, =vectors			// reload VBAR_EL1 with
+	msr	vbar_el1, x8			// relocated address
+	isb
+
+	ldr	x9, =__mmap_switched
+	br	x9
+ENDPROC(__relocate_kernel)
+
+#endif
+
 /*
  * end early head section, begin head code that is also used for
  * hotplug and needs to have the same protections as the text region
@@ -657,6 +712,7 @@ __calc_phys_offset:
 	mov	x2, PAGE_OFFSET
 	sub	x28, x0, x1			// x28 = PHYS_OFFSET - PAGE_OFFSET
 	add	x24, x2, x28			// x24 = PHYS_OFFSET
+	sub	x24, x24, x23			// subtract image offset
 	ret
 ENDPROC(__calc_phys_offset)
 
diff --git a/arch/arm64/kernel/image.h b/arch/arm64/kernel/image.h
index 8fae0756e175..8b1e9fa8fc8c 100644
--- a/arch/arm64/kernel/image.h
+++ b/arch/arm64/kernel/image.h
@@ -47,7 +47,13 @@
 #define __HEAD_FLAG_BE	0
 #endif
 
-#define __HEAD_FLAGS	(__HEAD_FLAG_BE << 0)
+#ifdef CONFIG_RELOCATABLE_KERNEL
+#define __HEAD_FLAG_RELOC	1
+#else
+#define __HEAD_FLAG_RELOC	0
+#endif
+
+#define __HEAD_FLAGS	(__HEAD_FLAG_BE << 0) | (__HEAD_FLAG_RELOC << 1)
 
 /*
  * These will output as part of the Image header, which should be little-endian
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index a2c29865c3fe..df706a8c22f1 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -131,6 +131,18 @@ SECTIONS
 
 	PERCPU_SECTION(64)
 
+	.rela : {
+		. = ALIGN(8);
+		__reloc_start = .;
+		*(.rela .rela*)
+		__reloc_end = .;
+	}
+	.dynsym : {
+		. = ALIGN(8);
+		__dynsym_start = .;
+		*(.dynsym)
+	}
+
 	. = ALIGN(PAGE_SIZE);
 	__init_end = .;
 
diff --git a/scripts/sortextable.c b/scripts/sortextable.c
index 1052d4834a44..77fcc1a80011 100644
--- a/scripts/sortextable.c
+++ b/scripts/sortextable.c
@@ -262,9 +262,9 @@ do_file(char const *const fname)
 		break;
 	}  /* end switch */
 	if (memcmp(ELFMAG, ehdr->e_ident, SELFMAG) != 0
-	||  r2(&ehdr->e_type) != ET_EXEC
+	|| (r2(&ehdr->e_type) != ET_EXEC && r2(&ehdr->e_type) != ET_DYN)
 	||  ehdr->e_ident[EI_VERSION] != EV_CURRENT) {
-		fprintf(stderr, "unrecognized ET_EXEC file %s\n", fname);
+		fprintf(stderr, "unrecognized ET_EXEC/ET_DYN file %s\n", fname);
 		fail_file();
 	}
 
-- 
1.8.3.2
