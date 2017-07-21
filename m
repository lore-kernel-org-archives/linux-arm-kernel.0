From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 21 Jul 2017 18:15:35 +0100
Subject: [PATCH 09/16] ARM: Check condition code before trying to handle an
 UNDEF
In-Reply-To: <20170721171542.27639-1-marc.zyngier@arm.com>
References: <20170721171542.27639-1-marc.zyngier@arm.com>
Message-ID: <20170721171542.27639-10-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As indicated in the ARMv7 ARM in B1.9.2, an instruction that
would cause an UNDEF can trap even if it fails its condition
code. Yes, this is annoying.

Add a arm_check_condition call before trying to handle an
UNDEF, and move the PC by the right amount if the condition
check fails.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kernel/traps.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 948c648fea00..ca51e80a60b6 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -462,6 +462,19 @@ asmlinkage void __exception do_undefinstr(struct pt_regs *regs)
 		instr = __mem_to_opcode_arm(instr);
 	}
 
+	/*
+	 * An UNDEF is allowed to trap even when failing its condition
+	 * code (see B1.9.2 in the ARMv7 ARM).
+	 */
+	if (arm_check_condition(instr, regs->ARM_cpsr) == ARM_OPCODE_CONDTEST_FAIL) {
+		if (thumb_mode(regs) && !is_wide_instruction(instr))
+			regs->ARM_pc += 2;
+		else
+			regs->ARM_pc +=4;
+
+		return;
+	}
+
 	if (call_undef_hook(regs, instr) == 0)
 		return;
 
-- 
2.11.0
