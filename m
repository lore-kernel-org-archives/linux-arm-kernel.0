From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 22 Aug 2012 11:12:28 +0200
Subject: [PATCH] ARM: ux500: implement set_wake() callback for the GIC
Message-ID: <1345626748-29057-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

The Ux500 will be able to wake up on any IRQ, so implement a
.set_wake() callback that just returns 0 instead of the default
in common/gic.c which returns an error if you try to set
wakeup on the GIC.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/cpu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/mach-ux500/cpu.c b/arch/arm/mach-ux500/cpu.c
index e2360e7..24598e2 100644
--- a/arch/arm/mach-ux500/cpu.c
+++ b/arch/arm/mach-ux500/cpu.c
@@ -46,11 +46,18 @@ static const struct of_device_id ux500_dt_irq_match[] = {
 	{},
 };
 
+static int ux500_gic_irq_set_wake(struct irq_data *d, unsigned int on)
+{
+	return 0;
+}
+
 void __init ux500_init_irq(void)
 {
 	void __iomem *dist_base;
 	void __iomem *cpu_base;
 
+	gic_arch_extn.irq_set_wake = ux500_gic_irq_set_wake;
+
 	if (cpu_is_u8500_family()) {
 		dist_base = __io_address(U8500_GIC_DIST_BASE);
 		cpu_base = __io_address(U8500_GIC_CPU_BASE);
-- 
1.7.11.3
