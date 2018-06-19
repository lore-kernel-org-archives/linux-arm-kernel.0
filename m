From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 19 Jun 2018 21:26:33 +0200
Subject: [PATCH 2/2] ARM: assembler: prevent ADR from setting the Thumb bit
 twice
In-Reply-To: <20180619192633.21846-1-ard.biesheuvel@linaro.org>
References: <20180619192633.21846-1-ard.biesheuvel@linaro.org>
Message-ID: <20180619192633.21846-3-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To work around recent issues where ADR references to Thumb function
symbols may or may not have the Thumb bit set already when they are
resolved by GAS, reference the symbol indirectly via a local symbol
typed as 'function', and emit the reference in a way that prevents
the assembler from resolving it directly. Instead, it will be fixed
up by the linker, which behaves consistently and according to spec
when it comes to relocations of symbols with function annotation
targetting wide ADR instructions.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/include/asm/assembler.h | 22 +++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
index 6ae42ad29518..ee2d4eb26318 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -195,13 +195,33 @@
 	.irp	c,,eq,ne,cs,cc,mi,pl,vs,vc,hi,ls,ge,lt,gt,le,hs,lo
 	.macro	badr\c, rd, sym
 #ifdef CONFIG_THUMB2_KERNEL
-	adr\c	\rd, \sym + 1
+	__badr	\c, \rd, \sym
 #else
 	adr\c	\rd, \sym
 #endif
 	.endm
 	.endr
 
+	/*
+	 * GAS's behavior with respect to setting the Thumb bit on addresses
+	 * of locally defined symbols taken using adr instructions is
+	 * inconsistent, and so we are better off letting the linker handle
+	 * it instead. So emit the reference as a relocation, and force a
+	 * wide encoding so that we can support both forward and backward
+	 * references, and avoid the R_ARM_THM_PC8 relocation that operates
+	 * on the narrow encoding, which is documented as not taking the
+	 * Thumb bit into account. (IHI 0044E ELF for the ARM Architecture)
+	 *
+	 * Note that this needs to be a separate macro or \@ does not work
+	 * correctly.
+	 */
+	.macro		__badr, c, rd, sym
+	.set		.Lsym\@, \sym
+	.type		.Lsym\@, %function
+	.reloc		., R_ARM_THM_ALU_PREL_11_0, .Lsym\@
+	adr\c\().w	\rd, .
+	.endm
+
 /*
  * Get current thread_info.
  */
-- 
2.17.1
