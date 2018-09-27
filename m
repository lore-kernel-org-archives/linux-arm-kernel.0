From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 27 Sep 2018 17:15:30 +0100
Subject: [PATCH 3/7] arm64: compat: Add condition code checks and IT advance
In-Reply-To: <20180927161534.247926-1-marc.zyngier@arm.com>
References: <20180927161534.247926-1-marc.zyngier@arm.com>
Message-ID: <20180927161534.247926-4-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here's a /really nice/ part of the architecture: a CP15 access is
allowed to trap even if it fails its condition check, and SW must
handle it. This includes decoding the IT state if this happens in
am IT block. As a consequence, SW must also deal with advancing
the IT state machine.

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kernel/traps.c | 85 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 7607283c1ef1..db036a097672 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -531,8 +531,93 @@ static struct sys64_hook sys64_hooks[] = {
 
 
 #ifdef CONFIG_COMPAT
+#define PSTATE_IT_1_0_SHIFT	25
+#define PSTATE_IT_1_0_MASK	(0x3 << PSTATE_IT_1_0_SHIFT)
+#define PSTATE_IT_7_2_SHIFT	10
+#define PSTATE_IT_7_2_MASK	(0x3f << PSTATE_IT_7_2_SHIFT)
+
+static u32 compat_get_it_state(struct pt_regs *regs)
+{
+	u32 it, pstate = regs->pstate;
+
+	it  = (pstate & PSTATE_IT_1_0_MASK) >> PSTATE_IT_1_0_SHIFT;
+	it |= ((pstate & PSTATE_IT_7_2_MASK) >> PSTATE_IT_7_2_SHIFT) << 2;
+
+	return it;
+}
+
+static void compat_set_it_state(struct pt_regs *regs, u32 it)
+{
+	u32 pstate_it;
+
+	pstate_it  = (it << PSTATE_IT_1_0_SHIFT) & PSTATE_IT_1_0_MASK;
+	pstate_it |= ((it >> 2) << PSTATE_IT_7_2_SHIFT) & PSTATE_IT_7_2_MASK;
+
+	regs->pstate &= ~PSR_AA32_IT_MASK;
+	regs->pstate |= pstate_it;
+}
+
+static bool cp15_cond_valid(unsigned int esr, struct pt_regs *regs)
+{
+	int cond;
+
+	/* Only a T32 instruction can trap without CV being set */
+	if (!(esr & ESR_ELx_CV)) {
+		u32 it;
+
+		it = compat_get_it_state(regs);
+		if (!it)
+			return true;
+
+		cond = it >> 4;
+	} else {
+		cond = (esr & ESR_ELx_COND_MASK) >> ESR_ELx_COND_SHIFT;
+	}
+
+	return aarch32_opcode_cond_checks[cond](regs->pstate);
+}
+
+static void advance_itstate(struct pt_regs *regs)
+{
+	u32 it;
+
+	/* ARM mode */
+	if (!(regs->pstate & PSR_AA32_T_BIT) ||
+	    !(regs->pstate & PSR_AA32_IT_MASK))
+		return;
+
+	it  = compat_get_it_state(regs);
+
+	/*
+	 * If this is the last instruction of the block, wipe the IT
+	 * state. Otherwise advance it.
+	 */
+	if (!(it & 7))
+		it = 0;
+	else
+		it = (it & 0xe0) | ((it << 1) & 0x1f);
+
+	compat_set_it_state(regs, it);
+}
+
+static void arm64_compat_skip_faulting_instruction(struct pt_regs *regs,
+						   unsigned int sz)
+{
+	advance_itstate(regs);
+	arm64_skip_faulting_instruction(regs, sz);
+}
+
 asmlinkage void __exception do_cp15instr(unsigned int esr, struct pt_regs *regs)
 {
+	if (!cp15_cond_valid(esr, regs)) {
+		/*
+		 * There is no T16 variant of a CP access, so we
+		 * always advance PC by 4 bytes.
+		 */
+		arm64_compat_skip_faulting_instruction(regs, 4);
+		return;
+	}
+
 	/*
 	 * New cp15 instructions may previously have been undefined at
 	 * EL0. Fall back to our usual undefined instruction handler
-- 
2.19.0
