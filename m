From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 21 Jul 2017 18:15:36 +0100
Subject: [PATCH 10/16] ARM: Add arm_advance_itstate helper
In-Reply-To: <20170721171542.27639-1-marc.zyngier@arm.com>
References: <20170721171542.27639-1-marc.zyngier@arm.com>
Message-ID: <20170721171542.27639-11-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to deal with conditional Thumb code, let's add a helper
to advance the IT state when an instruction is either skipped
or emulated.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/opcodes.h |  2 ++
 arch/arm/kernel/opcodes.c      | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/arch/arm/include/asm/opcodes.h b/arch/arm/include/asm/opcodes.h
index e796c598513b..6ff7a04e8530 100644
--- a/arch/arm/include/asm/opcodes.h
+++ b/arch/arm/include/asm/opcodes.h
@@ -12,6 +12,8 @@
 #ifndef __ASSEMBLY__
 #include <linux/linkage.h>
 extern asmlinkage unsigned int arm_check_condition(u32 opcode, u32 psr);
+struct pt_regs;
+extern void arm_advance_itstate(struct pt_regs *regs);
 #endif
 
 #define ARM_OPCODE_CONDTEST_FAIL   0
diff --git a/arch/arm/kernel/opcodes.c b/arch/arm/kernel/opcodes.c
index 827318ee5ff7..58cb36d0ee55 100644
--- a/arch/arm/kernel/opcodes.c
+++ b/arch/arm/kernel/opcodes.c
@@ -53,6 +53,40 @@ static u32 psr_get_it_state(u32 psr)
 	return it;
 }
 
+static void psr_set_it_state(struct pt_regs *regs, u32 it)
+{
+	u32 cpsr_it;
+
+	cpsr_it  = (it << PSR_IT_1_0_SHIFT) & PSR_IT_1_0_MASK;
+	cpsr_it |= ((it >> 2) << PSR_IT_7_2_SHIFT) & PSR_IT_7_2_MASK;
+
+	regs->ARM_cpsr &= ~PSR_IT_MASK;
+	regs->ARM_cpsr |= cpsr_it;
+}
+
+void arm_advance_itstate(struct pt_regs *regs)
+{
+	u32 it;
+
+	/* ARM mode or no conditional */
+	if (thumb_mode(regs) || !(regs->ARM_cpsr & PSR_IT_MASK))
+		return;
+
+	it = psr_get_it_state(regs->ARM_cpsr);
+
+	/*
+	 * If this is the last instruction of the block, wipe the IT
+	 * state. Otherwise advance it. See the ITAdvance() pseudocode
+	 * for reference.
+	 */
+	if (!(it & 7))
+		it = 0;
+	else
+		it = (it & 0xe0) | ((it << 1) & 0x1f);
+
+	psr_set_it_state(regs, it);
+}
+
 /*
  * Returns:
  * ARM_OPCODE_CONDTEST_FAIL   - if condition fails
-- 
2.11.0
