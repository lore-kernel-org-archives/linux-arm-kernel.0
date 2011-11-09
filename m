From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 9 Nov 2011 14:00:02 +0100
Subject: [PATCH] ARM: hw_breakpoint: don't fault when debug is not powered
Message-ID: <1320843602-12278-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rabin Vincent <rabin.vincent@stericsson.com>

If the debug logic is not powered, the processor can unfortunately
raise an undefined instruction exception on the instruction that
we use to check if the debug logic is powered up or not.

Handle this with an undef hook, so that the kernel doesn't crash
on boot on such setups.

Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/kernel/hw_breakpoint.c |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
index 814a52a9..f46137c 100644
--- a/arch/arm/kernel/hw_breakpoint.c
+++ b/arch/arm/kernel/hw_breakpoint.c
@@ -854,6 +854,25 @@ static int hw_breakpoint_pending(unsigned long addr, unsigned int fsr,
 	return ret;
 }
 
+static int hw_breakpoint_undef(struct pt_regs *regs, unsigned int instr)
+{
+	int reg = (instr >> 12) & 15;
+
+	/* Fake sticky power-down cleared */
+	regs->uregs[reg] = 0;
+	regs->ARM_pc += 4;
+
+	return 0;
+}
+
+static struct undef_hook hw_breakpoint_hook = {
+	.instr_mask	= 0xffff0fff,
+	.instr_val	= 0xee110e95,
+	.cpsr_mask	= MODE_MASK,
+	.cpsr_val	= SVC_MODE,
+	.fn		= hw_breakpoint_undef,
+};
+
 /*
  * One-time initialisation.
  */
@@ -900,6 +919,10 @@ static void reset_ctrl_regs(void *unused)
 		/*
 		 * Ensure sticky power-down is clear (i.e. debug logic is
 		 * powered up).
+		 *
+		 * This could raise an undefined instruction exception.  If it
+		 * does, it is fixed up with an undef hook which constructs
+		 * a fake value with the sticky power-down bit cleared.
 		 */
 		asm volatile("mrc p14, 0, %0, c1, c5, 4" : "=r" (dbg_power));
 		if ((dbg_power & 0x1) == 0)
@@ -980,6 +1003,8 @@ static int __init arch_hw_breakpoint_init(void)
 	core_num_brps = get_num_brps();
 	core_num_wrps = get_num_wrps();
 
+	register_undef_hook(&hw_breakpoint_hook);
+
 	/*
 	 * We need to tread carefully here because DBGSWENABLE may be
 	 * driven low on this core and there isn't an architected way to
-- 
1.7.3.2
