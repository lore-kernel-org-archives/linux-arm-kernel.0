From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 14 Jun 2012 13:59:34 +0800
Subject: [PATCH 03/16] ARM: imx: eliminate macro IRQ_GPIOx()
In-Reply-To: <1339653587-4832-1-git-send-email-shawn.guo@linaro.org>
References: <1339653587-4832-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1339653587-4832-4-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch changes all the static gpio irq number assigning with
IRQ_GPIOA() ... IRQ_GPIOF() to run-time assigning with gpio_to_irq
call, and in turn eliminates these macros.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/eukrea_mbimx27-baseboard.c |    3 ++-
 arch/arm/mach-imx/mach-apf9328.c             |    6 ++++--
 arch/arm/mach-imx/mach-cpuimx27.c            |   12 ++++++++----
 arch/arm/mach-imx/mach-imx27_visstrim_m10.c  |    9 +++++----
 arch/arm/mach-imx/mach-mx21ads.c             |   16 +++++++++++-----
 arch/arm/mach-imx/mach-mx27ads.c             |   12 ++++++------
 arch/arm/mach-imx/mach-mxt_td60.c            |    6 +++---
 arch/arm/mach-imx/mach-pca100.c              |    4 ++--
 arch/arm/mach-imx/mach-pcm038.c              |    4 +++-
 arch/arm/mach-imx/mach-scb9328.c             |    6 ++++--
 arch/arm/mach-imx/pcm970-baseboard.c         |   13 +++++++------
 arch/arm/plat-mxc/include/mach/iomux-v1.h    |    7 -------
 12 files changed, 55 insertions(+), 43 deletions(-)

diff --git a/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c b/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
index b46cab0..fd3177f 100644
--- a/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
+++ b/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
@@ -266,7 +266,7 @@ static struct spi_board_info __maybe_unused
 		.bus_num	= 0,
 		.chip_select	= 0,
 		.max_speed_hz	= 1500000,
-		.irq		= IRQ_GPIOD(25),
+		/* irq number is run-time assigned */
 		.platform_data	= &ads7846_config,
 		.mode           = SPI_MODE_2,
 	},
@@ -329,6 +329,7 @@ void __init eukrea_mbimx27_baseboard_init(void)
 	/* SPI_CS0 init */
 	mxc_gpio_mode(GPIO_PORTD | 28 | GPIO_GPIO | GPIO_OUT);
 	imx27_add_spi_imx0(&eukrea_mbimx27_spi0_data);
+	eukrea_mbimx27_spi_board_info[0].irq = gpio_to_irq(IMX_GPIO_NR(4, 25));
 	spi_register_board_info(eukrea_mbimx27_spi_board_info,
 			ARRAY_SIZE(eukrea_mbimx27_spi_board_info));
 
diff --git a/arch/arm/mach-imx/mach-apf9328.c b/arch/arm/mach-imx/mach-apf9328.c
index f4a63ee..5062fcb 100644
--- a/arch/arm/mach-imx/mach-apf9328.c
+++ b/arch/arm/mach-imx/mach-apf9328.c
@@ -18,6 +18,7 @@
 #include <linux/platform_device.h>
 #include <linux/mtd/physmap.h>
 #include <linux/dm9000.h>
+#include <linux/gpio.h>
 #include <linux/i2c.h>
 
 #include <asm/mach-types.h>
@@ -87,8 +88,7 @@ static struct resource dm9000_resources[] = {
 		.end    = MX1_CS4_PHYS + 0x00C00003,
 		.flags  = IORESOURCE_MEM,
 	}, {
-		.start  = IRQ_GPIOB(14),
-		.end    = IRQ_GPIOB(14),
+		/* irq number is run-time assigned */
 		.flags  = IORESOURCE_IRQ | IORESOURCE_IRQ_LOWLEVEL,
 	},
 };
@@ -129,6 +129,8 @@ static void __init apf9328_init(void)
 
 	imx1_add_imx_i2c(&apf9328_i2c_data);
 
+	dm9000_resources[2].start = gpio_to_irq(IMX_GPIO_NR(2, 14));
+	dm9000_resources[2].end = gpio_to_irq(IMX_GPIO_NR(2, 14));
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 }
 
