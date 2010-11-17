From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 17 Nov 2010 22:30:10 +0100
Subject: [PATCH 42/51] ARM: mx3: move registration of gpios to plat-mxc/gpio.c
In-Reply-To: <20101117212821.GF8942@pengutronix.de>
References: <20101117212821.GF8942@pengutronix.de>
Message-ID: <1290029419-21435-42-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx3/devices.c |   28 ----------------------------
 arch/arm/mach-mx3/mm.c      |   23 ++++++++++++-----------
 arch/arm/plat-mxc/gpio.c    |   22 ++++++++++++++++++++++
 3 files changed, 34 insertions(+), 39 deletions(-)

diff --git a/arch/arm/mach-mx3/devices.c b/arch/arm/mach-mx3/devices.c
index 5808ce1..b179f70 100644
--- a/arch/arm/mach-mx3/devices.c
+++ b/arch/arm/mach-mx3/devices.c
@@ -29,31 +29,6 @@
 
 #include "devices.h"
 
-/* GPIO port description */
-static struct mxc_gpio_port imx_gpio_ports[] = {
-	{
-		.chip.label = "gpio-0",
-		.base = MX31_IO_ADDRESS(MX31_GPIO1_BASE_ADDR),
-		.irq = MX3x_INT_GPIO1,
-		.virtual_irq_start = MXC_GPIO_IRQ_START,
-	}, {
-		.chip.label = "gpio-1",
-		.base = MX31_IO_ADDRESS(MX31_GPIO2_BASE_ADDR),
-		.irq = MX3x_INT_GPIO2,
-		.virtual_irq_start = MXC_GPIO_IRQ_START + 32,
-	}, {
-		.chip.label = "gpio-2",
-		.base = MX31_IO_ADDRESS(MX31_GPIO3_BASE_ADDR),
-		.irq = MX3x_INT_GPIO3,
-		.virtual_irq_start = MXC_GPIO_IRQ_START + 64,
-	}
-};
-
-int __init imx3x_register_gpios(void)
-{
-	return mxc_gpio_init(imx_gpio_ports, ARRAY_SIZE(imx_gpio_ports));
-}
-
 #ifdef CONFIG_ARCH_MX31
 static struct resource mxcsdhc0_resources[] = {
 	{
@@ -330,9 +305,6 @@ static int __init mx3_devices_init(void)
 #endif
 #if defined(CONFIG_ARCH_MX35)
 	if (cpu_is_mx35()) {
-		imx_gpio_ports[0].base = MX35_IO_ADDRESS(MX35_GPIO1_BASE_ADDR),
-		imx_gpio_ports[1].base = MX35_IO_ADDRESS(MX35_GPIO2_BASE_ADDR),
-		imx_gpio_ports[2].base = MX35_IO_ADDRESS(MX35_GPIO3_BASE_ADDR),
 		otg_resources[0].start = MX35_OTG_BASE_ADDR;
 		otg_resources[0].end = MX35_OTG_BASE_ADDR + 0x1ff;
 		otg_resources[1].start = MX35_INT_USBOTG;
diff --git a/arch/arm/mach-mx3/mm.c b/arch/arm/mach-mx3/mm.c
index 193c18c..998c3d7 100644
--- a/arch/arm/mach-mx3/mm.c
+++ b/arch/arm/mach-mx3/mm.c
@@ -57,7 +57,14 @@ void __init mx31_map_io(void)
 
 	iotable_init(mx31_io_desc, ARRAY_SIZE(mx31_io_desc));
 }
-#endif
+
+int imx31_register_gpios(void);
+void __init mx31_init_irq(void)
+{
+	mxc_init_irq(MX31_IO_ADDRESS(MX31_AVIC_BASE_ADDR));
+	imx31_register_gpios();
+}
+#endif /* ifdef CONFIG_ARCH_MX31 */
 
 #ifdef CONFIG_ARCH_MX35
 static struct map_desc mx35_io_desc[] __initdata = {
@@ -76,20 +83,14 @@ void __init mx35_map_io(void)
 
 	iotable_init(mx35_io_desc, ARRAY_SIZE(mx35_io_desc));
 }
-#endif
-
-int imx3x_register_gpios(void);
-
-void __init mx31_init_irq(void)
-{
-	mxc_init_irq(MX31_IO_ADDRESS(MX3x_AVIC_BASE_ADDR));
-	imx3x_register_gpios();
-}
 
+int imx35_register_gpios(void);
 void __init mx35_init_irq(void)
 {
-	mx31_init_irq();
+	mxc_init_irq(MX35_IO_ADDRESS(MX35_AVIC_BASE_ADDR));
+	imx35_register_gpios();
 }
+#endif /* ifdef CONFIG_ARCH_MX35 */
 
 #ifdef CONFIG_CACHE_L2X0
 static int mxc_init_l2x0(void)
diff --git a/arch/arm/plat-mxc/gpio.c b/arch/arm/plat-mxc/gpio.c
index c853bfa..2fb1efa 100644
--- a/arch/arm/plat-mxc/gpio.c
+++ b/arch/arm/plat-mxc/gpio.c
@@ -420,3 +420,25 @@ static struct mxc_gpio_port imx27_gpio_ports[] = {
 DEFINE_REGISTER_FUNCTION(imx27)
 
 #endif /* if defined(CONFIG_SOC_IMX27) */
+
+#if defined(CONFIG_ARCH_MX31)
+static struct mxc_gpio_port imx31_gpio_ports[] = {
+	DEFINE_IMX_GPIO_PORT_IRQ(MX31, 0, 1, MX31_INT_GPIO1),
+	DEFINE_IMX_GPIO_PORT_IRQ(MX31, 1, 2, MX31_INT_GPIO2),
+	DEFINE_IMX_GPIO_PORT_IRQ(MX31, 2, 3, MX31_INT_GPIO3),
+};
+
+DEFINE_REGISTER_FUNCTION(imx31)
+
+#endif /* if defined(CONFIG_ARCH_MX31) */
+
+#if defined(CONFIG_ARCH_MX35)
+static struct mxc_gpio_port imx35_gpio_ports[] = {
+	DEFINE_IMX_GPIO_PORT_IRQ(MX35, 0, 1, MX35_INT_GPIO1),
+	DEFINE_IMX_GPIO_PORT_IRQ(MX35, 1, 2, MX35_INT_GPIO2),
+	DEFINE_IMX_GPIO_PORT_IRQ(MX35, 2, 3, MX35_INT_GPIO3),
+};
+
+DEFINE_REGISTER_FUNCTION(imx35)
+
+#endif /* if defined(CONFIG_ARCH_MX35) */
-- 
1.7.2.3
