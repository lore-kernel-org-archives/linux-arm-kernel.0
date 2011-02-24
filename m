From: eric@eukrea.com (=?UTF-8?q?Eric=20B=C3=A9nard?=)
Date: Thu, 24 Feb 2011 22:42:17 +0100
Subject: [PATCH] i.MX51 & i.MX53: move registration of gpios to plat-mxc/gpio.c
Message-ID: <1298583737-3933-1-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric B?nard <eric@eukrea.com>
---
 arch/arm/mach-mx5/devices.c |   63 -------------------------------------------
 arch/arm/mach-mx5/mm.c      |   39 +++++++++++++++-----------
 arch/arm/plat-mxc/gpio.c    |   27 ++++++++++++++++++
 3 files changed, 49 insertions(+), 80 deletions(-)

diff --git a/arch/arm/mach-mx5/devices.c b/arch/arm/mach-mx5/devices.c
index 153ada5..8951312 100644
--- a/arch/arm/mach-mx5/devices.c
+++ b/arch/arm/mach-mx5/devices.c
@@ -119,66 +119,3 @@ struct platform_device mxc_usbh2_device = {
 		.coherent_dma_mask = DMA_BIT_MASK(32),
 	},
 };
-
-static struct mxc_gpio_port mxc_gpio_ports[] = {
-	{
-		.chip.label = "gpio-0",
-		.base = MX51_IO_ADDRESS(MX51_GPIO1_BASE_ADDR),
-		.irq = MX51_MXC_INT_GPIO1_LOW,
-		.irq_high = MX51_MXC_INT_GPIO1_HIGH,
-		.virtual_irq_start = MXC_GPIO_IRQ_START
-	},
-	{
-		.chip.label = "gpio-1",
-		.base = MX51_IO_ADDRESS(MX51_GPIO2_BASE_ADDR),
-		.irq = MX51_MXC_INT_GPIO2_LOW,
-		.irq_high = MX51_MXC_INT_GPIO2_HIGH,
-		.virtual_irq_start = MXC_GPIO_IRQ_START + 32 * 1
-	},
-	{
-		.chip.label = "gpio-2",
-		.base = MX51_IO_ADDRESS(MX51_GPIO3_BASE_ADDR),
-		.irq = MX51_MXC_INT_GPIO3_LOW,
-		.irq_high = MX51_MXC_INT_GPIO3_HIGH,
-		.virtual_irq_start = MXC_GPIO_IRQ_START + 32 * 2
-	},
-	{
-		.chip.label = "gpio-3",
-		.base = MX51_IO_ADDRESS(MX51_GPIO4_BASE_ADDR),
-		.irq = MX51_MXC_INT_GPIO4_LOW,
-		.irq_high = MX51_MXC_INT_GPIO4_HIGH,
-		.virtual_irq_start = MXC_GPIO_IRQ_START + 32 * 3
-	},
-	{
-		.chip.label = "gpio-4",
-		.base = MX53_IO_ADDRESS(MX53_GPIO5_BASE_ADDR),
-		.irq = MX53_INT_GPIO5_LOW,
-		.irq_high = MX53_INT_GPIO5_HIGH,
-		.virtual_irq_start = MXC_GPIO_IRQ_START + 32 * 4
-	},
-	{
-		.chip.label = "gpio-5",
-		.base = MX53_IO_ADDRESS(MX53_GPIO6_BASE_ADDR),
-		.irq = MX53_INT_GPIO6_LOW,
-		.irq_high = MX53_INT_GPIO6_HIGH,
-		.virtual_irq_start = MXC_GPIO_IRQ_START + 32 * 5
-	},
-	{
-		.chip.label = "gpio-6",
-		.base = MX53_IO_ADDRESS(MX53_GPIO7_BASE_ADDR),
-		.irq = MX53_INT_GPIO7_LOW,
-		.irq_high = MX53_INT_GPIO7_HIGH,
-		.virtual_irq_start = MXC_GPIO_IRQ_START + 32 * 6
-	},
-};
-
-int __init imx51_register_gpios(void)
-{
-	return mxc_gpio_init(mxc_gpio_ports, 4);
-}
-
-int __init imx53_register_gpios(void)
-{
-	return mxc_gpio_init(mxc_gpio_ports, ARRAY_SIZE(mxc_gpio_ports));
-}
-
diff --git a/arch/arm/mach-mx5/mm.c b/arch/arm/mach-mx5/mm.c
index 457f9f9..c6d6787 100644
--- a/arch/arm/mach-mx5/mm.c
+++ b/arch/arm/mach-mx5/mm.c
@@ -20,6 +20,7 @@
 #include <mach/common.h>
 #include <mach/iomux-v3.h>
 
+#if defined(CONFIG_SOC_IMX51)
 /*
  * Define the MX51 memory map.
  */
