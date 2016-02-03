From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed,  3 Feb 2016 20:04:57 +0100
Subject: [PATCH v2 4/4] ARM: use single definition for vectors-to-stubs
 section offset
In-Reply-To: <1454526297-5269-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1454526297-5269-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1454526297-5269-5-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This replaces a couple of unannotated uses of the constant 0x1000 with
a single definition in the linker script, and updates the referring
code to use it.

Note that this involves explicitly emitting a relocation against the
literal in .stubs containing the address of vector_swi(), since the
assembler refuses to do so.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/kernel/entry-armv.S  | 17 +++++++++++++----
 arch/arm/kernel/traps.c       |  4 +++-
 arch/arm/kernel/vmlinux.lds.S |  9 ++++++++-
 3 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index 8575ff42c0d4..c19d3b82edb8 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -1064,8 +1064,7 @@ ENDPROC(vector_\name)
 	.endm
 
 	.section .stubs, "ax", %progbits
-__stubs_start:
-	@ This must be the first word
+.Lvector_swi:
 	.word	vector_swi
 
 vector_rst:
@@ -1205,16 +1204,26 @@ vector_addrexcptn:
 	.globl	vector_fiq
 
 	.section .vectors, "ax", %progbits
-.L__vectors_start:
 	W(b)	vector_rst
 	W(b)	vector_und
-	W(ldr)	pc, .L__vectors_start + 0x1000
+0:	W(ldr)	pc, .				@ vector_swi
 	W(b)	vector_pabt
 	W(b)	vector_dabt
 	W(b)	vector_addrexcptn
 	W(b)	vector_irq
 	W(b)	vector_fiq
 
+	/*
+	 * The assembler refuses to emit the correct relocation for the
+	 * cross-section reference to .Lvector_swi inside the ldr instruction
+	 * above, so we have to emit it manually. Note that the addend cannot
+	 * be set by the .reloc directive, and the initial offset recorded in
+	 * the instruction should compensate for the PC bias of the execution
+	 * mode, hence the use of '.' as the label.
+	 */
+ ARM(	.reloc	0b, R_ARM_LDR_PC_G0, .Lvector_swi	)
+ THUMB(	.reloc	0b, R_ARM_THM_PC12, .Lvector_swi	)
+
 	.data
 
 	.globl	cr_alignment
diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index bc698383e822..d90a5b2c02a3 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -792,6 +792,8 @@ void __init early_trap_init(void *vectors_base)
 {
 #ifndef CONFIG_CPU_V7M
 	unsigned long vectors = (unsigned long)vectors_base;
+	extern char __stubs_offset[];
+	unsigned long stubs = vectors + (unsigned long)&__stubs_offset;
 	extern char __stubs_start[], __stubs_end[];
 	extern char __vectors_start[], __vectors_end[];
 	unsigned i;
@@ -813,7 +815,7 @@ void __init early_trap_init(void *vectors_base)
 	 * are visible to the instruction stream.
 	 */
 	memcpy((void *)vectors, __vectors_start, __vectors_end - __vectors_start);
-	memcpy((void *)vectors + 0x1000, __stubs_start, __stubs_end - __stubs_start);
+	memcpy((void *)stubs, __stubs_start, __stubs_end - __stubs_start);
 
 	kuser_init(vectors_base);
 
diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index 9f96a54c7d90..8f270c8e9153 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -163,7 +163,14 @@ SECTIONS
 	/*
 	 * The vectors and stubs are relocatable code, and the
 	 * only thing that matters is their relative offsets
+	 * The .stubs section is virtually placed exactly 4 KB after
+	 * the .vectors section, so that it is in reach for indirect
+	 * jumps from the vector table ('ldr pc, <label>', where the
+	 * label itself is inside the .stubs section) but can still
+	 * be mapped with different permissions.
 	 */
+	__stubs_offset = 0x1000;
+
 	.stubs : {
 		__stubs_start = .;
 		*(.stubs)
@@ -171,7 +178,7 @@ SECTIONS
 	}
 
 	__vectors_start = .;
-	.vectors ADDR(.stubs) - 0x1000 : AT(__vectors_start) {
+	.vectors ADDR(.stubs) - __stubs_offset : AT(__vectors_start) {
 		*(.vectors)
 	}
 	. = __vectors_start + SIZEOF(.vectors);
-- 
2.5.0
