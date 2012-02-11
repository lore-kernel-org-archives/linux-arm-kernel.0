From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 11 Feb 2012 09:14:29 -0800
Subject: [PATCH 5/8] ARM: imx: eliminate macro IOMUX_TO_IRQ()
In-Reply-To: <1328980472-11923-1-git-send-email-shawn.guo@linaro.org>
References: <1328980472-11923-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1328980472-11923-6-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch changes all the static gpio irq number assigning with
IOMUX_TO_IRQ() to run-time assigning with gpio_to_irq call, and
in turn eliminates the macro IOMUX_TO_IRQ().

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/mach-armadillo5x0.c      |   12 ++++++++----
 arch/arm/mach-imx/mach-kzm_arm11_01.c      |   20 +++++++++++++++-----
 arch/arm/mach-imx/mach-mx31_3ds.c          |   13 ++++++-------
 arch/arm/mach-imx/mach-mx31ads.c           |   14 +++++++++-----
 arch/arm/mach-imx/mach-mx31lilly.c         |   10 +++++++---
 arch/arm/mach-imx/mach-mx31lite.c          |   10 +++++++---
 arch/arm/mach-imx/mach-mx31moboard.c       |    4 +++-
 arch/arm/mach-imx/mach-pcm037.c            |   18 ++++++++++++------
 arch/arm/mach-imx/mach-qong.c              |    9 +++++----
 arch/arm/mach-imx/mx31lilly-db.c           |    5 +++--
 arch/arm/mach-imx/mx31lite-db.c            |    5 +++--
 arch/arm/plat-mxc/include/mach/iomux-mx3.h |    3 ---
 12 files changed, 78 insertions(+), 45 deletions(-)

