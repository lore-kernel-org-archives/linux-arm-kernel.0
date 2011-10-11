From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Tue, 11 Oct 2011 21:17:27 +0800
Subject: [PATCH v3 3/7] ARM: pxa: rename gpio_to_irq and irq_to_gpio
In-Reply-To: <1318339051-19096-1-git-send-email-haojian.zhuang@marvell.com>
References: <1318339051-19096-1-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <1318339051-19096-4-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Avoid to define gpio_to_irq() and irq_to_gpio() for potential name
confliction since multiple architecture will be built together.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/mach-mmp/aspenite.c              |    4 +-
 arch/arm/mach-mmp/flint.c                 |    4 +-
 arch/arm/mach-mmp/include/mach/gpio-pxa.h |    1 +
 arch/arm/mach-mmp/include/mach/gpio.h     |    3 -
 arch/arm/mach-mmp/include/mach/irqs.h     |    1 +
 arch/arm/mach-mmp/tavorevb.c              |    4 +-
 arch/arm/mach-mmp/teton_bga.c             |    2 +-
 arch/arm/mach-pxa/capc7117.c              |   12 ++--
 arch/arm/mach-pxa/cm-x270.c               |    2 +-
 arch/arm/mach-pxa/cm-x2xx-pci.c           |    4 +-
 arch/arm/mach-pxa/colibri-pxa270.c        |    6 +-
 arch/arm/mach-pxa/colibri-pxa300.c        |    4 +-
 arch/arm/mach-pxa/colibri-pxa320.c        |    4 +-
 arch/arm/mach-pxa/corgi.c                 |    2 +-
 arch/arm/mach-pxa/em-x270.c               |    6 +-
 arch/arm/mach-pxa/hx4700.c                |   18 +++---
 arch/arm/mach-pxa/icontrol.c              |    8 +-
 arch/arm/mach-pxa/include/mach/csb726.h   |    4 +-
 arch/arm/mach-pxa/include/mach/gpio.h     |    3 -
 arch/arm/mach-pxa/littleton.c             |    2 +-
 arch/arm/mach-pxa/magician.c              |    8 +-
 arch/arm/mach-pxa/mioa701.c               |   12 ++--
 arch/arm/mach-pxa/mxm8x10.c               |    4 +-
 arch/arm/mach-pxa/poodle.c                |    2 +-
 arch/arm/mach-pxa/pxa25x.c                |    2 +-
 arch/arm/mach-pxa/pxa27x.c                |    2 +-
 arch/arm/mach-pxa/raumfeld.c              |   14 ++--
 arch/arm/mach-pxa/saar.c                  |    6 +-
 arch/arm/mach-pxa/saarb.c                 |    2 +-
 arch/arm/mach-pxa/spitz.c                 |    2 +-
 arch/arm/mach-pxa/stargate2.c             |    4 +-
 arch/arm/mach-pxa/tavorevb.c              |    4 +-
 arch/arm/mach-pxa/tavorevb3.c             |    2 +-
 arch/arm/mach-pxa/tosa.c                  |    4 +-
 arch/arm/mach-pxa/viper.c                 |   16 ++--
 arch/arm/mach-pxa/vpac270.c               |    4 +-
 arch/arm/mach-pxa/z2.c                    |    2 +-
 arch/arm/mach-pxa/zeus.c                  |   34 +++++-----
 arch/arm/mach-pxa/zylonite.c              |    4 +-
 arch/arm/plat-pxa/include/plat/gpio-pxa.h |    1 +
 drivers/gpio/gpio-pxa.c                   |  104 +++++++++++++++++++++++++++--
 41 files changed, 209 insertions(+), 118 deletions(-)

diff --git a/arch/arm/mach-mmp/aspenite.c b/arch/arm/mach-mmp/aspenite.c
index 06b5ad7..fb7dfc1 100644
--- a/arch/arm/mach-mmp/aspenite.c
+++ b/arch/arm/mach-mmp/aspenite.c
@@ -120,8 +120,8 @@ static struct resource smc91x_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= gpio_to_irq(27),
-		.end	= gpio_to_irq(27),
+		.start	= MMP_GPIO_TO_IRQ(27),
+		.end	= MMP_GPIO_TO_IRQ(27),
 		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHEDGE,
 	}
 };
diff --git a/arch/arm/mach-mmp/flint.c b/arch/arm/mach-mmp/flint.c
index c4fd806..a64c172 100644
--- a/arch/arm/mach-mmp/flint.c
+++ b/arch/arm/mach-mmp/flint.c
@@ -87,8 +87,8 @@ static struct resource smc91x_resources[] = {
 		.flags  = IORESOURCE_MEM,
 	},
 	[1] = {
-		.start  = gpio_to_irq(155),
-		.end    = gpio_to_irq(155),
+		.start  = MMP_GPIO_TO_IRQ(155),
+		.end    = MMP_GPIO_TO_IRQ(155),
 		.flags  = IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHEDGE,
 	}
 };
diff --git a/arch/arm/mach-mmp/include/mach/gpio-pxa.h b/arch/arm/mach-mmp/include/mach/gpio-pxa.h
index c017a98..f7bcc30 100644
--- a/arch/arm/mach-mmp/include/mach/gpio-pxa.h
+++ b/arch/arm/mach-mmp/include/mach/gpio-pxa.h
@@ -2,6 +2,7 @@
 #define __ASM_MACH_GPIO_PXA_H
 
 #include <mach/addr-map.h>
+#include <mach/cputype.h>
 #include <mach/irqs.h>
 
 #define GPIO_REGS_VIRT	(APB_VIRT_BASE + 0x19000)
diff --git a/arch/arm/mach-mmp/include/mach/gpio.h b/arch/arm/mach-mmp/include/mach/gpio.h
index 6812623..32b684a 100644
--- a/arch/arm/mach-mmp/include/mach/gpio.h
+++ b/arch/arm/mach-mmp/include/mach/gpio.h
@@ -3,9 +3,6 @@
 
 #include <asm-generic/gpio.h>
 
-#define gpio_to_irq(gpio)	(IRQ_GPIO_START + (gpio))
-#define irq_to_gpio(irq)	((irq) - IRQ_GPIO_START)
-
 #define __gpio_is_inverted(gpio)	(0)
 #define __gpio_is_occupied(gpio)	(0)
 
diff --git a/arch/arm/mach-mmp/include/mach/irqs.h b/arch/arm/mach-mmp/include/mach/irqs.h
index a09d328..ec95951 100644
--- a/arch/arm/mach-mmp/include/mach/irqs.h
+++ b/arch/arm/mach-mmp/include/mach/irqs.h
@@ -221,6 +221,7 @@
 #define IRQ_GPIO_START			128
 #define IRQ_GPIO_NUM			192
 #define IRQ_GPIO(x)			(IRQ_GPIO_START + (x))
+#define MMP_GPIO_TO_IRQ(gpio)		(IRQ_GPIO_START + (gpio))
 
 #define IRQ_BOARD_START			(IRQ_GPIO_START + IRQ_GPIO_NUM)
 
diff --git a/arch/arm/mach-mmp/tavorevb.c b/arch/arm/mach-mmp/tavorevb.c
index eb5be87..0afe3a3 100644
--- a/arch/arm/mach-mmp/tavorevb.c
+++ b/arch/arm/mach-mmp/tavorevb.c
@@ -71,8 +71,8 @@ static struct resource smc91x_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= gpio_to_irq(80),
-		.end	= gpio_to_irq(80),
+		.start	= MMP_GPIO_TO_IRQ(80),
+		.end	= MMP_GPIO_TO_IRQ(80),
 		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHEDGE,
 	}
 };
