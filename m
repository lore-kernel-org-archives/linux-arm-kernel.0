From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Fri, 26 Aug 2016 10:23:13 +0100
Subject: [PATCH v2 4/9] arm64: alternative: Disallow patching instructions
 using literals
In-Reply-To: <1472203398-8751-1-git-send-email-suzuki.poulose@arm.com>
References: <1472203398-8751-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1472203398-8751-5-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The alternative code patching doesn't check if the replaced instruction
uses a pc relative literal. This could cause silent corruption in the
instruction stream as the instruction will be executed from a different
address than what it was compiled for. Catch all such cases.

Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Andre Przywara <andre.przywara@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Suggested-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/kernel/alternative.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/kernel/alternative.c b/arch/arm64/kernel/alternative.c
index d2ee1b2..6b269a9 100644
--- a/arch/arm64/kernel/alternative.c
+++ b/arch/arm64/kernel/alternative.c
@@ -80,6 +80,12 @@ static u32 get_alt_insn(struct alt_instr *alt, u32 *insnptr, u32 *altinsnptr)
 			offset = target - (unsigned long)insnptr;
 			insn = aarch64_set_branch_offset(insn, offset);
 		}
+	} else if (aarch64_insn_uses_literal(insn)) {
+		/*
+		 * Disallow patching unhandled instructions using PC relative
+		 * literal addresses
+		 */
+		BUG();
 	}
 
 	return insn;
-- 
2.7.4
