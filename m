From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 18 Oct 2016 13:46:27 +0100
Subject: [PATCH] arm64/kprobes: Tidy up sign-extension usage
Message-ID: <f25b75bf250827113d4269614ba7936e870b0646.1476794661.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kprobes does not need its own homebrewed (and frankly inscrutable) sign
extension macro; just use the standard kernel functions instead. Since
the compiler actually recognises the sign-extension idiom of the latter,
we also get the small bonus of some nicer codegen, as each displacement
calculation helper then compiles to a single optimal SBFX instruction.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 arch/arm64/kernel/probes/simulate-insn.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/kernel/probes/simulate-insn.c b/arch/arm64/kernel/probes/simulate-insn.c
index 8977ce9d009d..357d3efe1366 100644
--- a/arch/arm64/kernel/probes/simulate-insn.c
+++ b/arch/arm64/kernel/probes/simulate-insn.c
@@ -13,28 +13,26 @@
  * General Public License for more details.
  */
 
+#include <linux/bitops.h>
 #include <linux/kernel.h>
 #include <linux/kprobes.h>
 
 #include "simulate-insn.h"
 
-#define sign_extend(x, signbit)		\
-	((x) | (0 - ((x) & (1 << (signbit)))))
-
 #define bbl_displacement(insn)		\
-	sign_extend(((insn) & 0x3ffffff) << 2, 27)
+	sign_extend32(((insn) & 0x3ffffff) << 2, 27)
 
 #define bcond_displacement(insn)	\
-	sign_extend(((insn >> 5) & 0x7ffff) << 2, 20)
+	sign_extend32(((insn >> 5) & 0x7ffff) << 2, 20)
 
 #define cbz_displacement(insn)	\
-	sign_extend(((insn >> 5) & 0x7ffff) << 2, 20)
+	sign_extend32(((insn >> 5) & 0x7ffff) << 2, 20)
 
 #define tbz_displacement(insn)	\
-	sign_extend(((insn >> 5) & 0x3fff) << 2, 15)
+	sign_extend32(((insn >> 5) & 0x3fff) << 2, 15)
 
 #define ldr_displacement(insn)	\
-	sign_extend(((insn >> 5) & 0x7ffff) << 2, 20)
+	sign_extend32(((insn >> 5) & 0x7ffff) << 2, 20)
 
 static inline void set_x_reg(struct pt_regs *regs, int reg, u64 val)
 {
@@ -106,7 +104,7 @@ static bool __kprobes check_tbnz(u32 opcode, struct pt_regs *regs)
 
 	xn = opcode & 0x1f;
 	imm = ((opcode >> 3) & 0x1ffffc) | ((opcode >> 29) & 0x3);
-	imm = sign_extend(imm, 20);
+	imm = sign_extend64(imm, 20);
 	if (opcode & 0x80000000)
 		val = (imm<<12) + (addr & 0xfffffffffffff000);
 	else
-- 
1.9.1
