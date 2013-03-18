From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 21:05:47 +0900
Subject: [PATCH 03/14] ARM: shmobile: INTC External IRQ pin driver on sh73a0
In-Reply-To: <1363608358-24215-1-git-send-email-horms+renesas@verge.net.au>
References: <1363608358-24215-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363608358-24215-4-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Adjust the sh73a0 IRQ code to make use of the
INTC External IRQ pin driver for external
interrupt pins IRQ0 -> IRQ31.

This removes quite a bit of special-case code
in intc-sh73a0.c but the number of lines get
replaced with platform device information in
setup-sh73a0.c. The PFC code is also adjusted
to make gpio_to_irq() return the correct
interrupt number.

At this point the DT reference implementations
are not covered. In the future such code shall
tie in the INTC External IRQ pin driver via
DT, so this kind of verbose code is not needed
for the long term DT case.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Kconfig        |    1 +
 arch/arm/mach-shmobile/board-kzm9g.c  |   14 ++--
 arch/arm/mach-shmobile/intc-sh73a0.c  |  117 ------------------------------
 arch/arm/mach-shmobile/setup-sh73a0.c |  126 +++++++++++++++++++++++++++++++++
 drivers/pinctrl/sh-pfc/pfc-sh73a0.c   |    6 +-
 5 files changed, 137 insertions(+), 127 deletions(-)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 9255546..f964accb 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -16,6 +16,7 @@ config ARCH_SH73A0
 	select CPU_V7
 	select I2C
 	select SH_CLK_CPG
+	select RENESAS_INTC_IRQPIN
 
 config ARCH_R8A7740
 	bool "R-Mobile A1 (R8A77400)"
diff --git a/arch/arm/mach-shmobile/board-kzm9g.c b/arch/arm/mach-shmobile/board-kzm9g.c
index 7f3a6b7..d34d12a 100644
--- a/arch/arm/mach-shmobile/board-kzm9g.c
+++ b/arch/arm/mach-shmobile/board-kzm9g.c
@@ -81,7 +81,7 @@ static struct resource smsc9221_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= intcs_evt2irq(0x260), /* IRQ3 */
+		.start	= irq_pin(3), /* IRQ3 */
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -115,7 +115,7 @@ static struct resource usb_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= intcs_evt2irq(0x220), /* IRQ1 */
+		.start	= irq_pin(1), /* IRQ1 */
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -138,7 +138,7 @@ struct usbhs_private {
 	struct renesas_usbhs_platform_info info;
 };
 
-#define IRQ15			intcs_evt2irq(0x03e0)
+#define IRQ15			irq_pin(15)
 #define USB_PHY_MODE		(1 << 4)
 #define USB_PHY_INT_EN		((1 << 3) | (1 << 2))
 #define USB_PHY_ON		(1 << 1)
@@ -563,25 +563,25 @@ static struct i2c_board_info i2c0_devices[] = {
 	},
 	{
 		I2C_BOARD_INFO("ak8975", 0x0c),
-		.irq = intcs_evt2irq(0x3380), /* IRQ28 */
+		.irq = irq_pin(28), /* IRQ28 */
 	},
 	{
 		I2C_BOARD_INFO("adxl34x", 0x1d),
-		.irq = intcs_evt2irq(0x3340), /* IRQ26 */
+		.irq = irq_pin(26), /* IRQ26 */
 	},
 };
 
 static struct i2c_board_info i2c1_devices[] = {
 	{
 		I2C_BOARD_INFO("st1232-ts", 0x55),
-		.irq = intcs_evt2irq(0x300), /* IRQ8 */
+		.irq = irq_pin(8), /* IRQ8 */
 	},
 };
 
 static struct i2c_board_info i2c3_devices[] = {
 	{
 		I2C_BOARD_INFO("pcf8575", 0x20),
-		.irq		= intcs_evt2irq(0x3260), /* IRQ19 */
+		.irq = irq_pin(19), /* IRQ19 */
 		.platform_data = &pcf8575_pdata,
 	},
 };
diff --git a/arch/arm/mach-shmobile/intc-sh73a0.c b/arch/arm/mach-shmobile/intc-sh73a0.c
index a81a1d8..19a26f4 100644
--- a/arch/arm/mach-shmobile/intc-sh73a0.c
+++ b/arch/arm/mach-shmobile/intc-sh73a0.c
@@ -260,108 +260,6 @@ static int sh73a0_set_wake(struct irq_data *data, unsigned int on)
 	return 0; /* always allow wakeup */
 }
 
