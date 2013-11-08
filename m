From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Fri,  8 Nov 2013 18:37:04 +0000
Subject: [PATCH 1/9] ARM: fix missed big-endian fix in traps.c
In-Reply-To: <1383935832-20865-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1383935832-20865-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1383935832-20865-2-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the case where the the opcode is fixed from user memory and is not
swapped properly before being analysed.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 arch/arm/kernel/traps.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 6125f25..500e68c 100644
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
1.8.4.rc3
