From: luc.vanoostenryck@gmail.com (Luc Van Oostenryck)
Date: Wed, 28 Jun 2017 16:55:52 +0200
Subject: [PATCH] arm64: fix endianness annotation for debug-monitors.c
Message-ID: <20170628145552.24365-1-luc.vanoostenryck@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here we're reading thumb or ARM instructions, which are always
stored in memory in little-endian order. These values are thus
correctly converted to native order but the intermediate value
should be annotated as for little-endian values.

Fix this by declaring the intermediate var as __le32 or __le16.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 arch/arm64/kernel/debug-monitors.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
index d618e25c3..c7ef99904 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -341,20 +341,22 @@ int aarch32_break_handler(struct pt_regs *regs)
 
 	if (compat_thumb_mode(regs)) {
 		/* get 16-bit Thumb instruction */
-		get_user(thumb_instr, (u16 __user *)pc);
-		thumb_instr = le16_to_cpu(thumb_instr);
+		__le16 instr;
+		get_user(instr, (__le16 __user *)pc);
+		thumb_instr = le16_to_cpu(instr);
 		if (thumb_instr == AARCH32_BREAK_THUMB2_LO) {
 			/* get second half of 32-bit Thumb-2 instruction */
-			get_user(thumb_instr, (u16 __user *)(pc + 2));
-			thumb_instr = le16_to_cpu(thumb_instr);
+			get_user(instr, (__le16 __user *)(pc + 2));
+			thumb_instr = le16_to_cpu(instr);
 			bp = thumb_instr == AARCH32_BREAK_THUMB2_HI;
 		} else {
 			bp = thumb_instr == AARCH32_BREAK_THUMB;
 		}
 	} else {
 		/* 32-bit ARM instruction */
-		get_user(arm_instr, (u32 __user *)pc);
-		arm_instr = le32_to_cpu(arm_instr);
+		__le32 instr;
+		get_user(instr, (__le32 __user *)pc);
+		arm_instr = le32_to_cpu(instr);
 		bp = (arm_instr & ~0xf0000000) == AARCH32_BREAK_ARM;
 	}
 
-- 
2.13.0
