From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Wed, 15 Dec 2010 03:03:53 +0100
Subject: [PATCH 14/16] ARM: pxa: Switch over to gpiolib's version of
	__gpio_to_irq().
In-Reply-To: <cover.1292377339.git.buytenh@wantstofly.org>
References: <cover.1292377339.git.buytenh@wantstofly.org>
Message-ID: <20101215020353.GG15575@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
---
 arch/arm/mach-pxa/capc7117.c            |   12 ++++++------
 arch/arm/mach-pxa/cm-x270.c             |    2 +-
 arch/arm/mach-pxa/colibri-pxa270.c      |    6 +++---
 arch/arm/mach-pxa/colibri-pxa300.c      |    4 ++--
 arch/arm/mach-pxa/colibri-pxa320.c      |    4 ++--
 arch/arm/mach-pxa/corgi.c               |    2 +-
 arch/arm/mach-pxa/hx4700.c              |   18 +++++++++---------
 arch/arm/mach-pxa/icontrol.c            |    8 ++++----
 arch/arm/mach-pxa/include/mach/csb726.h |    4 ++--
 arch/arm/mach-pxa/include/mach/gpio.h   |    3 ++-
 arch/arm/mach-pxa/littleton.c           |    2 +-
 arch/arm/mach-pxa/magician.c            |    8 ++++----
 arch/arm/mach-pxa/mioa701.c             |    8 ++++----
 arch/arm/mach-pxa/mxm8x10.c             |    4 ++--
 arch/arm/mach-pxa/poodle.c              |    2 +-
 arch/arm/mach-pxa/raumfeld.c            |    8 ++++----
 arch/arm/mach-pxa/saar.c                |    6 +++---
 arch/arm/mach-pxa/spitz.c               |    2 +-
 arch/arm/mach-pxa/stargate2.c           |    4 ++--
 arch/arm/mach-pxa/tavorevb.c            |    4 ++--
 arch/arm/mach-pxa/tavorevb3.c           |    2 +-
 arch/arm/mach-pxa/tosa.c                |    4 ++--
 arch/arm/mach-pxa/viper.c               |   12 ++++++------
 arch/arm/mach-pxa/vpac270.c             |    4 ++--
 arch/arm/mach-pxa/z2.c                  |    2 +-
 arch/arm/mach-pxa/zeus.c                |   20 ++++++++++----------
 26 files changed, 78 insertions(+), 77 deletions(-)

diff --git a/arch/arm/mach-pxa/capc7117.c b/arch/arm/mach-pxa/capc7117.c
index 4bd7a3c..92d4966 100644
--- a/arch/arm/mach-pxa/capc7117.c
+++ b/arch/arm/mach-pxa/capc7117.c
@@ -50,8 +50,8 @@ static struct resource capc7117_ide_resources[] = {
 	       .flags = IORESOURCE_MEM
 	},
 	[2] = {
-	       .start = gpio_to_irq(mfp_to_gpio(MFP_PIN_GPIO76)),
-	       .end = gpio_to_irq(mfp_to_gpio(MFP_PIN_GPIO76)),
+	       .start = IRQ_GPIO(mfp_to_gpio(MFP_PIN_GPIO76)),
+	       .end = IRQ_GPIO(mfp_to_gpio(MFP_PIN_GPIO76)),
 	       .flags = IORESOURCE_IRQ | IRQF_TRIGGER_RISING
 	}
 };