@@ -32,15 +33,6 @@ static struct map_desc mx51_io_desc[] __initdata = {
 };
 
 /*
- * Define the MX53 memory map.
- */
-static struct map_desc mx53_io_desc[] __initdata = {
-	imx_map_entry(MX53, AIPS1, MT_DEVICE),
-	imx_map_entry(MX53, SPBA0, MT_DEVICE),
-	imx_map_entry(MX53, AIPS2, MT_DEVICE),
-};
-
-/*
  * This function initializes the memory map. It is called during the
  * system startup to create static physical to virtual memory mappings
  * for the IO modules.
@@ -53,14 +45,6 @@ void __init mx51_map_io(void)
 	iotable_init(mx51_io_desc, ARRAY_SIZE(mx51_io_desc));
 }
 
-void __init mx53_map_io(void)
-{
-	mxc_set_cpu_type(MXC_CPU_MX53);
-	mxc_iomux_v3_init(MX53_IO_ADDRESS(MX53_IOMUXC_BASE_ADDR));
-	mxc_arch_reset_init(MX53_IO_ADDRESS(MX53_WDOG_BASE_ADDR));
-	iotable_init(mx53_io_desc, ARRAY_SIZE(mx53_io_desc));
-}
-
 int imx51_register_gpios(void);
 
 void __init mx51_init_irq(void)
@@ -80,6 +64,26 @@ void __init mx51_init_irq(void)
 	tzic_init_irq(tzic_virt);
 	imx51_register_gpios();
 }
+#endif /* if defined(CONFIG_SOC_IMX51) */
+
+#if defined(CONFIG_SOC_IMX53)
+
+/*
+ * Define the MX53 memory map.
+ */
+static struct map_desc mx53_io_desc[] __initdata = {
+	imx_map_entry(MX53, AIPS1, MT_DEVICE),
+	imx_map_entry(MX53, SPBA0, MT_DEVICE),
+	imx_map_entry(MX53, AIPS2, MT_DEVICE),
+};
+
+void __init mx53_map_io(void)
+{
+	mxc_set_cpu_type(MXC_CPU_MX53);
+	mxc_iomux_v3_init(MX53_IO_ADDRESS(MX53_IOMUXC_BASE_ADDR));
+	mxc_arch_reset_init(MX53_IO_ADDRESS(MX53_WDOG_BASE_ADDR));
+	iotable_init(mx53_io_desc, ARRAY_SIZE(mx53_io_desc));
+}
 
 int imx53_register_gpios(void);
 
@@ -97,3 +101,4 @@ void __init mx53_init_irq(void)
 	tzic_init_irq(tzic_virt);
 	imx53_register_gpios();
 }
+#endif /* if defined(CONFIG_SOC_IMX53) */
diff --git a/arch/arm/plat-mxc/gpio.c b/arch/arm/plat-mxc/gpio.c
index d17b3c9..b204b45 100644
--- a/arch/arm/plat-mxc/gpio.c
+++ b/arch/arm/plat-mxc/gpio.c
@@ -459,3 +459,30 @@ static struct mxc_gpio_port imx50_gpio_ports[] = {
 DEFINE_REGISTER_FUNCTION(imx50)
 
 #endif /* if defined(CONFIG_SOC_IMX50) */
+
+#if defined(CONFIG_SOC_IMX51)
+static struct mxc_gpio_port imx51_gpio_ports[] = {
+	DEFINE_IMX_GPIO_PORT_IRQ_HIGH(MX51, 0, 1, MX51_MXC_INT_GPIO1_LOW, MX51_MXC_INT_GPIO1_HIGH),
+	DEFINE_IMX_GPIO_PORT_IRQ_HIGH(MX51, 1, 2, MX51_MXC_INT_GPIO2_LOW, MX51_MXC_INT_GPIO2_HIGH),
+	DEFINE_IMX_GPIO_PORT_IRQ_HIGH(MX51, 2, 3, MX51_MXC_INT_GPIO3_LOW, MX51_MXC_INT_GPIO3_HIGH),
+	DEFINE_IMX_GPIO_PORT_IRQ_HIGH(MX51, 3, 4, MX51_MXC_INT_GPIO4_LOW, MX51_MXC_INT_GPIO4_HIGH),
+};
+
+DEFINE_REGISTER_FUNCTION(imx51)
+
+#endif /* if defined(CONFIG_SOC_IMX51) */
+
+#if defined(CONFIG_SOC_IMX53)
+static struct mxc_gpio_port imx53_gpio_ports[] = {
+	DEFINE_IMX_GPIO_PORT_IRQ_HIGH(MX51, 0, 1, MX51_MXC_INT_GPIO1_LOW, MX51_MXC_INT_GPIO1_HIGH),
+	DEFINE_IMX_GPIO_PORT_IRQ_HIGH(MX51, 1, 2, MX51_MXC_INT_GPIO2_LOW, MX51_MXC_INT_GPIO2_HIGH),
+	DEFINE_IMX_GPIO_PORT_IRQ_HIGH(MX51, 2, 3, MX51_MXC_INT_GPIO3_LOW, MX51_MXC_INT_GPIO3_HIGH),
+	DEFINE_IMX_GPIO_PORT_IRQ_HIGH(MX51, 3, 4, MX51_MXC_INT_GPIO4_LOW, MX51_MXC_INT_GPIO4_HIGH),
+	DEFINE_IMX_GPIO_PORT_IRQ_HIGH(MX51, 4, 5, MX53_INT_GPIO5_LOW, MX53_INT_GPIO5_HIGH),
+	DEFINE_IMX_GPIO_PORT_IRQ_HIGH(MX51, 5, 6, MX53_INT_GPIO6_LOW, MX53_INT_GPIO6_HIGH),
+	DEFINE_IMX_GPIO_PORT_IRQ_HIGH(MX51, 6, 7, MX53_INT_GPIO7_LOW, MX53_INT_GPIO7_HIGH),
+};
+
+DEFINE_REGISTER_FUNCTION(imx53)
+
+#endif /* if defined(CONFIG_SOC_IMX53) */
-- 
1.7.4
