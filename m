From: luc.vanoostenryck@gmail.com (Luc Van Oostenryck)
Date: Wed, 28 Jun 2017 16:55:55 +0200
Subject: [PATCH] arm64: fix endianness annotation in call_undef_hook()
Message-ID: <20170628145555.24410-1-luc.vanoostenryck@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here we're reading thumb or ARM instructions, which are always
stored in memory in little-endian order. These values are thus
correctly converted to native order but the intermediate value
should be annotated as for little-endian values.

Fix this by declaring the intermediate var as __le32 or __le16.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 arch/arm64/kernel/traps.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 0805b44f9..bdf390ae3 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -344,22 +344,24 @@ static int call_undef_hook(struct pt_regs *regs)
 
 	if (compat_thumb_mode(regs)) {
 		/* 16-bit Thumb instruction */
-		if (get_user(instr, (u16 __user *)pc))
+		__le16 instr_le;
+		if (get_user(instr_le, (__le16 __user *)pc))
 			goto exit;
-		instr = le16_to_cpu(instr);
+		instr = le16_to_cpu(instr_le);
 		if (aarch32_insn_is_wide(instr)) {
 			u32 instr2;
 
-			if (get_user(instr2, (u16 __user *)(pc + 2)))
+			if (get_user(instr_le, (__le16 __user *)(pc + 2)))
 				goto exit;
-			instr2 = le16_to_cpu(instr2);
+			instr2 = le16_to_cpu(instr_le);
 			instr = (instr << 16) | instr2;
 		}
 	} else {
 		/* 32-bit ARM instruction */
-		if (get_user(instr, (u32 __user *)pc))
+		__le32 instr_le;
+		if (get_user(instr_le, (__le32 __user *)pc))
 			goto exit;
-		instr = le32_to_cpu(instr);
+		instr = le32_to_cpu(instr_le);
 	}
 
 	raw_spin_lock_irqsave(&undef_lock, flags);
-- 
2.13.0
