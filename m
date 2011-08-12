From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 12 Aug 2011 15:54:57 +0800
Subject: [PATCH 2/6] arm/imx: remove the uses of gpio_to_irq()
In-Reply-To: <1313135701-22456-1-git-send-email-shawn.guo@linaro.org>
References: <1313135701-22456-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1313135701-22456-3-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

gpio_to_irq() is too generic to be defined and used by i.mx platform
code.  The patch defines IMX_GPIO_TO_IRQ() in mach/hardware.h and
replaces all the uses of gpio_to_irq() with IMX_GPIO_TO_IRQ().

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-imx/mach-armadillo5x0.c        |    3 ++-
 arch/arm/mach-imx/mach-cpuimx35.c            |    2 +-
 arch/arm/mach-imx/mach-mx27_3ds.c            |    8 ++++----
 arch/arm/mach-imx/mach-mx31moboard.c         |    4 ++--
 arch/arm/mach-imx/mach-mx35_3ds.c            |    2 +-
 arch/arm/mach-imx/mach-vpr200.c              |    2 +-
 arch/arm/mach-imx/mx31moboard-devboard.c     |    4 ++--
 arch/arm/mach-imx/mx31moboard-marxbot.c      |    4 ++--
 arch/arm/mach-mx5/board-cpuimx51.c           |    8 ++++----
 arch/arm/mach-mx5/board-cpuimx51sd.c         |    4 ++--
 arch/arm/mach-mx5/board-mx51_3ds.c           |    2 +-
 arch/arm/mach-mx5/board-mx53_ard.c           |    4 ++--
 arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c |    4 ++--
 arch/arm/mach-mx5/mx51_efika.c               |    2 +-
 arch/arm/plat-mxc/include/mach/hardware.h    |    2 ++
 15 files changed, 29 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-imx/mach-armadillo5x0.c b/arch/arm/mach-imx/mach-armadillo5x0.c
index ede2710..2ecb62d 100644
--- a/arch/arm/mach-imx/mach-armadillo5x0.c
+++ b/arch/arm/mach-imx/mach-armadillo5x0.c
@@ -527,7 +527,8 @@ static void __init armadillo5x0_init(void)
 	/* Get RTC IRQ and register the chip */
 	if (gpio_request(ARMADILLO5X0_RTC_GPIO, "rtc") == 0) {
 		if (gpio_direction_input(ARMADILLO5X0_RTC_GPIO) == 0)
-			armadillo5x0_i2c_rtc.irq = gpio_to_irq(ARMADILLO5X0_RTC_GPIO);
+			armadillo5x0_i2c_rtc.irq =
+				IMX_GPIO_TO_IRQ(ARMADILLO5X0_RTC_GPIO);
 		else
 			gpio_free(ARMADILLO5X0_RTC_GPIO);
 	}
diff --git a/arch/arm/mach-imx/mach-cpuimx35.c b/arch/arm/mach-imx/mach-cpuimx35.c
index f39a478b..13b7041 100644
--- a/arch/arm/mach-imx/mach-cpuimx35.c
+++ b/arch/arm/mach-imx/mach-cpuimx35.c
@@ -66,7 +66,7 @@ static struct i2c_board_info eukrea_cpuimx35_i2c_devices[] = {
 		I2C_BOARD_INFO("tsc2007", 0x48),
 		.type		= "tsc2007",
 		.platform_data	= &tsc2007_info,
-		.irq		= gpio_to_irq(TSC2007_IRQGPIO),
+		.irq		= IMX_GPIO_TO_IRQ(TSC2007_IRQGPIO),
 	},
 };
 
diff --git a/arch/arm/mach-imx/mach-mx27_3ds.c b/arch/arm/mach-imx/mach-mx27_3ds.c
index 6fa6934..7f3833e 100644
--- a/arch/arm/mach-imx/mach-mx27_3ds.c
+++ b/arch/arm/mach-imx/mach-mx27_3ds.c
@@ -46,7 +46,7 @@
 #define SD1_EN_GPIO		IMX_GPIO_NR(2, 25)
 #define OTG_PHY_RESET_GPIO	IMX_GPIO_NR(2, 23)
 #define SPI2_SS0		IMX_GPIO_NR(4, 21)
