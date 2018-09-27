From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 27 Sep 2018 17:15:31 +0100
Subject: [PATCH 4/7] arm64: compat: Add cp15_32 and cp15_64 handler arrays
In-Reply-To: <20180927161534.247926-1-marc.zyngier@arm.com>
References: <20180927161534.247926-1-marc.zyngier@arm.com>
Message-ID: <20180927161534.247926-5-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We're now ready to start handling CP15 access. Let's add (empty)
arrays for both 32 and 64bit accessors, and the code that deals
with them.

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kernel/traps.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index db036a097672..2920a8f30158 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -607,8 +607,18 @@ static void arm64_compat_skip_faulting_instruction(struct pt_regs *regs,
 	arm64_skip_faulting_instruction(regs, sz);
 }
 
+static struct sys64_hook cp15_32_hooks[] = {
+	{},
+};
+
+static struct sys64_hook cp15_64_hooks[] = {
+	{},
+};
+
 asmlinkage void __exception do_cp15instr(unsigned int esr, struct pt_regs *regs)
 {
+	struct sys64_hook *hook, *hook_base;
+
 	if (!cp15_cond_valid(esr, regs)) {
 		/*
 		 * There is no T16 variant of a CP access, so we
@@ -618,6 +628,24 @@ asmlinkage void __exception do_cp15instr(unsigned int esr, struct pt_regs *regs)
 		return;
 	}
 
+	switch (ESR_ELx_EC(esr)) {
+	case ESR_ELx_EC_CP15_32:
+		hook_base = cp15_32_hooks;
+		break;
+	case ESR_ELx_EC_CP15_64:
+		hook_base = cp15_64_hooks;
+		break;
+	default:
+		do_undefinstr(regs);
+		return;
+	}
+
+	for (hook = hook_base; hook->handler; hook++)
+		if ((hook->esr_mask & esr) == hook->esr_val) {
+			hook->handler(esr, regs);
+			return;
+		}
+
 	/*
 	 * New cp15 instructions may previously have been undefined at
 	 * EL0. Fall back to our usual undefined instruction handler
-- 
2.19.0
