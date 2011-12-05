From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon,  5 Dec 2011 12:15:47 +0800
Subject: [PATCH 4/6] arm/imx: eliminate macro IRQ_GPIOx()
In-Reply-To: <1323058550-13368-1-git-send-email-shawn.guo@linaro.org>
References: <1323058550-13368-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1323058550-13368-6-git-send-email-shawn.guo@linaro.org>
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
 arch/arm/mach-imx/mach-imx27_visstrim_m10.c  |    8 ++++----
 arch/arm/mach-imx/mach-mx21ads.c             |    5 ++---
 arch/arm/mach-imx/mach-mx27ads.c             |   12 ++++++------
 arch/arm/mach-imx/mach-mxt_td60.c            |    6 +++---
 arch/arm/mach-imx/mach-pca100.c              |    4 ++--
 arch/arm/mach-imx/mach-pcm038.c              |    4 +++-
 arch/arm/mach-imx/mach-scb9328.c             |    6 ++++--
 arch/arm/mach-imx/pcm970-baseboard.c         |   13 +++++++------
 arch/arm/plat-mxc/include/mach/iomux-v1.h    |   12 ++++++------
 12 files changed, 51 insertions(+), 40 deletions(-)

diff --git a/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c b/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
index 5db3e14..420ef06 100644
--- a/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
+++ b/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
@@ -267,7 +267,7 @@ static struct spi_board_info __maybe_unused
 		.bus_num	= 0,
 		.chip_select	= 0,
 		.max_speed_hz	= 1500000,
-		.irq		= IRQ_GPIOD(25),
+		/* irq number is run-time assigned */
 		.platform_data	= &ads7846_config,
 		.mode           = SPI_MODE_2,
 	},
@@ -349,6 +349,7 @@ void __init eukrea_mbimx27_baseboard_init(void)
 	/* SPI_CS0 init */
 	mxc_gpio_mode(GPIO_PORTD | 28 | GPIO_GPIO | GPIO_OUT);
 	imx27_add_spi_imx0(&eukrea_mbimx27_spi0_data);
+	eukrea_mbimx27_spi_board_info[0].irq = gpio_to_irq(IMX_GPIOD(25));
 	spi_register_board_info(eukrea_mbimx27_spi_board_info,
 			ARRAY_SIZE(eukrea_mbimx27_spi_board_info));
 
diff --git a/arch/arm/mach-imx/mach-apf9328.c b/arch/arm/mach-imx/mach-apf9328.c
index 1e486e6..943d8c7 100644
--- a/arch/arm/mach-imx/mach-apf9328.c
+++ b/arch/arm/mach-imx/mach-apf9328.c
@@ -18,6 +18,7 @@
 #include <linux/platform_device.h>
 #include <linux/mtd/physmap.h>
 #include <linux/dm9000.h>
+#include <linux/gpio.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -83,8 +84,7 @@ static struct resource dm9000_resources[] = {
 		.end    = MX1_CS4_PHYS + 0x00C00003,
 		.flags  = IORESOURCE_MEM,
 	}, {
-		.start  = IRQ_GPIOB(14),
-		.end    = IRQ_GPIOB(14),
+		/* irq number is run-time assigned */
 		.flags  = IORESOURCE_IRQ | IORESOURCE_IRQ_LOWLEVEL,
 	},
 };
@@ -119,6 +119,8 @@ static void __init apf9328_init(void)
 	imx1_add_imx_uart0(NULL);
 	imx1_add_imx_uart1(&uart1_pdata);
 
+	dm9000_resources[2].start = gpio_to_irq(IMX_GPIOB(14));
+	dm9000_resources[2].end = gpio_to_irq(IMX_GPIOB(14));
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 }
 
diff --git a/arch/arm/mach-imx/mach-cpuimx27.c b/arch/arm/mach-imx/mach-cpuimx27.c
index edb3730..a83613c 100644
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
+	serial_platform_data[0].irq = IMX_GPIOB(23);
+	serial_platform_data[1].irq = IMX_GPIOB(22);
+	serial_platform_data[2].irq = IMX_GPIOB(27);
+	serial_platform_data[3].irq = IMX_GPIOB(30);
 	platform_device_register(&serial_device);
 #endif
 
diff --git a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
index 38eb9e4..4c29a7c 100644
--- a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
+++ b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
@@ -40,7 +40,7 @@
 #include "devices-imx27.h"
 
 #define OTG_PHY_CS_GPIO (GPIO_PORTF + 17)
