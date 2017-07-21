From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 21 Jul 2017 18:15:37 +0100
Subject: [PATCH 11/16] ARM: Advance the IT state on successful emulation of an
 UNDEF
In-Reply-To: <20170721171542.27639-1-marc.zyngier@arm.com>
References: <20170721171542.27639-1-marc.zyngier@arm.com>
Message-ID: <20170721171542.27639-12-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When trapping a conditional Thumb instruction, we need to
advance the IT state accordingly, or we'll end-up corrupting
the execution of a subsequent instruction.

Let's add calls to arm_advance_itstate() in the relevant
spots.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kernel/traps.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index ca51e80a60b6..b697e9234a07 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -472,11 +472,14 @@ asmlinkage void __exception do_undefinstr(struct pt_regs *regs)
 		else
 			regs->ARM_pc +=4;
 
+		arm_advance_itstate(regs);
 		return;
 	}
 
-	if (call_undef_hook(regs, instr) == 0)
+	if (call_undef_hook(regs, instr) == 0) {
+		arm_advance_itstate(regs);
 		return;
+	}
 
 die_sig:
 #ifdef CONFIG_DEBUG_USER
-- 
2.11.0
