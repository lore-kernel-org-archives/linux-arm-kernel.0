From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 21 Jul 2017 18:15:31 +0100
Subject: [PATCH 05/16] arm64: compat: Add cp15_32 and cp15_64 handler arrays
In-Reply-To: <20170721171542.27639-1-marc.zyngier@arm.com>
References: <20170721171542.27639-1-marc.zyngier@arm.com>
Message-ID: <20170721171542.27639-6-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We're now ready to start handling CP15 access. Let's add (empty)
arrays for both 32 and 64bit accessors, and the code that deals
with them.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kernel/traps.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index c89458f975bf..ac91f4ead737 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -558,6 +558,14 @@ static struct sys64_hook sys64_hooks[] = {
 
 
 #ifdef CONFIG_COMPAT
+static struct sys64_hook cp15_32_hooks[] = {
+	{},
+};
+
+static struct sys64_hook cp15_64_hooks[] = {
+	{},
+};
+
 #define PSTATE_IT_1_0_SHIFT	25
 #define PSTATE_IT_1_0_MASK	(0x3 << PSTATE_IT_1_0_SHIFT)
 #define PSTATE_IT_7_2_SHIFT	10
@@ -629,6 +637,8 @@ static void advance_itstate(struct pt_regs *regs)
 
 asmlinkage void __exception do_cp15instr(unsigned int esr, struct pt_regs *regs)
 {
+	struct sys64_hook *hook, *hook_base;
+
 	if (!cp15_cond_valid(esr, regs)) {
 		advance_itstate(regs);
 		/*
@@ -639,6 +649,25 @@ asmlinkage void __exception do_cp15instr(unsigned int esr, struct pt_regs *regs)
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
+			advance_itstate(regs);
+			return;
+		}
+
 	/*
 	 * New cp15 instructions may previously have been undefined at
 	 * EL0. Fall back to our usual undefined instruction handler
-- 
2.11.0