@@ -80,7 +80,7 @@ static void __init capc7117_ide_init(void)
 static struct plat_serial8250_port ti16c752_platform_data[] = {
 	[0] = {
 	       .mapbase = 0x14000000,
-	       .irq = gpio_to_irq(mfp_to_gpio(MFP_PIN_GPIO78)),
+	       .irq = IRQ_GPIO(mfp_to_gpio(MFP_PIN_GPIO78)),
 	       .irqflags = IRQF_TRIGGER_RISING,
 	       .flags = TI16C752_FLAGS,
 	       .iotype = UPIO_MEM,
@@ -89,7 +89,7 @@ static struct plat_serial8250_port ti16c752_platform_data[] = {
 	},
 	[1] = {
 	       .mapbase = 0x14000040,
-	       .irq = gpio_to_irq(mfp_to_gpio(MFP_PIN_GPIO79)),
+	       .irq = IRQ_GPIO(mfp_to_gpio(MFP_PIN_GPIO79)),
 	       .irqflags = IRQF_TRIGGER_RISING,
 	       .flags = TI16C752_FLAGS,
 	       .iotype = UPIO_MEM,
@@ -98,7 +98,7 @@ static struct plat_serial8250_port ti16c752_platform_data[] = {
 	},
 	[2] = {
 	       .mapbase = 0x14000080,
-	       .irq = gpio_to_irq(mfp_to_gpio(MFP_PIN_GPIO80)),
+	       .irq = IRQ_GPIO(mfp_to_gpio(MFP_PIN_GPIO80)),
 	       .irqflags = IRQF_TRIGGER_RISING,
 	       .flags = TI16C752_FLAGS,
 	       .iotype = UPIO_MEM,
@@ -107,7 +107,7 @@ static struct plat_serial8250_port ti16c752_platform_data[] = {
 	},
 	[3] = {
 	       .mapbase = 0x140000c0,
-	       .irq = gpio_to_irq(mfp_to_gpio(MFP_PIN_GPIO81)),
+	       .irq = IRQ_GPIO(mfp_to_gpio(MFP_PIN_GPIO81)),
 	       .irqflags = IRQF_TRIGGER_RISING,
 	       .flags = TI16C752_FLAGS,
 	       .iotype = UPIO_MEM,
diff --git a/arch/arm/mach-pxa/cm-x270.c b/arch/arm/mach-pxa/cm-x270.c
index a9926bb..b26387c 100644
--- a/arch/arm/mach-pxa/cm-x270.c
+++ b/arch/arm/mach-pxa/cm-x270.c
@@ -381,7 +381,7 @@ static struct spi_board_info cm_x270_spi_devices[] __initdata = {
 		.modalias		= "libertas_spi",
 		.max_speed_hz		= 13000000,
 		.bus_num		= 2,
-		.irq			= gpio_to_irq(95),
+		.irq			= IRQ_GPIO(95),
 		.chip_select		= 0,
 		.controller_data	= &cm_x270_libertas_chip,
 		.platform_data		= &cm_x270_libertas_pdata,
diff --git a/arch/arm/mach-pxa/colibri-pxa270.c b/arch/arm/mach-pxa/colibri-pxa270.c
index bc04510..b2603d8 100644
--- a/arch/arm/mach-pxa/colibri-pxa270.c
+++ b/arch/arm/mach-pxa/colibri-pxa270.c
@@ -121,8 +121,8 @@ static struct resource colibri_pxa270_dm9000_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	{
-		.start	= gpio_to_irq(GPIO114_COLIBRI_PXA270_ETH_IRQ),
-		.end	= gpio_to_irq(GPIO114_COLIBRI_PXA270_ETH_IRQ),
+		.start	= IRQ_GPIO(GPIO114_COLIBRI_PXA270_ETH_IRQ),
+		.end	= IRQ_GPIO(GPIO114_COLIBRI_PXA270_ETH_IRQ),
 		.flags	= IORESOURCE_IRQ | IRQF_TRIGGER_RISING,
 	},
 };
@@ -152,7 +152,7 @@ static pxa2xx_audio_ops_t colibri_pxa270_ac97_pdata = {
 };
 
 static struct ucb1400_pdata colibri_pxa270_ucb1400_pdata = {
-	.irq		= gpio_to_irq(GPIO113_COLIBRI_PXA270_TS_IRQ),
+	.irq		= IRQ_GPIO(GPIO113_COLIBRI_PXA270_TS_IRQ),
 };
 
 static struct platform_device colibri_pxa270_ucb1400_device = {
diff --git a/arch/arm/mach-pxa/colibri-pxa300.c b/arch/arm/mach-pxa/colibri-pxa300.c
index a70b256..2beb10a 100644
--- a/arch/arm/mach-pxa/colibri-pxa300.c
+++ b/arch/arm/mach-pxa/colibri-pxa300.c
@@ -49,8 +49,8 @@ static struct resource colibri_asix_resource[] = {
 		.flags = IORESOURCE_MEM,
 	},
 	[1] = {
-		.start = gpio_to_irq(COLIBRI_ETH_IRQ_GPIO),
-		.end   = gpio_to_irq(COLIBRI_ETH_IRQ_GPIO),
+		.start = IRQ_GPIO(COLIBRI_ETH_IRQ_GPIO),
+		.end   = IRQ_GPIO(COLIBRI_ETH_IRQ_GPIO),
 		.flags = IORESOURCE_IRQ | IRQF_TRIGGER_FALLING,
 	}
 };
diff --git a/arch/arm/mach-pxa/colibri-pxa320.c b/arch/arm/mach-pxa/colibri-pxa320.c
index ca5f29e..6eba496 100644
--- a/arch/arm/mach-pxa/colibri-pxa320.c
+++ b/arch/arm/mach-pxa/colibri-pxa320.c
@@ -53,8 +53,8 @@ static struct resource colibri_asix_resource[] = {
 		.flags = IORESOURCE_MEM,
 	},
 	[1] = {
-		.start = gpio_to_irq(COLIBRI_ETH_IRQ_GPIO),
-		.end   = gpio_to_irq(COLIBRI_ETH_IRQ_GPIO),
+		.start = IRQ_GPIO(COLIBRI_ETH_IRQ_GPIO),
+		.end   = IRQ_GPIO(COLIBRI_ETH_IRQ_GPIO),
 		.flags = IORESOURCE_IRQ | IRQF_TRIGGER_FALLING,
 	}
 };
diff --git a/arch/arm/mach-pxa/corgi.c b/arch/arm/mach-pxa/corgi.c
index 821229a..3582b29 100644
--- a/arch/arm/mach-pxa/corgi.c
+++ b/arch/arm/mach-pxa/corgi.c
@@ -531,7 +531,7 @@ static struct spi_board_info corgi_spi_devices[] = {
 		.chip_select	= 0,
 		.platform_data	= &corgi_ads7846_info,
 		.controller_data= &corgi_ads7846_chip,
-		.irq		= gpio_to_irq(CORGI_GPIO_TP_INT),
+		.irq		= IRQ_GPIO(CORGI_GPIO_TP_INT),
 	}, {
 		.modalias	= "corgi-lcd",
 		.max_speed_hz	= 50000,
diff --git a/arch/arm/mach-pxa/hx4700.c b/arch/arm/mach-pxa/hx4700.c
index 76d93a2..4416db5 100644
--- a/arch/arm/mach-pxa/hx4700.c
+++ b/arch/arm/mach-pxa/hx4700.c
@@ -288,8 +288,8 @@ static struct resource asic3_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= gpio_to_irq(GPIO12_HX4700_ASIC3_IRQ),
-		.end	= gpio_to_irq(GPIO12_HX4700_ASIC3_IRQ),
+		.start	= IRQ_GPIO(GPIO12_HX4700_ASIC3_IRQ),
+		.end	= IRQ_GPIO(GPIO12_HX4700_ASIC3_IRQ),
 		.flags	= IORESOURCE_IRQ,
 	},
 	/* SD part */
@@ -299,8 +299,8 @@ static struct resource asic3_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[3] = {
-		.start	= gpio_to_irq(GPIO66_HX4700_ASIC3_nSDIO_IRQ),
-		.end	= gpio_to_irq(GPIO66_HX4700_ASIC3_nSDIO_IRQ),
+		.start	= IRQ_GPIO(GPIO66_HX4700_ASIC3_nSDIO_IRQ),
+		.end	= IRQ_GPIO(GPIO66_HX4700_ASIC3_nSDIO_IRQ),
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -623,7 +623,7 @@ static struct spi_board_info tsc2046_board_info[] __initdata = {
 		.modalias        = "ads7846",
 		.bus_num         = 2,
 		.max_speed_hz    = 2600000, /* 100 kHz sample rate */
-		.irq             = gpio_to_irq(GPIO58_HX4700_TSC2046_nPENIRQ),
+		.irq             = IRQ_GPIO(GPIO58_HX4700_TSC2046_nPENIRQ),
 		.platform_data   = &tsc2046_info,
 		.controller_data = &tsc2046_chip,
 	},
@@ -671,15 +671,15 @@ static struct resource power_supply_resources[] = {
 		.name  = "ac",
 		.flags = IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHEDGE |
 		         IORESOURCE_IRQ_LOWEDGE,
-		.start = gpio_to_irq(GPIOD9_nAC_IN),
-		.end   = gpio_to_irq(GPIOD9_nAC_IN),
+		.start = IRQ_GPIO(GPIOD9_nAC_IN),
+		.end   = IRQ_GPIO(GPIOD9_nAC_IN),
 	},
 	[1] = {
 		.name  = "usb",
 		.flags = IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHEDGE |
 		         IORESOURCE_IRQ_LOWEDGE,
-		.start = gpio_to_irq(GPIOD14_nUSBC_DETECT),
-		.end   = gpio_to_irq(GPIOD14_nUSBC_DETECT),
+		.start = IRQ_GPIO(GPIOD14_nUSBC_DETECT),
+		.end   = IRQ_GPIO(GPIOD14_nUSBC_DETECT),
 	},
 };
 
diff --git a/arch/arm/mach-pxa/icontrol.c b/arch/arm/mach-pxa/icontrol.c
index d51ee3d..eea11de 100644
--- a/arch/arm/mach-pxa/icontrol.c
+++ b/arch/arm/mach-pxa/icontrol.c
@@ -86,7 +86,7 @@ static struct spi_board_info mcp251x_board_info[] = {
 		.chip_select     = 0,
 		.platform_data   = &mcp251x_info,
 		.controller_data = &mcp251x_chip_info1,
-		.irq             = gpio_to_irq(ICONTROL_MCP251x_nIRQ1)
+		.irq             = IRQ_GPIO(ICONTROL_MCP251x_nIRQ1)
 	},
 	{
 		.modalias        = "mcp2515",
@@ -95,7 +95,7 @@ static struct spi_board_info mcp251x_board_info[] = {
 		.chip_select     = 1,
 		.platform_data   = &mcp251x_info,
 		.controller_data = &mcp251x_chip_info2,
-		.irq             = gpio_to_irq(ICONTROL_MCP251x_nIRQ2)
+		.irq             = IRQ_GPIO(ICONTROL_MCP251x_nIRQ2)
 	},
 	{
 		.modalias        = "mcp2515",
@@ -104,7 +104,7 @@ static struct spi_board_info mcp251x_board_info[] = {
 		.chip_select     = 0,
 		.platform_data   = &mcp251x_info,
 		.controller_data = &mcp251x_chip_info3,
-		.irq             = gpio_to_irq(ICONTROL_MCP251x_nIRQ3)
+		.irq             = IRQ_GPIO(ICONTROL_MCP251x_nIRQ3)
 	},
 	{
 		.modalias        = "mcp2515",
@@ -113,7 +113,7 @@ static struct spi_board_info mcp251x_board_info[] = {
 		.chip_select     = 1,
 		.platform_data   = &mcp251x_info,
 		.controller_data = &mcp251x_chip_info4,
-		.irq             = gpio_to_irq(ICONTROL_MCP251x_nIRQ4)
+		.irq             = IRQ_GPIO(ICONTROL_MCP251x_nIRQ4)
 	}
 };
 
diff --git a/arch/arm/mach-pxa/include/mach/csb726.h b/arch/arm/mach-pxa/include/mach/csb726.h
index 747ab1a..6eafb1a 100644
--- a/arch/arm/mach-pxa/include/mach/csb726.h
+++ b/arch/arm/mach-pxa/include/mach/csb726.h
@@ -19,8 +19,8 @@
 #define CSB726_FLASH_SIZE	(64 * 1024 * 1024)
 #define CSB726_FLASH_uMON	(8 * 1024 * 1024)
 
-#define CSB726_IRQ_LAN		gpio_to_irq(CSB726_GPIO_IRQ_LAN)
-#define CSB726_IRQ_SM501	gpio_to_irq(CSB726_GPIO_IRQ_SM501)
+#define CSB726_IRQ_LAN		IRQ_GPIO(CSB726_GPIO_IRQ_LAN)
+#define CSB726_IRQ_SM501	IRQ_GPIO(CSB726_GPIO_IRQ_SM501)
 
 #endif
 
diff --git a/arch/arm/mach-pxa/include/mach/gpio.h b/arch/arm/mach-pxa/include/mach/gpio.h
index b024a8b..12d7ea9 100644
--- a/arch/arm/mach-pxa/include/mach/gpio.h
+++ b/arch/arm/mach-pxa/include/mach/gpio.h
@@ -101,8 +101,9 @@
 
 #define NR_BUILTIN_GPIO 128
 
+#define gpio_to_irq		__gpio_to_irq
+
 #define gpio_to_bank(gpio)	((gpio) >> 5)
-#define gpio_to_irq(gpio)	IRQ_GPIO(gpio)
 #define irq_to_gpio(irq)	IRQ_TO_GPIO(irq)
 
 #ifdef CONFIG_CPU_PXA26x
diff --git a/arch/arm/mach-pxa/littleton.c b/arch/arm/mach-pxa/littleton.c
index 41aa89e..20681b2 100644
--- a/arch/arm/mach-pxa/littleton.c
+++ b/arch/arm/mach-pxa/littleton.c
@@ -395,7 +395,7 @@ static struct i2c_board_info littleton_i2c_info[] = {
 		.type		= "da9034",
 		.addr		= 0x34,
 		.platform_data	= &littleton_da9034_info,
-		.irq		= gpio_to_irq(mfp_to_gpio(MFP_PIN_GPIO18)),
+		.irq		= IRQ_GPIO(mfp_to_gpio(MFP_PIN_GPIO18)),
 	},
 	[1] = {
 		.type		= "max7320",
diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
index 9066376..41a7d80 100644
--- a/arch/arm/mach-pxa/magician.c
+++ b/arch/arm/mach-pxa/magician.c
@@ -184,8 +184,8 @@ static struct resource egpio_resources[] = {
 		.flags = IORESOURCE_MEM,
 	},
 	[1] = {
-		.start = gpio_to_irq(GPIO13_MAGICIAN_CPLD_IRQ),
-		.end   = gpio_to_irq(GPIO13_MAGICIAN_CPLD_IRQ),
+		.start = IRQ_GPIO(GPIO13_MAGICIAN_CPLD_IRQ),
+		.end   = IRQ_GPIO(GPIO13_MAGICIAN_CPLD_IRQ),
 		.flags = IORESOURCE_IRQ,
 	},
 };
@@ -477,8 +477,8 @@ static struct resource pasic3_resources[] = {
 	},
 	/* No IRQ handler in the PASIC3, DS1WM needs an external IRQ */
 	[1] = {
-		.start  = gpio_to_irq(GPIO107_MAGICIAN_DS1WM_IRQ),
-		.end    = gpio_to_irq(GPIO107_MAGICIAN_DS1WM_IRQ),
+		.start  = IRQ_GPIO(GPIO107_MAGICIAN_DS1WM_IRQ),
+		.end    = IRQ_GPIO(GPIO107_MAGICIAN_DS1WM_IRQ),
 		.flags  = IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHEDGE,
 	}
 };
diff --git a/arch/arm/mach-pxa/mioa701.c b/arch/arm/mach-pxa/mioa701.c
index f5fb915..3eaeee0 100644
--- a/arch/arm/mach-pxa/mioa701.c
+++ b/arch/arm/mach-pxa/mioa701.c
@@ -612,15 +612,15 @@ static struct pda_power_pdata power_pdata = {
 static struct resource power_resources[] = {
 	[0] = {
 		.name	= "ac",
-		.start	= gpio_to_irq(GPIO96_AC_DETECT),
-		.end	= gpio_to_irq(GPIO96_AC_DETECT),
+		.start	= IRQ_GPIO(GPIO96_AC_DETECT),
+		.end	= IRQ_GPIO(GPIO96_AC_DETECT),
 		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHEDGE |
 		IORESOURCE_IRQ_LOWEDGE,
 	},
 	[1] = {
 		.name	= "usb",
-		.start	= gpio_to_irq(GPIO13_nUSB_DETECT),
-		.end	= gpio_to_irq(GPIO13_nUSB_DETECT),
+		.start	= IRQ_GPIO(GPIO13_nUSB_DETECT),
+		.end	= IRQ_GPIO(GPIO13_nUSB_DETECT),
 		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHEDGE |
 		IORESOURCE_IRQ_LOWEDGE,
 	},
diff --git a/arch/arm/mach-pxa/mxm8x10.c b/arch/arm/mach-pxa/mxm8x10.c
index 462167a..c36f566 100644
--- a/arch/arm/mach-pxa/mxm8x10.c
+++ b/arch/arm/mach-pxa/mxm8x10.c
@@ -416,8 +416,8 @@ static struct resource dm9k_resources[] = {
 	       .flags = IORESOURCE_MEM
 	},
 	[2] = {
-	       .start = gpio_to_irq(mfp_to_gpio(MFP_PIN_GPIO9)),
-	       .end = gpio_to_irq(mfp_to_gpio(MFP_PIN_GPIO9)),
+	       .start = IRQ_GPIO(mfp_to_gpio(MFP_PIN_GPIO9)),
+	       .end = IRQ_GPIO(mfp_to_gpio(MFP_PIN_GPIO9)),
 	       .flags = IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHEDGE
 	}
 };
diff --git a/arch/arm/mach-pxa/poodle.c b/arch/arm/mach-pxa/poodle.c
index 93a191c..414aaf7 100644
--- a/arch/arm/mach-pxa/poodle.c
+++ b/arch/arm/mach-pxa/poodle.c
@@ -211,7 +211,7 @@ static struct spi_board_info poodle_spi_devices[] = {
 		.bus_num	= 1,
 		.platform_data	= &poodle_ads7846_info,
 		.controller_data= &poodle_ads7846_chip,
-		.irq		= gpio_to_irq(POODLE_GPIO_TP_INT),
+		.irq		= IRQ_GPIO(POODLE_GPIO_TP_INT),
 	},
 };
 
diff --git a/arch/arm/mach-pxa/raumfeld.c b/arch/arm/mach-pxa/raumfeld.c
index 4121d03..07757f0 100644
--- a/arch/arm/mach-pxa/raumfeld.c
+++ b/arch/arm/mach-pxa/raumfeld.c
@@ -296,8 +296,8 @@ static struct resource smc91x_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	{
-		.start	= gpio_to_irq(GPIO_ETH_IRQ),
-		.end	= gpio_to_irq(GPIO_ETH_IRQ),
+		.start	= IRQ_GPIO(GPIO_ETH_IRQ),
+		.end	= IRQ_GPIO(GPIO_ETH_IRQ),
 		.flags	= IORESOURCE_IRQ | IRQF_TRIGGER_FALLING,
 	}
 };
@@ -668,7 +668,7 @@ static struct lis3lv02d_platform_data lis3_pdata = {
 	.chip_select	= 1,			\
 	.controller_data = (void *) GPIO_ACCEL_CS,	\
 	.platform_data	= &lis3_pdata,		\
-	.irq		= gpio_to_irq(GPIO_ACCEL_IRQ),	\
+	.irq		= IRQ_GPIO(GPIO_ACCEL_IRQ),	\
 }
 
 #define SPI_DAC7512	\
@@ -952,7 +952,7 @@ static struct eeti_ts_platform_data eeti_ts_pdata = {
 static struct i2c_board_info raumfeld_controller_i2c_board_info __initdata = {
 	.type	= "eeti_ts",
 	.addr	= 0x0a,
-	.irq	= gpio_to_irq(GPIO_TOUCH_IRQ),
+	.irq	= IRQ_GPIO(GPIO_TOUCH_IRQ),
 	.platform_data = &eeti_ts_pdata,
 };
 
diff --git a/arch/arm/mach-pxa/saar.c b/arch/arm/mach-pxa/saar.c
index ffa50e6..5c98132 100644
--- a/arch/arm/mach-pxa/saar.c
+++ b/arch/arm/mach-pxa/saar.c
@@ -96,8 +96,8 @@ static struct resource smc91x_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= gpio_to_irq(mfp_to_gpio(MFP_PIN_GPIO97)),
-		.end	= gpio_to_irq(mfp_to_gpio(MFP_PIN_GPIO97)),
+		.start	= IRQ_GPIO(mfp_to_gpio(MFP_PIN_GPIO97)),
+		.end	= IRQ_GPIO(mfp_to_gpio(MFP_PIN_GPIO97)),
 		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHEDGE,
 	}
 };
@@ -502,7 +502,7 @@ static struct i2c_board_info saar_i2c_info[] = {
 		.type		= "da9034",
 		.addr		= 0x34,
 		.platform_data	= &saar_da9034_info,
-		.irq		= gpio_to_irq(mfp_to_gpio(MFP_PIN_GPIO83)),
+		.irq		= IRQ_GPIO(mfp_to_gpio(MFP_PIN_GPIO83)),
 	},
 };
 
diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
index f736119..bd68a26 100644
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -550,7 +550,7 @@ static struct spi_board_info spitz_spi_devices[] = {
 		.chip_select		= 0,
 		.platform_data		= &spitz_ads7846_info,
 		.controller_data	= &spitz_ads7846_chip,
-		.irq			= gpio_to_irq(SPITZ_GPIO_TP_INT),
+		.irq			= IRQ_GPIO(SPITZ_GPIO_TP_INT),
 	}, {
 		.modalias		= "corgi-lcd",
 		.max_speed_hz		= 50000,
diff --git a/arch/arm/mach-pxa/stargate2.c b/arch/arm/mach-pxa/stargate2.c
index 738adc1..8160af9 100644
--- a/arch/arm/mach-pxa/stargate2.c
+++ b/arch/arm/mach-pxa/stargate2.c
@@ -545,7 +545,7 @@ static struct i2c_board_info __initdata imote2_pwr_i2c_board_info[] = {
 		.type = "da9030",
 		.addr = 0x49,
 		.platform_data = &imote2_da9030_pdata,
-		.irq = gpio_to_irq(1),
+		.irq = IRQ_GPIO(1),
 	},
 };
 
@@ -912,7 +912,7 @@ static struct i2c_board_info __initdata stargate2_pwr_i2c_board_info[] = {
 		.type = "da9030",
 		.addr = 0x49,
 		.platform_data = &stargate2_da9030_pdata,
-		.irq = gpio_to_irq(1),
+		.irq = IRQ_GPIO(1),
 	},
 };
 
diff --git a/arch/arm/mach-pxa/tavorevb.c b/arch/arm/mach-pxa/tavorevb.c
index 2ea7545..b1780f2 100644
--- a/arch/arm/mach-pxa/tavorevb.c
+++ b/arch/arm/mach-pxa/tavorevb.c
@@ -85,8 +85,8 @@ static struct resource smc91x_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= gpio_to_irq(mfp_to_gpio(MFP_PIN_GPIO47)),
-		.end	= gpio_to_irq(mfp_to_gpio(MFP_PIN_GPIO47)),
+		.start	= IRQ_GPIO(mfp_to_gpio(MFP_PIN_GPIO47)),
+		.end	= IRQ_GPIO(mfp_to_gpio(MFP_PIN_GPIO47)),
 		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHEDGE,
 	}
 };
