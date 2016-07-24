From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sun, 24 Jul 2016 14:00:13 +0200
Subject: [PATCH] arm64: relocatable: suppress R_AARCH64_ABS64 relocations in
 vmlinux
Message-ID: <1469361613-21129-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The linker routines that we rely on to produce a relocatable PIE binary
treat it as a shared ELF object in some ways, i.e., it emits symbol based
R_AARCH64_ABS64 relocations into the final binary since doing so would be
appropriate when linking a shared library that is subject to symbol
preemption. (This means that an executable can override certain symbols
that are exported by a shared library it is linked with, and that the
shared library *must* update all its internal references as well, and point
them to the version provided by the executable.)

Symbol preemption does not occur for OS hosted PIE executables, let alone
for vmlinux, and so we would prefer to get rid of these symbol based
relocations. This would allow us to simplify the relocation routines, and
to strip the .dynsym, .dynstr and .hash sections from the binary. (Note
that these are tiny, and are placed in the .init segment, but they clutter
up the vmlinux binary.)

Note that these R_AARCH64_ABS64 relocations are only emitted for absolute
references to symbols defined in the linker script, all other relocatable
quantities are covered by anonymous R_AARCH64_RELATIVE relocations that
simply list the offsets to all 64-bit values in the binary that need to be
fixed up based on the offset between the link time and run time addresses.

Fortunately, GNU ld has a -Bsymbolic option, which is intended for shared
libraries to allow them to ignore symbol preemption, and unconditionally
bind all internal symbol references to its own definitions. So set it for
our PIE binary as well, and get rid of the asoociated sections and the
relocation code that processes them.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/Makefile             |  2 +-
 arch/arm64/kernel/head.S        | 21 +++------------------
 arch/arm64/kernel/vmlinux.lds.S | 11 +----------
 3 files changed, 5 insertions(+), 29 deletions(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 393103b8abe4..76708280b04a 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -15,7 +15,7 @@ CPPFLAGS_vmlinux.lds = -DTEXT_OFFSET=$(TEXT_OFFSET)
 GZFLAGS		:=-9
 
 ifneq ($(CONFIG_RELOCATABLE),)
-LDFLAGS_vmlinux		+= -pie
+LDFLAGS_vmlinux		+= -pie -Bsymbolic
 endif
 
 KBUILD_DEFCONFIG := defconfig
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 2c6e598a94dc..b77f58355da1 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -781,40 +781,25 @@ __primary_switch:
 	 * Iterate over each entry in the relocation table, and apply the
 	 * relocations in place.
 	 */
-	ldr	w8, =__dynsym_offset		// offset to symbol table
 	ldr	w9, =__rela_offset		// offset to reloc table
 	ldr	w10, =__rela_size		// size of reloc table
 
 	mov_q	x11, KIMAGE_VADDR		// default virtual offset
 	add	x11, x11, x23			// actual virtual offset
-	add	x8, x8, x11			// __va(.dynsym)
 	add	x9, x9, x11			// __va(.rela)
 	add	x10, x9, x10			// __va(.rela) + sizeof(.rela)
 
 0:	cmp	x9, x10
-	b.hs	2f
+	b.hs	1f
 	ldp	x11, x12, [x9], #24
 	ldr	x13, [x9, #-8]
 	cmp	w12, #R_AARCH64_RELATIVE
-	b.ne	1f
+	b.ne	0b
 	add	x13, x13, x23			// relocate
 	str	x13, [x11, x23]
 	b	0b
 
-1:	cmp	w12, #R_AARCH64_ABS64
-	b.ne	0b
-	add	x12, x12, x12, lsl #1		// symtab offset: 24x top word
-	add	x12, x8, x12, lsr #(32 - 3)	// ... shifted into bottom word
-	ldrsh	w14, [x12, #6]			// Elf64_Sym::st_shndx
-	ldr	x15, [x12, #8]			// Elf64_Sym::st_value
-	cmp	w14, #-0xf			// SHN_ABS (0xfff1) ?
-	add	x14, x15, x23			// relocate
-	csel	x15, x14, x15, ne
-	add	x15, x13, x15
-	str	x15, [x11, x23]
-	b	0b
-
-2:
+1:
 #endif
 	ldr	x8, =__primary_switched
 	br	x8
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 89d6e177ecbd..12e65119b683 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -103,6 +103,7 @@ SECTIONS
 		*(.discard)
 		*(.discard.*)
 		*(.interp .dynamic)
+		*(.dynsym .dynstr .hash)
 	}
 
 	. = KIMAGE_VADDR + TEXT_OFFSET;
@@ -174,19 +175,9 @@ SECTIONS
 	.rela : ALIGN(8) {
 		*(.rela .rela*)
 	}
-	.dynsym : ALIGN(8) {
-		*(.dynsym)
-	}
-	.dynstr : {
-		*(.dynstr)
-	}
-	.hash : {
-		*(.hash)
-	}
 
 	__rela_offset	= ADDR(.rela) - KIMAGE_VADDR;
 	__rela_size	= SIZEOF(.rela);
-	__dynsym_offset	= ADDR(.dynsym) - KIMAGE_VADDR;
 
 	. = ALIGN(SEGMENT_ALIGN);
 	__init_end = .;
-- 
2.7.4