-#define SDHC1_IRQ IRQ_GPIOB(25)
+#define SDHC1_IRQ_GPIO IMX_GPIOB(25)
 
 static const int visstrim_m10_pins[] __initconst = {
 	/* UART1 (console) */
@@ -142,14 +142,14 @@ static int visstrim_m10_sdhc1_init(struct device *dev,
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
index 25f8402..b1a0b5e 100644
--- a/arch/arm/mach-imx/mach-mx21ads.c
+++ b/arch/arm/mach-imx/mach-mx21ads.c
@@ -37,7 +37,6 @@
 #define MX21ADS_REG_ADDR(offset)    (void __force __iomem *) \
 		(MX21ADS_MMIO_BASE_ADDR + (offset))
 
-#define MX21ADS_CS8900A_IRQ         IRQ_GPIOE(11)
 #define MX21ADS_CS8900A_IOBASE_REG  MX21ADS_REG_ADDR(0x000000)
 #define MX21ADS_ST16C255_IOBASE_REG MX21ADS_REG_ADDR(0x200000)
 #define MX21ADS_VERSION_REG         MX21ADS_REG_ADDR(0x400000)
@@ -229,13 +228,13 @@ static int mx21ads_sdhc_get_ro(struct device *dev)
 static int mx21ads_sdhc_init(struct device *dev, irq_handler_t detect_irq,
 	void *data)
 {
-	return request_irq(IRQ_GPIOD(25), detect_irq,
+	return request_irq(gpio_to_irq(IMX_GPIOD(25)), detect_irq,
 		IRQF_TRIGGER_FALLING, "mmc-detect", data);
 }
 
 static void mx21ads_sdhc_exit(struct device *dev, void *data)
 {
-	free_irq(IRQ_GPIOD(25), data);
+	free_irq(gpio_to_irq(IMX_GPIOD(25)), data);
 }
 
 static const struct imxmmc_platform_data mx21ads_sdhc_pdata __initconst = {
diff --git a/arch/arm/mach-imx/mach-mx27ads.c b/arch/arm/mach-imx/mach-mx27ads.c
index 74dd573..8504da1 100644
--- a/arch/arm/mach-imx/mach-mx27ads.c
+++ b/arch/arm/mach-imx/mach-mx27ads.c
@@ -246,25 +246,25 @@ static const struct imx_fb_platform_data mx27ads_fb_data __initconst = {
 static int mx27ads_sdhc1_init(struct device *dev, irq_handler_t detect_irq,
 			      void *data)
 {
-	return request_irq(IRQ_GPIOE(21), detect_irq, IRQF_TRIGGER_RISING,
-			   "sdhc1-card-detect", data);
+	return request_irq(gpio_to_irq(IMX_GPIOE(21)), detect_irq,
+			   IRQF_TRIGGER_RISING, "sdhc1-card-detect", data);
 }
 
 static int mx27ads_sdhc2_init(struct device *dev, irq_handler_t detect_irq,
 			      void *data)
 {
-	return request_irq(IRQ_GPIOB(7), detect_irq, IRQF_TRIGGER_RISING,
-			   "sdhc2-card-detect", data);
+	return request_irq(gpio_to_irq(IMX_GPIOB(7)), detect_irq,
+			   IRQF_TRIGGER_RISING, "sdhc2-card-detect", data);
 }
 
 static void mx27ads_sdhc1_exit(struct device *dev, void *data)
 {
-	free_irq(IRQ_GPIOE(21), data);
+	free_irq(gpio_to_irq(IMX_GPIOE(21)), data);
 }
 
 static void mx27ads_sdhc2_exit(struct device *dev, void *data)
 {
-	free_irq(IRQ_GPIOB(7), data);
+	free_irq(gpio_to_irq(IMX_GPIOB(7)), data);
 }
 
 static const struct imxmmc_platform_data sdhc1_pdata __initconst = {
diff --git a/arch/arm/mach-imx/mach-mxt_td60.c b/arch/arm/mach-imx/mach-mxt_td60.c
index 125c196..ab56fab 100644
--- a/arch/arm/mach-imx/mach-mxt_td60.c
+++ b/arch/arm/mach-imx/mach-mxt_td60.c
@@ -213,13 +213,13 @@ static const struct imx_fb_platform_data mxt_td60_fb_data __initconst = {
 static int mxt_td60_sdhc1_init(struct device *dev, irq_handler_t detect_irq,
 				void *data)
 {
-	return request_irq(IRQ_GPIOF(8), detect_irq, IRQF_TRIGGER_FALLING,
-				"sdhc1-card-detect", data);
+	return request_irq(gpio_to_irq(IMX_GPIOF(8)), detect_irq,
+			   IRQF_TRIGGER_FALLING, "sdhc1-card-detect", data);
 }
 
 static void mxt_td60_sdhc1_exit(struct device *dev, void *data)
 {
-	free_irq(IRQ_GPIOF(8), data);
+	free_irq(gpio_to_irq(IMX_GPIOF(8)), data);
 }
 
 static const struct imxmmc_platform_data sdhc1_pdata __initconst = {
diff --git a/arch/arm/mach-imx/mach-pca100.c b/arch/arm/mach-imx/mach-pca100.c
index 26072f4..227f93e 100644
--- a/arch/arm/mach-imx/mach-pca100.c
+++ b/arch/arm/mach-imx/mach-pca100.c
@@ -246,7 +246,7 @@ static int pca100_sdhc2_init(struct device *dev, irq_handler_t detect_irq,
 {
 	int ret;
 
-	ret = request_irq(IRQ_GPIOC(29), detect_irq,
+	ret = request_irq(gpio_to_irq(IMX_GPIOC(29)), detect_irq,
 			  IRQF_DISABLED | IRQF_TRIGGER_FALLING,
 			  "imx-mmc-detect", data);
 	if (ret)
@@ -258,7 +258,7 @@ static int pca100_sdhc2_init(struct device *dev, irq_handler_t detect_irq,
 
 static void pca100_sdhc2_exit(struct device *dev, void *data)
 {
-	free_irq(IRQ_GPIOC(29), data);
+	free_irq(gpio_to_irq(IMX_GPIOC(29)), data);
 }
 
 static const struct imxmmc_platform_data sdhc_pdata __initconst = {
diff --git a/arch/arm/mach-imx/mach-pcm038.c b/arch/arm/mach-imx/mach-pcm038.c
index a17e9c7..07e8d5d 100644
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
+	pcm038_spi_board_info[0].irq = gpio_to_irq(IMX_GPIOB(23));
 	spi_register_board_info(pcm038_spi_board_info,
 				ARRAY_SIZE(pcm038_spi_board_info));
 
diff --git a/arch/arm/mach-imx/mach-scb9328.c b/arch/arm/mach-imx/mach-scb9328.c
index bb6e5b2..e7db004 100644
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
+	dm9000x_resources[2].start = gpio_to_irq(IMX_GPIOC(3));
+	dm9000x_resources[2].end = gpio_to_irq(IMX_GPIOC(3));
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 }
 
diff --git a/arch/arm/mach-imx/pcm970-baseboard.c b/arch/arm/mach-imx/pcm970-baseboard.c
index 99afbc3..8ca349e 100644
--- a/arch/arm/mach-imx/pcm970-baseboard.c
+++ b/arch/arm/mach-imx/pcm970-baseboard.c
@@ -95,14 +95,14 @@ static int pcm970_sdhc2_init(struct device *dev, irq_handler_t detect_irq, void
 {
 	int ret;
 
-	ret = request_irq(IRQ_GPIOC(29), detect_irq, IRQF_TRIGGER_FALLING,
-				"imx-mmc-detect", data);
+	ret = request_irq(gpio_to_irq(IMX_GPIOC(29)), detect_irq,
+			  IRQF_TRIGGER_FALLING, "imx-mmc-detect", data);
 	if (ret)
 		return ret;
 
 	ret = gpio_request(GPIO_PORTC + 28, "imx-mmc-ro");
 	if (ret) {
-		free_irq(IRQ_GPIOC(29), data);
+		free_irq(gpio_to_irq(IMX_GPIOC(29)), data);
 		return ret;
 	}
 
@@ -113,7 +113,7 @@ static int pcm970_sdhc2_init(struct device *dev, irq_handler_t detect_irq, void
 
 static void pcm970_sdhc2_exit(struct device *dev, void *data)
 {
-	free_irq(IRQ_GPIOC(29), data);
+	free_irq(gpio_to_irq(IMX_GPIOC(29)), data);
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
+	pcm970_sja1000_resources[1].start = gpio_to_irq(IMX_GPIOE(19));
+	pcm970_sja1000_resources[1].end = gpio_to_irq(IMX_GPIOE(19));
 	platform_device_register(&pcm970_sja1000);
 }
diff --git a/arch/arm/plat-mxc/include/mach/iomux-v1.h b/arch/arm/plat-mxc/include/mach/iomux-v1.h
index 6fa8a70..2820341 100644
--- a/arch/arm/plat-mxc/include/mach/iomux-v1.h
+++ b/arch/arm/plat-mxc/include/mach/iomux-v1.h
@@ -85,12 +85,12 @@
 #define GPIO_BOUT_0	(2 << GPIO_BOUT_SHIFT)
 #define GPIO_BOUT_1	(3 << GPIO_BOUT_SHIFT)
 
-#define IRQ_GPIOA(x)  (MXC_GPIO_IRQ_START + x)
-#define IRQ_GPIOB(x)  (IRQ_GPIOA(32) + x)
-#define IRQ_GPIOC(x)  (IRQ_GPIOB(32) + x)
-#define IRQ_GPIOD(x)  (IRQ_GPIOC(32) + x)
-#define IRQ_GPIOE(x)  (IRQ_GPIOD(32) + x)
-#define IRQ_GPIOF(x)  (IRQ_GPIOE(32) + x)
+#define IMX_GPIOA(x)  (GPIO_PORTA + x)
+#define IMX_GPIOB(x)  (GPIO_PORTB + x)
+#define IMX_GPIOC(x)  (GPIO_PORTC + x)
+#define IMX_GPIOD(x)  (GPIO_PORTD + x)
+#define IMX_GPIOE(x)  (GPIO_PORTE + x)
+#define IMX_GPIOF(x)  (GPIO_PORTF + x)
 
 extern int mxc_gpio_mode(int gpio_mode);
 extern int mxc_gpio_setup_multiple_pins(const int *pin_list, unsigned count,
-- 
1.7.4.1
