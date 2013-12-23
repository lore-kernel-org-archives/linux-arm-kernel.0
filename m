From: taras.kondratiuk@linaro.org (Taras Kondratiuk)
Date: Mon, 23 Dec 2013 18:42:07 +0200
Subject: [PATCH] ARM: traps: fix opcode endianness when read from user memory
Message-ID: <1387816927-4313-1-git-send-email-taras.kondratiuk@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently code has an inverted logic: opcode from user memory
is swapped to a proper endianness only in case of read error.
While normally opcode should be swapped only if it was read
correctly from user memory.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
Signed-off-by: Taras Kondratiuk <taras.kondratiuk@linaro.org>
---
 arch/arm/kernel/traps.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 7940241..36a844e 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -425,9 +425,10 @@ asmlinkage void __exception do_undefinstr(struct pt_regs *regs)
 			instr2 = __mem_to_opcode_thumb16(instr2);
 			instr = __opcode_thumb32_compose(instr, instr2);
 		}
-	} else if (get_user(instr, (u32 __user *)pc)) {
+	} else {
+		if (get_user(instr, (u32 __user *)pc))
+			goto die_sig;
 		instr = __mem_to_opcode_arm(instr);
-		goto die_sig;
 	}
 
 	if (call_undef_hook(regs, instr) == 0)
-- 
1.7.9.5