diff --git a/arch/arm/mach-pxa/tavorevb3.c b/arch/arm/mach-pxa/tavorevb3.c
index dc30116..90471a8 100644
--- a/arch/arm/mach-pxa/tavorevb3.c
+++ b/arch/arm/mach-pxa/tavorevb3.c
@@ -102,7 +102,7 @@ static struct i2c_board_info evb3_i2c_info[] = {
 		.type		= "88PM860x",
 		.addr		= 0x34,
 		.platform_data	= &evb3_pm8607_info,
-		.irq		= gpio_to_irq(mfp_to_gpio(MFP_PIN_GPIO83)),
+		.irq		= IRQ_GPIO(mfp_to_gpio(MFP_PIN_GPIO83)),
 	},
 };
 
diff --git a/arch/arm/mach-pxa/tosa.c b/arch/arm/mach-pxa/tosa.c
index 0ee1df4..42028a0 100644
--- a/arch/arm/mach-pxa/tosa.c
+++ b/arch/arm/mach-pxa/tosa.c
@@ -394,8 +394,8 @@ static struct pda_power_pdata tosa_power_data = {
 static struct resource tosa_power_resource[] = {
 	{
 		.name		= "ac",
-		.start		= gpio_to_irq(TOSA_GPIO_AC_IN),
-		.end		= gpio_to_irq(TOSA_GPIO_AC_IN),
+		.start		= IRQ_GPIO(TOSA_GPIO_AC_IN),
+		.end		= IRQ_GPIO(TOSA_GPIO_AC_IN),
 		.flags		= IORESOURCE_IRQ |
 				  IORESOURCE_IRQ_HIGHEDGE |
 				  IORESOURCE_IRQ_LOWEDGE,
diff --git a/arch/arm/mach-pxa/viper.c b/arch/arm/mach-pxa/viper.c
index 438fc9a..3abec52 100644
--- a/arch/arm/mach-pxa/viper.c
+++ b/arch/arm/mach-pxa/viper.c
@@ -422,8 +422,8 @@ static struct resource smc91x_resources[] = {
 		.flags  = IORESOURCE_MEM,
 	},
 	[1] = {
-		.start  = gpio_to_irq(VIPER_ETH_GPIO),
-		.end    = gpio_to_irq(VIPER_ETH_GPIO),
+		.start  = IRQ_GPIO(VIPER_ETH_GPIO),
+		.end    = IRQ_GPIO(VIPER_ETH_GPIO),
 		.flags  = IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHEDGE,
 	},
 	[2] = {
@@ -546,7 +546,7 @@ static struct plat_serial8250_port serial_platform_data[] = {
 	/* External UARTs */
 	{
 		.mapbase	= VIPER_UARTA_PHYS,
-		.irq		= gpio_to_irq(VIPER_UARTA_GPIO),
+		.irq		= IRQ_GPIO(VIPER_UARTA_GPIO),
 		.irqflags	= IRQF_TRIGGER_RISING,
 		.uartclk	= 1843200,
 		.regshift	= 1,
@@ -556,7 +556,7 @@ static struct plat_serial8250_port serial_platform_data[] = {
 	},
 	{
 		.mapbase	= VIPER_UARTB_PHYS,
-		.irq		= gpio_to_irq(VIPER_UARTB_GPIO),
+		.irq		= IRQ_GPIO(VIPER_UARTB_GPIO),
 		.irqflags	= IRQF_TRIGGER_RISING,
 		.uartclk	= 1843200,
 		.regshift	= 1,
@@ -596,8 +596,8 @@ static struct resource isp116x_resources[] = {
 		.flags  = IORESOURCE_MEM,
 	},
 	[2] = {
-		.start  = gpio_to_irq(VIPER_USB_GPIO),
-		.end    = gpio_to_irq(VIPER_USB_GPIO),
+		.start  = IRQ_GPIO(VIPER_USB_GPIO),
+		.end    = IRQ_GPIO(VIPER_USB_GPIO),
 		.flags  = IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHEDGE,
 	},
 };
diff --git a/arch/arm/mach-pxa/vpac270.c b/arch/arm/mach-pxa/vpac270.c
index f45ac09..7906125 100644
--- a/arch/arm/mach-pxa/vpac270.c
+++ b/arch/arm/mach-pxa/vpac270.c
@@ -612,8 +612,8 @@ static struct resource vpac270_ide_resources[] = {
 	       .flags	= IORESOURCE_DMA
 	},
 	[3] = {	/* IDE IRQ pin */
-	       .start	= gpio_to_irq(GPIO36_VPAC270_IDE_IRQ),
-	       .end	= gpio_to_irq(GPIO36_VPAC270_IDE_IRQ),
+	       .start	= IRQ_GPIO(GPIO36_VPAC270_IDE_IRQ),
+	       .end	= IRQ_GPIO(GPIO36_VPAC270_IDE_IRQ),
 	       .flags	= IORESOURCE_IRQ
 	}
 };
diff --git a/arch/arm/mach-pxa/z2.c b/arch/arm/mach-pxa/z2.c
index fefde98..cac7e09 100644
--- a/arch/arm/mach-pxa/z2.c
+++ b/arch/arm/mach-pxa/z2.c
@@ -574,7 +574,7 @@ static struct spi_board_info spi_board_info[] __initdata = {
 	.modalias		= "libertas_spi",
 	.platform_data		= &z2_lbs_pdata,
 	.controller_data	= &z2_lbs_chip_info,
-	.irq			= gpio_to_irq(GPIO36_ZIPITZ2_WIFI_IRQ),
+	.irq			= IRQ_GPIO(GPIO36_ZIPITZ2_WIFI_IRQ),
 	.max_speed_hz		= 13000000,
 	.bus_num		= 1,
 	.chip_select		= 0,
diff --git a/arch/arm/mach-pxa/zeus.c b/arch/arm/mach-pxa/zeus.c
index dea46a2..60a959a 100644
--- a/arch/arm/mach-pxa/zeus.c
+++ b/arch/arm/mach-pxa/zeus.c
@@ -232,7 +232,7 @@ static struct plat_serial8250_port serial_platform_data[] = {
 	/* FIXME: Shared IRQs on COM1-COM4 will not work properly on v1i1 hardware. */
 	{ /* COM1 */
 		.mapbase	= 0x10000000,
-		.irq		= gpio_to_irq(ZEUS_UARTA_GPIO),
+		.irq		= IRQ_GPIO(ZEUS_UARTA_GPIO),
 		.irqflags	= IRQF_TRIGGER_RISING,
 		.uartclk	= 14745600,
 		.regshift	= 1,
@@ -241,7 +241,7 @@ static struct plat_serial8250_port serial_platform_data[] = {
 	},
 	{ /* COM2 */
 		.mapbase	= 0x10800000,
-		.irq		= gpio_to_irq(ZEUS_UARTB_GPIO),
+		.irq		= IRQ_GPIO(ZEUS_UARTB_GPIO),
 		.irqflags	= IRQF_TRIGGER_RISING,
 		.uartclk	= 14745600,
 		.regshift	= 1,
@@ -250,7 +250,7 @@ static struct plat_serial8250_port serial_platform_data[] = {
 	},
 	{ /* COM3 */
 		.mapbase	= 0x11000000,
-		.irq		= gpio_to_irq(ZEUS_UARTC_GPIO),
+		.irq		= IRQ_GPIO(ZEUS_UARTC_GPIO),
 		.irqflags	= IRQF_TRIGGER_RISING,
 		.uartclk	= 14745600,
 		.regshift	= 1,
@@ -259,7 +259,7 @@ static struct plat_serial8250_port serial_platform_data[] = {
 	},
 	{ /* COM4 */
 		.mapbase	= 0x11800000,
-		.irq		= gpio_to_irq(ZEUS_UARTD_GPIO),
+		.irq		= IRQ_GPIO(ZEUS_UARTD_GPIO),
 		.irqflags	= IRQF_TRIGGER_RISING,
 		.uartclk	= 14745600,
 		.regshift	= 1,
@@ -320,8 +320,8 @@ static struct resource zeus_dm9k0_resource[] = {
 		.flags = IORESOURCE_MEM
 	},
 	[2] = {
-		.start = gpio_to_irq(ZEUS_ETH0_GPIO),
-		.end   = gpio_to_irq(ZEUS_ETH0_GPIO),
+		.start = IRQ_GPIO(ZEUS_ETH0_GPIO),
+		.end   = IRQ_GPIO(ZEUS_ETH0_GPIO),
 		.flags = IORESOURCE_IRQ | IORESOURCE_IRQ_LOWEDGE,
 	},
 };
@@ -338,8 +338,8 @@ static struct resource zeus_dm9k1_resource[] = {
 		.flags = IORESOURCE_MEM,
 	},
 	[2] = {
-		.start = gpio_to_irq(ZEUS_ETH1_GPIO),
-		.end   = gpio_to_irq(ZEUS_ETH1_GPIO),
+		.start = IRQ_GPIO(ZEUS_ETH1_GPIO),
+		.end   = IRQ_GPIO(ZEUS_ETH1_GPIO),
 		.flags = IORESOURCE_IRQ | IORESOURCE_IRQ_LOWEDGE,
 	},
 };
@@ -422,7 +422,7 @@ static struct spi_board_info zeus_spi_board_info[] = {
 	[0] = {
 		.modalias	= "mcp2515",
 		.platform_data	= &zeus_mcp2515_pdata,
-		.irq		= gpio_to_irq(ZEUS_CAN_GPIO),
+		.irq		= IRQ_GPIO(ZEUS_CAN_GPIO),
 		.max_speed_hz	= 1*1000*1000,
 		.bus_num	= 3,
 		.mode		= SPI_MODE_0,
@@ -752,7 +752,7 @@ static struct i2c_board_info __initdata zeus_i2c_devices[] = {
 	{
 		I2C_BOARD_INFO("pca9535",	0x20),
 		.platform_data	= &zeus_pca953x_pdata[2],
-		.irq		= gpio_to_irq(ZEUS_EXTGPIO_GPIO),
+		.irq		= IRQ_GPIO(ZEUS_EXTGPIO_GPIO),
 	},
 	{ I2C_BOARD_INFO("lm75a",	0x48) },
 	{ I2C_BOARD_INFO("24c01",	0x50) },
-- 
1.7.1
