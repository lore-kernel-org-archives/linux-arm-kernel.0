From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon,  1 Feb 2016 14:09:36 +0100
Subject: [PATCH v5sub2 6/8] arm64: add support for building vmlinux as a
 relocatable PIE binary
In-Reply-To: <1454332178-4414-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1454332178-4414-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1454332178-4414-7-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This implements CONFIG_RELOCATABLE, which links the final vmlinux
image with a dynamic relocation section, allowing the early boot code
to perform a relocation to a different virtual address at runtime.

This is a prerequisite for KASLR (CONFIG_RANDOMIZE_BASE).

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/Kconfig              | 11 +++++++
 arch/arm64/Makefile             |  4 +++
 arch/arm64/include/asm/elf.h    |  2 ++
 arch/arm64/kernel/head.S        | 32 ++++++++++++++++++++
 arch/arm64/kernel/vmlinux.lds.S | 16 ++++++++++
 5 files changed, 65 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 141f65ab0ed5..5e155cc7b49f 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -762,6 +762,17 @@ config ARM64_MODULE_PLTS
 	select ARM64_MODULE_CMODEL_LARGE
 	select HAVE_MOD_ARCH_SPECIFIC
 
+config RELOCATABLE
+	bool
+	help
+	  This builds the kernel as a Position Independent Executable (PIE),
+	  which retains all relocation metadata required to relocate the
+	  kernel binary at runtime to a different virtual address than the
+	  address it was linked at.
+	  Since AArch64 uses the RELA relocation format, this requires a
+	  relocation pass at runtime even if the kernel is loaded at the
+	  same address it was linked at.
+
 endmenu
 
 menu "Boot options"
diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index a6bba9623836..6b5508a17495 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -15,6 +15,10 @@ CPPFLAGS_vmlinux.lds = -DTEXT_OFFSET=$(TEXT_OFFSET)
 OBJCOPYFLAGS	:=-O binary -R .note -R .note.gnu.build-id -R .comment -S
 GZFLAGS		:=-9
 
+ifneq ($(CONFIG_RELOCATABLE),)
+LDFLAGS_vmlinux		+= -pie
+endif
+
 KBUILD_DEFCONFIG := defconfig
 
 # Check for binutils support for specific extensions
diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index 435f55952e1f..24ed037f09fd 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -77,6 +77,8 @@
 #define R_AARCH64_MOVW_PREL_G2_NC	292
 #define R_AARCH64_MOVW_PREL_G3		293
 
+#define R_AARCH64_RELATIVE		1027
+
 /*
  * These are used to set parameters in the core dumps.
  */
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 4cad8f9f2268..4e69412a7323 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -29,6 +29,7 @@
 #include <asm/asm-offsets.h>
 #include <asm/cache.h>
 #include <asm/cputype.h>
+#include <asm/elf.h>
 #include <asm/kernel-pgtable.h>
 #include <asm/memory.h>
 #include <asm/pgtable-hwdef.h>
@@ -432,6 +433,37 @@ __mmap_switched:
 	bl	__pi_memset
 	dsb	ishst				// Make zero page visible to PTW
 
+#ifdef CONFIG_RELOCATABLE
+
+	/*
+	 * Iterate over each entry in the relocation table, and apply the
+	 * relocations in place.
+	 */
+	adr_l	x8, __dynsym_start		// start of symbol table
+	adr_l	x9, __reloc_start		// start of reloc table
+	adr_l	x10, __reloc_end		// end of reloc table
+
+0:	cmp	x9, x10
+	b.hs	2f
+	ldp	x11, x12, [x9], #24
+	ldr	x13, [x9, #-8]
+	cmp	w12, #R_AARCH64_RELATIVE
+	b.ne	1f
+	str	x13, [x11]
+	b	0b
+
+1:	cmp	w12, #R_AARCH64_ABS64
+	b.ne	0b
+	add	x12, x12, x12, lsl #1		// symtab offset: 24x top word
+	add	x12, x8, x12, lsr #(32 - 3)	// ... shifted into bottom word
+	ldr	x15, [x12, #8]			// Elf64_Sym::st_value
+	add	x15, x13, x15
+	str	x15, [x11]
+	b	0b
+
+2:
+#endif
+
 	adr_l	sp, initial_sp, x4
 	mov	x4, sp
 	and	x4, x4, #~(THREAD_SIZE - 1)
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 282e3e64a17e..e3f6cd740ea3 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -87,6 +87,7 @@ SECTIONS
 		EXIT_CALL
 		*(.discard)
 		*(.discard.*)
+		*(.interp .dynamic)
 	}
 
 	. = KIMAGE_VADDR + TEXT_OFFSET;
@@ -149,6 +150,21 @@ SECTIONS
 	.altinstr_replacement : {
 		*(.altinstr_replacement)
 	}
+	.rela : ALIGN(8) {
+		__reloc_start = .;
+		*(.rela .rela*)
+		__reloc_end = .;
+	}
+	.dynsym : ALIGN(8) {
+		__dynsym_start = .;
+		*(.dynsym)
+	}
+	.dynstr : {
+		*(.dynstr)
+	}
+	.hash : {
+		*(.hash)
+	}
 
 	. = ALIGN(PAGE_SIZE);
 	__init_end = .;
-- 
2.5.0
