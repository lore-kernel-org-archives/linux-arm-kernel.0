From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon,  4 Jan 2016 17:09:22 +0100
Subject: [PATCH] arm64: fix relocation of movz instruction with negative
 immediate
Message-ID: <1451923762-8387-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The test whether a movz instruction with a signed immediate should be
turned into a movn instruction (i.e., when the immediate is negative)
is flawed, since the value of imm is always positive. So check sval
instead.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/module.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
index f4bc779e62e8..39e4a29cab50 100644
--- a/arch/arm64/kernel/module.c
+++ b/arch/arm64/kernel/module.c
@@ -128,7 +128,7 @@ static int reloc_insn_movw(enum aarch64_reloc_op op, void *place, u64 val,
 		 * immediate is less than zero.
 		 */
 		insn &= ~(3 << 29);
-		if ((s64)imm >= 0) {
+		if (sval >= 0) {
 			/* >=0: Set the instruction to MOVZ (opcode 10b). */
 			insn |= 2 << 29;
 		} else {
-- 
2.5.0
