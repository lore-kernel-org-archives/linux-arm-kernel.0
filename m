From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sat,  3 Dec 2016 14:05:38 +0000
Subject: [PATCH 2/2] arm64: alternatives: Work around NOP generation with
 broken assembler
In-Reply-To: <20161203140538.23525-1-marc.zyngier@arm.com>
References: <20161203140538.23525-1-marc.zyngier@arm.com>
Message-ID: <20161203140538.23525-3-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When compiling a .inst directive in an alternative clause with
a rather old version of gas (circa 2.24), and when used with
the alternative_else_nop_endif feature, the compilation fails
with a rather cryptic message such as:

arch/arm64/lib/clear_user.S:33: Error: bad or irreducible absolute expression

which is caused by the bug described in eb7c11ee3c5c ("arm64:
alternative: Work around .inst assembler bugs").

This effectively prevents the use of the "nops" macro, which
requires the number of instruction as a parameter (the assembler
is confused and unable to compute the difference between two labels).

As an alternative(!), use the .fill directive to output the number
of required NOPs (.fill has the good idea to output the fill pattern
in the endianness of the instruction stream).

Fixes: 792d47379f4d ("arm64: alternative: add auto-nop infrastructure")
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/alternative.h | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/alternative.h b/arch/arm64/include/asm/alternative.h
index 39feb85..39f8c98 100644
--- a/arch/arm64/include/asm/alternative.h
+++ b/arch/arm64/include/asm/alternative.h
@@ -159,9 +159,19 @@ void apply_alternatives(void *start, size_t length);
  * of NOPs. The number of NOPs is chosen automatically to match the
  * previous case.
  */
+
+#define NOP_INST	0xd503201f
+
 .macro alternative_else_nop_endif
 alternative_else
-	nops	(662b-661b) / AARCH64_INSN_SIZE
+	/*
+	 * The same assembler bug strikes again here if the first half
+	 * of the alternative sequence contains a .inst, leading to a
+	 * bizarre error message. Fortulately, .fill replaces the
+	 * "nops" macro by inserting padding with the target machine
+	 * endianness.
+	 */
+	.fill	(662b-661b) / AARCH64_INSN_SIZE, AARCH64_INSN_SIZE, NOP_INST
 alternative_endif
 .endm
 
-- 
2.10.2
