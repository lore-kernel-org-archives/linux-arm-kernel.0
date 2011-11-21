From: leif.lindholm@arm.com (Leif Lindholm)
Date: Mon, 21 Nov 2011 18:30:58 +0000
Subject: [PATCH 3/4] [RFC] Add condition code checking to SWP emulation
 handler.
In-Reply-To: <20111121183046.28964.23829.stgit@localhost6.localdomain6>
References: <20111121183046.28964.23829.stgit@localhost6.localdomain6>
Message-ID: <20111121183058.28964.79067.stgit@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes two separate issues with the SWP emulation handler:
1: Certain processors implementing the ARMv7-A can (legally) take an
   undef exception even when the condition code would have meant that
   the instruction should not have been executed.
2: Opcodes with all flags set (condition code = 0xf) have been reused
   in recent, and not-so-recent, versions of the ARM architecture to
   implement unconditional extensions to the instruction set. The
   existing code would still have processed any undefs triggered by
   executing an opcode with such a value.

This patch uses the new generic ARM instruction set condition code
checks to implement proper handling of these situations.

Signed-off-by: Leif Lindholm <leif.lindholm@arm.com>
---
 arch/arm/kernel/swp_emulate.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/swp_emulate.c b/arch/arm/kernel/swp_emulate.c
index 5f452f8..2e379d5 100644
--- a/arch/arm/kernel/swp_emulate.c
+++ b/arch/arm/kernel/swp_emulate.c
@@ -25,6 +25,7 @@
 #include <linux/syscalls.h>
 #include <linux/perf_event.h>
 
+#include <asm/opcodes.h>
 #include <asm/traps.h>
 #include <asm/uaccess.h>
 
@@ -183,6 +184,16 @@ static int swp_handler(struct pt_regs *regs, unsigned int instr)
 	unsigned int address, destreg, data, type;
 	unsigned int res = 0;
 
+	res = arm_check_condition(instr, regs->ARM_cpsr);
+	if (!res) {
+		/* Condition failed - return to next instruction */
+		regs->ARM_pc += 4;
+		return 0;
+	} else if (res != 1) {
+		/* If unconditional encoding - not a SWP, undef */
+		return -EFAULT;
+	}
+
 	perf_sw_event(PERF_COUNT_SW_EMULATION_FAULTS, 1, regs, regs->ARM_pc);
 
 	if (current->pid != previous_pid) {