diff --git a/arch/arm/mach-mmp/teton_bga.c b/arch/arm/mach-mmp/teton_bga.c
index bbe4727..825a01c 100644
--- a/arch/arm/mach-mmp/teton_bga.c
+++ b/arch/arm/mach-mmp/teton_bga.c
@@ -66,7 +66,7 @@ static struct pxa27x_keypad_platform_data teton_bga_keypad_info __initdata = {
 static struct i2c_board_info teton_bga_i2c_info[] __initdata = {
 	{
 		I2C_BOARD_INFO("ds1337", 0x68),
-		.irq = gpio_to_irq(RTC_INT_GPIO)
+		.irq = MMP_GPIO_TO_IRQ(RTC_INT_GPIO)
 	},
 };
 
diff --git a/arch/arm/mach-pxa/capc7117.c b/arch/arm/mach-pxa/capc7117.c
index 4efc16d..5516317 100644
--- a/arch/arm/mach-pxa/capc7117.c
+++ b/arch/arm/mach-pxa/capc7117.c
@@ -50,8 +50,8 @@ static struct resource capc7117_ide_resources[] = {
 	       .flags = IORESOURCE_MEM
 	},
 	[2] = {
-	       .start = gpio_to_irq(mfp_to_gpio(MFP_PIN_GPIO76)),
-	       .end = gpio_to_irq(mfp_to_gpio(MFP_PIN_GPIO76)),
+	       .start = PXA_GPIO_TO_IRQ(mfp_to_gpio(MFP_PIN_GPIO76)),
+	       .end = PXA_GPIO_TO_IRQ(mfp_to_gpio(MFP_PIN_GPIO76)),
 	       .flags = IORESOURCE_IRQ | IRQF_TRIGGER_RISING
 	}
 };
