From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 21 Jul 2017 18:15:40 +0100
Subject: [PATCH 14/16] ARM: Handle trapping of CNTFRQ from userspace
In-Reply-To: <20170721171542.27639-1-marc.zyngier@arm.com>
References: <20170721171542.27639-1-marc.zyngier@arm.com>
Message-ID: <20170721171542.27639-15-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As we're about to enable trapping of some of the userspace-visible
timer registers, let's add a handler for CNTFRQ.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kernel/traps.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index bda12a243b40..1c1b86af20e9 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -755,9 +755,26 @@ static struct undef_hook cntvct_hook = {
 	.fn		= read_cntvct_trap,
 };
 
+static int read_cntfrq_trap(struct pt_regs *regs, unsigned int instr)
+{
+	int reg = (instr >> 12) & 15;
+	if (reg == 15)
+		return 1;
+	regs->uregs[reg] = arch_timer_get_rate();
+	regs->ARM_pc += 4;
+	return 0;
+}
+
+static struct undef_hook cntfrq_hook = {
+	.instr_mask	= 0x0fff0fff,
+	.instr_val	= 0x0e1e0f10,
+	.fn		= read_cntfrq_trap,
+};
+
 static int __init arch_timer_hook_init(void)
 {
 	register_undef_hook(&cntvct_hook);
+	register_undef_hook(&cntfrq_hook);
 	return 0;
 }
 
-- 
2.11.0