-#define RELOC_BASE 0x1200
-
-/* INTCA IRQ pins@INTCS + RELOC_BASE to make space for GIC+INTC handling */
-#define INTCS_VECT_RELOC(n, vect) INTCS_VECT((n), (vect) + RELOC_BASE)
-
-INTC_IRQ_PINS_32(intca_irq_pins, 0xe6900000,
-		 INTCS_VECT_RELOC, "sh73a0-intca-irq-pins");
-
-static int to_gic_irq(struct irq_data *data)
-{
-	unsigned int vect = irq2evt(data->irq) - INTCS_VECT_BASE;
-
-	if (vect >= 0x3200)
-		vect -= 0x3000;
-	else
-		vect -= 0x0200;
-
-	return gic_spi((vect >> 5) + 1);
-}
-
-static int to_intca_reloc_irq(struct irq_data *data)
-{
-	return data->irq + (RELOC_BASE >> 5);
-}
-
-#define irq_cb(cb, irq) irq_get_chip(irq)->cb(irq_get_irq_data(irq))
-#define irq_cbp(cb, irq, p...) irq_get_chip(irq)->cb(irq_get_irq_data(irq), p)
-
-static void intca_gic_enable(struct irq_data *data)
-{
-	irq_cb(irq_unmask, to_intca_reloc_irq(data));
-	irq_cb(irq_unmask, to_gic_irq(data));
-}
-
-static void intca_gic_disable(struct irq_data *data)
-{
-	irq_cb(irq_mask, to_gic_irq(data));
-	irq_cb(irq_mask, to_intca_reloc_irq(data));
-}
-
-static void intca_gic_mask_ack(struct irq_data *data)
-{
-	irq_cb(irq_mask, to_gic_irq(data));
-	irq_cb(irq_mask_ack, to_intca_reloc_irq(data));
-}
-
-static void intca_gic_eoi(struct irq_data *data)
-{
-	irq_cb(irq_eoi, to_gic_irq(data));
-}
-
-static int intca_gic_set_type(struct irq_data *data, unsigned int type)
-{
-	return irq_cbp(irq_set_type, to_intca_reloc_irq(data), type);
-}
-
-#ifdef CONFIG_SMP
-static int intca_gic_set_affinity(struct irq_data *data,
-				  const struct cpumask *cpumask,
-				  bool force)
-{
-	return irq_cbp(irq_set_affinity, to_gic_irq(data), cpumask, force);
-}
-#endif
-
-struct irq_chip intca_gic_irq_chip = {
-	.name			= "INTCA-GIC",
-	.irq_mask		= intca_gic_disable,
-	.irq_unmask		= intca_gic_enable,
-	.irq_mask_ack		= intca_gic_mask_ack,
-	.irq_eoi		= intca_gic_eoi,
-	.irq_enable		= intca_gic_enable,
-	.irq_disable		= intca_gic_disable,
-	.irq_shutdown		= intca_gic_disable,
-	.irq_set_type		= intca_gic_set_type,
-	.irq_set_wake		= sh73a0_set_wake,
-#ifdef CONFIG_SMP
-	.irq_set_affinity	= intca_gic_set_affinity,
-#endif
-};
-
-static int to_intc_vect(int irq)
-{
-	unsigned int irq_pin = irq - gic_spi(1);
-	unsigned int offs;
-
-	if (irq_pin < 16)
-		offs = 0x0200;
-	else
-		offs = 0x3000;
-
-	return offs + (irq_pin << 5);
-}
-
-static irqreturn_t sh73a0_irq_pin_demux(int irq, void *dev_id)
-{
-	generic_handle_irq(intcs_evt2irq(to_intc_vect(irq)));
-	return IRQ_HANDLED;
-}
-
-static struct irqaction sh73a0_irq_pin_cascade[32];
-
 #define PINTER0_PHYS 0xe69000a0
 #define PINTER1_PHYS 0xe69000a4
 #define PINTER0_VIRT IOMEM(0xe69000a0)
@@ -422,13 +320,11 @@ void __init sh73a0_init_irq(void)
 	void __iomem *gic_dist_base = IOMEM(0xf0001000);
 	void __iomem *gic_cpu_base = IOMEM(0xf0000100);
 	void __iomem *intevtsa = ioremap_nocache(0xffd20100, PAGE_SIZE);
-	int k, n;
 
 	gic_init(0, 29, gic_dist_base, gic_cpu_base);
 	gic_arch_extn.irq_set_wake = sh73a0_set_wake;
 
 	register_intc_controller(&intcs_desc);
-	register_intc_controller(&intca_irq_pins_desc);
 	register_intc_controller(&intc_pint0_desc);
 	register_intc_controller(&intc_pint1_desc);
 
@@ -438,19 +334,6 @@ void __init sh73a0_init_irq(void)
 	sh73a0_intcs_cascade.dev_id = intevtsa;
 	setup_irq(gic_spi(50), &sh73a0_intcs_cascade);
 
