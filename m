From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 21 Jul 2017 18:15:39 +0100
Subject: [PATCH 13/16] ARM: Handle trapping of CNTVCT from userspace
In-Reply-To: <20170721171542.27639-1-marc.zyngier@arm.com>
References: <20170721171542.27639-1-marc.zyngier@arm.com>
Message-ID: <20170721171542.27639-14-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As we're about to enable trapping of some of the userspace-visible
timer registers, let's add a handler for CNTVCT.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kernel/traps.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index b697e9234a07..bda12a243b40 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -30,6 +30,7 @@
 #include <linux/irq.h>
 
 #include <linux/atomic.h>
+#include <asm/arch_timer.h>
 #include <asm/cacheflush.h>
 #include <asm/exception.h>
 #include <asm/unistd.h>
@@ -735,6 +736,34 @@ late_initcall(arm_mrc_hook_init);
 
 #endif
 
+#ifdef CONFIG_ARM_ARCH_TIMER
+static int read_cntvct_trap(struct pt_regs *regs, unsigned int instr)
+{
+	int rt  = (instr >> 12) & 15;
+	int rt2 = (instr >> 16) & 15;
+	u64 val = arch_counter_get_cntvct();
+
+	regs->uregs[rt]  = lower_32_bits(val);
+	regs->uregs[rt2] = upper_32_bits(val);
+	regs->ARM_pc += 4;
+	return 0;
+}
+
+static struct undef_hook cntvct_hook = {
+	.instr_mask	= 0x0ff00fff,
+	.instr_val	= 0x0c500f1e,
+	.fn		= read_cntvct_trap,
+};
+
+static int __init arch_timer_hook_init(void)
+{
+	register_undef_hook(&cntvct_hook);
+	return 0;
+}
+
+late_initcall(arch_timer_hook_init);
+#endif
+
 /*
  * A data abort trap was taken, but we did not handle the instruction.
  * Try to abort the user program, or panic if it was the kernel.
-- 
2.11.0
