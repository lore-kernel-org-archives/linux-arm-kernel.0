From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 22 Aug 2012 10:43:48 +0200
Subject: [PATCH 1/7] ux500: GIC: MASK_ON_SUSPEND
Message-ID: <1345625028-5608-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Etienne Carriere <etienne.carriere@stericsson.com>

ux500 machines performs pins (GPIO) reconfiguration when entering
in the suspended mode. This reconfiguration aims at reaching an ultra
low power HW configuration.

Due to this HW reconfiguration, some HW devices can change of HW state
and have their output signals at level that could generate IRQs.

If the non-wakeup IRQs are disabled but not yet masked (delayed interrupt
disable feature from the generic irq layer), effective interrupts reach
the system only because the system attempt to enter the suspended mode.

To prevent such IRQs to trig, all irq chips embedded in ux500 platform
should enable their IRQCHIP_MASK_ON_SUSPEND flag.

Signed-off-by: Etienne Carriere <etienne.carriere@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-ux500/cpu.c b/arch/arm/mach-ux500/cpu.c
index e2360e7..84d7f7e 100644
--- a/arch/arm/mach-ux500/cpu.c
+++ b/arch/arm/mach-ux500/cpu.c
@@ -51,6 +51,8 @@ void __init ux500_init_irq(void)
 	void __iomem *dist_base;
 	void __iomem *cpu_base;
 
+	gic_arch_extn.flags = IRQCHIP_MASK_ON_SUSPEND;
+
 	if (cpu_is_u8500_family()) {
 		dist_base = __io_address(U8500_GIC_DIST_BASE);
 		cpu_base = __io_address(U8500_GIC_CPU_BASE);
-- 
1.7.11.3
