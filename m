From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 21:05:48 +0900
Subject: [PATCH 04/14] ARM: shmobile: INTC External IRQ pin driver on r8a7779
In-Reply-To: <1363608358-24215-1-git-send-email-horms+renesas@verge.net.au>
References: <1363608358-24215-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363608358-24215-5-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Update the r8a7779 IRQ code to make use of the
INTC External IRQ pin driver for external
interrupt pins IRQ0 -> IRQ3.

The r8a7779 SoC can like older SH SoCs configure
to use the IRQ0 -> IRQ3 signals as individual
interrupts or a combined IRL mode.

Without this patch the r8a7779 SoC code does
not fully support external IRQ pins in individual
IRQ mode. The r8a7779 PFC code does not yet have
gpio_to_irq() support so no need to update such
code.

At this point the DT reference implementations
are not covered. In the future such code shall
tie in the INTC External IRQ pin driver via
DT, so this kind of verbose code is not needed
for the long term DT case.

Signed-off-by: Magnus Damm <damm@opensource.se>
Tested-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Kconfig               |    1 +
 arch/arm/mach-shmobile/include/mach/common.h |    1 +
 arch/arm/mach-shmobile/intc-r8a7779.c        |   53 +++++++++++++++++++++++++-
 3 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index f964accb..75d413c 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -32,6 +32,7 @@ config ARCH_R8A7779
 	select SH_CLK_CPG
 	select USB_ARCH_HAS_EHCI
 	select USB_ARCH_HAS_OHCI
+	select RENESAS_INTC_IRQPIN
 
 config ARCH_EMEV2
 	bool "Emma Mobile EV2"
diff --git a/arch/arm/mach-shmobile/include/mach/common.h b/arch/arm/mach-shmobile/include/mach/common.h
index 86fcdf9..03f73de 100644
--- a/arch/arm/mach-shmobile/include/mach/common.h
+++ b/arch/arm/mach-shmobile/include/mach/common.h
@@ -61,6 +61,7 @@ extern void r8a7740_pm_init(void);
 
 extern void r8a7779_init_delay(void);
 extern void r8a7779_init_irq(void);
+extern void r8a7779_init_irq_extpin(int irlm);
 extern void r8a7779_init_irq_dt(void);
 extern void r8a7779_map_io(void);
 extern void r8a7779_earlytimer_init(void);
diff --git a/arch/arm/mach-shmobile/intc-r8a7779.c b/arch/arm/mach-shmobile/intc-r8a7779.c
index f9cc4bc..fb0363c 100644
--- a/arch/arm/mach-shmobile/intc-r8a7779.c
+++ b/arch/arm/mach-shmobile/intc-r8a7779.c
@@ -19,13 +19,16 @@
  */
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/platform_device.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/io.h>
 #include <linux/irqchip/arm-gic.h>
-#include <mach/common.h>
+#include <linux/platform_data/irq-renesas-intc-irqpin.h>
 #include <linux/irqchip.h>
+#include <mach/common.h>
 #include <mach/intc.h>
+#include <mach/irqs.h>
 #include <mach/r8a7779.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -39,6 +42,54 @@
 #define INT2NTSR0 IOMEM(0xfe700060)
 #define INT2NTSR1 IOMEM(0xfe700064)
 
+struct renesas_intc_irqpin_config irqpin0_platform_data = {
+	.irq_base = irq_pin(0), /* IRQ0 -> IRQ3 */
+	.sense_bitfield_width = 2,
+};
+
+static struct resource irqpin0_resources[] = {
+	DEFINE_RES_MEM(0xfe78001c, 4), /* ICR1 */
+	DEFINE_RES_MEM(0xfe780010, 4), /* INTPRI */
+	DEFINE_RES_MEM(0xfe780024, 4), /* INTREQ */
+	DEFINE_RES_MEM(0xfe780044, 4), /* INTMSK0 */
+	DEFINE_RES_MEM(0xfe780064, 4), /* INTMSKCLR0 */
+	DEFINE_RES_IRQ(gic_spi(27)), /* IRQ0 */
+	DEFINE_RES_IRQ(gic_spi(28)), /* IRQ1 */
+	DEFINE_RES_IRQ(gic_spi(29)), /* IRQ2 */
+	DEFINE_RES_IRQ(gic_spi(30)), /* IRQ3 */
+};
+
+static struct platform_device irqpin0_device = {
+	.name		= "renesas_intc_irqpin",
+	.id		= 0,
+	.resource	= irqpin0_resources,
+	.num_resources	= ARRAY_SIZE(irqpin0_resources),
+	.dev		= {
+		.platform_data	= &irqpin0_platform_data,
+	},
+};
+
+void __init r8a7779_init_irq_extpin(int irlm)
+{
+	void __iomem *icr0 = ioremap_nocache(0xfe780000, PAGE_SIZE);
+	unsigned long tmp;
+
+	if (icr0) {
+		tmp = ioread32(icr0);
+		if (irlm)
+			tmp |= 1 << 23; /* IRQ0 -> IRQ3 as individual pins */
+		else
+			tmp &= ~(1 << 23); /* IRL mode - not supported */
+		tmp |= (1 << 21); /* LVLMODE = 1 */
+		iowrite32(tmp, icr0);
+		iounmap(icr0);
+
+		if (irlm)
+			platform_device_register(&irqpin0_device);
+	} else
+		pr_warn("r8a7779: unable to setup external irq pin mode\n");
+}
+
 static int r8a7779_set_wake(struct irq_data *data, unsigned int on)
 {
 	return 0; /* always allow wakeup */
-- 
1.7.10.4
