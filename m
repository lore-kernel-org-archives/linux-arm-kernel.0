From: rpimentel.silva@gmail.com (Rogerio Pimentel)
Date: Mon, 25 Oct 2010 12:55:59 -0200
Subject: [PATCH 4/4] mx31_3ds: Add SDHC1 support to mx31_3ds
Message-ID: <AANLkTin8dRmLKaOQEMCsayK_=PifHvWdaatnm-==K96T@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add SDHC1 support to mx31_3ds

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
Signed-off-by: Rogerio Pimentel <rogerio.pimentel@freescale.com>

---
 arch/arm/mach-mx3/mach-mx31_3ds.c |   74 +++++++++++++++++++++++++++++++++++++
 1 files changed, 74 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx3/mach-mx31_3ds.c
b/arch/arm/mach-mx3/mach-mx31_3ds.c
index 9c23146..9b0a240 100644
--- a/arch/arm/mach-mx3/mach-mx31_3ds.c
+++ b/arch/arm/mach-mx3/mach-mx31_3ds.c
@@ -34,6 +34,7 @@
 #include <mach/common.h>
 #include <mach/iomux-mx3.h>
 #include <mach/3ds_debugboard.h>
+#include <mach/mmc.h>

 #include "devices-imx31.h"
 #include "devices.h"
@@ -41,6 +42,9 @@
 /* CPLD IRQ line for external uart, external ethernet etc */
 #define EXPIO_PARENT_INT	IOMUX_TO_IRQ(MX31_PIN_GPIO1_1)

+#define SDHC1_EN IOMUX_TO_GPIO(MX31_PIN_GPIO3_0)
+#define SDHC1_CD IOMUX_TO_GPIO(MX31_PIN_GPIO3_1)
+
 /*
  * This file contains the board-specific initialization routines.
  */
@@ -84,6 +88,15 @@ static int mx31_3ds_pins[] = {
 	MX31_PIN_KEY_COL1_KEY_COL1,
 	MX31_PIN_KEY_COL2_KEY_COL2,
 	MX31_PIN_KEY_COL3_KEY_COL3,
+	/* SDHC1 */
+	MX31_PIN_SD1_DATA3__SD1_DATA3,
+	MX31_PIN_SD1_DATA2__SD1_DATA2,
+	MX31_PIN_SD1_DATA1__SD1_DATA1,
+	MX31_PIN_SD1_DATA0__SD1_DATA0,
+	MX31_PIN_SD1_CLK__SD1_CLK,
+	MX31_PIN_SD1_CMD__SD1_CMD,
+	MX31_PIN_GPIO3_0__GPIO3_0,
+	MX31_PIN_GPIO3_1__GPIO3_1,
 };

 /*
@@ -115,6 +128,22 @@ static struct regulator_init_data pwgtx_init = {
 	},
 };

+static struct regulator_consumer_supply sdhc_consumers[] = {
+	{
+		.dev	= &mxcsdhc_device0.dev,
+		.supply	= "sdhc0_vcc",
+	},
+};
+
+static struct regulator_init_data sdhc_vreg_data = {
+	.constraints = {
+		.always_on = 1,
+		.boot_on = 1,
+	},
+	.num_consumer_supplies = ARRAY_SIZE(sdhc_consumers),
+	.consumer_supplies = sdhc_consumers,
+};
+
 static struct mc13783_regulator_init_data mx31_3ds_regulators[] = {
 	{
 		.id = MC13783_REGU_PWGT1SPI, /* Power Gate for ARM core. */
@@ -122,6 +151,9 @@ static struct mc13783_regulator_init_data
mx31_3ds_regulators[] = {
 	}, {
 		.id = MC13783_REGU_PWGT2SPI, /* Power Gate for L2 Cache. */
 		.init_data = &pwgtx_init,
+	}, {
+		.id = MC13783_REGU_GPO1,	 /* Power Gate for MMC1. */
+		.init_data = &sdhc_vreg_data,
 	},
 };

@@ -231,6 +263,44 @@ static void __init mx31_3ds_map_io(void)
 	mx31_map_io();
 }

+/*
+ * SDHC1
+ */
+static int mx31_3ds_sdhc1_init(struct device *dev,
+		irq_handler_t detect_irq, void *data)
+{
+	int ret;
+
+	ret = request_irq(gpio_to_irq(SDHC1_CD), detect_irq,
+		IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING, "mmc-detect", data);
+	return ret;
+}
+
+static void mx31_3ds_sdhc1_exit(struct device *dev, void *data)
+{
+	free_irq(gpio_to_irq(SDHC1_CD), data);
+	gpio_free(SDHC1_CD);
+}
+
+static struct imxmmc_platform_data mx31_3ds_sdhc_pdata = {
+	.init = mx31_3ds_sdhc1_init,
+	.exit = mx31_3ds_sdhc1_exit,
+};
+
+static void mx31_3ds_sdhc1_enable_level_translator(void)
+{
+	/* Turn on TXB0108 OE pin */
+	gpio_request(MX31_PIN_GPIO3_0__GPIO3_0, "sd1_enable");
+	gpio_direction_output(MX31_PIN_GPIO3_0__GPIO3_0, 1);
+}
+
+static void mx31_3ds_sdhc1_enable_card_detect(void)
+{
+	/* Turn on card detection pin */
+	gpio_request(IOMUX_TO_GPIO(MX31_PIN_GPIO1_3), "pmic-irq");
+	gpio_direction_input(IOMUX_TO_GPIO(MX31_PIN_GPIO1_3));
+}
+
 /*!
  * Board specific initialization.
  */
@@ -239,9 +309,12 @@ static void __init mxc_board_init(void)
 	mxc_iomux_setup_multiple_pins(mx31_3ds_pins, ARRAY_SIZE(mx31_3ds_pins),
 				      "mx31_3ds");

+	mx31_3ds_sdhc1_enable_level_translator();
 	imx31_add_imx_uart0(&uart_pdata);
 	imx31_add_mxc_nand(&mx31_3ds_nand_board_info);

+	mx31_3ds_sdhc1_enable_card_detect();
+
 	imx31_add_spi_imx1(&spi1_pdata);
 	spi_register_board_info(mx31_3ds_spi_devs,
 						ARRAY_SIZE(mx31_3ds_spi_devs));
@@ -250,6 +323,7 @@ static void __init mxc_board_init(void)

 	mx31_3ds_usbotg_init();
 	mxc_register_device(&mxc_otg_udc_device, &usbotg_pdata);
+	mxc_register_device(&mxcsdhc_device0, &mx31_3ds_sdhc_pdata);

 	if (mxc_expio_init(CS5_BASE_ADDR, EXPIO_PARENT_INT))
 		printk(KERN_WARNING "Init of the debug board failed, all "
-- 
1.7.0.4