@@ -80,7 +80,7 @@ static void __init capc7117_ide_init(void)
 static struct plat_serial8250_port ti16c752_platform_data[] = {
 	[0] = {
 	       .mapbase = 0x14000000,
-	       .irq = gpio_to_irq(mfp_to_gpio(MFP_PIN_GPIO78)),
+	       .irq = PXA_GPIO_TO_IRQ(mfp_to_gpio(MFP_PIN_GPIO78)),
 	       .irqflags = IRQF_TRIGGER_RISING,
 	       .flags = TI16C752_FLAGS,
 	       .iotype = UPIO_MEM,
@@ -89,7 +89,7 @@ static struct plat_serial8250_port ti16c752_platform_data[] = {
 	},
 	[1] = {
 	       .mapbase = 0x14000040,
-	       .irq = gpio_to_irq(mfp_to_gpio(MFP_PIN_GPIO79)),
+	       .irq = PXA_GPIO_TO_IRQ(mfp_to_gpio(MFP_PIN_GPIO79)),
 	       .irqflags = IRQF_TRIGGER_RISING,
 	       .flags = TI16C752_FLAGS,
 	       .iotype = UPIO_MEM,
@@ -98,7 +98,7 @@ static struct plat_serial8250_port ti16c752_platform_data[] = {
 	},
 	[2] = {
 	       .mapbase = 0x14000080,
-	       .irq = gpio_to_irq(mfp_to_gpio(MFP_PIN_GPIO80)),
+	       .irq = PXA_GPIO_TO_IRQ(mfp_to_gpio(MFP_PIN_GPIO80)),
 	       .irqflags = IRQF_TRIGGER_RISING,
 	       .flags = TI16C752_FLAGS,
 	       .iotype = UPIO_MEM,
@@ -107,7 +107,7 @@ static struct plat_serial8250_port ti16c752_platform_data[] = {
 	},
 	[3] = {
 	       .mapbase = 0x140000c0,
-	       .irq = gpio_to_irq(mfp_to_gpio(MFP_PIN_GPIO81)),
+	       .irq = PXA_GPIO_TO_IRQ(mfp_to_gpio(MFP_PIN_GPIO81)),
 	       .irqflags = IRQF_TRIGGER_RISING,
 	       .flags = TI16C752_FLAGS,
 	       .iotype = UPIO_MEM,
diff --git a/arch/arm/mach-pxa/cm-x270.c b/arch/arm/mach-pxa/cm-x270.c
index 4ebcee5..431ef56 100644
--- a/arch/arm/mach-pxa/cm-x270.c
+++ b/arch/arm/mach-pxa/cm-x270.c
@@ -380,7 +380,7 @@ static struct spi_board_info cm_x270_spi_devices[] __initdata = {
 		.modalias		= "libertas_spi",
 		.max_speed_hz		= 13000000,
 		.bus_num		= 2,
-		.irq			= gpio_to_irq(95),
+		.irq			= PXA_GPIO_TO_IRQ(95),
 		.chip_select		= 0,
 		.controller_data	= &cm_x270_libertas_chip,
 		.platform_data		= &cm_x270_libertas_pdata,
diff --git a/arch/arm/mach-pxa/cm-x2xx-pci.c b/arch/arm/mach-pxa/cm-x2xx-pci.c
index 6bf479d..dd8443f 100644
--- a/arch/arm/mach-pxa/cm-x2xx-pci.c
+++ b/arch/arm/mach-pxa/cm-x2xx-pci.c
@@ -43,9 +43,9 @@ void __cmx2xx_pci_init_irq(int irq_gpio)
 
 	cmx2xx_it8152_irq_gpio = irq_gpio;
 
-	irq_set_irq_type(gpio_to_irq(irq_gpio), IRQ_TYPE_EDGE_RISING);
+	irq_set_irq_type(PXA_GPIO_TO_IRQ(irq_gpio), IRQ_TYPE_EDGE_RISING);
 
-	irq_set_chained_handler(gpio_to_irq(irq_gpio),
+	irq_set_chained_handler(PXA_GPIO_TO_IRQ(irq_gpio),
 				cmx2xx_it8152_irq_demux);
 }
 
diff --git a/arch/arm/mach-pxa/colibri-pxa270.c b/arch/arm/mach-pxa/colibri-pxa270.c
index 7db6646..3b25472 100644
--- a/arch/arm/mach-pxa/colibri-pxa270.c
+++ b/arch/arm/mach-pxa/colibri-pxa270.c
@@ -217,8 +217,8 @@ static struct resource colibri_pxa270_dm9000_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	{
-		.start	= gpio_to_irq(GPIO114_COLIBRI_PXA270_ETH_IRQ),
-		.end	= gpio_to_irq(GPIO114_COLIBRI_PXA270_ETH_IRQ),
+		.start	= PXA_GPIO_TO_IRQ(GPIO114_COLIBRI_PXA270_ETH_IRQ),
+		.end	= PXA_GPIO_TO_IRQ(GPIO114_COLIBRI_PXA270_ETH_IRQ),
 		.flags	= IORESOURCE_IRQ | IRQF_TRIGGER_RISING,
 	},
 };
@@ -248,7 +248,7 @@ static pxa2xx_audio_ops_t colibri_pxa270_ac97_pdata = {
 };
 
 static struct ucb1400_pdata colibri_pxa270_ucb1400_pdata = {
-	.irq		= gpio_to_irq(GPIO113_COLIBRI_PXA270_TS_IRQ),
+	.irq		= PXA_GPIO_TO_IRQ(GPIO113_COLIBRI_PXA270_TS_IRQ),
 };
 
 static struct platform_device colibri_pxa270_ucb1400_device = {
diff --git a/arch/arm/mach-pxa/colibri-pxa300.c b/arch/arm/mach-pxa/colibri-pxa300.c
index c825e8b..0a6222e 100644
--- a/arch/arm/mach-pxa/colibri-pxa300.c
+++ b/arch/arm/mach-pxa/colibri-pxa300.c
@@ -78,8 +78,8 @@ static struct resource colibri_asix_resource[] = {
 		.flags = IORESOURCE_MEM,
 	},
 	[1] = {
-		.start = gpio_to_irq(COLIBRI_ETH_IRQ_GPIO),
-		.end   = gpio_to_irq(COLIBRI_ETH_IRQ_GPIO),
+		.start = PXA_GPIO_TO_IRQ(COLIBRI_ETH_IRQ_GPIO),
+		.end   = PXA_GPIO_TO_IRQ(COLIBRI_ETH_IRQ_GPIO),
 		.flags = IORESOURCE_IRQ | IRQF_TRIGGER_FALLING,
 	}
 };
diff --git a/arch/arm/mach-pxa/colibri-pxa320.c b/arch/arm/mach-pxa/colibri-pxa320.c
index 692e1ff..8cbb2b4 100644
--- a/arch/arm/mach-pxa/colibri-pxa320.c
+++ b/arch/arm/mach-pxa/colibri-pxa320.c
@@ -115,8 +115,8 @@ static struct resource colibri_asix_resource[] = {
 		.flags = IORESOURCE_MEM,
 	},
 	[1] = {
-		.start = gpio_to_irq(COLIBRI_ETH_IRQ_GPIO),
-		.end   = gpio_to_irq(COLIBRI_ETH_IRQ_GPIO),
+		.start = PXA_GPIO_TO_IRQ(COLIBRI_ETH_IRQ_GPIO),
+		.end   = PXA_GPIO_TO_IRQ(COLIBRI_ETH_IRQ_GPIO),
 		.flags = IORESOURCE_IRQ | IRQF_TRIGGER_FALLING,
 	}
 };
diff --git a/arch/arm/mach-pxa/corgi.c b/arch/arm/mach-pxa/corgi.c
index 3e9483b..bed7cec 100644
--- a/arch/arm/mach-pxa/corgi.c
+++ b/arch/arm/mach-pxa/corgi.c
@@ -530,7 +530,7 @@ static struct spi_board_info corgi_spi_devices[] = {
 		.chip_select	= 0,
 		.platform_data	= &corgi_ads7846_info,
 		.controller_data= &corgi_ads7846_chip,
-		.irq		= gpio_to_irq(CORGI_GPIO_TP_INT),
+		.irq		= PXA_GPIO_TO_IRQ(CORGI_GPIO_TP_INT),
 	}, {
 		.modalias	= "corgi-lcd",
 		.max_speed_hz	= 50000,
diff --git a/arch/arm/mach-pxa/em-x270.c b/arch/arm/mach-pxa/em-x270.c
index 3358f4d..e71c395 100644
--- a/arch/arm/mach-pxa/em-x270.c
+++ b/arch/arm/mach-pxa/em-x270.c
@@ -558,7 +558,7 @@ static int em_x270_mci_init(struct device *dev,
 		return PTR_ERR(em_x270_sdio_ldo);
 	}
 
-	err = request_irq(gpio_to_irq(mmc_cd), em_x270_detect_int,
+	err = request_irq(PXA_GPIO_TO_IRQ(mmc_cd), em_x270_detect_int,
 			      IRQF_DISABLED | IRQF_TRIGGER_RISING |
 			      IRQF_TRIGGER_FALLING,
 			      "MMC card detect", data);
@@ -588,7 +588,7 @@ static int em_x270_mci_init(struct device *dev,
 	return 0;
 
 err_gpio_wp:
-	free_irq(gpio_to_irq(mmc_cd), data);
+	free_irq(PXA_GPIO_TO_IRQ(mmc_cd), data);
 err_irq:
 	regulator_put(em_x270_sdio_ldo);
 
@@ -611,7 +611,7 @@ static void em_x270_mci_setpower(struct device *dev, unsigned int vdd)
 
 static void em_x270_mci_exit(struct device *dev, void *data)
 {
-	free_irq(gpio_to_irq(mmc_cd), data);
+	free_irq(PXA_GPIO_TO_IRQ(mmc_cd), data);
 	regulator_put(em_x270_sdio_ldo);
 
 	if (machine_is_em_x270())
diff --git a/arch/arm/mach-pxa/hx4700.c b/arch/arm/mach-pxa/hx4700.c
index 6f6368e..82e9976 100644
--- a/arch/arm/mach-pxa/hx4700.c
+++ b/arch/arm/mach-pxa/hx4700.c
@@ -252,8 +252,8 @@ static struct resource asic3_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= gpio_to_irq(GPIO12_HX4700_ASIC3_IRQ),
-		.end	= gpio_to_irq(GPIO12_HX4700_ASIC3_IRQ),
+		.start	= PXA_GPIO_TO_IRQ(GPIO12_HX4700_ASIC3_IRQ),
+		.end	= PXA_GPIO_TO_IRQ(GPIO12_HX4700_ASIC3_IRQ),
 		.flags	= IORESOURCE_IRQ,
 	},
 	/* SD part */
@@ -263,8 +263,8 @@ static struct resource asic3_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[3] = {
-		.start	= gpio_to_irq(GPIO66_HX4700_ASIC3_nSDIO_IRQ),
-		.end	= gpio_to_irq(GPIO66_HX4700_ASIC3_nSDIO_IRQ),
+		.start	= PXA_GPIO_TO_IRQ(GPIO66_HX4700_ASIC3_nSDIO_IRQ),
+		.end	= PXA_GPIO_TO_IRQ(GPIO66_HX4700_ASIC3_nSDIO_IRQ),
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -587,7 +587,7 @@ static struct spi_board_info tsc2046_board_info[] __initdata = {
 		.modalias        = "ads7846",
 		.bus_num         = 2,
 		.max_speed_hz    = 2600000, /* 100 kHz sample rate */
-		.irq             = gpio_to_irq(GPIO58_HX4700_TSC2046_nPENIRQ),
+		.irq             = PXA_GPIO_TO_IRQ(GPIO58_HX4700_TSC2046_nPENIRQ),
 		.platform_data   = &tsc2046_info,
 		.controller_data = &tsc2046_chip,
 	},
@@ -635,15 +635,15 @@ static struct resource power_supply_resources[] = {
 		.name  = "ac",
 		.flags = IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHEDGE |
 		         IORESOURCE_IRQ_LOWEDGE,
-		.start = gpio_to_irq(GPIOD9_nAC_IN),
-		.end   = gpio_to_irq(GPIOD9_nAC_IN),
+		.start = PXA_GPIO_TO_IRQ(GPIOD9_nAC_IN),
+		.end   = PXA_GPIO_TO_IRQ(GPIOD9_nAC_IN),
 	},
 	[1] = {
 		.name  = "usb",
 		.flags = IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHEDGE |
 		         IORESOURCE_IRQ_LOWEDGE,
-		.start = gpio_to_irq(GPIOD14_nUSBC_DETECT),
-		.end   = gpio_to_irq(GPIOD14_nUSBC_DETECT),
+		.start = PXA_GPIO_TO_IRQ(GPIOD14_nUSBC_DETECT),
+		.end   = PXA_GPIO_TO_IRQ(GPIOD14_nUSBC_DETECT),
 	},
 };
 
diff --git a/arch/arm/mach-pxa/icontrol.c b/arch/arm/mach-pxa/icontrol.c
index f78d5db..33e81e8 100644
--- a/arch/arm/mach-pxa/icontrol.c
+++ b/arch/arm/mach-pxa/icontrol.c
@@ -86,7 +86,7 @@ static struct spi_board_info mcp251x_board_info[] = {
 		.chip_select     = 0,
 		.platform_data   = &mcp251x_info,
 		.controller_data = &mcp251x_chip_info1,
-		.irq             = gpio_to_irq(ICONTROL_MCP251x_nIRQ1)
+		.irq             = PXA_GPIO_TO_IRQ(ICONTROL_MCP251x_nIRQ1)
 	},
 	{
 		.modalias        = "mcp2515",
@@ -95,7 +95,7 @@ static struct spi_board_info mcp251x_board_info[] = {
 		.chip_select     = 1,
 		.platform_data   = &mcp251x_info,
 		.controller_data = &mcp251x_chip_info2,
-		.irq             = gpio_to_irq(ICONTROL_MCP251x_nIRQ2)
+		.irq             = PXA_GPIO_TO_IRQ(ICONTROL_MCP251x_nIRQ2)
 	},
 	{
 		.modalias        = "mcp2515",
@@ -104,7 +104,7 @@ static struct spi_board_info mcp251x_board_info[] = {
 		.chip_select     = 0,
 		.platform_data   = &mcp251x_info,
 		.controller_data = &mcp251x_chip_info3,
-		.irq             = gpio_to_irq(ICONTROL_MCP251x_nIRQ3)
+		.irq             = PXA_GPIO_TO_IRQ(ICONTROL_MCP251x_nIRQ3)
 	},
 	{
 		.modalias        = "mcp2515",
@@ -113,7 +113,7 @@ static struct spi_board_info mcp251x_board_info[] = {
 		.chip_select     = 1,
 		.platform_data   = &mcp251x_info,
 		.controller_data = &mcp251x_chip_info4,
-		.irq             = gpio_to_irq(ICONTROL_MCP251x_nIRQ4)
+		.irq             = PXA_GPIO_TO_IRQ(ICONTROL_MCP251x_nIRQ4)
 	}
 };
 
diff --git a/arch/arm/mach-pxa/include/mach/csb726.h b/arch/arm/mach-pxa/include/mach/csb726.h
index 747ab1a..2628e7b 100644
--- a/arch/arm/mach-pxa/include/mach/csb726.h
+++ b/arch/arm/mach-pxa/include/mach/csb726.h
@@ -19,8 +19,8 @@
 #define CSB726_FLASH_SIZE	(64 * 1024 * 1024)
 #define CSB726_FLASH_uMON	(8 * 1024 * 1024)
 
-#define CSB726_IRQ_LAN		gpio_to_irq(CSB726_GPIO_IRQ_LAN)
-#define CSB726_IRQ_SM501	gpio_to_irq(CSB726_GPIO_IRQ_SM501)
+#define CSB726_IRQ_LAN		PXA_GPIO_TO_IRQ(CSB726_GPIO_IRQ_LAN)
+#define CSB726_IRQ_SM501	PXA_GPIO_TO_IRQ(CSB726_GPIO_IRQ_SM501)
 
 #endif
 
diff --git a/arch/arm/mach-pxa/include/mach/gpio.h b/arch/arm/mach-pxa/include/mach/gpio.h
index 13b9039..5cf0137 100644
--- a/arch/arm/mach-pxa/include/mach/gpio.h
+++ b/arch/arm/mach-pxa/include/mach/gpio.h
@@ -28,8 +28,5 @@
 /* The defines for the driver are needed for the accelerated accessors */
 #include "gpio-pxa.h"
 
-#define gpio_to_irq(gpio)	PXA_GPIO_TO_IRQ(gpio)
-#define irq_to_gpio(irq)	(irq - PXA_GPIO_TO_IRQ(0))
-
 #include <plat/gpio.h>
 #endif
diff --git a/arch/arm/mach-pxa/littleton.c b/arch/arm/mach-pxa/littleton.c
index 9cd2356..27147f6 100644
--- a/arch/arm/mach-pxa/littleton.c
+++ b/arch/arm/mach-pxa/littleton.c
@@ -395,7 +395,7 @@ static struct i2c_board_info littleton_i2c_info[] = {
 		.type		= "da9034",
 		.addr		= 0x34,
 		.platform_data	= &littleton_da9034_info,
-		.irq		= gpio_to_irq(mfp_to_gpio(MFP_PIN_GPIO18)),
+		.irq		= PXA_GPIO_TO_IRQ(mfp_to_gpio(MFP_PIN_GPIO18)),
 	},
 	[1] = {
 		.type		= "max7320",
diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
index 4b796c3..e340ea0 100644
--- a/arch/arm/mach-pxa/magician.c
+++ b/arch/arm/mach-pxa/magician.c
@@ -184,8 +184,8 @@ static struct resource egpio_resources[] = {
 		.flags = IORESOURCE_MEM,
 	},
 	[1] = {
-		.start = gpio_to_irq(GPIO13_MAGICIAN_CPLD_IRQ),
-		.end   = gpio_to_irq(GPIO13_MAGICIAN_CPLD_IRQ),
+		.start = PXA_GPIO_TO_IRQ(GPIO13_MAGICIAN_CPLD_IRQ),
+		.end   = PXA_GPIO_TO_IRQ(GPIO13_MAGICIAN_CPLD_IRQ),
 		.flags = IORESOURCE_IRQ,
 	},
 };
@@ -468,8 +468,8 @@ static struct resource pasic3_resources[] = {
 	},
 	/* No IRQ handler in the PASIC3, DS1WM needs an external IRQ */
 	[1] = {
-		.start  = gpio_to_irq(GPIO107_MAGICIAN_DS1WM_IRQ),
-		.end    = gpio_to_irq(GPIO107_MAGICIAN_DS1WM_IRQ),
+		.start  = PXA_GPIO_TO_IRQ(GPIO107_MAGICIAN_DS1WM_IRQ),
+		.end    = PXA_GPIO_TO_IRQ(GPIO107_MAGICIAN_DS1WM_IRQ),
 		.flags  = IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHEDGE,
 	}
 };
diff --git a/arch/arm/mach-pxa/mioa701.c b/arch/arm/mach-pxa/mioa701.c
index b938fc2..1144def 100644
--- a/arch/arm/mach-pxa/mioa701.c
+++ b/arch/arm/mach-pxa/mioa701.c
@@ -314,7 +314,7 @@ static int __init gsm_init(void)
 	rc = gpio_request_array(ARRAY_AND_SIZE(gsm_gpios));
 	if (rc)
 		goto err_gpio;
-	rc = request_irq(gpio_to_irq(GPIO25_GSM_MOD_ON_STATE), gsm_on_irq,
+	rc = request_irq(PXA_GPIO_TO_IRQ(GPIO25_GSM_MOD_ON_STATE), gsm_on_irq,
 			 IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
 			 "GSM XS200 Power Irq", NULL);
 	if (rc)
@@ -333,7 +333,7 @@ err_gpio:
 
 static void gsm_exit(void)
 {
-	free_irq(gpio_to_irq(GPIO25_GSM_MOD_ON_STATE), NULL);
+	free_irq(PXA_GPIO_TO_IRQ(GPIO25_GSM_MOD_ON_STATE), NULL);
 	gpio_free_array(ARRAY_AND_SIZE(gsm_gpios));
 }
 
@@ -541,15 +541,15 @@ static struct pda_power_pdata power_pdata = {
 static struct resource power_resources[] = {
 	[0] = {
 		.name	= "ac",
-		.start	= gpio_to_irq(GPIO96_AC_DETECT),
-		.end	= gpio_to_irq(GPIO96_AC_DETECT),
+		.start	= PXA_GPIO_TO_IRQ(GPIO96_AC_DETECT),
+		.end	= PXA_GPIO_TO_IRQ(GPIO96_AC_DETECT),
 		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHEDGE |
 		IORESOURCE_IRQ_LOWEDGE,
 	},
 	[1] = {
 		.name	= "usb",
-		.start	= gpio_to_irq(GPIO13_nUSB_DETECT),
-		.end	= gpio_to_irq(GPIO13_nUSB_DETECT),
+		.start	= PXA_GPIO_TO_IRQ(GPIO13_nUSB_DETECT),
+		.end	= PXA_GPIO_TO_IRQ(GPIO13_nUSB_DETECT),
 		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHEDGE |
 		IORESOURCE_IRQ_LOWEDGE,
 	},
diff --git a/arch/arm/mach-pxa/mxm8x10.c b/arch/arm/mach-pxa/mxm8x10.c
index b5a8fd3..a13a1e3 100644
--- a/arch/arm/mach-pxa/mxm8x10.c
+++ b/arch/arm/mach-pxa/mxm8x10.c
@@ -416,8 +416,8 @@ static struct resource dm9k_resources[] = {
 	       .flags = IORESOURCE_MEM
 	},
 	[2] = {
-	       .start = gpio_to_irq(mfp_to_gpio(MFP_PIN_GPIO9)),
-	       .end = gpio_to_irq(mfp_to_gpio(MFP_PIN_GPIO9)),
+	       .start = PXA_GPIO_TO_IRQ(mfp_to_gpio(MFP_PIN_GPIO9)),
+	       .end = PXA_GPIO_TO_IRQ(mfp_to_gpio(MFP_PIN_GPIO9)),
 	       .flags = IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHEDGE
 	}
 };
diff --git a/arch/arm/mach-pxa/poodle.c b/arch/arm/mach-pxa/poodle.c
index 7c8a308..b5a4214 100644
--- a/arch/arm/mach-pxa/poodle.c
+++ b/arch/arm/mach-pxa/poodle.c
@@ -211,7 +211,7 @@ static struct spi_board_info poodle_spi_devices[] = {
 		.bus_num	= 1,
 		.platform_data	= &poodle_ads7846_info,
 		.controller_data= &poodle_ads7846_chip,
-		.irq		= gpio_to_irq(POODLE_GPIO_TP_INT),
+		.irq		= PXA_GPIO_TO_IRQ(POODLE_GPIO_TP_INT),
 	},
 };
 
diff --git a/arch/arm/mach-pxa/pxa25x.c b/arch/arm/mach-pxa/pxa25x.c
index 8746e10..d4fca6a 100644
--- a/arch/arm/mach-pxa/pxa25x.c
+++ b/arch/arm/mach-pxa/pxa25x.c
@@ -287,7 +287,7 @@ static inline void pxa25x_init_pm(void) {}
 
 static int pxa25x_set_wake(struct irq_data *d, unsigned int on)
 {
-	int gpio = irq_to_gpio(d->irq);
+	int gpio = pxa_irq_to_gpio(d->irq);
 	uint32_t mask = 0;
 
 	if (gpio >= 0 && gpio < 85)
diff --git a/arch/arm/mach-pxa/pxa27x.c b/arch/arm/mach-pxa/pxa27x.c
index 2bb5cf8..08eb452 100644
--- a/arch/arm/mach-pxa/pxa27x.c
+++ b/arch/arm/mach-pxa/pxa27x.c
@@ -355,7 +355,7 @@ static inline void pxa27x_init_pm(void) {}
  */
 static int pxa27x_set_wake(struct irq_data *d, unsigned int on)
 {
-	int gpio = irq_to_gpio(d->irq);
+	int gpio = pxa_irq_to_gpio(d->irq);
 	uint32_t mask;
 
 	if (gpio >= 0 && gpio < 128)
diff --git a/arch/arm/mach-pxa/raumfeld.c b/arch/arm/mach-pxa/raumfeld.c
index 6810cdd..9d13f87 100644
--- a/arch/arm/mach-pxa/raumfeld.c
+++ b/arch/arm/mach-pxa/raumfeld.c
@@ -292,8 +292,8 @@ static struct resource smc91x_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	{
-		.start	= gpio_to_irq(GPIO_ETH_IRQ),
-		.end	= gpio_to_irq(GPIO_ETH_IRQ),
+		.start	= PXA_GPIO_TO_IRQ(GPIO_ETH_IRQ),
+		.end	= PXA_GPIO_TO_IRQ(GPIO_ETH_IRQ),
 		.flags	= IORESOURCE_IRQ | IRQF_TRIGGER_FALLING,
 	}
 };
@@ -671,7 +671,7 @@ static struct lis3lv02d_platform_data lis3_pdata = {
 	.chip_select	= 1,			\
 	.controller_data = (void *) GPIO_ACCEL_CS,	\
 	.platform_data	= &lis3_pdata,		\
-	.irq		= gpio_to_irq(GPIO_ACCEL_IRQ),	\
+	.irq		= PXA_GPIO_TO_IRQ(GPIO_ACCEL_IRQ),	\
 }
 
 #define SPI_DAC7512	\
@@ -823,10 +823,10 @@ static void __init raumfeld_power_init(void)
 	else
 		gpio_direction_output(GPIO_CHARGE_USB_SUSP, 0);
 
-	power_supply_resources[0].start = gpio_to_irq(GPIO_CHARGE_DC_OK);
-	power_supply_resources[0].end = gpio_to_irq(GPIO_CHARGE_DC_OK);
+	power_supply_resources[0].start = PXA_GPIO_TO_IRQ(GPIO_CHARGE_DC_OK);
+	power_supply_resources[0].end = PXA_GPIO_TO_IRQ(GPIO_CHARGE_DC_OK);
 
-	ret = request_irq(gpio_to_irq(GPIO_CHARGE_DONE),
+	ret = request_irq(PXA_GPIO_TO_IRQ(GPIO_CHARGE_DONE),
 			&charge_done_irq, IORESOURCE_IRQ_LOWEDGE,
 			"charge_done", NULL);
 
@@ -955,7 +955,7 @@ static struct eeti_ts_platform_data eeti_ts_pdata = {
 static struct i2c_board_info raumfeld_controller_i2c_board_info __initdata = {
 	.type	= "eeti_ts",
 	.addr	= 0x0a,
-	.irq	= gpio_to_irq(GPIO_TOUCH_IRQ),
+	.irq	= PXA_GPIO_TO_IRQ(GPIO_TOUCH_IRQ),
 	.platform_data = &eeti_ts_pdata,
 };
 
diff --git a/arch/arm/mach-pxa/saar.c b/arch/arm/mach-pxa/saar.c
index fc2c1e0..423ec89 100644
--- a/arch/arm/mach-pxa/saar.c
+++ b/arch/arm/mach-pxa/saar.c
@@ -96,8 +96,8 @@ static struct resource smc91x_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= gpio_to_irq(mfp_to_gpio(MFP_PIN_GPIO97)),
-		.end	= gpio_to_irq(mfp_to_gpio(MFP_PIN_GPIO97)),
+		.start	= PXA_GPIO_TO_IRQ(mfp_to_gpio(MFP_PIN_GPIO97)),
+		.end	= PXA_GPIO_TO_IRQ(mfp_to_gpio(MFP_PIN_GPIO97)),
 		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHEDGE,
 	}
 };
@@ -502,7 +502,7 @@ static struct i2c_board_info saar_i2c_info[] = {
 		.type		= "da9034",
 		.addr		= 0x34,
 		.platform_data	= &saar_da9034_info,
-		.irq		= gpio_to_irq(mfp_to_gpio(MFP_PIN_GPIO83)),
+		.irq		= PXA_GPIO_TO_IRQ(mfp_to_gpio(MFP_PIN_GPIO83)),
 	},
 };
 
diff --git a/arch/arm/mach-pxa/saarb.c b/arch/arm/mach-pxa/saarb.c
index 3c988b6f..cfa172c 100644
--- a/arch/arm/mach-pxa/saarb.c
+++ b/arch/arm/mach-pxa/saarb.c
@@ -91,7 +91,7 @@ static struct i2c_board_info saarb_i2c_info[] = {
 		.type		= "88PM860x",
 		.addr		= 0x34,
 		.platform_data	= &saarb_pm8607_info,
-		.irq		= gpio_to_irq(mfp_to_gpio(MFP_PIN_GPIO83)),
+		.irq		= PXA_GPIO_TO_IRQ(mfp_to_gpio(MFP_PIN_GPIO83)),
 	},
 };
 
diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
index d8dec91..4c3600b 100644
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -551,7 +551,7 @@ static struct spi_board_info spitz_spi_devices[] = {
 		.chip_select		= 0,
 		.platform_data		= &spitz_ads7846_info,
 		.controller_data	= &spitz_ads7846_chip,
-		.irq			= gpio_to_irq(SPITZ_GPIO_TP_INT),
+		.irq			= PXA_GPIO_TO_IRQ(SPITZ_GPIO_TP_INT),
 	}, {
 		.modalias		= "corgi-lcd",
 		.max_speed_hz		= 50000,
diff --git a/arch/arm/mach-pxa/stargate2.c b/arch/arm/mach-pxa/stargate2.c
index bbf79d5..940ca56 100644
--- a/arch/arm/mach-pxa/stargate2.c
+++ b/arch/arm/mach-pxa/stargate2.c
@@ -546,7 +546,7 @@ static struct i2c_board_info __initdata imote2_pwr_i2c_board_info[] = {
 		.type = "da9030",
 		.addr = 0x49,
 		.platform_data = &imote2_da9030_pdata,
-		.irq = gpio_to_irq(1),
+		.irq = PXA_GPIO_TO_IRQ(1),
 	},
 };
 
@@ -913,7 +913,7 @@ static struct i2c_board_info __initdata stargate2_pwr_i2c_board_info[] = {
 		.type = "da9030",
 		.addr = 0x49,
 		.platform_data = &stargate2_da9030_pdata,
-		.irq = gpio_to_irq(1),
+		.irq = PXA_GPIO_TO_IRQ(1),
 	},
 };
 
diff --git a/arch/arm/mach-pxa/tavorevb.c b/arch/arm/mach-pxa/tavorevb.c
index ad47bb9..43bdcb9 100644
--- a/arch/arm/mach-pxa/tavorevb.c
+++ b/arch/arm/mach-pxa/tavorevb.c
@@ -85,8 +85,8 @@ static struct resource smc91x_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= gpio_to_irq(mfp_to_gpio(MFP_PIN_GPIO47)),
-		.end	= gpio_to_irq(mfp_to_gpio(MFP_PIN_GPIO47)),
+		.start	= PXA_GPIO_TO_IRQ(mfp_to_gpio(MFP_PIN_GPIO47)),
+		.end	= PXA_GPIO_TO_IRQ(mfp_to_gpio(MFP_PIN_GPIO47)),
 		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHEDGE,
 	}
 };
diff --git a/arch/arm/mach-pxa/tavorevb3.c b/arch/arm/mach-pxa/tavorevb3.c
index fd56916..46c60b3 100644
--- a/arch/arm/mach-pxa/tavorevb3.c
+++ b/arch/arm/mach-pxa/tavorevb3.c
@@ -101,7 +101,7 @@ static struct i2c_board_info evb3_i2c_info[] = {
 		.type		= "88PM860x",
 		.addr		= 0x34,
 		.platform_data	= &evb3_pm8607_info,
-		.irq		= gpio_to_irq(mfp_to_gpio(MFP_PIN_GPIO83)),
+		.irq		= PXA_GPIO_TO_IRQ(mfp_to_gpio(MFP_PIN_GPIO83)),
 	},
 };
 
diff --git a/arch/arm/mach-pxa/tosa.c b/arch/arm/mach-pxa/tosa.c
index 402b0c9..1ddb982 100644
--- a/arch/arm/mach-pxa/tosa.c
+++ b/arch/arm/mach-pxa/tosa.c
@@ -404,8 +404,8 @@ static struct pda_power_pdata tosa_power_data = {
 static struct resource tosa_power_resource[] = {
 	{
 		.name		= "ac",
-		.start		= gpio_to_irq(TOSA_GPIO_AC_IN),
-		.end		= gpio_to_irq(TOSA_GPIO_AC_IN),
+		.start		= PXA_GPIO_TO_IRQ(TOSA_GPIO_AC_IN),
+		.end		= PXA_GPIO_TO_IRQ(TOSA_GPIO_AC_IN),
 		.flags		= IORESOURCE_IRQ |
 				  IORESOURCE_IRQ_HIGHEDGE |
 				  IORESOURCE_IRQ_LOWEDGE,
diff --git a/arch/arm/mach-pxa/viper.c b/arch/arm/mach-pxa/viper.c
index 242ddae..b49d10b 100644
--- a/arch/arm/mach-pxa/viper.c
+++ b/arch/arm/mach-pxa/viper.c
@@ -315,9 +315,9 @@ static void __init viper_init_irq(void)
 		set_irq_flags(isa_irq, IRQF_VALID | IRQF_PROBE);
 	}
 
-	irq_set_chained_handler(gpio_to_irq(VIPER_CPLD_GPIO),
+	irq_set_chained_handler(PXA_GPIO_TO_IRQ(VIPER_CPLD_GPIO),
 				viper_irq_handler);
-	irq_set_irq_type(gpio_to_irq(VIPER_CPLD_GPIO), IRQ_TYPE_EDGE_BOTH);
+	irq_set_irq_type(PXA_GPIO_TO_IRQ(VIPER_CPLD_GPIO), IRQ_TYPE_EDGE_BOTH);
 }
 
 /* Flat Panel */
@@ -422,8 +422,8 @@ static struct resource smc91x_resources[] = {
 		.flags  = IORESOURCE_MEM,
 	},
 	[1] = {
-		.start  = gpio_to_irq(VIPER_ETH_GPIO),
-		.end    = gpio_to_irq(VIPER_ETH_GPIO),
+		.start  = PXA_GPIO_TO_IRQ(VIPER_ETH_GPIO),
+		.end    = PXA_GPIO_TO_IRQ(VIPER_ETH_GPIO),
 		.flags  = IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHEDGE,
 	},
 	[2] = {
@@ -546,7 +546,7 @@ static struct plat_serial8250_port serial_platform_data[] = {
 	/* External UARTs */
 	{
 		.mapbase	= VIPER_UARTA_PHYS,
-		.irq		= gpio_to_irq(VIPER_UARTA_GPIO),
+		.irq		= PXA_GPIO_TO_IRQ(VIPER_UARTA_GPIO),
 		.irqflags	= IRQF_TRIGGER_RISING,
 		.uartclk	= 1843200,
 		.regshift	= 1,
@@ -556,7 +556,7 @@ static struct plat_serial8250_port serial_platform_data[] = {
 	},
 	{
 		.mapbase	= VIPER_UARTB_PHYS,
-		.irq		= gpio_to_irq(VIPER_UARTB_GPIO),
+		.irq		= PXA_GPIO_TO_IRQ(VIPER_UARTB_GPIO),
 		.irqflags	= IRQF_TRIGGER_RISING,
 		.uartclk	= 1843200,
 		.regshift	= 1,
@@ -596,8 +596,8 @@ static struct resource isp116x_resources[] = {
 		.flags  = IORESOURCE_MEM,
 	},
 	[2] = {
-		.start  = gpio_to_irq(VIPER_USB_GPIO),
-		.end    = gpio_to_irq(VIPER_USB_GPIO),
+		.start  = PXA_GPIO_TO_IRQ(VIPER_USB_GPIO),
+		.end    = PXA_GPIO_TO_IRQ(VIPER_USB_GPIO),
 		.flags  = IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHEDGE,
 	},
 };
diff --git a/arch/arm/mach-pxa/vpac270.c b/arch/arm/mach-pxa/vpac270.c
index 585e4f4..bf2403c 100644
--- a/arch/arm/mach-pxa/vpac270.c
+++ b/arch/arm/mach-pxa/vpac270.c
@@ -610,8 +610,8 @@ static struct resource vpac270_ide_resources[] = {
 	       .flags	= IORESOURCE_DMA
 	},
 	[3] = {	/* IDE IRQ pin */
-	       .start	= gpio_to_irq(GPIO36_VPAC270_IDE_IRQ),
-	       .end	= gpio_to_irq(GPIO36_VPAC270_IDE_IRQ),
+	       .start	= PXA_GPIO_TO_IRQ(GPIO36_VPAC270_IDE_IRQ),
+	       .end	= PXA_GPIO_TO_IRQ(GPIO36_VPAC270_IDE_IRQ),
 	       .flags	= IORESOURCE_IRQ
 	}
 };
diff --git a/arch/arm/mach-pxa/z2.c b/arch/arm/mach-pxa/z2.c
index 65fed37..7bd4863 100644
--- a/arch/arm/mach-pxa/z2.c
+++ b/arch/arm/mach-pxa/z2.c
@@ -573,7 +573,7 @@ static struct spi_board_info spi_board_info[] __initdata = {
 	.modalias		= "libertas_spi",
 	.platform_data		= &z2_lbs_pdata,
 	.controller_data	= &z2_lbs_chip_info,
-	.irq			= gpio_to_irq(GPIO36_ZIPITZ2_WIFI_IRQ),
+	.irq			= PXA_GPIO_TO_IRQ(GPIO36_ZIPITZ2_WIFI_IRQ),
 	.max_speed_hz		= 13000000,
 	.bus_num		= 1,
 	.chip_select		= 0,
diff --git a/arch/arm/mach-pxa/zeus.c b/arch/arm/mach-pxa/zeus.c
index c424e7d..7d22c0b 100644
--- a/arch/arm/mach-pxa/zeus.c
+++ b/arch/arm/mach-pxa/zeus.c
@@ -136,12 +136,12 @@ static void __init zeus_init_irq(void)
 
 	/* Peripheral IRQs. It would be nice to move those inside driver
 	   configuration, but it is not supported@the moment. */
-	irq_set_irq_type(gpio_to_irq(ZEUS_AC97_GPIO), IRQ_TYPE_EDGE_RISING);
-	irq_set_irq_type(gpio_to_irq(ZEUS_WAKEUP_GPIO), IRQ_TYPE_EDGE_RISING);
-	irq_set_irq_type(gpio_to_irq(ZEUS_PTT_GPIO), IRQ_TYPE_EDGE_RISING);
-	irq_set_irq_type(gpio_to_irq(ZEUS_EXTGPIO_GPIO),
+	irq_set_irq_type(PXA_GPIO_TO_IRQ(ZEUS_AC97_GPIO), IRQ_TYPE_EDGE_RISING);
+	irq_set_irq_type(PXA_GPIO_TO_IRQ(ZEUS_WAKEUP_GPIO), IRQ_TYPE_EDGE_RISING);
+	irq_set_irq_type(PXA_GPIO_TO_IRQ(ZEUS_PTT_GPIO), IRQ_TYPE_EDGE_RISING);
+	irq_set_irq_type(PXA_GPIO_TO_IRQ(ZEUS_EXTGPIO_GPIO),
 			 IRQ_TYPE_EDGE_FALLING);
-	irq_set_irq_type(gpio_to_irq(ZEUS_CAN_GPIO), IRQ_TYPE_EDGE_FALLING);
+	irq_set_irq_type(PXA_GPIO_TO_IRQ(ZEUS_CAN_GPIO), IRQ_TYPE_EDGE_FALLING);
 
 	/* Setup ISA IRQs */
 	for (level = 0; level < ARRAY_SIZE(zeus_isa_irqs); level++) {
@@ -151,8 +151,8 @@ static void __init zeus_init_irq(void)
 		set_irq_flags(isa_irq, IRQF_VALID | IRQF_PROBE);
 	}
 
-	irq_set_irq_type(gpio_to_irq(ZEUS_ISA_GPIO), IRQ_TYPE_EDGE_RISING);
-	irq_set_chained_handler(gpio_to_irq(ZEUS_ISA_GPIO), zeus_irq_handler);
+	irq_set_irq_type(PXA_GPIO_TO_IRQ(ZEUS_ISA_GPIO), IRQ_TYPE_EDGE_RISING);
+	irq_set_chained_handler(PXA_GPIO_TO_IRQ(ZEUS_ISA_GPIO), zeus_irq_handler);
 }
 
 
@@ -233,7 +233,7 @@ static struct plat_serial8250_port serial_platform_data[] = {
 	/* FIXME: Shared IRQs on COM1-COM4 will not work properly on v1i1 hardware. */
 	{ /* COM1 */
 		.mapbase	= 0x10000000,
-		.irq		= gpio_to_irq(ZEUS_UARTA_GPIO),
+		.irq		= PXA_GPIO_TO_IRQ(ZEUS_UARTA_GPIO),
 		.irqflags	= IRQF_TRIGGER_RISING,
 		.uartclk	= 14745600,
 		.regshift	= 1,
@@ -242,7 +242,7 @@ static struct plat_serial8250_port serial_platform_data[] = {
 	},
 	{ /* COM2 */
 		.mapbase	= 0x10800000,
-		.irq		= gpio_to_irq(ZEUS_UARTB_GPIO),
+		.irq		= PXA_GPIO_TO_IRQ(ZEUS_UARTB_GPIO),
 		.irqflags	= IRQF_TRIGGER_RISING,
 		.uartclk	= 14745600,
 		.regshift	= 1,
@@ -251,7 +251,7 @@ static struct plat_serial8250_port serial_platform_data[] = {
 	},
 	{ /* COM3 */
 		.mapbase	= 0x11000000,
-		.irq		= gpio_to_irq(ZEUS_UARTC_GPIO),
+		.irq		= PXA_GPIO_TO_IRQ(ZEUS_UARTC_GPIO),
 		.irqflags	= IRQF_TRIGGER_RISING,
 		.uartclk	= 14745600,
 		.regshift	= 1,
@@ -260,7 +260,7 @@ static struct plat_serial8250_port serial_platform_data[] = {
 	},
 	{ /* COM4 */
 		.mapbase	= 0x11800000,
-		.irq		= gpio_to_irq(ZEUS_UARTD_GPIO),
+		.irq		= PXA_GPIO_TO_IRQ(ZEUS_UARTD_GPIO),
 		.irqflags	= IRQF_TRIGGER_RISING,
 		.uartclk	= 14745600,
 		.regshift	= 1,
@@ -321,8 +321,8 @@ static struct resource zeus_dm9k0_resource[] = {
 		.flags = IORESOURCE_MEM
 	},
 	[2] = {
-		.start = gpio_to_irq(ZEUS_ETH0_GPIO),
-		.end   = gpio_to_irq(ZEUS_ETH0_GPIO),
+		.start = PXA_GPIO_TO_IRQ(ZEUS_ETH0_GPIO),
+		.end   = PXA_GPIO_TO_IRQ(ZEUS_ETH0_GPIO),
 		.flags = IORESOURCE_IRQ | IORESOURCE_IRQ_LOWEDGE,
 	},
 };
@@ -339,8 +339,8 @@ static struct resource zeus_dm9k1_resource[] = {
 		.flags = IORESOURCE_MEM,
 	},
 	[2] = {
-		.start = gpio_to_irq(ZEUS_ETH1_GPIO),
-		.end   = gpio_to_irq(ZEUS_ETH1_GPIO),
+		.start = PXA_GPIO_TO_IRQ(ZEUS_ETH1_GPIO),
+		.end   = PXA_GPIO_TO_IRQ(ZEUS_ETH1_GPIO),
 		.flags = IORESOURCE_IRQ | IORESOURCE_IRQ_LOWEDGE,
 	},
 };
@@ -423,7 +423,7 @@ static struct spi_board_info zeus_spi_board_info[] = {
 	[0] = {
 		.modalias	= "mcp2515",
 		.platform_data	= &zeus_mcp2515_pdata,
-		.irq		= gpio_to_irq(ZEUS_CAN_GPIO),
+		.irq		= PXA_GPIO_TO_IRQ(ZEUS_CAN_GPIO),
 		.max_speed_hz	= 1*1000*1000,
 		.bus_num	= 3,
 		.mode		= SPI_MODE_0,
@@ -753,7 +753,7 @@ static struct i2c_board_info __initdata zeus_i2c_devices[] = {
 	{
 		I2C_BOARD_INFO("pca9535",	0x20),
 		.platform_data	= &zeus_pca953x_pdata[2],
-		.irq		= gpio_to_irq(ZEUS_EXTGPIO_GPIO),
+		.irq		= PXA_GPIO_TO_IRQ(ZEUS_EXTGPIO_GPIO),
 	},
 	{ I2C_BOARD_INFO("lm75a",	0x48) },
 	{ I2C_BOARD_INFO("24c01",	0x50) },
diff --git a/arch/arm/mach-pxa/zylonite.c b/arch/arm/mach-pxa/zylonite.c
index 31d4968..2406fd2 100644
--- a/arch/arm/mach-pxa/zylonite.c
+++ b/arch/arm/mach-pxa/zylonite.c
@@ -407,8 +407,8 @@ static void __init zylonite_init(void)
 	 * Note: We depend that the bootloader set
 	 * the correct value to MSC register for SMC91x.
 	 */
-	smc91x_resources[1].start = gpio_to_irq(gpio_eth_irq);
-	smc91x_resources[1].end   = gpio_to_irq(gpio_eth_irq);
+	smc91x_resources[1].start = PXA_GPIO_TO_IRQ(gpio_eth_irq);
+	smc91x_resources[1].end   = PXA_GPIO_TO_IRQ(gpio_eth_irq);
 	platform_device_register(&smc91x_device);
 
 	pxa_set_ac97_info(NULL);
diff --git a/arch/arm/plat-pxa/include/plat/gpio-pxa.h b/arch/arm/plat-pxa/include/plat/gpio-pxa.h
index b6390be..15bf9be 100644
--- a/arch/arm/plat-pxa/include/plat/gpio-pxa.h
+++ b/arch/arm/plat-pxa/include/plat/gpio-pxa.h
@@ -40,5 +40,6 @@ extern int pxa_last_gpio;
 typedef int (*set_wake_t)(struct irq_data *d, unsigned int on);
 
 extern void pxa_init_gpio(int mux_irq, int start, int end, set_wake_t fn);
+extern int pxa_irq_to_gpio(int irq);
 
 #endif /* __PLAT_PXA_GPIO_H */
diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
index 8c34e8c..a26e37a 100644
--- a/drivers/gpio/gpio-pxa.c
+++ b/drivers/gpio/gpio-pxa.c
@@ -39,8 +39,19 @@ struct pxa_gpio_chip {
 #endif
 };
 
+enum {
+	PXA25X_GPIO = 0,
+	PXA26X_GPIO,
+	PXA27X_GPIO,
+	PXA3XX_GPIO,
+	PXA93X_GPIO,
+	MMP_GPIO = 0x10,
+	MMP2_GPIO,
+};
+
 static DEFINE_SPINLOCK(gpio_lock);
 static struct pxa_gpio_chip *pxa_gpio_chips;
+static int gpio_type;
 
 #define for_each_gpio_chip(i, c)			\
 	for (i = 0, c = &pxa_gpio_chips[0]; i <= pxa_last_gpio; i += 32, c++)
@@ -55,6 +66,49 @@ static inline struct pxa_gpio_chip *gpio_to_pxachip(unsigned gpio)
 	return &pxa_gpio_chips[gpio_to_bank(gpio)];
 }
 
+static inline int gpio_is_pxa_type(int type)
+{
+	if (type & MMP_GPIO)
+		return 0;
+	return 1;
+}
+
+static inline int gpio_is_mmp_type(int type)
+{
+	if (type & MMP_GPIO)
+		return 1;
+	return 0;
+}
+
+static int pxa_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
+{
+	int gpio;
+
+	gpio = chip->base + offset;
+#ifdef CONFIG_ARCH_PXA
+	if (gpio_is_pxa_type(gpio_type))
+		return PXA_GPIO_TO_IRQ(gpio);
+#endif
+#ifdef CONFIG_ARCH_MMP
+	if (gpio_is_mmp_type(gpio_type))
+		return MMP_GPIO_TO_IRQ(gpio);
+#endif
+	return 0;
+}
+
+int pxa_irq_to_gpio(int irq)
+{
+#ifdef CONFIG_ARCH_PXA
+	if (gpio_is_pxa_type(gpio_type))
+		return irq - PXA_GPIO_TO_IRQ(0);
+#endif
+#ifdef CONFIG_ARCH_MMP
+	if (gpio_is_mmp_type(gpio_type))
+		return irq - MMP_GPIO_TO_IRQ(0);
+#endif
+	return 0;
+}
+
 static int pxa_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
 {
 	void __iomem *base = gpio_chip_base(chip);
@@ -131,6 +185,7 @@ static int __init pxa_init_gpio_chip(int gpio_end)
 		c->direction_output = pxa_gpio_direction_output;
 		c->get = pxa_gpio_get;
 		c->set = pxa_gpio_set;
+		c->to_irq = pxa_gpio_to_irq;
 
 		/* number of GPIOs on last bank may be less than 32 */
 		c->ngpio = (gpio + 31 > gpio_end) ? (gpio_end - gpio + 1) : 32;
@@ -158,7 +213,7 @@ static inline void update_edge_detect(struct pxa_gpio_chip *c)
 static int pxa_gpio_irq_type(struct irq_data *d, unsigned int type)
 {
 	struct pxa_gpio_chip *c;
-	int gpio = irq_to_gpio(d->irq);
+	int gpio = pxa_irq_to_gpio(d->irq);
 	unsigned long gpdr, mask = GPIO_bit(gpio);
 
 	c = gpio_to_pxachip(gpio);
@@ -229,7 +284,7 @@ static void pxa_gpio_demux_handler(unsigned int irq, struct irq_desc *desc)
 
 static void pxa_ack_muxed_gpio(struct irq_data *d)
 {
-	int gpio = irq_to_gpio(d->irq);
+	int gpio = pxa_irq_to_gpio(d->irq);
 	struct pxa_gpio_chip *c = gpio_to_pxachip(gpio);
 
 	__raw_writel(GPIO_bit(gpio), c->regbase + GEDR_OFFSET);
@@ -237,7 +292,7 @@ static void pxa_ack_muxed_gpio(struct irq_data *d)
 
 static void pxa_mask_muxed_gpio(struct irq_data *d)
 {
-	int gpio = irq_to_gpio(d->irq);
+	int gpio = pxa_irq_to_gpio(d->irq);
 	struct pxa_gpio_chip *c = gpio_to_pxachip(gpio);
 	uint32_t grer, gfer;
 
@@ -251,7 +306,7 @@ static void pxa_mask_muxed_gpio(struct irq_data *d)
 
 static void pxa_unmask_muxed_gpio(struct irq_data *d)
 {
-	int gpio = irq_to_gpio(d->irq);
+	int gpio = pxa_irq_to_gpio(d->irq);
 	struct pxa_gpio_chip *c = gpio_to_pxachip(gpio);
 
 	c->irq_mask |= GPIO_bit(gpio);
@@ -266,12 +321,51 @@ static struct irq_chip pxa_muxed_gpio_chip = {
 	.irq_set_type	= pxa_gpio_irq_type,
 };
 
+static int pxa_gpio_nums(void)
+{
+	int count = 0;
+
+#ifdef CONFIG_ARCH_PXA
+	if (cpu_is_pxa25x()) {
+#ifdef CONFIG_CPU_PXA26x
+		count = 89;
+		gpio_type = PXA26X_GPIO;
+#elif defined(CONFIG_PXA25x)
+		count = 84;
+		gpio_type = PXA26X_GPIO;
+#endif /* CONFIG_CPU_PXA26x */
+	} else if (cpu_is_pxa27x()) {
+		count = 120;
+		gpio_type = PXA27X_GPIO;
+	} else if (cpu_is_pxa93x() || cpu_is_pxa95x()) {
+		count = 191;
+		gpio_type = PXA93X_GPIO;
+	} else if (cpu_is_pxa3xx()) {
+		count = 127;
+		gpio_type = PXA3XX_GPIO;
+	}
+#endif /* CONFIG_ARCH_PXA */
+
+#ifdef CONFIG_ARCH_MMP
+	if (cpu_is_pxa168() || cpu_is_pxa910()) {
+		count = 127;
+		gpio_type = MMP_GPIO;
+	} else if (cpu_is_mmp2()) {
+		count = 191;
+		gpio_type = MMP2_GPIO;
+	}
+#endif /* CONFIG_ARCH_MMP */
+	return count;
+}
+
 void __init pxa_init_gpio(int mux_irq, int start, int end, set_wake_t fn)
 {
 	struct pxa_gpio_chip *c;
 	int gpio, irq;
 
-	pxa_last_gpio = end;
+	pxa_last_gpio = pxa_gpio_nums();
+	if (!pxa_last_gpio)
+		return -EINVAL;
 
 	/* Initialize GPIO chips */
 	pxa_init_gpio_chip(end);
-- 
1.7.2.5
