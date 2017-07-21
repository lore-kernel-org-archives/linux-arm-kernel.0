From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 21 Jul 2017 18:15:38 +0100
Subject: [PATCH 12/16] ARM: Simplify condition checks in swp_handler
In-Reply-To: <20170721171542.27639-1-marc.zyngier@arm.com>
References: <20170721171542.27639-1-marc.zyngier@arm.com>
Message-ID: <20170721171542.27639-13-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We now check the validity of the condition code before calling
the UNDEF handlers, so we can simplify swp_handler by only
checking for ARM_OPCODE_CONDTEST_UNCOND, which indicates that
this is not a SWP instruction.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kernel/swp_emulate.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/arch/arm/kernel/swp_emulate.c b/arch/arm/kernel/swp_emulate.c
index 3bda08bee674..2683c559e0ff 100644
--- a/arch/arm/kernel/swp_emulate.c
+++ b/arch/arm/kernel/swp_emulate.c
@@ -179,20 +179,9 @@ static int swp_handler(struct pt_regs *regs, unsigned int instr)
 
 	perf_sw_event(PERF_COUNT_SW_EMULATION_FAULTS, 1, regs, regs->ARM_pc);
 
-	res = arm_check_condition(instr, regs->ARM_cpsr);
-	switch (res) {
-	case ARM_OPCODE_CONDTEST_PASS:
-		break;
-	case ARM_OPCODE_CONDTEST_FAIL:
-		/* Condition failed - return to next instruction */
-		regs->ARM_pc += 4;
-		return 0;
-	case ARM_OPCODE_CONDTEST_UNCOND:
-		/* If unconditional encoding - not a SWP, undef */
+	/* If unconditional encoding - not a SWP, undef */
+	if (arm_check_condition(instr, regs->ARM_cpsr) == ARM_OPCODE_CONDTEST_UNCOND)
 		return -EFAULT;
-	default:
-		return -EINVAL;
-	}
 
 	if (current->pid != previous_pid) {
 		pr_debug("\"%s\" (%ld) uses deprecated SWP{B} instruction\n",
-- 
2.11.0