-#define EXPIO_PARENT_INT	gpio_to_irq(IMX_GPIO_NR(3, 28))
+#define EXPIO_PARENT_INT	IMX_GPIO_TO_IRQ(IMX_GPIO_NR(3, 28))
 #define PMIC_INT		IMX_GPIO_NR(3, 14)
 #define SPI1_SS0		IMX_GPIO_NR(4, 28)
 #define SD1_CD			IMX_GPIO_NR(2, 26)
@@ -171,13 +171,13 @@ static const struct matrix_keymap_data mx27_3ds_keymap_data __initconst = {
 static int mx27_3ds_sdhc1_init(struct device *dev, irq_handler_t detect_irq,
 				void *data)
 {
-	return request_irq(gpio_to_irq(SD1_CD), detect_irq,
+	return request_irq(IMX_GPIO_TO_IRQ(SD1_CD), detect_irq,
 	IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING, "sdhc1-card-detect", data);
 }
 
 static void mx27_3ds_sdhc1_exit(struct device *dev, void *data)
 {
-	free_irq(gpio_to_irq(SD1_CD), data);
+	free_irq(IMX_GPIO_TO_IRQ(SD1_CD), data);
 }
 
 static const struct imxmmc_platform_data sdhc1_pdata __initconst = {
@@ -359,7 +359,7 @@ static struct spi_board_info mx27_3ds_spi_devs[] __initdata = {
 		.bus_num	= 1,
 		.chip_select	= 0, /* SS0 */
 		.platform_data	= &mc13783_pdata,
-		.irq = gpio_to_irq(PMIC_INT),
+		.irq = IMX_GPIO_TO_IRQ(PMIC_INT),
 		.mode = SPI_CS_HIGH,
 	}, {
 		.modalias	= "l4f00242t03",
diff --git a/arch/arm/mach-imx/mach-mx31moboard.c b/arch/arm/mach-imx/mach-mx31moboard.c
index b358383..649a937 100644
--- a/arch/arm/mach-imx/mach-mx31moboard.c
+++ b/arch/arm/mach-imx/mach-mx31moboard.c
@@ -319,7 +319,7 @@ static int moboard_sdhc1_init(struct device *dev, irq_handler_t detect_irq,
 		goto err_gpio_free;
 	gpio_direction_input(SDHC1_WP);
 
-	ret = request_irq(gpio_to_irq(SDHC1_CD), detect_irq,
+	ret = request_irq(IMX_GPIO_TO_IRQ(SDHC1_CD), detect_irq,
 		IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
 		"sdhc1-card-detect", data);
 	if (ret)
@@ -337,7 +337,7 @@ err_gpio_free:
 
 static void moboard_sdhc1_exit(struct device *dev, void *data)
 {
-	free_irq(gpio_to_irq(SDHC1_CD), data);
+	free_irq(IMX_GPIO_TO_IRQ(SDHC1_CD), data);
 	gpio_free(SDHC1_WP);
 	gpio_free(SDHC1_CD);
 }
diff --git a/arch/arm/mach-imx/mach-mx35_3ds.c b/arch/arm/mach-imx/mach-mx35_3ds.c
index b3b9bd8..bc68eba 100644
--- a/arch/arm/mach-imx/mach-mx35_3ds.c
+++ b/arch/arm/mach-imx/mach-mx35_3ds.c
@@ -43,7 +43,7 @@
 
 #include "devices-imx35.h"
 
-#define EXPIO_PARENT_INT	gpio_to_irq(IMX_GPIO_NR(1, 1))
+#define EXPIO_PARENT_INT	IMX_GPIO_TO_IRQ(IMX_GPIO_NR(1, 1))
 
 static const struct imxuart_platform_data uart_pdata __initconst = {
 	.flags = IMXUART_HAVE_RTSCTS,
diff --git a/arch/arm/mach-imx/mach-vpr200.c b/arch/arm/mach-imx/mach-vpr200.c
index 7d8e012..5250283 100644
--- a/arch/arm/mach-imx/mach-vpr200.c
+++ b/arch/arm/mach-imx/mach-vpr200.c
@@ -162,7 +162,7 @@ static struct i2c_board_info vpr200_i2c_devices[] = {
 	}, {
 		I2C_BOARD_INFO("mc13892", 0x08),
 		.platform_data = &vpr200_pmic,
-		.irq = gpio_to_irq(GPIO_PMIC_INT),
+		.irq = IMX_GPIO_TO_IRQ(GPIO_PMIC_INT),
 	}
 };
 
diff --git a/arch/arm/mach-imx/mx31moboard-devboard.c b/arch/arm/mach-imx/mx31moboard-devboard.c
index 0aa2536..6dfb602 100644
--- a/arch/arm/mach-imx/mx31moboard-devboard.c
+++ b/arch/arm/mach-imx/mx31moboard-devboard.c
@@ -77,7 +77,7 @@ static int devboard_sdhc2_init(struct device *dev, irq_handler_t detect_irq,
 		goto err_gpio_free;
 	gpio_direction_input(SDHC2_WP);
 
-	ret = request_irq(gpio_to_irq(SDHC2_CD), detect_irq,
+	ret = request_irq(IMX_GPIO_TO_IRQ(SDHC2_CD), detect_irq,
 		IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
 		"sdhc2-card-detect", data);
 	if (ret)
@@ -95,7 +95,7 @@ err_gpio_free:
 
 static void devboard_sdhc2_exit(struct device *dev, void *data)
 {
-	free_irq(gpio_to_irq(SDHC2_CD), data);
+	free_irq(IMX_GPIO_TO_IRQ(SDHC2_CD), data);
 	gpio_free(SDHC2_WP);
 	gpio_free(SDHC2_CD);
 }
diff --git a/arch/arm/mach-imx/mx31moboard-marxbot.c b/arch/arm/mach-imx/mx31moboard-marxbot.c
index bb639cb..8f8664f 100644
--- a/arch/arm/mach-imx/mx31moboard-marxbot.c
+++ b/arch/arm/mach-imx/mx31moboard-marxbot.c
@@ -89,7 +89,7 @@ static int marxbot_sdhc2_init(struct device *dev, irq_handler_t detect_irq,
 		goto err_gpio_free;
 	gpio_direction_input(SDHC2_WP);
 
-	ret = request_irq(gpio_to_irq(SDHC2_CD), detect_irq,
+	ret = request_irq(IMX_GPIO_TO_IRQ(SDHC2_CD), detect_irq,
 		IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
 		"sdhc2-card-detect", data);
 	if (ret)
@@ -107,7 +107,7 @@ err_gpio_free:
 
 static void marxbot_sdhc2_exit(struct device *dev, void *data)
 {
-	free_irq(gpio_to_irq(SDHC2_CD), data);
+	free_irq(IMX_GPIO_TO_IRQ(SDHC2_CD), data);
 	gpio_free(SDHC2_WP);
 	gpio_free(SDHC2_CD);
 }
diff --git a/arch/arm/mach-mx5/board-cpuimx51.c b/arch/arm/mach-mx5/board-cpuimx51.c
index 68934ea..49ec98e 100644
--- a/arch/arm/mach-mx5/board-cpuimx51.c
+++ b/arch/arm/mach-mx5/board-cpuimx51.c
@@ -57,7 +57,7 @@
 static struct plat_serial8250_port serial_platform_data[] = {
 	{
 		.mapbase = (unsigned long)(MX51_CS1_BASE_ADDR + 0x400000),
-		.irq = gpio_to_irq(CPUIMX51_QUARTA_GPIO),
+		.irq = IMX_GPIO_TO_IRQ(CPUIMX51_QUARTA_GPIO),
 		.irqflags = IRQF_TRIGGER_HIGH,
 		.uartclk = CPUIMX51_QUART_XTAL,
 		.regshift = CPUIMX51_QUART_REGSHIFT,
@@ -65,7 +65,7 @@ static struct plat_serial8250_port serial_platform_data[] = {
 		.flags = UPF_BOOT_AUTOCONF | UPF_SKIP_TEST | UPF_IOREMAP,
 	}, {
 		.mapbase = (unsigned long)(MX51_CS1_BASE_ADDR + 0x800000),
-		.irq = gpio_to_irq(CPUIMX51_QUARTB_GPIO),
+		.irq = IMX_GPIO_TO_IRQ(CPUIMX51_QUARTB_GPIO),
 		.irqflags = IRQF_TRIGGER_HIGH,
 		.uartclk = CPUIMX51_QUART_XTAL,
 		.regshift = CPUIMX51_QUART_REGSHIFT,
@@ -73,7 +73,7 @@ static struct plat_serial8250_port serial_platform_data[] = {
 		.flags = UPF_BOOT_AUTOCONF | UPF_SKIP_TEST | UPF_IOREMAP,
 	}, {
 		.mapbase = (unsigned long)(MX51_CS1_BASE_ADDR + 0x1000000),
-		.irq = gpio_to_irq(CPUIMX51_QUARTC_GPIO),
+		.irq = IMX_GPIO_TO_IRQ(CPUIMX51_QUARTC_GPIO),
 		.irqflags = IRQF_TRIGGER_HIGH,
 		.uartclk = CPUIMX51_QUART_XTAL,
 		.regshift = CPUIMX51_QUART_REGSHIFT,
@@ -81,7 +81,7 @@ static struct plat_serial8250_port serial_platform_data[] = {
 		.flags = UPF_BOOT_AUTOCONF | UPF_SKIP_TEST | UPF_IOREMAP,
 	}, {
 		.mapbase = (unsigned long)(MX51_CS1_BASE_ADDR + 0x2000000),
-		.irq = gpio_to_irq(CPUIMX51_QUARTD_GPIO),
+		.irq = IMX_GPIO_TO_IRQ(CPUIMX51_QUARTD_GPIO),
 		.irqflags = IRQF_TRIGGER_HIGH,
 		.uartclk = CPUIMX51_QUART_XTAL,
 		.regshift = CPUIMX51_QUART_REGSHIFT,
diff --git a/arch/arm/mach-mx5/board-cpuimx51sd.c b/arch/arm/mach-mx5/board-cpuimx51sd.c
index ff096d5..8badbdb 100644
--- a/arch/arm/mach-mx5/board-cpuimx51sd.c
+++ b/arch/arm/mach-mx5/board-cpuimx51sd.c
@@ -129,7 +129,7 @@ static struct i2c_board_info eukrea_cpuimx51sd_i2c_devices[] = {
 		I2C_BOARD_INFO("tsc2007", 0x49),
 		.type		= "tsc2007",
 		.platform_data	= &tsc2007_info,
-		.irq		= gpio_to_irq(TSC2007_IRQGPIO),
+		.irq		= IMX_GPIO_TO_IRQ(TSC2007_IRQGPIO),
 	},
 };
 
@@ -245,7 +245,7 @@ static struct spi_board_info cpuimx51sd_spi_device[] = {
 		.mode		= SPI_MODE_0,
 		.chip_select     = 0,
 		.platform_data   = &mcp251x_info,
-		.irq             = gpio_to_irq(CAN_IRQGPIO)
+		.irq             = IMX_GPIO_TO_IRQ(CAN_IRQGPIO)
 	},
 };
 
diff --git a/arch/arm/mach-mx5/board-mx51_3ds.c b/arch/arm/mach-mx5/board-mx51_3ds.c
index 07a3815..2cb2a4b 100644
--- a/arch/arm/mach-mx5/board-mx51_3ds.c
+++ b/arch/arm/mach-mx5/board-mx51_3ds.c
@@ -27,7 +27,7 @@
 #include "devices-imx51.h"
 #include "devices.h"
 
-#define EXPIO_PARENT_INT	gpio_to_irq(IMX_GPIO_NR(1, 6))
+#define EXPIO_PARENT_INT	IMX_GPIO_TO_IRQ(IMX_GPIO_NR(1, 6))
 #define MX51_3DS_ECSPI2_CS	(GPIO_PORTC + 28)
 
 static iomux_v3_cfg_t mx51_3ds_pads[] = {
diff --git a/arch/arm/mach-mx5/board-mx53_ard.c b/arch/arm/mach-mx5/board-mx53_ard.c
index 76a67c4..ddc3015 100644
--- a/arch/arm/mach-mx5/board-mx53_ard.c
+++ b/arch/arm/mach-mx5/board-mx53_ard.c
@@ -134,8 +134,8 @@ static struct resource ard_smsc911x_resources[] = {
 		.flags = IORESOURCE_MEM,
 	},
 	{
-		.start =  gpio_to_irq(ARD_ETHERNET_INT_B),
-		.end =  gpio_to_irq(ARD_ETHERNET_INT_B),
+		.start =  IMX_GPIO_TO_IRQ(ARD_ETHERNET_INT_B),
+		.end =  IMX_GPIO_TO_IRQ(ARD_ETHERNET_INT_B),
 		.flags = IORESOURCE_IRQ,
 	},
 };
diff --git a/arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c b/arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c
index bbf4564..19675bb 100644
--- a/arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c
+++ b/arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c
@@ -160,7 +160,7 @@ struct tsc2007_platform_data tsc2007_data = {
 static struct i2c_board_info mbimx51_i2c_devices[] = {
 	{
 		I2C_BOARD_INFO("tsc2007", 0x49),
-		.irq  = gpio_to_irq(MBIMX51_TSC2007_GPIO),
+		.irq  = IMX_GPIO_TO_IRQ(MBIMX51_TSC2007_GPIO),
 		.platform_data = &tsc2007_data,
 	}, {
 		I2C_BOARD_INFO("tlv320aic23", 0x1a),
@@ -197,7 +197,7 @@ void __init eukrea_mbimx51_baseboard_init(void)
 
 	gpio_request(MBIMX51_TSC2007_GPIO, "tsc2007_irq");
 	gpio_direction_input(MBIMX51_TSC2007_GPIO);
-	irq_set_irq_type(gpio_to_irq(MBIMX51_TSC2007_GPIO),
+	irq_set_irq_type(IMX_GPIO_TO_IRQ(MBIMX51_TSC2007_GPIO),
 					IRQF_TRIGGER_FALLING);
 	i2c_register_board_info(1, mbimx51_i2c_devices,
 				ARRAY_SIZE(mbimx51_i2c_devices));
diff --git a/arch/arm/mach-mx5/mx51_efika.c b/arch/arm/mach-mx5/mx51_efika.c
index 4435e03..2a3015a 100644
--- a/arch/arm/mach-mx5/mx51_efika.c
+++ b/arch/arm/mach-mx5/mx51_efika.c
@@ -589,7 +589,7 @@ static struct spi_board_info mx51_efika_spi_board_info[] __initdata = {
 		.bus_num = 0,
 		.chip_select = 0,
 		.platform_data = &mx51_efika_mc13892_data,
-		.irq = gpio_to_irq(EFIKAMX_PMIC),
+		.irq = IMX_GPIO_TO_IRQ(EFIKAMX_PMIC),
 	},
 };
 
diff --git a/arch/arm/plat-mxc/include/mach/hardware.h b/arch/arm/plat-mxc/include/mach/hardware.h
index a8bfd56..77f6556 100644
--- a/arch/arm/plat-mxc/include/mach/hardware.h
+++ b/arch/arm/plat-mxc/include/mach/hardware.h
@@ -116,4 +116,6 @@
 	.type = _type,							\
 }
 
+#define IMX_GPIO_TO_IRQ(gpio)	(MXC_GPIO_IRQ_START + (gpio))
+
 #endif /* __ASM_ARCH_MXC_HARDWARE_H__ */
-- 
1.7.4.1