diff --git a/arch/arm/mach-imx/mach-cpuimx27.c b/arch/arm/mach-imx/mach-cpuimx27.c
index d085aea..fe74c84 100644
--- a/arch/arm/mach-imx/mach-cpuimx27.c
+++ b/arch/arm/mach-imx/mach-cpuimx27.c
@@ -169,28 +169,28 @@ static struct i2c_board_info eukrea_cpuimx27_i2c_devices[] = {
 static struct plat_serial8250_port serial_platform_data[] = {
 	{
 		.mapbase = (unsigned long)(MX27_CS3_BASE_ADDR + 0x200000),
-		.irq = IRQ_GPIOB(23),
+		/* irq number is run-time assigned */
 		.uartclk = 14745600,
 		.regshift = 1,
 		.iotype = UPIO_MEM,
 		.flags = UPF_BOOT_AUTOCONF | UPF_SKIP_TEST | UPF_IOREMAP,
 	}, {
 		.mapbase = (unsigned long)(MX27_CS3_BASE_ADDR + 0x400000),
-		.irq = IRQ_GPIOB(22),
+		/* irq number is run-time assigned */
 		.uartclk = 14745600,
 		.regshift = 1,
 		.iotype = UPIO_MEM,
 		.flags = UPF_BOOT_AUTOCONF | UPF_SKIP_TEST | UPF_IOREMAP,
 	}, {
 		.mapbase = (unsigned long)(MX27_CS3_BASE_ADDR + 0x800000),
-		.irq = IRQ_GPIOB(27),
+		/* irq number is run-time assigned */
 		.uartclk = 14745600,
 		.regshift = 1,
 		.iotype = UPIO_MEM,
 		.flags = UPF_BOOT_AUTOCONF | UPF_SKIP_TEST | UPF_IOREMAP,
 	}, {
 		.mapbase = (unsigned long)(MX27_CS3_BASE_ADDR + 0x1000000),
-		.irq = IRQ_GPIOB(30),
+		/* irq number is run-time assigned */
 		.uartclk = 14745600,
 		.regshift = 1,
 		.iotype = UPIO_MEM,
@@ -279,6 +279,10 @@ static void __init eukrea_cpuimx27_init(void)
 #endif
 
 #if defined(CONFIG_SERIAL_8250) || defined(CONFIG_SERIAL_8250_MODULE)
+	serial_platform_data[0].irq = IMX_GPIO_NR(2, 23);
+	serial_platform_data[1].irq = IMX_GPIO_NR(2, 22);
+	serial_platform_data[2].irq = IMX_GPIO_NR(2, 27);
+	serial_platform_data[3].irq = IMX_GPIO_NR(2, 30);
 	platform_device_register(&serial_device);
 #endif
 
diff --git a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
index dff82eb..54c34a6 100644
--- a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
+++ b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
@@ -40,6 +40,7 @@
 #include <asm/mach/time.h>
 #include <asm/system.h>
 #include <mach/common.h>
+#include <mach/hardware.h>
 #include <mach/iomux-mx27.h>
 
 #include "devices-imx27.h"
@@ -47,7 +48,7 @@
 #define TVP5150_RSTN (GPIO_PORTC + 18)
 #define TVP5150_PWDN (GPIO_PORTC + 19)
 #define OTG_PHY_CS_GPIO (GPIO_PORTF + 17)
-#define SDHC1_IRQ IRQ_GPIOB(25)
+#define SDHC1_IRQ_GPIO IMX_GPIO_NR(2, 25)
 
 #define MOTHERBOARD_BIT2	(GPIO_PORTD + 31)
 #define MOTHERBOARD_BIT1	(GPIO_PORTD + 30)
@@ -294,14 +295,14 @@ static int visstrim_m10_sdhc1_init(struct device *dev,
 {
 	int ret;
 
-	ret = request_irq(SDHC1_IRQ, detect_irq, IRQF_TRIGGER_FALLING,
-				"mmc-detect", data);
+	ret = request_irq(gpio_to_irq(SDHC1_IRQ_GPIO), detect_irq,
+			  IRQF_TRIGGER_FALLING, "mmc-detect", data);
 	return ret;
 }
 
 static void visstrim_m10_sdhc1_exit(struct device *dev, void *data)
 {
-	free_irq(SDHC1_IRQ, data);
+	free_irq(gpio_to_irq(SDHC1_IRQ_GPIO), data);
 }
 
 static const struct imxmmc_platform_data visstrim_m10_sdhc_pdata __initconst = {
diff --git a/arch/arm/mach-imx/mach-mx21ads.c b/arch/arm/mach-imx/mach-mx21ads.c
index d14bbe9..ab3bdf7 100644
--- a/arch/arm/mach-imx/mach-mx21ads.c
+++ b/arch/arm/mach-imx/mach-mx21ads.c
@@ -38,7 +38,7 @@
 		(MX21ADS_MMIO_BASE_ADDR + (offset))
 
 #define MX21ADS_CS8900A_MMIO_SIZE   0x200000
-#define MX21ADS_CS8900A_IRQ         IRQ_GPIOE(11)
+#define MX21ADS_CS8900A_IRQ_GPIO    IMX_GPIO_NR(5, 11)
 #define MX21ADS_ST16C255_IOBASE_REG MX21ADS_REG_ADDR(0x200000)
 #define MX21ADS_VERSION_REG         MX21ADS_REG_ADDR(0x400000)
 #define MX21ADS_IO_REG              MX21ADS_REG_ADDR(0x800000)
@@ -159,9 +159,10 @@ static struct platform_device mx21ads_nor_mtd_device = {
 	.resource = &mx21ads_flash_resource,
 };
 
-static const struct resource mx21ads_cs8900_resources[] __initconst = {
+static struct resource mx21ads_cs8900_resources[] __initdata = {
 	DEFINE_RES_MEM(MX21_CS1_BASE_ADDR, MX21ADS_CS8900A_MMIO_SIZE),
-	DEFINE_RES_IRQ(MX21ADS_CS8900A_IRQ),
+	/* irq number is run-time assigned */
+	DEFINE_RES_IRQ(-1),
 };
 
 static const struct platform_device_info mx21ads_cs8900_devinfo __initconst = {
@@ -241,13 +242,13 @@ static int mx21ads_sdhc_get_ro(struct device *dev)
 static int mx21ads_sdhc_init(struct device *dev, irq_handler_t detect_irq,
 	void *data)
 {
-	return request_irq(IRQ_GPIOD(25), detect_irq,
+	return request_irq(gpio_to_irq(IMX_GPIO_NR(4, 25)), detect_irq,
 		IRQF_TRIGGER_FALLING, "mmc-detect", data);
 }
 
 static void mx21ads_sdhc_exit(struct device *dev, void *data)
 {
-	free_irq(IRQ_GPIOD(25), data);
+	free_irq(gpio_to_irq(IMX_GPIO_NR(4, 25)), data);
 }
 
 static const struct imxmmc_platform_data mx21ads_sdhc_pdata __initconst = {
@@ -304,6 +305,11 @@ static void __init mx21ads_board_init(void)
 	imx21_add_mxc_nand(&mx21ads_nand_board_info);
 
 	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
+
+	mx21ads_cs8900_resources[1].start =
+			gpio_to_irq(MX21ADS_CS8900A_IRQ_GPIO);
+	mx21ads_cs8900_resources[1].end =
+			gpio_to_irq(MX21ADS_CS8900A_IRQ_GPIO);
 	platform_device_register_full(&mx21ads_cs8900_devinfo);
 }
 
diff --git a/arch/arm/mach-imx/mach-mx27ads.c b/arch/arm/mach-imx/mach-mx27ads.c
index 0228d2e..78b6bb5 100644
--- a/arch/arm/mach-imx/mach-mx27ads.c
+++ b/arch/arm/mach-imx/mach-mx27ads.c
@@ -246,25 +246,25 @@ static const struct imx_fb_platform_data mx27ads_fb_data __initconst = {
 static int mx27ads_sdhc1_init(struct device *dev, irq_handler_t detect_irq,
 			      void *data)
 {
-	return request_irq(IRQ_GPIOE(21), detect_irq, IRQF_TRIGGER_RISING,
-			   "sdhc1-card-detect", data);
+	return request_irq(gpio_to_irq(IMX_GPIO_NR(5, 21)), detect_irq,
+			   IRQF_TRIGGER_RISING, "sdhc1-card-detect", data);
 }
 
 static int mx27ads_sdhc2_init(struct device *dev, irq_handler_t detect_irq,
 			      void *data)
 {
-	return request_irq(IRQ_GPIOB(7), detect_irq, IRQF_TRIGGER_RISING,
-			   "sdhc2-card-detect", data);
+	return request_irq(gpio_to_irq(IMX_GPIO_NR(2, 7)), detect_irq,
+			   IRQF_TRIGGER_RISING, "sdhc2-card-detect", data);
 }
 
 static void mx27ads_sdhc1_exit(struct device *dev, void *data)
 {
-	free_irq(IRQ_GPIOE(21), data);
+	free_irq(gpio_to_irq(IMX_GPIO_NR(5, 21)), data);
 }
 
 static void mx27ads_sdhc2_exit(struct device *dev, void *data)
 {
-	free_irq(IRQ_GPIOB(7), data);
+	free_irq(gpio_to_irq(IMX_GPIO_NR(2, 7)), data);
 }
 
 static const struct imxmmc_platform_data sdhc1_pdata __initconst = {
diff --git a/arch/arm/mach-imx/mach-mxt_td60.c b/arch/arm/mach-imx/mach-mxt_td60.c
index 8b3d3f0..0bf6d30 100644
--- a/arch/arm/mach-imx/mach-mxt_td60.c
+++ b/arch/arm/mach-imx/mach-mxt_td60.c
@@ -213,13 +213,13 @@ static const struct imx_fb_platform_data mxt_td60_fb_data __initconst = {
 static int mxt_td60_sdhc1_init(struct device *dev, irq_handler_t detect_irq,
 				void *data)
 {
-	return request_irq(IRQ_GPIOF(8), detect_irq, IRQF_TRIGGER_FALLING,
-				"sdhc1-card-detect", data);
+	return request_irq(gpio_to_irq(IMX_GPIO_NR(6, 8)), detect_irq,
+			   IRQF_TRIGGER_FALLING, "sdhc1-card-detect", data);
 }
 
 static void mxt_td60_sdhc1_exit(struct device *dev, void *data)
 {
-	free_irq(IRQ_GPIOF(8), data);
+	free_irq(gpio_to_irq(IMX_GPIO_NR(6, 8)), data);
 }
 
 static const struct imxmmc_platform_data sdhc1_pdata __initconst = {
diff --git a/arch/arm/mach-imx/mach-pca100.c b/arch/arm/mach-imx/mach-pca100.c
index 541152e..8b1dfa2 100644
--- a/arch/arm/mach-imx/mach-pca100.c
+++ b/arch/arm/mach-imx/mach-pca100.c
@@ -245,7 +245,7 @@ static int pca100_sdhc2_init(struct device *dev, irq_handler_t detect_irq,
 {
 	int ret;
 
-	ret = request_irq(IRQ_GPIOC(29), detect_irq,
+	ret = request_irq(gpio_to_irq(IMX_GPIO_NR(3, 29)), detect_irq,
 			  IRQF_DISABLED | IRQF_TRIGGER_FALLING,
 			  "imx-mmc-detect", data);
 	if (ret)
@@ -257,7 +257,7 @@ static int pca100_sdhc2_init(struct device *dev, irq_handler_t detect_irq,
 
 static void pca100_sdhc2_exit(struct device *dev, void *data)
 {
-	free_irq(IRQ_GPIOC(29), data);
+	free_irq(gpio_to_irq(IMX_GPIO_NR(3, 29)), data);
 }
 
 static const struct imxmmc_platform_data sdhc_pdata __initconst = {
diff --git a/arch/arm/mach-imx/mach-pcm038.c b/arch/arm/mach-imx/mach-pcm038.c
index 2f3debe..cfb3903 100644
--- a/arch/arm/mach-imx/mach-pcm038.c
+++ b/arch/arm/mach-imx/mach-pcm038.c
@@ -27,6 +27,7 @@
 #include <linux/mfd/mc13783.h>
 #include <linux/spi/spi.h>
 #include <linux/irq.h>
+#include <linux/gpio.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -274,7 +275,7 @@ static struct mc13xxx_platform_data pcm038_pmic = {
 static struct spi_board_info pcm038_spi_board_info[] __initdata = {
 	{
 		.modalias = "mc13783",
-		.irq = IRQ_GPIOB(23),
+		/* irq number is run-time assigned */
 		.max_speed_hz = 300000,
 		.bus_num = 0,
 		.chip_select = 0,
@@ -325,6 +326,7 @@ static void __init pcm038_init(void)
 	mxc_gpio_mode(GPIO_PORTB | 23 | GPIO_GPIO | GPIO_IN);
 
 	imx27_add_spi_imx0(&pcm038_spi0_data);
+	pcm038_spi_board_info[0].irq = gpio_to_irq(IMX_GPIO_NR(2, 23));
 	spi_register_board_info(pcm038_spi_board_info,
 				ARRAY_SIZE(pcm038_spi_board_info));
 
diff --git a/arch/arm/mach-imx/mach-scb9328.c b/arch/arm/mach-imx/mach-scb9328.c
index cb9ceae..5001164 100644
--- a/arch/arm/mach-imx/mach-scb9328.c
+++ b/arch/arm/mach-imx/mach-scb9328.c
@@ -14,6 +14,7 @@
 #include <linux/mtd/physmap.h>
 #include <linux/interrupt.h>
 #include <linux/dm9000.h>
+#include <linux/gpio.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -78,8 +79,7 @@ static struct resource dm9000x_resources[] = {
 		.end	= MX1_CS5_PHYS + 5,
 		.flags	= IORESOURCE_MEM,	/* data access */
 	}, {
-		.start	= IRQ_GPIOC(3),
-		.end	= IRQ_GPIOC(3),
+		/* irq number is run-time assigned */
 		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_LOWLEVEL,
 	},
 };
@@ -123,6 +123,8 @@ static void __init scb9328_init(void)
 	imx1_add_imx_uart0(&uart_pdata);
 
 	printk(KERN_INFO"Scb9328: Adding devices\n");
+	dm9000x_resources[2].start = gpio_to_irq(IMX_GPIO_NR(3, 3));
+	dm9000x_resources[2].end = gpio_to_irq(IMX_GPIO_NR(3, 3));
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 }
 
diff --git a/arch/arm/mach-imx/pcm970-baseboard.c b/arch/arm/mach-imx/pcm970-baseboard.c
index 99afbc3..9917e2f 100644
--- a/arch/arm/mach-imx/pcm970-baseboard.c
+++ b/arch/arm/mach-imx/pcm970-baseboard.c
@@ -95,14 +95,14 @@ static int pcm970_sdhc2_init(struct device *dev, irq_handler_t detect_irq, void
 {
 	int ret;
 
-	ret = request_irq(IRQ_GPIOC(29), detect_irq, IRQF_TRIGGER_FALLING,
-				"imx-mmc-detect", data);
+	ret = request_irq(gpio_to_irq(IMX_GPIO_NR(3, 29)), detect_irq,
+			  IRQF_TRIGGER_FALLING, "imx-mmc-detect", data);
 	if (ret)
 		return ret;
 
 	ret = gpio_request(GPIO_PORTC + 28, "imx-mmc-ro");
 	if (ret) {
-		free_irq(IRQ_GPIOC(29), data);
+		free_irq(gpio_to_irq(IMX_GPIO_NR(3, 29)), data);
 		return ret;
 	}
 
@@ -113,7 +113,7 @@ static int pcm970_sdhc2_init(struct device *dev, irq_handler_t detect_irq, void
 
 static void pcm970_sdhc2_exit(struct device *dev, void *data)
 {
-	free_irq(IRQ_GPIOC(29), data);
+	free_irq(gpio_to_irq(IMX_GPIO_NR(3, 29)), data);
 	gpio_free(GPIO_PORTC + 28);
 }
 
@@ -192,8 +192,7 @@ static struct resource pcm970_sja1000_resources[] = {
 		.end     = MX27_CS4_BASE_ADDR + 0x100 - 1,
 		.flags   = IORESOURCE_MEM,
 	}, {
-		.start   = IRQ_GPIOE(19),
-		.end     = IRQ_GPIOE(19),
+		/* irq number is run-time assigned */
 		.flags   = IORESOURCE_IRQ | IORESOURCE_IRQ_LOWEDGE,
 	},
 };
@@ -227,5 +226,7 @@ void __init pcm970_baseboard_init(void)
 	imx27_add_imx_fb(&pcm038_fb_data);
 	mxc_gpio_mode(GPIO_PORTC | 28 | GPIO_GPIO | GPIO_IN);
 	imx27_add_mxc_mmc(1, &sdhc_pdata);
+	pcm970_sja1000_resources[1].start = gpio_to_irq(IMX_GPIO_NR(5, 19));
+	pcm970_sja1000_resources[1].end = gpio_to_irq(IMX_GPIO_NR(5, 19));
 	platform_device_register(&pcm970_sja1000);
 }
diff --git a/arch/arm/plat-mxc/include/mach/iomux-v1.h b/arch/arm/plat-mxc/include/mach/iomux-v1.h
index f7d1804..02651a4 100644
--- a/arch/arm/plat-mxc/include/mach/iomux-v1.h
+++ b/arch/arm/plat-mxc/include/mach/iomux-v1.h
@@ -85,13 +85,6 @@
 #define GPIO_BOUT_0	(2 << GPIO_BOUT_SHIFT)
 #define GPIO_BOUT_1	(3 << GPIO_BOUT_SHIFT)
 
-#define IRQ_GPIOA(x)  (MXC_GPIO_IRQ_START + x)
-#define IRQ_GPIOB(x)  (IRQ_GPIOA(32) + x)
-#define IRQ_GPIOC(x)  (IRQ_GPIOB(32) + x)
-#define IRQ_GPIOD(x)  (IRQ_GPIOC(32) + x)
-#define IRQ_GPIOE(x)  (IRQ_GPIOD(32) + x)
-#define IRQ_GPIOF(x)  (IRQ_GPIOE(32) + x)
-
 extern int mxc_gpio_mode(int gpio_mode);
 extern int mxc_gpio_setup_multiple_pins(const int *pin_list, unsigned count,
 		const char *label);
-- 
1.7.5.4