-	/* IRQ pins require special handling through INTCA and GIC */
-	for (k = 0; k < 32; k++) {
-		sh73a0_irq_pin_cascade[k].name = "INTCA-GIC cascade";
-		sh73a0_irq_pin_cascade[k].handler = sh73a0_irq_pin_demux;
-		setup_irq(gic_spi(1 + k), &sh73a0_irq_pin_cascade[k]);
-
-		n = intcs_evt2irq(to_intc_vect(gic_spi(1 + k)));
-		WARN_ON(irq_alloc_desc_at(n, numa_node_id()) != n);
-		irq_set_chip_and_handler_name(n, &intca_gic_irq_chip,
-					      handle_level_irq, "level");
-		set_irq_flags(n, IRQF_VALID); /* yuck */
-	}
-
 	/* PINT pins are sanely tied to the GIC as SPI */
 	sh73a0_pint0_cascade.name = "PINT0 cascade";
 	sh73a0_pint0_cascade.handler = sh73a0_pint0_demux;
diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
index 2257a91..638735f 100644
--- a/arch/arm/mach-shmobile/setup-sh73a0.c
+++ b/arch/arm/mach-shmobile/setup-sh73a0.c
@@ -33,6 +33,7 @@
 #include <linux/sh_intc.h>
 #include <linux/sh_timer.h>
 #include <linux/platform_data/sh_ipmmu.h>
+#include <linux/platform_data/irq-renesas-intc-irqpin.h>
 #include <mach/dma-register.h>
 #include <mach/hardware.h>
 #include <mach/irqs.h>
@@ -811,6 +812,127 @@ static struct platform_device ipmmu_device = {
 	.num_resources  = ARRAY_SIZE(ipmmu_resources),
 };
 
