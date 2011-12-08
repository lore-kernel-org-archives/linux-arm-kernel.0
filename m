From: leif.lindholm@arm.com (Leif Lindholm)
Date: Thu, 08 Dec 2011 17:32:13 +0000
Subject: [PATCH 4/4] Use generic ARM instruction set condition code checks for
 kprobes.
In-Reply-To: <20111208173100.7572.9099.stgit@localhost6.localdomain6>
References: <20111208173100.7572.9099.stgit@localhost6.localdomain6>
Message-ID: <20111208173212.7572.16210.stgit@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch changes the kprobes implementation to use the generic ARM
instruction set condition code checks, rather than a dedicated
implementation.

Signed-off-by: Leif Lindholm <leif.lindholm@arm.com>
Acked-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes-test.c |   66 ++++------------------------------------
 1 files changed, 6 insertions(+), 60 deletions(-)

diff --git a/arch/arm/kernel/kprobes-test.c b/arch/arm/kernel/kprobes-test.c
index e17cdd6..f81c2b4 100644
--- a/arch/arm/kernel/kprobes-test.c
+++ b/arch/arm/kernel/kprobes-test.c
@@ -202,6 +202,8 @@
 #include <linux/slab.h>
 #include <linux/kprobes.h>
 
+#include <asm/opcodes.h>
+
 #include "kprobes.h"
 #include "kprobes-test.h"
 
@@ -1048,67 +1050,11 @@ static int test_instance;
  */
 #define PSR_IGNORE_BITS (PSR_A_BIT | PSR_F_BIT)
 
-static unsigned long test_check_cc(int cc, unsigned long cpsr)
+inline unsigned long test_check_cc(int cc, unsigned long cpsr)
 {
-	unsigned long temp;
-
-	switch (cc) {
-	case 0x0: /* eq */
-		return cpsr & PSR_Z_BIT;
-
-	case 0x1: /* ne */
-		return (~cpsr) & PSR_Z_BIT;
-
-	case 0x2: /* cs */
-		return cpsr & PSR_C_BIT;
-
-	case 0x3: /* cc */
-		return (~cpsr) & PSR_C_BIT;
-
-	case 0x4: /* mi */
-		return cpsr & PSR_N_BIT;
-
-	case 0x5: /* pl */
-		return (~cpsr) & PSR_N_BIT;
-
-	case 0x6: /* vs */
-		return cpsr & PSR_V_BIT;
-
-	case 0x7: /* vc */
-		return (~cpsr) & PSR_V_BIT;
+	int ret = arm_check_condition(cc << 28, cpsr);
 
-	case 0x8: /* hi */
-		cpsr &= ~(cpsr >> 1); /* PSR_C_BIT &= ~PSR_Z_BIT */
-		return cpsr & PSR_C_BIT;
-
-	case 0x9: /* ls */
-		cpsr &= ~(cpsr >> 1); /* PSR_C_BIT &= ~PSR_Z_BIT */
-		return (~cpsr) & PSR_C_BIT;
-
-	case 0xa: /* ge */
-		cpsr ^= (cpsr << 3); /* PSR_N_BIT ^= PSR_V_BIT */
-		return (~cpsr) & PSR_N_BIT;
-
-	case 0xb: /* lt */
-		cpsr ^= (cpsr << 3); /* PSR_N_BIT ^= PSR_V_BIT */
-		return cpsr & PSR_N_BIT;
-
-	case 0xc: /* gt */
-		temp = cpsr ^ (cpsr << 3); /* PSR_N_BIT ^= PSR_V_BIT */
-		temp |= (cpsr << 1);	   /* PSR_N_BIT |= PSR_Z_BIT */
-		return (~temp) & PSR_N_BIT;
-
-	case 0xd: /* le */
-		temp = cpsr ^ (cpsr << 3); /* PSR_N_BIT ^= PSR_V_BIT */
-		temp |= (cpsr << 1);	   /* PSR_N_BIT |= PSR_Z_BIT */
-		return temp & PSR_N_BIT;
-
-	case 0xe: /* al */
-	case 0xf: /* unconditional */
-		return true;
-	}
-	BUG();
-	return false;
+	return (ret != ARM_OPCODE_CONDTEST_FAIL);
 }
 
 static int is_last_scenario;
@@ -1128,7 +1074,7 @@ static unsigned long test_context_cpsr(int scenario)
 
 	if (!test_case_is_thumb) {
 		/* Testing ARM code */
-		probe_should_run = test_check_cc(current_instruction >> 28, cpsr) != 0;
+		probe_should_run = arm_check_condition(current_instruction, cpsr) != ARM_OPCODE_CONDTEST_FAIL;
 		if (scenario == 15)
 			is_last_scenario = true;
 
