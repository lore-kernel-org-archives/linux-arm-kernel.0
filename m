From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Fri,  8 Jul 2016 12:37:15 +0100
Subject: [PATCH 5/8] arm64: alternative: Add support for patching adrp
 instructions
In-Reply-To: <1467977839-27543-1-git-send-email-suzuki.poulose@arm.com>
References: <1467977839-27543-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1467977839-27543-7-git-send-email-suzuki.poulose@arm.com>
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
 arch/arm64/kernel/alternative.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/kernel/alternative.c b/arch/arm64/kernel/alternative.c
index d2ee1b2..cd36950 100644
--- a/arch/arm64/kernel/alternative.c
+++ b/arch/arm64/kernel/alternative.c
@@ -80,6 +80,19 @@ static u32 get_alt_insn(struct alt_instr *alt, u32 *insnptr, u32 *altinsnptr)
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
+		orig_offset  = aarch64_get_addr_offset(insn);
+		target = ((unsigned long)altinsnptr & ~0xfffUL) + orig_offset;
+		new_offset = target - ((unsigned long)insnptr & ~0xfffUL);
+		insn = aarch64_set_addr_offset(insn, new_offset);
 	}
 
 	return insn;
-- 
2.7.4
