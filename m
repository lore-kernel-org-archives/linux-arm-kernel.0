From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Fri, 26 Aug 2016 10:23:15 +0100
Subject: [PATCH v2 6/9] arm64: alternative: Add support for patching adrp
 instructions
In-Reply-To: <1472203398-8751-1-git-send-email-suzuki.poulose@arm.com>
References: <1472203398-8751-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1472203398-8751-7-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

adrp uses PC-relative address offset to a page (of 4K size) of
a symbol. If it appears in an alternative code patched in, we
should adjust the offset to reflect the address where it will
be run from. This patch adds support for fixing the offset
for adrp instructions.

Cc: Will Deacon <will.deacon@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Andre Przywara <andre.przywara@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

---
Changes since V1:
 - Add align_down macro. Couldn't find the best place to add it.
   Didn't want to add this to uapi/ headers where the kernel's generic
   ALIGN helpers are really defined. For the time being left it here.
---
 arch/arm64/kernel/alternative.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/kernel/alternative.c b/arch/arm64/kernel/alternative.c
index 6b269a9..d681498 100644
--- a/arch/arm64/kernel/alternative.c
+++ b/arch/arm64/kernel/alternative.c
@@ -59,6 +59,8 @@ static bool branch_insn_requires_update(struct alt_instr *alt, unsigned long pc)
 	BUG();
 }
 
+#define align_down(x, a)	((unsigned long)(x) & ~(((unsigned long)(a)) - 1))
+
 static u32 get_alt_insn(struct alt_instr *alt, u32 *insnptr, u32 *altinsnptr)
 {
 	u32 insn;
@@ -80,6 +82,19 @@ static u32 get_alt_insn(struct alt_instr *alt, u32 *insnptr, u32 *altinsnptr)
 			offset = target - (unsigned long)insnptr;
 			insn = aarch64_set_branch_offset(insn, offset);
 		}
+	} else if (aarch64_insn_is_adrp(insn)) {
+		s32 orig_offset, new_offset;
+		unsigned long target;
+
+		/*
+		 * If we're replacing an adrp instruction, which uses PC-relative
+		 * immediate addressing, adjust the offset to reflect the new
+		 * PC. adrp operates on 4K aligned addresses.
+		 */
+		orig_offset  = aarch64_insn_adrp_get_offset(insn);
+		target = align_down(altinsnptr, SZ_4K) + orig_offset;
+		new_offset = target - align_down(insnptr, SZ_4K);
+		insn = aarch64_insn_adrp_set_offset(insn, new_offset);
 	} else if (aarch64_insn_uses_literal(insn)) {
 		/*
 		 * Disallow patching unhandled instructions using PC relative
-- 
2.7.4
