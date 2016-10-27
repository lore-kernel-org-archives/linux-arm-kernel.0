From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 27 Oct 2016 17:27:10 +0100
Subject: [PATCH v3 2/3] powerpc/reloc64: add support for 32-bit CRC
 pseudo-symbols
In-Reply-To: <1477585631-18574-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1477585631-18574-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1477585631-18574-3-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In preparation of modifying the core modversions code to emit the CRCs
as 32-bit quantities, ensure that 64-bit PowerPC will be able to deal
with this when CONFIG_RELOCATABLE=y, in which case the CRCs will be
emitted into the final ELF binary as R_PPC64_ADDR32 relocations.

Since 32-bit relocations cannot be used to relocate memory addresses on
64-bit architectures, and since the CRC pseudo-symbol references are
emitted as anonymous relocations (i.e., against the NULL symbol in the
.dynsym section) with the final value recorded in the addend (*), we
can disregard any relocations where the symbol index != 0.

* Note that unsatisfied CRC pseudo-symbol references are emitted as
  R_PPC64_ADDR32 relocations against named symbols that are typed as
  weak undefined in the .dynsym symbol table. These can simply be
  ignored (as before), considering that zero CRCs are interpreted as
  missing, and the module code deals with that accordingly.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/powerpc/kernel/reloc_64.S | 22 ++++++++++++++++----
 arch/powerpc/relocs_check.sh   |  3 ++-
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/reloc_64.S b/arch/powerpc/kernel/reloc_64.S
index d88736fbece6..7927e00be746 100644
--- a/arch/powerpc/kernel/reloc_64.S
+++ b/arch/powerpc/kernel/reloc_64.S
@@ -14,6 +14,7 @@
 RELA = 7
 RELACOUNT = 0x6ffffff9
 R_PPC64_RELATIVE = 22
+R_PPC64_ADDR32 = 1
 
 /*
  * r3 = desired final address of kernel
@@ -66,10 +67,10 @@ _GLOBAL(relocate)
 
 	/*
 	 * Run through the list of relocations and process the
-	 * R_PPC64_RELATIVE ones.
+	 * R_PPC64_RELATIVE and R_PPC64_ADDR32 ones.
 	 */
 	mtctr	r8
-5:	ld	r0,8(9)		/* ELF64_R_TYPE(reloc->r_info) */
+5:	ld	r0,8(9)		/* reloc->r_info (type *and* symbol index) */
 	cmpdi	r0,R_PPC64_RELATIVE
 	bne	6f
 	ld	r6,0(r9)	/* reloc->r_offset */
@@ -77,9 +78,22 @@ _GLOBAL(relocate)
 	add	r0,r0,r3
 	stdx	r0,r7,r6
 	addi	r9,r9,24
-	bdnz	5b
+	b	7f
+
+	/*
+	 * CRCs of exported symbols are emitted as 32-bit relocations against
+	 * the NULL .dynsym entry, with the CRC value recorded in the addend.
+	 */
+6:	cmpdi	r0,R_PPC64_ADDR32
+	bne	7f
+	ld	r6,0(r9)	/* reloc->r_offset */
+	ld	r0,16(r9)	/* reloc->r_addend */
+	stwx	r0,r7,r6
+	addi	r9,r9,24
+
+7:	bdnz	5b
+	blr
 
-6:	blr
 
 .balign 8
 p_dyn:	.llong	__dynamic_start - 0b
diff --git a/arch/powerpc/relocs_check.sh b/arch/powerpc/relocs_check.sh
index ec2d5c835170..2f510fbc87da 100755
--- a/arch/powerpc/relocs_check.sh
+++ b/arch/powerpc/relocs_check.sh
@@ -43,7 +43,8 @@ R_PPC_ADDR16_HA
 R_PPC_RELATIVE
 R_PPC_NONE' |
 	grep -E -v '\<R_PPC64_ADDR64[[:space:]]+mach_' |
-	grep -E -v '\<R_PPC64_ADDR64[[:space:]]+__crc_'
+	grep -E -v '\<R_PPC64_ADDR64[[:space:]]+__crc_' |
+	grep -E -v '\<R_PPC64_ADDR32[[:space:]]+\*ABS\*'
 )
 
 if [ -z "$bad_relocs" ]; then
-- 
2.7.4