diff --git a/arch/arm/mach-imx/mach-armadillo5x0.c b/arch/arm/mach-imx/mach-armadillo5x0.c
index e4f426a..ad56ff0 100644
--- a/arch/arm/mach-imx/mach-armadillo5x0.c
+++ b/arch/arm/mach-imx/mach-armadillo5x0.c
@@ -406,7 +406,8 @@ static int armadillo5x0_sdhc1_init(struct device *dev,
 	gpio_direction_input(gpio_wp);
 
 	/* When supported the trigger type have to be BOTH */
-	ret = request_irq(IOMUX_TO_IRQ(MX31_PIN_ATA_DMACK), detect_irq,
+	ret = request_irq(gpio_to_irq(IOMUX_TO_GPIO(MX31_PIN_ATA_DMACK)),
+			  detect_irq,
 			  IRQF_DISABLED | IRQF_TRIGGER_FALLING,
 			  "sdhc-detect", data);
 
@@ -427,7 +428,7 @@ err_gpio_free:
 
 static void armadillo5x0_sdhc1_exit(struct device *dev, void *data)
 {
-	free_irq(IOMUX_TO_IRQ(MX31_PIN_ATA_DMACK), data);
+	free_irq(gpio_to_irq(IOMUX_TO_GPIO(MX31_PIN_ATA_DMACK)), data);
 	gpio_free(IOMUX_TO_GPIO(MX31_PIN_ATA_DMACK));
 	gpio_free(IOMUX_TO_GPIO(MX31_PIN_ATA_RESET_B));
 }
@@ -448,8 +449,7 @@ static struct resource armadillo5x0_smc911x_resources[] = {
 		.end	= MX31_CS3_BASE_ADDR + SZ_32M - 1,
 		.flags	= IORESOURCE_MEM,
 	}, {
-		.start	= IOMUX_TO_IRQ(MX31_PIN_GPIO1_0),
-		.end	= IOMUX_TO_IRQ(MX31_PIN_GPIO1_0),
+		/* irq number is run-time assigned */
 		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_LOWLEVEL,
 	},
 };
@@ -489,6 +489,10 @@ static void __init armadillo5x0_init(void)
 	mxc_iomux_setup_multiple_pins(armadillo5x0_pins,
 			ARRAY_SIZE(armadillo5x0_pins), "armadillo5x0");
 
+	armadillo5x0_smc911x_resources[1].start =
+			gpio_to_irq(IOMUX_TO_GPIO(MX31_PIN_GPIO1_0));
+	armadillo5x0_smc911x_resources[1].end =
+			gpio_to_irq(IOMUX_TO_GPIO(MX31_PIN_GPIO1_0));
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 	imx_add_gpio_keys(&armadillo5x0_button_data);
 	imx31_add_imx_i2c1(NULL);
diff --git a/arch/arm/mach-imx/mach-kzm_arm11_01.c b/arch/arm/mach-imx/mach-kzm_arm11_01.c
index fc78e80..e8b41ec 100644
--- a/arch/arm/mach-imx/mach-kzm_arm11_01.c
+++ b/arch/arm/mach-imx/mach-kzm_arm11_01.c
@@ -71,7 +71,7 @@ static struct plat_serial8250_port serial_platform_data[] = {
 	{
 		.membase	= KZM_ARM11_IO_ADDRESS(KZM_ARM11_16550),
 		.mapbase	= KZM_ARM11_16550,
-		.irq		= IOMUX_TO_IRQ(MX31_PIN_GPIO1_1),
+		/* irq number is run-time assigned */
 		.irqflags	= IRQ_TYPE_EDGE_RISING,
 		.uartclk	= 14745600,
 		.regshift	= 0,
@@ -89,8 +89,7 @@ static struct resource serial8250_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	{
-		.start	= IOMUX_TO_IRQ(MX31_PIN_GPIO1_1),
-		.end	= IOMUX_TO_IRQ(MX31_PIN_GPIO1_1),
+		/* irq number is run-time assigned */
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -123,6 +122,13 @@ static int __init kzm_init_ext_uart(void)
 	tmp |= 0x2;
 	__raw_writeb(tmp, KZM_ARM11_IO_ADDRESS(KZM_ARM11_CTL1));
 
+	serial_platform_data[0].irq =
+			gpio_to_irq(IOMUX_TO_GPIO(MX31_PIN_GPIO1_1));
+	serial8250_resources[1].start =
+			gpio_to_irq(IOMUX_TO_GPIO(MX31_PIN_GPIO1_1));
+	serial8250_resources[1].end =
+			gpio_to_irq(IOMUX_TO_GPIO(MX31_PIN_GPIO1_1));
+
 	return platform_device_register(&serial_device);
 }
 #else
@@ -150,8 +156,7 @@ static struct resource kzm_smsc9118_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	{
-		.start	= IOMUX_TO_IRQ(MX31_PIN_GPIO1_2),
-		.end	= IOMUX_TO_IRQ(MX31_PIN_GPIO1_2),
+		/* irq number is run-time assigned */
 		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHEDGE,
 	},
 };
@@ -175,6 +180,11 @@ static int __init kzm_init_smsc9118(void)
 	gpio_request(IOMUX_TO_GPIO(MX31_PIN_GPIO1_2), "smsc9118-int");
 	gpio_direction_input(IOMUX_TO_GPIO(MX31_PIN_GPIO1_2));
 
+	kzm_smsc9118_resources[1].start =
+			gpio_to_irq(IOMUX_TO_GPIO(MX31_PIN_GPIO1_2));
+	kzm_smsc9118_resources[1].end =
+			gpio_to_irq(IOMUX_TO_GPIO(MX31_PIN_GPIO1_2));
+
 	return platform_device_register(&kzm_smsc9118_device);
 }
 #else
diff --git a/arch/arm/mach-imx/mach-mx31_3ds.c b/arch/arm/mach-imx/mach-mx31_3ds.c
index 4d1aab1..ab56702 100644
--- a/arch/arm/mach-imx/mach-mx31_3ds.c
+++ b/arch/arm/mach-imx/mach-mx31_3ds.c
@@ -44,9 +44,6 @@
 
 #include "devices-imx31.h"
 
-/* CPLD IRQ line for external uart, external ethernet etc */
-#define EXPIO_PARENT_INT	IOMUX_TO_IRQ(MX31_PIN_GPIO1_1)
-
 static int mx31_3ds_pins[] = {
 	/* UART1 */
 	MX31_PIN_CTS1__CTS1,
@@ -312,7 +309,7 @@ static int mx31_3ds_sdhc1_init(struct device *dev,
 		return ret;
 	}
 
-	ret = request_irq(IOMUX_TO_IRQ(MX31_PIN_GPIO3_1),
+	ret = request_irq(gpio_to_irq(IOMUX_TO_GPIO(MX31_PIN_GPIO3_1)),
 			  detect_irq, IRQF_DISABLED |
 			  IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING,
 			  "sdhc1-detect", data);
@@ -331,7 +328,7 @@ gpio_free:
 
 static void mx31_3ds_sdhc1_exit(struct device *dev, void *data)
 {
-	free_irq(IOMUX_TO_IRQ(MX31_PIN_GPIO3_1), data);
+	free_irq(gpio_to_irq(IOMUX_TO_GPIO(MX31_PIN_GPIO3_1)), data);
 	gpio_free_array(mx31_3ds_sdhc1_gpios,
 			 ARRAY_SIZE(mx31_3ds_sdhc1_gpios));
 }
@@ -523,7 +520,7 @@ static struct spi_board_info mx31_3ds_spi_devs[] __initdata = {
 		.bus_num	= 1,
 		.chip_select	= 1, /* SS2 */
 		.platform_data	= &mc13783_pdata,
-		.irq		= IOMUX_TO_IRQ(MX31_PIN_GPIO1_3),
+		/* irq number is run-time assigned */
 		.mode = SPI_CS_HIGH,
 	}, {
 		.modalias	= "l4f00242t03",
@@ -698,6 +695,7 @@ static void __init mx31_3ds_init(void)
 	imx31_add_mxc_nand(&mx31_3ds_nand_board_info);
 
 	imx31_add_spi_imx1(&spi1_pdata);
+	mx31_3ds_spi_devs[0].irq = gpio_to_irq(IOMUX_TO_GPIO(MX31_PIN_GPIO1_3));
 	spi_register_board_info(mx31_3ds_spi_devs,
 						ARRAY_SIZE(mx31_3ds_spi_devs));
 
@@ -720,7 +718,8 @@ static void __init mx31_3ds_init(void)
 	if (!otg_mode_host)
 		imx31_add_fsl_usb2_udc(&usbotg_pdata);
 
-	if (mxc_expio_init(MX31_CS5_BASE_ADDR, EXPIO_PARENT_INT))
+	if (mxc_expio_init(MX31_CS5_BASE_ADDR,
+			   gpio_to_irq(IOMUX_TO_GPIO(MX31_PIN_GPIO1_1))))
 		printk(KERN_WARNING "Init of the debug board failed, all "
 				    "devices on the debug board are unusable.\n");
 	imx31_add_imx2_wdt(NULL);
diff --git a/arch/arm/mach-imx/mach-mx31ads.c b/arch/arm/mach-imx/mach-mx31ads.c
index 4917aab..2e878ee 100644
--- a/arch/arm/mach-imx/mach-mx31ads.c
+++ b/arch/arm/mach-imx/mach-mx31ads.c
@@ -60,7 +60,6 @@
 #define PBC_INTSTATUS_REG	(PBC_INTSTATUS + PBC_BASE_ADDRESS)
 #define PBC_INTMASK_SET_REG	(PBC_INTMASK_SET + PBC_BASE_ADDRESS)
 #define PBC_INTMASK_CLEAR_REG	(PBC_INTMASK_CLEAR + PBC_BASE_ADDRESS)
-#define EXPIO_PARENT_INT	IOMUX_TO_IRQ(MX31_PIN_GPIO1_4)
 
 #define MXC_IRQ_TO_EXPIO(irq)	((irq) - MXC_EXP_IO_BASE)
 
@@ -184,7 +183,7 @@ static struct irq_chip expio_irq_chip = {
 
 static void __init mx31ads_init_expio(void)
 {
-	int i;
+	int i, irq;
 
 	printk(KERN_INFO "MX31ADS EXPIO(CPLD) hardware\n");
 
@@ -201,8 +200,9 @@ static void __init mx31ads_init_expio(void)
 		irq_set_chip_and_handler(i, &expio_irq_chip, handle_level_irq);
 		set_irq_flags(i, IRQF_VALID);
 	}
-	irq_set_irq_type(EXPIO_PARENT_INT, IRQ_TYPE_LEVEL_HIGH);
-	irq_set_chained_handler(EXPIO_PARENT_INT, mx31ads_expio_irq_handler);
+	irq = gpio_to_irq(IOMUX_TO_GPIO(MX31_PIN_GPIO1_4));
+	irq_set_irq_type(irq, IRQ_TYPE_LEVEL_HIGH);
+	irq_set_chained_handler(irq, mx31ads_expio_irq_handler);
 }
 
 #ifdef CONFIG_MACH_MX31ADS_WM1133_EV1
@@ -463,13 +463,17 @@ static struct i2c_board_info __initdata mx31ads_i2c1_devices[] = {
 	{
 		I2C_BOARD_INFO("wm8350", 0x1a),
 		.platform_data = &mx31_wm8350_pdata,
-		.irq = IOMUX_TO_IRQ(MX31_PIN_GPIO1_3),
+		/* irq number is run-time assigned */
 	},
 #endif
 };
 
 static void __init mxc_init_i2c(void)
 {
+#ifdef CONFIG_MACH_MX31ADS_WM1133_EV1
+	mx31ads_i2c1_devices[0].irq =
+			gpio_to_irq(IOMUX_TO_GPIO(MX31_PIN_GPIO1_3));
+#endif
 	i2c_register_board_info(1, mx31ads_i2c1_devices,
 				ARRAY_SIZE(mx31ads_i2c1_devices));
 
diff --git a/arch/arm/mach-imx/mach-mx31lilly.c b/arch/arm/mach-imx/mach-mx31lilly.c
index 02401bb..2ba43aa 100644
--- a/arch/arm/mach-imx/mach-mx31lilly.c
+++ b/arch/arm/mach-imx/mach-mx31lilly.c
@@ -63,8 +63,7 @@ static struct resource smsc91x_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	{
-		.start	= IOMUX_TO_IRQ(MX31_PIN_GPIO1_0),
-		.end	= IOMUX_TO_IRQ(MX31_PIN_GPIO1_0),
+		/* irq number is run-time assigned */
 		.flags	= IORESOURCE_IRQ | IRQF_TRIGGER_FALLING,
 	}
 };
@@ -231,7 +230,7 @@ static struct spi_board_info mc13783_dev __initdata = {
 	.bus_num	= 1,
 	.chip_select	= 0,
 	.platform_data	= &mc13783_pdata,
-	.irq		= IOMUX_TO_IRQ(MX31_PIN_GPIO1_3),
+	/* irq number is run-time assigned */
 };
 
 static struct platform_device *devices[] __initdata = {
@@ -278,8 +277,13 @@ static void __init mx31lilly_board_init(void)
 
 	imx31_add_spi_imx0(&spi0_pdata);
 	imx31_add_spi_imx1(&spi1_pdata);
+	mc13783_dev.irq = gpio_to_irq(IOMUX_TO_GPIO(MX31_PIN_GPIO1_3));
 	spi_register_board_info(&mc13783_dev, 1);
 
+	smsc91x_resources[1].start =
+			gpio_to_irq(IOMUX_TO_GPIO(MX31_PIN_GPIO1_0));
+	smsc91x_resources[1].end =
+			gpio_to_irq(IOMUX_TO_GPIO(MX31_PIN_GPIO1_0));
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 
 	/* USB */
diff --git a/arch/arm/mach-imx/mach-mx31lite.c b/arch/arm/mach-imx/mach-mx31lite.c
index ef80751..8adb1fc 100644
--- a/arch/arm/mach-imx/mach-mx31lite.c
+++ b/arch/arm/mach-imx/mach-mx31lite.c
@@ -81,8 +81,7 @@ static struct resource smsc911x_resources[] = {
 		.end		= MX31_CS4_BASE_ADDR + 0x100,
 		.flags		= IORESOURCE_MEM,
 	}, {
-		.start		= IOMUX_TO_IRQ(MX31_PIN_SFS6),
-		.end		= IOMUX_TO_IRQ(MX31_PIN_SFS6),
+		/* irq number is run-time assigned */
 		.flags		= IORESOURCE_IRQ,
 	},
 };
@@ -122,7 +121,7 @@ static struct spi_board_info mc13783_spi_dev __initdata = {
 	.bus_num	= 1,
 	.chip_select    = 0,
 	.platform_data  = &mc13783_pdata,
-	.irq		= IOMUX_TO_IRQ(MX31_PIN_GPIO1_3),
+	/* irq number is run-time assigned */
 };
 
 /*
@@ -251,6 +250,7 @@ static void __init mx31lite_init(void)
 	imx31_add_mxc_nand(&mx31lite_nand_board_info);
 
 	imx31_add_spi_imx1(&spi1_pdata);
+	mc13783_spi_dev.irq = gpio_to_irq(IOMUX_TO_GPIO(MX31_PIN_GPIO1_3));
 	spi_register_board_info(&mc13783_spi_dev, 1);
 
 	/* USB */
@@ -265,6 +265,10 @@ static void __init mx31lite_init(void)
 		pr_warning("could not get LAN irq gpio\n");
 	else {
 		gpio_direction_input(IOMUX_TO_GPIO(MX31_PIN_SFS6));
+		smsc911x_resources[1].start =
+			gpio_to_irq(IOMUX_TO_GPIO(MX31_PIN_SFS6));
+		smsc911x_resources[1].end =
+			gpio_to_irq(IOMUX_TO_GPIO(MX31_PIN_SFS6));
 		platform_device_register(&smsc911x_device);
 	}
 }
diff --git a/arch/arm/mach-imx/mach-mx31moboard.c b/arch/arm/mach-imx/mach-mx31moboard.c
index f225262..4ff84c0 100644
--- a/arch/arm/mach-imx/mach-mx31moboard.c
+++ b/arch/arm/mach-imx/mach-mx31moboard.c
@@ -289,7 +289,7 @@ static struct mc13xxx_platform_data moboard_pmic = {
 static struct spi_board_info moboard_spi_board_info[] __initdata = {
 	{
 		.modalias = "mc13783",
-		.irq = IOMUX_TO_IRQ(MX31_PIN_GPIO1_3),
+		/* irq number is run-time assigned */
 		.max_speed_hz = 300000,
 		.bus_num = 1,
 		.chip_select = 0,
@@ -541,6 +541,8 @@ static void __init mx31moboard_init(void)
 
 	gpio_request(IOMUX_TO_GPIO(MX31_PIN_GPIO1_3), "pmic-irq");
 	gpio_direction_input(IOMUX_TO_GPIO(MX31_PIN_GPIO1_3));
+	moboard_spi_board_info[0].irq =
+			gpio_to_irq(IOMUX_TO_GPIO(MX31_PIN_GPIO1_3));
 	spi_register_board_info(moboard_spi_board_info,
 		ARRAY_SIZE(moboard_spi_board_info));
 
diff --git a/arch/arm/mach-imx/mach-pcm037.c b/arch/arm/mach-imx/mach-pcm037.c
index e48854b..92dc17c 100644
--- a/arch/arm/mach-imx/mach-pcm037.c
+++ b/arch/arm/mach-imx/mach-pcm037.c
@@ -223,8 +223,7 @@ static struct resource smsc911x_resources[] = {
 		.end		= MX31_CS1_BASE_ADDR + 0x300 + SZ_64K - 1,
 		.flags		= IORESOURCE_MEM,
 	}, {
-		.start		= IOMUX_TO_IRQ(MX31_PIN_GPIO3_1),
-		.end		= IOMUX_TO_IRQ(MX31_PIN_GPIO3_1),
+		/* irq number is run-time assigned */
 		.flags		= IORESOURCE_IRQ | IORESOURCE_IRQ_LOWLEVEL,
 	},
 };
@@ -369,7 +368,7 @@ static int pcm970_sdhc1_init(struct device *dev, irq_handler_t detect_irq,
 	gpio_direction_input(SDHC1_GPIO_WP);
 #endif
 
-	ret = request_irq(IOMUX_TO_IRQ(MX31_PIN_SCK6), detect_irq,
+	ret = request_irq(gpio_to_irq(IOMUX_TO_GPIO(MX31_PIN_SCK6)), detect_irq,
 			IRQF_DISABLED | IRQF_TRIGGER_FALLING,
 				"sdhc-detect", data);
 	if (ret)
@@ -389,7 +388,7 @@ err_gpio_free:
 
 static void pcm970_sdhc1_exit(struct device *dev, void *data)
 {
-	free_irq(IOMUX_TO_IRQ(MX31_PIN_SCK6), data);
+	free_irq(gpio_to_irq(IOMUX_TO_GPIO(MX31_PIN_SCK6)), data);
 	gpio_free(SDHC1_GPIO_DET);
 	gpio_free(SDHC1_GPIO_WP);
 }
@@ -509,8 +508,7 @@ static struct resource pcm970_sja1000_resources[] = {
 		.end     = MX31_CS5_BASE_ADDR + 0x100 - 1,
 		.flags   = IORESOURCE_MEM,
 	}, {
-		.start   = IOMUX_TO_IRQ(IOMUX_PIN(48, 105)),
-		.end     = IOMUX_TO_IRQ(IOMUX_PIN(48, 105)),
+		/* irq number is run-time assigned */
 		.flags   = IORESOURCE_IRQ | IORESOURCE_IRQ_LOWEDGE,
 	},
 };
@@ -624,6 +622,10 @@ static void __init pcm037_init(void)
 		pr_warning("could not get LAN irq gpio\n");
 	else {
 		gpio_direction_input(IOMUX_TO_GPIO(MX31_PIN_GPIO3_1));
+		smsc911x_resources[1].start =
+			gpio_to_irq(IOMUX_TO_GPIO(MX31_PIN_GPIO3_1));
+		smsc911x_resources[1].end =
+			gpio_to_irq(IOMUX_TO_GPIO(MX31_PIN_GPIO3_1));
 		platform_device_register(&pcm037_eth);
 	}
 
@@ -650,6 +652,10 @@ static void __init pcm037_init(void)
 
 	pcm037_init_camera();
 
+	pcm970_sja1000_resources[1].start =
+			gpio_to_irq(IOMUX_TO_GPIO(IOMUX_PIN(48, 105)));
+	pcm970_sja1000_resources[1].end =
+			gpio_to_irq(IOMUX_TO_GPIO(IOMUX_PIN(48, 105)));
 	platform_device_register(&pcm970_sja1000);
 
 	if (otg_mode_host) {
diff --git a/arch/arm/mach-imx/mach-qong.c b/arch/arm/mach-imx/mach-qong.c
index 2606210..b6f11d2 100644
--- a/arch/arm/mach-imx/mach-qong.c
+++ b/arch/arm/mach-imx/mach-qong.c
@@ -51,8 +51,6 @@
 	(QONG_FPGA_BASEADDR + QONG_DNET_ID * QONG_FPGA_PERIPH_SIZE)
 #define QONG_DNET_SIZE		0x00001000
 
-#define QONG_FPGA_IRQ		IOMUX_TO_IRQ(MX31_PIN_DTR_DCE1)
-
 static const struct imxuart_platform_data uart_pdata __initconst = {
 	.flags = IMXUART_HAVE_RTSCTS,
 };
@@ -78,8 +76,7 @@ static struct resource dnet_resources[] = {
 		.end	= QONG_DNET_BASEADDR + QONG_DNET_SIZE - 1,
 		.flags	= IORESOURCE_MEM,
 	}, {
-		.start	= QONG_FPGA_IRQ,
-		.end	= QONG_FPGA_IRQ,
+		/* irq number is run-time assigned */
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -95,6 +92,10 @@ static int __init qong_init_dnet(void)
 {
 	int ret;
 
+	dnet_resources[1].start =
+		gpio_to_irq(IOMUX_TO_GPIO(MX31_PIN_DTR_DCE1));
+	dnet_resources[1].end =
+		gpio_to_irq(IOMUX_TO_GPIO(MX31_PIN_DTR_DCE1));
 	ret = platform_device_register(&dnet_device);
 	return ret;
 }
diff --git a/arch/arm/mach-imx/mx31lilly-db.c b/arch/arm/mach-imx/mx31lilly-db.c
index 7d26f76..2df625b 100644
--- a/arch/arm/mach-imx/mx31lilly-db.c
+++ b/arch/arm/mach-imx/mx31lilly-db.c
@@ -130,7 +130,8 @@ static int mxc_mmc1_init(struct device *dev,
 	gpio_direction_input(gpio_det);
 	gpio_direction_input(gpio_wp);
 
-	ret = request_irq(IOMUX_TO_IRQ(MX31_PIN_GPIO1_1), detect_irq,
+	ret = request_irq(gpio_to_irq(IOMUX_TO_GPIO(MX31_PIN_GPIO1_1)),
+			  detect_irq,
 			  IRQF_DISABLED | IRQF_TRIGGER_FALLING,
 			  "MMC detect", data);
 	if (ret)
@@ -151,7 +152,7 @@ static void mxc_mmc1_exit(struct device *dev, void *data)
 {
 	gpio_free(gpio_det);
 	gpio_free(gpio_wp);
-	free_irq(IOMUX_TO_IRQ(MX31_PIN_GPIO1_1), data);
+	free_irq(gpio_to_irq(IOMUX_TO_GPIO(MX31_PIN_GPIO1_1)), data);
 }
 
 static const struct imxmmc_platform_data mmc_pdata __initconst = {
diff --git a/arch/arm/mach-imx/mx31lite-db.c b/arch/arm/mach-imx/mx31lite-db.c
index bf0fb87..d639391 100644
--- a/arch/arm/mach-imx/mx31lite-db.c
+++ b/arch/arm/mach-imx/mx31lite-db.c
@@ -116,7 +116,8 @@ static int mxc_mmc1_init(struct device *dev,
 	gpio_direction_input(gpio_det);
 	gpio_direction_input(gpio_wp);
 
-	ret = request_irq(IOMUX_TO_IRQ(MX31_PIN_DCD_DCE1), detect_irq,
+	ret = request_irq(gpio_to_irq(IOMUX_TO_GPIO(MX31_PIN_DCD_DCE1)),
+			  detect_irq,
 			  IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
 			  "MMC detect", data);
 	if (ret)
@@ -137,7 +138,7 @@ static void mxc_mmc1_exit(struct device *dev, void *data)
 {
 	gpio_free(gpio_det);
 	gpio_free(gpio_wp);
-	free_irq(IOMUX_TO_IRQ(MX31_PIN_DCD_DCE1), data);
+	free_irq(gpio_to_irq(IOMUX_TO_GPIO(MX31_PIN_DCD_DCE1)), data);
 }
 
 static const struct imxmmc_platform_data mmc_pdata __initconst = {
diff --git a/arch/arm/plat-mxc/include/mach/iomux-mx3.h b/arch/arm/plat-mxc/include/mach/iomux-mx3.h
index 63f22a0..d8b65b5 100644
--- a/arch/arm/plat-mxc/include/mach/iomux-mx3.h
+++ b/arch/arm/plat-mxc/include/mach/iomux-mx3.h
@@ -160,9 +160,6 @@ int mxc_iomux_mode(unsigned int pin_mode);
 
 #define IOMUX_TO_GPIO(iomux_pin) \
 	((iomux_pin & IOMUX_GPIONUM_MASK) >> IOMUX_GPIONUM_SHIFT)
-#define IOMUX_TO_IRQ(iomux_pin) \
-	(((iomux_pin & IOMUX_GPIONUM_MASK) >> IOMUX_GPIONUM_SHIFT) + \
-	MXC_GPIO_IRQ_START)
 
 /*
  * This enumeration is constructed based on the Section
-- 
1.7.5.4