+struct renesas_intc_irqpin_config irqpin0_platform_data = {
+	.irq_base = irq_pin(0), /* IRQ0 -> IRQ7 */
+};
+
+static struct resource irqpin0_resources[] = {
+	DEFINE_RES_MEM(0xe6900000, 4), /* ICR1A */
+	DEFINE_RES_MEM(0xe6900010, 4), /* INTPRI00A */
+	DEFINE_RES_MEM(0xe6900020, 1), /* INTREQ00A */
+	DEFINE_RES_MEM(0xe6900040, 1), /* INTMSK00A */
+	DEFINE_RES_MEM(0xe6900060, 1), /* INTMSKCLR00A */
+	DEFINE_RES_IRQ(gic_spi(1)), /* IRQ0 */
+	DEFINE_RES_IRQ(gic_spi(2)), /* IRQ1 */
+	DEFINE_RES_IRQ(gic_spi(3)), /* IRQ2 */
+	DEFINE_RES_IRQ(gic_spi(4)), /* IRQ3 */
+	DEFINE_RES_IRQ(gic_spi(5)), /* IRQ4 */
+	DEFINE_RES_IRQ(gic_spi(6)), /* IRQ5 */
+	DEFINE_RES_IRQ(gic_spi(7)), /* IRQ6 */
+	DEFINE_RES_IRQ(gic_spi(8)), /* IRQ7 */
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
+struct renesas_intc_irqpin_config irqpin1_platform_data = {
+	.irq_base = irq_pin(8), /* IRQ8 -> IRQ15 */
+	.control_parent = true, /* Disable spurious IRQ10 */
+};
+
+static struct resource irqpin1_resources[] = {
+	DEFINE_RES_MEM(0xe6900004, 4), /* ICR2A */
+	DEFINE_RES_MEM(0xe6900014, 4), /* INTPRI10A */
+	DEFINE_RES_MEM(0xe6900024, 1), /* INTREQ10A */
+	DEFINE_RES_MEM(0xe6900044, 1), /* INTMSK10A */
+	DEFINE_RES_MEM(0xe6900064, 1), /* INTMSKCLR10A */
+	DEFINE_RES_IRQ(gic_spi(9)), /* IRQ8 */
+	DEFINE_RES_IRQ(gic_spi(10)), /* IRQ9 */
+	DEFINE_RES_IRQ(gic_spi(11)), /* IRQ10 */
+	DEFINE_RES_IRQ(gic_spi(12)), /* IRQ11 */
+	DEFINE_RES_IRQ(gic_spi(13)), /* IRQ12 */
+	DEFINE_RES_IRQ(gic_spi(14)), /* IRQ13 */
+	DEFINE_RES_IRQ(gic_spi(15)), /* IRQ14 */
+	DEFINE_RES_IRQ(gic_spi(16)), /* IRQ15 */
+};
+
+static struct platform_device irqpin1_device = {
+	.name		= "renesas_intc_irqpin",
+	.id		= 1,
+	.resource	= irqpin1_resources,
+	.num_resources	= ARRAY_SIZE(irqpin1_resources),
+	.dev		= {
+		.platform_data	= &irqpin1_platform_data,
+	},
+};
+
+struct renesas_intc_irqpin_config irqpin2_platform_data = {
+	.irq_base = irq_pin(16), /* IRQ16 -> IRQ23 */
+};
+
+static struct resource irqpin2_resources[] = {
+	DEFINE_RES_MEM(0xe6900008, 4), /* ICR3A */
+	DEFINE_RES_MEM(0xe6900018, 4), /* INTPRI20A */
+	DEFINE_RES_MEM(0xe6900028, 1), /* INTREQ20A */
+	DEFINE_RES_MEM(0xe6900048, 1), /* INTMSK20A */
+	DEFINE_RES_MEM(0xe6900068, 1), /* INTMSKCLR20A */
+	DEFINE_RES_IRQ(gic_spi(17)), /* IRQ16 */
+	DEFINE_RES_IRQ(gic_spi(18)), /* IRQ17 */
+	DEFINE_RES_IRQ(gic_spi(19)), /* IRQ18 */
+	DEFINE_RES_IRQ(gic_spi(20)), /* IRQ19 */
+	DEFINE_RES_IRQ(gic_spi(21)), /* IRQ20 */
+	DEFINE_RES_IRQ(gic_spi(22)), /* IRQ21 */
+	DEFINE_RES_IRQ(gic_spi(23)), /* IRQ22 */
+	DEFINE_RES_IRQ(gic_spi(24)), /* IRQ23 */
+};
+
+static struct platform_device irqpin2_device = {
+	.name		= "renesas_intc_irqpin",
+	.id		= 2,
+	.resource	= irqpin2_resources,
+	.num_resources	= ARRAY_SIZE(irqpin2_resources),
+	.dev		= {
+		.platform_data	= &irqpin2_platform_data,
+	},
+};
+
+struct renesas_intc_irqpin_config irqpin3_platform_data = {
+	.irq_base = irq_pin(24), /* IRQ24 -> IRQ31 */
+};
+
+static struct resource irqpin3_resources[] = {
+	DEFINE_RES_MEM(0xe690000c, 4), /* ICR4A */
+	DEFINE_RES_MEM(0xe690001c, 4), /* INTPRI30A */
+	DEFINE_RES_MEM(0xe690002c, 1), /* INTREQ30A */
+	DEFINE_RES_MEM(0xe690004c, 1), /* INTMSK30A */
+	DEFINE_RES_MEM(0xe690006c, 1), /* INTMSKCLR30A */
+	DEFINE_RES_IRQ(gic_spi(25)), /* IRQ24 */
+	DEFINE_RES_IRQ(gic_spi(26)), /* IRQ25 */
+	DEFINE_RES_IRQ(gic_spi(27)), /* IRQ26 */
+	DEFINE_RES_IRQ(gic_spi(28)), /* IRQ27 */
+	DEFINE_RES_IRQ(gic_spi(29)), /* IRQ28 */
+	DEFINE_RES_IRQ(gic_spi(30)), /* IRQ29 */
+	DEFINE_RES_IRQ(gic_spi(31)), /* IRQ30 */
+	DEFINE_RES_IRQ(gic_spi(32)), /* IRQ31 */
+};
+
+static struct platform_device irqpin3_device = {
+	.name		= "renesas_intc_irqpin",
+	.id		= 3,
+	.resource	= irqpin3_resources,
+	.num_resources	= ARRAY_SIZE(irqpin3_resources),
+	.dev		= {
+		.platform_data	= &irqpin3_platform_data,
+	},
+};
+
 static struct platform_device *sh73a0_devices_dt[] __initdata = {
 	&scif0_device,
 	&scif1_device,
@@ -839,6 +961,10 @@ static struct platform_device *sh73a0_late_devices[] __initdata = {
 	&dma0_device,
 	&mpdma0_device,
 	&pmu_device,
+	&irqpin0_device,
+	&irqpin1_device,
+	&irqpin2_device,
+	&irqpin3_device,
 };
 
 #define SRCR2          IOMEM(0xe61580b0)
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
index 709008e..6f15c03 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
@@ -2733,9 +2733,9 @@ static struct pinmux_data_reg pinmux_data_regs[] = {
 	{ },
 };
 
-/* IRQ pins through INTCS with IRQ0->15 from 0x200 and IRQ16-31 from 0x3200 */
-#define EXT_IRQ16L(n) intcs_evt2irq(0x200 + ((n) << 5))
-#define EXT_IRQ16H(n) intcs_evt2irq(0x3200 + ((n - 16) << 5))
+/* External IRQ pins mapped@IRQPIN_BASE */
+#define EXT_IRQ16L(n) irq_pin(n)
+#define EXT_IRQ16H(n) irq_pin(n)
 
 static struct pinmux_irq pinmux_irqs[] = {
 	PINMUX_IRQ(EXT_IRQ16H(19), PORT9_FN0),
-- 
1.7.10.4
