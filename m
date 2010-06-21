From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 21 Jun 2010 22:22:34 +0800
Subject: [PATCH 3/3] [ARM] pxa: merge all eseries board code into eseries.c
In-Reply-To: <1277130154-25912-1-git-send-email-eric.y.miao@gmail.com>
References: <1277130154-25912-1-git-send-email-eric.y.miao@gmail.com>
Message-ID: <1277130154-25912-3-git-send-email-eric.y.miao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
---
 arch/arm/mach-pxa/Makefile  |    6 -
 arch/arm/mach-pxa/e330.c    |   78 -----
 arch/arm/mach-pxa/e350.c    |   79 -----
 arch/arm/mach-pxa/e400.c    |  155 ---------
 arch/arm/mach-pxa/e740.c    |  225 ------------
 arch/arm/mach-pxa/e750.c    |  226 ------------
 arch/arm/mach-pxa/e800.c    |  229 ------------
 arch/arm/mach-pxa/eseries.c |  809 +++++++++++++++++++++++++++++++++++++++++++
 8 files changed, 809 insertions(+), 998 deletions(-)
 delete mode 100644 arch/arm/mach-pxa/e330.c
 delete mode 100644 arch/arm/mach-pxa/e350.c
 delete mode 100644 arch/arm/mach-pxa/e400.c
 delete mode 100644 arch/arm/mach-pxa/e740.c
 delete mode 100644 arch/arm/mach-pxa/e750.c
 delete mode 100644 arch/arm/mach-pxa/e800.c

diff --git a/arch/arm/mach-pxa/Makefile b/arch/arm/mach-pxa/Makefile
index 3f72218..cb408ef 100644
--- a/arch/arm/mach-pxa/Makefile
+++ b/arch/arm/mach-pxa/Makefile
@@ -86,12 +86,6 @@ obj-$(CONFIG_MACH_POODLE)	+= poodle.o
 obj-$(CONFIG_MACH_TOSA)		+= tosa.o
 obj-$(CONFIG_MACH_ICONTROL)     += icontrol.o mxm8x10.o
 obj-$(CONFIG_ARCH_PXA_ESERIES)	+= eseries.o
-obj-$(CONFIG_MACH_E330)		+= e330.o
-obj-$(CONFIG_MACH_E350)		+= e350.o
-obj-$(CONFIG_MACH_E740)		+= e740.o
-obj-$(CONFIG_MACH_E750)		+= e750.o
-obj-$(CONFIG_MACH_E400)		+= e400.o
-obj-$(CONFIG_MACH_E800)		+= e800.o
 obj-$(CONFIG_MACH_RAUMFELD_RC)		+= raumfeld.o
 obj-$(CONFIG_MACH_RAUMFELD_CONNECTOR)	+= raumfeld.o
 obj-$(CONFIG_MACH_RAUMFELD_SPEAKER)	+= raumfeld.o
diff --git a/arch/arm/mach-pxa/e330.c b/arch/arm/mach-pxa/e330.c
deleted file mode 100644
index 8fde338..0000000
--- a/arch/arm/mach-pxa/e330.c
+++ /dev/null
@@ -1,78 +0,0 @@
-/*
- * Hardware definitions for the Toshiba e330 PDAs
- *
- * Copyright (c) 2003 Ian Molton <spyro@f2s.com>
- *
- * This file is licensed under
- * the terms of the GNU General Public License version 2. This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
- *
- */
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/clk.h>
-#include <linux/platform_device.h>
-#include <linux/mfd/tc6387xb.h>
-
-#include <asm/setup.h>
-#include <asm/mach/arch.h>
-#include <asm/mach-types.h>
-
-#include <mach/pxa25x.h>
-#include <mach/eseries-gpio.h>
-#include <mach/udc.h>
-
-#include "generic.h"
-#include "eseries.h"
-#include "clock.h"
-
-/* -------------------- e330 tc6387xb parameters -------------------- */
-
-static struct tc6387xb_platform_data e330_tc6387xb_info = {
-	.enable   = &eseries_tmio_enable,
-	.disable  = &eseries_tmio_disable,
-	.suspend  = &eseries_tmio_suspend,
-	.resume   = &eseries_tmio_resume,
-};
-
-static struct platform_device e330_tc6387xb_device = {
-	.name           = "tc6387xb",
-	.id             = -1,
-	.dev            = {
-		.platform_data = &e330_tc6387xb_info,
-	},
-	.num_resources = 2,
-	.resource      = eseries_tmio_resources,
-};
-
-/* --------------------------------------------------------------- */
-
-static struct platform_device *devices[] __initdata = {
-	&e330_tc6387xb_device,
-};
-
-static void __init e330_init(void)
-{
-	pxa_set_ffuart_info(NULL);
-	pxa_set_btuart_info(NULL);
-	pxa_set_stuart_info(NULL);
-	eseries_register_clks();
-	eseries_get_tmio_gpios();
-	platform_add_devices(devices, ARRAY_SIZE(devices));
-	pxa_set_udc_info(&e7xx_udc_mach_info);
-}
-
-MACHINE_START(E330, "Toshiba e330")
-	/* Maintainer: Ian Molton (spyro at f2s.com) */
-	.phys_io	= 0x40000000,
-	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
-	.boot_params	= 0xa0000100,
-	.map_io		= pxa_map_io,
-	.init_irq	= pxa25x_init_irq,
-	.fixup		= eseries_fixup,
-	.init_machine	= e330_init,
-	.timer		= &pxa_timer,
-MACHINE_END
-
diff --git a/arch/arm/mach-pxa/e350.c b/arch/arm/mach-pxa/e350.c
deleted file mode 100644
index f50f055..0000000
--- a/arch/arm/mach-pxa/e350.c
+++ /dev/null
@@ -1,79 +0,0 @@
-/*
- * Hardware definitions for the Toshiba e350 PDAs
- *
- * Copyright (c) 2003 Ian Molton <spyro@f2s.com>
- *
- * This file is licensed under
- * the terms of the GNU General Public License version 2. This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
- *
- */
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/clk.h>
-#include <linux/platform_device.h>
-#include <linux/mfd/t7l66xb.h>
-
-#include <asm/setup.h>
-#include <asm/mach/arch.h>
-#include <asm/mach-types.h>
-
-#include <mach/irqs.h>
-#include <mach/pxa25x.h>
-#include <mach/eseries-gpio.h>
-#include <mach/udc.h>
-
-#include "generic.h"
-#include "eseries.h"
-#include "clock.h"
-
-/* -------------------- e350 t7l66xb parameters -------------------- */
-
-static struct t7l66xb_platform_data e350_t7l66xb_info = {
-	.irq_base               = IRQ_BOARD_START,
-	.enable                 = &eseries_tmio_enable,
-	.suspend                = &eseries_tmio_suspend,
-	.resume                 = &eseries_tmio_resume,
-};
-
-static struct platform_device e350_t7l66xb_device = {
-	.name           = "t7l66xb",
-	.id             = -1,
-	.dev            = {
-		.platform_data = &e350_t7l66xb_info,
-	},
-	.num_resources = 2,
-	.resource      = eseries_tmio_resources,
-};
-
-/* ---------------------------------------------------------- */
-
-static struct platform_device *devices[] __initdata = {
-	&e350_t7l66xb_device,
-};
-
-static void __init e350_init(void)
-{
-	pxa_set_ffuart_info(NULL);
-	pxa_set_btuart_info(NULL);
-	pxa_set_stuart_info(NULL);
-	eseries_register_clks();
-	eseries_get_tmio_gpios();
-	platform_add_devices(devices, ARRAY_SIZE(devices));
-	pxa_set_udc_info(&e7xx_udc_mach_info);
-}
-
-MACHINE_START(E350, "Toshiba e350")
-	/* Maintainer: Ian Molton (spyro at f2s.com) */
-	.phys_io	= 0x40000000,
-	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
-	.boot_params	= 0xa0000100,
-	.map_io		= pxa_map_io,
-	.init_irq	= pxa25x_init_irq,
-	.fixup		= eseries_fixup,
-	.init_machine	= e350_init,
-	.timer		= &pxa_timer,
-MACHINE_END
-
diff --git a/arch/arm/mach-pxa/e400.c b/arch/arm/mach-pxa/e400.c
deleted file mode 100644
index 55b950f..0000000
--- a/arch/arm/mach-pxa/e400.c
+++ /dev/null
@@ -1,155 +0,0 @@
-/*
- * Hardware definitions for the Toshiba eseries PDAs
- *
- * Copyright (c) 2003 Ian Molton <spyro@f2s.com>
- *
- * This file is licensed under
- * the terms of the GNU General Public License version 2. This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
- *
- */
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/clk.h>
-#include <linux/platform_device.h>
-#include <linux/mfd/t7l66xb.h>
-#include <linux/mtd/nand.h>
-#include <linux/mtd/partitions.h>
-
-#include <asm/setup.h>
-#include <asm/mach/arch.h>
-#include <asm/mach-types.h>
-
-#include <mach/pxa25x.h>
-#include <mach/eseries-gpio.h>
-#include <mach/pxafb.h>
-#include <mach/udc.h>
-#include <mach/irqs.h>
-
-#include "generic.h"
-#include "eseries.h"
-#include "clock.h"
-
-/* ------------------------ E400 LCD definitions ------------------------ */
-
-static struct pxafb_mode_info e400_pxafb_mode_info = {
-	.pixclock       = 140703,
-	.xres           = 240,
-	.yres           = 320,
-	.bpp            = 16,
-	.hsync_len      = 4,
-	.left_margin    = 28,
-	.right_margin   = 8,
-	.vsync_len      = 3,
-	.upper_margin   = 5,
-	.lower_margin   = 6,
-	.sync           = 0,
-};
-
-static struct pxafb_mach_info e400_pxafb_mach_info = {
-	.modes          = &e400_pxafb_mode_info,
-	.num_modes      = 1,
-	.lcd_conn	= LCD_COLOR_TFT_16BPP,
-	.lccr3          = 0,
-	.pxafb_backlight_power  = NULL,
-};
-
-/* ------------------------ E400 MFP config ----------------------------- */
-
-static unsigned long e400_pin_config[] __initdata = {
-	/* Chip selects */
-	GPIO15_nCS_1,   /* CS1 - Flash */
-	GPIO80_nCS_4,   /* CS4 - TMIO */
-
-	/* Clocks */
-	GPIO12_32KHz,
-
-	/* BTUART */
-	GPIO42_BTUART_RXD,
-	GPIO43_BTUART_TXD,
-	GPIO44_BTUART_CTS,
-
-	/* TMIO controller */
-	GPIO19_GPIO, /* t7l66xb #PCLR */
-	GPIO45_GPIO, /* t7l66xb #SUSPEND (NOT BTUART!) */
-
-	/* wakeup */
-	GPIO0_GPIO | WAKEUP_ON_EDGE_RISE,
-};
-
-/* ---------------------------------------------------------------------- */
-
-static struct mtd_partition partition_a = {
-	.name = "Internal NAND flash",
-	.offset =  0,
-	.size =  MTDPART_SIZ_FULL,
-};
-
-static uint8_t scan_ff_pattern[] = { 0xff, 0xff };
-
-static struct nand_bbt_descr e400_t7l66xb_nand_bbt = {
-	.options = 0,
-	.offs = 4,
-	.len = 2,
-	.pattern = scan_ff_pattern
-};
-
-static struct tmio_nand_data e400_t7l66xb_nand_config = {
-	.num_partitions = 1,
-	.partition = &partition_a,
-	.badblock_pattern = &e400_t7l66xb_nand_bbt,
-};
-
-static struct t7l66xb_platform_data e400_t7l66xb_info = {
-	.irq_base 		= IRQ_BOARD_START,
-	.enable                 = &eseries_tmio_enable,
-	.suspend                = &eseries_tmio_suspend,
-	.resume                 = &eseries_tmio_resume,
-
-	.nand_data              = &e400_t7l66xb_nand_config,
-};
-
-static struct platform_device e400_t7l66xb_device = {
-	.name           = "t7l66xb",
-	.id             = -1,
-	.dev            = {
-		.platform_data = &e400_t7l66xb_info,
-	},
-	.num_resources = 2,
-	.resource      = eseries_tmio_resources,
-};
-
-/* ---------------------------------------------------------- */
-
-static struct platform_device *devices[] __initdata = {
-	&e400_t7l66xb_device,
-};
-
-static void __init e400_init(void)
-{
-	pxa2xx_mfp_config(ARRAY_AND_SIZE(e400_pin_config));
-	pxa_set_ffuart_info(NULL);
-	pxa_set_btuart_info(NULL);
-	pxa_set_stuart_info(NULL);
-	/* Fixme - e400 may have a switched clock */
-	eseries_register_clks();
-	eseries_get_tmio_gpios();
-	set_pxa_fb_info(&e400_pxafb_mach_info);
-	platform_add_devices(devices, ARRAY_SIZE(devices));
-	pxa_set_udc_info(&e7xx_udc_mach_info);
-}
-
-MACHINE_START(E400, "Toshiba e400")
-	/* Maintainer: Ian Molton (spyro at f2s.com) */
-	.phys_io	= 0x40000000,
-	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
-	.boot_params	= 0xa0000100,
-	.map_io		= pxa_map_io,
-	.init_irq	= pxa25x_init_irq,
-	.fixup		= eseries_fixup,
-	.init_machine	= e400_init,
-	.timer		= &pxa_timer,
-MACHINE_END
-
diff --git a/arch/arm/mach-pxa/e740.c b/arch/arm/mach-pxa/e740.c
deleted file mode 100644
index d578021..0000000
--- a/arch/arm/mach-pxa/e740.c
+++ /dev/null
@@ -1,225 +0,0 @@
-/*
- * Hardware definitions for the Toshiba eseries PDAs
- *
- * Copyright (c) 2003 Ian Molton <spyro@f2s.com>
- *
- * This file is licensed under
- * the terms of the GNU General Public License version 2. This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
- *
- */
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/device.h>
-#include <linux/platform_device.h>
-#include <linux/fb.h>
-#include <linux/clk.h>
-#include <linux/mfd/t7l66xb.h>
-
-#include <video/w100fb.h>
-
-#include <asm/setup.h>
-#include <asm/mach/arch.h>
-#include <asm/mach-types.h>
-
-#include <mach/pxa25x.h>
-#include <mach/eseries-gpio.h>
-#include <mach/udc.h>
-#include <mach/irda.h>
-#include <mach/irqs.h>
-#include <mach/audio.h>
-
-#include "generic.h"
-#include "eseries.h"
-#include "clock.h"
-#include "devices.h"
-
-/* ------------------------ e740 video support --------------------------- */
-
-static struct w100_gen_regs e740_lcd_regs = {
-	.lcd_format =            0x00008023,
-	.lcdd_cntl1 =            0x0f000000,
-	.lcdd_cntl2 =            0x0003ffff,
-	.genlcd_cntl1 =          0x00ffff03,
-	.genlcd_cntl2 =          0x003c0f03,
-	.genlcd_cntl3 =          0x000143aa,
-};
-
-static struct w100_mode e740_lcd_mode = {
-	.xres            = 240,
-	.yres            = 320,
-	.left_margin     = 20,
-	.right_margin    = 28,
-	.upper_margin    = 9,
-	.lower_margin    = 8,
-	.crtc_ss         = 0x80140013,
-	.crtc_ls         = 0x81150110,
-	.crtc_gs         = 0x80050005,
-	.crtc_vpos_gs    = 0x000a0009,
-	.crtc_rev        = 0x0040010a,
-	.crtc_dclk       = 0xa906000a,
-	.crtc_gclk       = 0x80050108,
-	.crtc_goe        = 0x80050108,
-	.pll_freq        = 57,
-	.pixclk_divider         = 4,
-	.pixclk_divider_rotated = 4,
-	.pixclk_src     = CLK_SRC_XTAL,
-	.sysclk_divider  = 1,
-	.sysclk_src     = CLK_SRC_PLL,
-	.crtc_ps1_active =       0x41060010,
-};
-
-static struct w100_gpio_regs e740_w100_gpio_info = {
-	.init_data1 = 0x21002103,
-	.gpio_dir1  = 0xffffdeff,
-	.gpio_oe1   = 0x03c00643,
-	.init_data2 = 0x003f003f,
-	.gpio_dir2  = 0xffffffff,
-	.gpio_oe2   = 0x000000ff,
-};
-
-static struct w100fb_mach_info e740_fb_info = {
-	.modelist   = &e740_lcd_mode,
-	.num_modes  = 1,
-	.regs       = &e740_lcd_regs,
-	.gpio       = &e740_w100_gpio_info,
-	.xtal_freq = 14318000,
-	.xtal_dbl   = 1,
-};
-
-static struct resource e740_fb_resources[] = {
-	[0] = {
-		.start          = 0x0c000000,
-		.end            = 0x0cffffff,
-		.flags          = IORESOURCE_MEM,
-	},
-};
-
-static struct platform_device e740_fb_device = {
-	.name           = "w100fb",
-	.id             = -1,
-	.dev            = {
-		.platform_data  = &e740_fb_info,
-	},
-	.num_resources  = ARRAY_SIZE(e740_fb_resources),
-	.resource       = e740_fb_resources,
-};
-
-/* --------------------------- MFP Pin config -------------------------- */
-
-static unsigned long e740_pin_config[] __initdata = {
-	/* Chip selects */
-	GPIO15_nCS_1,   /* CS1 - Flash */
-	GPIO79_nCS_3,   /* CS3 - IMAGEON */
-	GPIO80_nCS_4,   /* CS4 - TMIO */
-
-	/* Clocks */
-	GPIO12_32KHz,
-
-	/* BTUART */
-	GPIO42_BTUART_RXD,
-	GPIO43_BTUART_TXD,
-	GPIO44_BTUART_CTS,
-
-	/* TMIO controller */
-	GPIO19_GPIO, /* t7l66xb #PCLR */
-	GPIO45_GPIO, /* t7l66xb #SUSPEND (NOT BTUART!) */
-
-	/* UDC */
-	GPIO13_GPIO,
-	GPIO3_GPIO,
-
-	/* IrDA */
-	GPIO38_GPIO | MFP_LPM_DRIVE_HIGH,
-
-	/* AC97 */
-	GPIO28_AC97_BITCLK,
-	GPIO29_AC97_SDATA_IN_0,
-	GPIO30_AC97_SDATA_OUT,
-	GPIO31_AC97_SYNC,
-
-	/* Audio power control */
-	GPIO16_GPIO,  /* AC97 codec AVDD2 supply (analogue power) */
-	GPIO40_GPIO,  /* Mic amp power */
-	GPIO41_GPIO,  /* Headphone amp power */
-
-	/* PC Card */
-	GPIO8_GPIO,   /* CD0 */
-	GPIO44_GPIO,  /* CD1 */
-	GPIO11_GPIO,  /* IRQ0 */
-	GPIO6_GPIO,   /* IRQ1 */
-	GPIO27_GPIO,  /* RST0 */
-	GPIO24_GPIO,  /* RST1 */
-	GPIO20_GPIO,  /* PWR0 */
-	GPIO23_GPIO,  /* PWR1 */
-	GPIO48_nPOE,
-	GPIO49_nPWE,
-	GPIO50_nPIOR,
-	GPIO51_nPIOW,
-	GPIO52_nPCE_1,
-	GPIO53_nPCE_2,
-	GPIO54_nPSKTSEL,
-	GPIO55_nPREG,
-	GPIO56_nPWAIT,
-	GPIO57_nIOIS16,
-
-	/* wakeup */
-	GPIO0_GPIO | WAKEUP_ON_EDGE_RISE,
-};
-
-/* -------------------- e740 t7l66xb parameters -------------------- */
-
-static struct t7l66xb_platform_data e740_t7l66xb_info = {
-	.irq_base 		= IRQ_BOARD_START,
-	.enable                 = &eseries_tmio_enable,
-	.suspend                = &eseries_tmio_suspend,
-	.resume                 = &eseries_tmio_resume,
-};
-
-static struct platform_device e740_t7l66xb_device = {
-	.name           = "t7l66xb",
-	.id             = -1,
-	.dev            = {
-		.platform_data = &e740_t7l66xb_info,
-	},
-	.num_resources = 2,
-	.resource      = eseries_tmio_resources,
-};
-
-/* ----------------------------------------------------------------------- */
-
-static struct platform_device *devices[] __initdata = {
-	&e740_fb_device,
-	&e740_t7l66xb_device,
-};
-
-static void __init e740_init(void)
-{
-	pxa2xx_mfp_config(ARRAY_AND_SIZE(e740_pin_config));
-	pxa_set_ffuart_info(NULL);
-	pxa_set_btuart_info(NULL);
-	pxa_set_stuart_info(NULL);
-	eseries_register_clks();
-	clk_add_alias("CLK_CK48M", e740_t7l66xb_device.name,
-			"UDCCLK", &pxa25x_device_udc.dev),
-	eseries_get_tmio_gpios();
-	platform_add_devices(devices, ARRAY_SIZE(devices));
-	pxa_set_udc_info(&e7xx_udc_mach_info);
-	pxa_set_ac97_info(NULL);
-	pxa_set_ficp_info(&e7xx_ficp_platform_data);
-}
-
-MACHINE_START(E740, "Toshiba e740")
-	/* Maintainer: Ian Molton (spyro at f2s.com) */
-	.phys_io	= 0x40000000,
-	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
-	.boot_params	= 0xa0000100,
-	.map_io		= pxa_map_io,
-	.init_irq	= pxa25x_init_irq,
-	.fixup		= eseries_fixup,
-	.init_machine	= e740_init,
-	.timer		= &pxa_timer,
-MACHINE_END
-
diff --git a/arch/arm/mach-pxa/e750.c b/arch/arm/mach-pxa/e750.c
deleted file mode 100644
index af83caa..0000000
--- a/arch/arm/mach-pxa/e750.c
+++ /dev/null
@@ -1,226 +0,0 @@
-/*
- * Hardware definitions for the Toshiba eseries PDAs
- *
- * Copyright (c) 2003 Ian Molton <spyro@f2s.com>
- *
- * This file is licensed under
- * the terms of the GNU General Public License version 2. This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
- *
- */
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/device.h>
-#include <linux/platform_device.h>
-#include <linux/fb.h>
-#include <linux/mfd/tc6393xb.h>
-
-#include <video/w100fb.h>
-
-#include <asm/setup.h>
-#include <asm/mach/arch.h>
-#include <asm/mach-types.h>
-
-#include <mach/pxa25x.h>
-#include <mach/eseries-gpio.h>
-#include <mach/udc.h>
-#include <mach/irda.h>
-#include <mach/irqs.h>
-#include <mach/audio.h>
-
-#include "generic.h"
-#include "eseries.h"
-#include "clock.h"
-
-/* ---------------------- E750 LCD definitions -------------------- */
-
-static struct w100_gen_regs e750_lcd_regs = {
-	.lcd_format =            0x00008003,
-	.lcdd_cntl1 =            0x00000000,
-	.lcdd_cntl2 =            0x0003ffff,
-	.genlcd_cntl1 =          0x00fff003,
-	.genlcd_cntl2 =          0x003c0f03,
-	.genlcd_cntl3 =          0x000143aa,
-};
-
-static struct w100_mode e750_lcd_mode = {
-	.xres            = 240,
-	.yres            = 320,
-	.left_margin     = 21,
-	.right_margin    = 22,
-	.upper_margin    = 5,
-	.lower_margin    = 4,
-	.crtc_ss         = 0x80150014,
-	.crtc_ls         = 0x8014000d,
-	.crtc_gs         = 0xc1000005,
-	.crtc_vpos_gs    = 0x00020147,
-	.crtc_rev        = 0x0040010a,
-	.crtc_dclk       = 0xa1700030,
-	.crtc_gclk       = 0x80cc0015,
-	.crtc_goe        = 0x80cc0015,
-	.crtc_ps1_active = 0x61060017,
-	.pll_freq        = 57,
-	.pixclk_divider         = 4,
-	.pixclk_divider_rotated = 4,
-	.pixclk_src     = CLK_SRC_XTAL,
-	.sysclk_divider  = 1,
-	.sysclk_src     = CLK_SRC_PLL,
-};
-
-static struct w100_gpio_regs e750_w100_gpio_info = {
-	.init_data1 = 0x01192f1b,
-	.gpio_dir1  = 0xd5ffdeff,
-	.gpio_oe1   = 0x000020bf,
-	.init_data2 = 0x010f010f,
-	.gpio_dir2  = 0xffffffff,
-	.gpio_oe2   = 0x000001cf,
-};
-
-static struct w100fb_mach_info e750_fb_info = {
-	.modelist   = &e750_lcd_mode,
-	.num_modes  = 1,
-	.regs       = &e750_lcd_regs,
-	.gpio       = &e750_w100_gpio_info,
-	.xtal_freq  = 14318000,
-	.xtal_dbl   = 1,
-};
-
-static struct resource e750_fb_resources[] = {
-	[0] = {
-		.start          = 0x0c000000,
-		.end            = 0x0cffffff,
-		.flags          = IORESOURCE_MEM,
-	},
-};
-
-static struct platform_device e750_fb_device = {
-	.name           = "w100fb",
-	.id             = -1,
-	.dev            = {
-		.platform_data  = &e750_fb_info,
-	},
-	.num_resources  = ARRAY_SIZE(e750_fb_resources),
-	.resource       = e750_fb_resources,
-};
-
-/* -------------------- e750 MFP parameters -------------------- */
-
-static unsigned long e750_pin_config[] __initdata = {
-	/* Chip selects */
-	GPIO15_nCS_1,   /* CS1 - Flash */
-	GPIO79_nCS_3,   /* CS3 - IMAGEON */
-	GPIO80_nCS_4,   /* CS4 - TMIO */
-
-	/* Clocks */
-	GPIO11_3_6MHz,
-
-	/* BTUART */
-	GPIO42_BTUART_RXD,
-	GPIO43_BTUART_TXD,
-	GPIO44_BTUART_CTS,
-
-	/* TMIO controller */
-	GPIO19_GPIO, /* t7l66xb #PCLR */
-	GPIO45_GPIO, /* t7l66xb #SUSPEND (NOT BTUART!) */
-
-	/* UDC */
-	GPIO13_GPIO,
-	GPIO3_GPIO,
-
-	/* IrDA */
-	GPIO38_GPIO | MFP_LPM_DRIVE_HIGH,
-
-	/* AC97 */
-	GPIO28_AC97_BITCLK,
-	GPIO29_AC97_SDATA_IN_0,
-	GPIO30_AC97_SDATA_OUT,
-	GPIO31_AC97_SYNC,
-
-	/* Audio power control */
-	GPIO4_GPIO,  /* Headphone amp power */
-	GPIO7_GPIO,  /* Speaker amp power */
-	GPIO37_GPIO, /* Headphone detect */
-
-	/* PC Card */
-	GPIO8_GPIO,   /* CD0 */
-	GPIO44_GPIO,  /* CD1 */
-	GPIO11_GPIO,  /* IRQ0 */
-	GPIO6_GPIO,   /* IRQ1 */
-	GPIO27_GPIO,  /* RST0 */
-	GPIO24_GPIO,  /* RST1 */
-	GPIO20_GPIO,  /* PWR0 */
-	GPIO23_GPIO,  /* PWR1 */
-	GPIO48_nPOE,
-	GPIO49_nPWE,
-	GPIO50_nPIOR,
-	GPIO51_nPIOW,
-	GPIO52_nPCE_1,
-	GPIO53_nPCE_2,
-	GPIO54_nPSKTSEL,
-	GPIO55_nPREG,
-	GPIO56_nPWAIT,
-	GPIO57_nIOIS16,
-
-	/* wakeup */
-	GPIO0_GPIO | WAKEUP_ON_EDGE_RISE,
-};
-
-/* ----------------- e750 tc6393xb parameters ------------------ */
-
-static struct tc6393xb_platform_data e750_tc6393xb_info = {
-	.irq_base       = IRQ_BOARD_START,
-	.scr_pll2cr     = 0x0cc1,
-	.scr_gper       = 0,
-	.gpio_base      = -1,
-	.suspend        = &eseries_tmio_suspend,
-	.resume         = &eseries_tmio_resume,
-	.enable         = &eseries_tmio_enable,
-	.disable        = &eseries_tmio_disable,
-};
-
-static struct platform_device e750_tc6393xb_device = {
-	.name           = "tc6393xb",
-	.id             = -1,
-	.dev            = {
-		.platform_data = &e750_tc6393xb_info,
-	},
-	.num_resources = 2,
-	.resource      = eseries_tmio_resources,
-};
-
-/* ------------------------------------------------------------- */
-
-static struct platform_device *devices[] __initdata = {
-	&e750_fb_device,
-	&e750_tc6393xb_device,
-};
-
-static void __init e750_init(void)
-{
-	pxa2xx_mfp_config(ARRAY_AND_SIZE(e750_pin_config));
-	pxa_set_ffuart_info(NULL);
-	pxa_set_btuart_info(NULL);
-	pxa_set_stuart_info(NULL);
-	clk_add_alias("CLK_CK3P6MI", e750_tc6393xb_device.name,
-			"GPIO11_CLK", NULL),
-	eseries_get_tmio_gpios();
-	platform_add_devices(devices, ARRAY_SIZE(devices));
-	pxa_set_udc_info(&e7xx_udc_mach_info);
-	pxa_set_ac97_info(NULL);
-	pxa_set_ficp_info(&e7xx_ficp_platform_data);
-}
-
-MACHINE_START(E750, "Toshiba e750")
-	/* Maintainer: Ian Molton (spyro at f2s.com) */
-	.phys_io	= 0x40000000,
-	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
-	.boot_params	= 0xa0000100,
-	.map_io		= pxa_map_io,
-	.init_irq	= pxa25x_init_irq,
-	.fixup		= eseries_fixup,
-	.init_machine	= e750_init,
-	.timer		= &pxa_timer,
-MACHINE_END
-
diff --git a/arch/arm/mach-pxa/e800.c b/arch/arm/mach-pxa/e800.c
deleted file mode 100644
index 8ea97bf..0000000
--- a/arch/arm/mach-pxa/e800.c
+++ /dev/null
@@ -1,229 +0,0 @@
-/*
- * Hardware definitions for the Toshiba eseries PDAs
- *
- * Copyright (c) 2003 Ian Molton <spyro@f2s.com>
- *
- * This file is licensed under
- * the terms of the GNU General Public License version 2. This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
- *
- */
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/device.h>
-#include <linux/platform_device.h>
-#include <linux/fb.h>
-#include <linux/mfd/tc6393xb.h>
-
-#include <video/w100fb.h>
-
-#include <asm/setup.h>
-#include <asm/mach/arch.h>
-#include <asm/mach-types.h>
-
-#include <mach/pxa25x.h>
-#include <mach/eseries-gpio.h>
-#include <mach/udc.h>
-#include <mach/irqs.h>
-#include <mach/audio.h>
-
-#include "generic.h"
-#include "eseries.h"
-#include "clock.h"
-
-/* ------------------------ e800 LCD definitions ------------------------- */
-
-static unsigned long e800_pin_config[] __initdata = {
-	/* AC97 */
-	GPIO28_AC97_BITCLK,
-	GPIO29_AC97_SDATA_IN_0,
-	GPIO30_AC97_SDATA_OUT,
-	GPIO31_AC97_SYNC,
-};
-
-static struct w100_gen_regs e800_lcd_regs = {
-	.lcd_format =            0x00008003,
-	.lcdd_cntl1 =            0x02a00000,
-	.lcdd_cntl2 =            0x0003ffff,
-	.genlcd_cntl1 =          0x000ff2a3,
-	.genlcd_cntl2 =          0x000002a3,
-	.genlcd_cntl3 =          0x000102aa,
-};
-
-static struct w100_mode e800_lcd_mode[2] = {
-	[0] = {
-		.xres            = 480,
-		.yres            = 640,
-		.left_margin     = 52,
-		.right_margin    = 148,
-		.upper_margin    = 2,
-		.lower_margin    = 6,
-		.crtc_ss         = 0x80350034,
-		.crtc_ls         = 0x802b0026,
-		.crtc_gs         = 0x80160016,
-		.crtc_vpos_gs    = 0x00020003,
-		.crtc_rev        = 0x0040001d,
-		.crtc_dclk       = 0xe0000000,
-		.crtc_gclk       = 0x82a50049,
-		.crtc_goe        = 0x80ee001c,
-		.crtc_ps1_active = 0x00000000,
-		.pll_freq        = 128,
-		.pixclk_divider         = 4,
-		.pixclk_divider_rotated = 6,
-		.pixclk_src     = CLK_SRC_PLL,
-		.sysclk_divider  = 0,
-		.sysclk_src     = CLK_SRC_PLL,
-	},
-	[1] = {
-		.xres            = 240,
-		.yres            = 320,
-		.left_margin     = 15,
-		.right_margin    = 88,
-		.upper_margin    = 0,
-		.lower_margin    = 7,
-		.crtc_ss         = 0xd010000f,
-		.crtc_ls         = 0x80070003,
-		.crtc_gs         = 0x80000000,
-		.crtc_vpos_gs    = 0x01460147,
-		.crtc_rev        = 0x00400003,
-		.crtc_dclk       = 0xa1700030,
-		.crtc_gclk       = 0x814b0008,
-		.crtc_goe        = 0x80cc0015,
-		.crtc_ps1_active = 0x00000000,
-		.pll_freq        = 100,
-		.pixclk_divider         = 6, /* Wince uses 14 which gives a */
-		.pixclk_divider_rotated = 6, /* 7MHz Pclk. We use a 14MHz one */
-		.pixclk_src     = CLK_SRC_PLL,
-		.sysclk_divider  = 0,
-		.sysclk_src     = CLK_SRC_PLL,
-	}
-};
-
-
-static struct w100_gpio_regs e800_w100_gpio_info = {
-	.init_data1 = 0xc13fc019,
-	.gpio_dir1  = 0x3e40df7f,
-	.gpio_oe1   = 0x003c3000,
-	.init_data2 = 0x00000000,
-	.gpio_dir2  = 0x00000000,
-	.gpio_oe2   = 0x00000000,
-};
-
-static struct w100_mem_info e800_w100_mem_info = {
-	.ext_cntl        = 0x09640011,
-	.sdram_mode_reg  = 0x00600021,
-	.ext_timing_cntl = 0x10001545,
-	.io_cntl         = 0x7ddd7333,
-	.size            = 0x1fffff,
-};
-
-static void e800_tg_change(struct w100fb_par *par)
-{
-	unsigned long tmp;
-
-	tmp = w100fb_gpio_read(W100_GPIO_PORT_A);
-	if (par->mode->xres == 480)
-		tmp |= 0x100;
-	else
-		tmp &= ~0x100;
-	w100fb_gpio_write(W100_GPIO_PORT_A, tmp);
-}
-
-static struct w100_tg_info e800_tg_info = {
-	.change = e800_tg_change,
-};
-
-static struct w100fb_mach_info e800_fb_info = {
-	.modelist   = e800_lcd_mode,
-	.num_modes  = 2,
-	.regs       = &e800_lcd_regs,
-	.gpio       = &e800_w100_gpio_info,
-	.mem        = &e800_w100_mem_info,
-	.tg         = &e800_tg_info,
-	.xtal_freq  = 16000000,
-};
-
-static struct resource e800_fb_resources[] = {
-	[0] = {
-		.start          = 0x0c000000,
-		.end            = 0x0cffffff,
-		.flags          = IORESOURCE_MEM,
-	},
-};
-
-static struct platform_device e800_fb_device = {
-	.name           = "w100fb",
-	.id             = -1,
-	.dev            = {
-		.platform_data  = &e800_fb_info,
-	},
-	.num_resources  = ARRAY_SIZE(e800_fb_resources),
-	.resource       = e800_fb_resources,
-};
-
-/* --------------------------- UDC definitions --------------------------- */
-
-static struct pxa2xx_udc_mach_info e800_udc_mach_info = {
-	.gpio_vbus   = GPIO_E800_USB_DISC,
-	.gpio_pullup = GPIO_E800_USB_PULLUP,
-	.gpio_pullup_inverted = 1
-};
-
-/* ----------------- e800 tc6393xb parameters ------------------ */
-
-static struct tc6393xb_platform_data e800_tc6393xb_info = {
-	.irq_base       = IRQ_BOARD_START,
-	.scr_pll2cr     = 0x0cc1,
-	.scr_gper       = 0,
-	.gpio_base      = -1,
-	.suspend        = &eseries_tmio_suspend,
-	.resume         = &eseries_tmio_resume,
-	.enable         = &eseries_tmio_enable,
-	.disable        = &eseries_tmio_disable,
-};
-
-static struct platform_device e800_tc6393xb_device = {
-	.name           = "tc6393xb",
-	.id             = -1,
-	.dev            = {
-		.platform_data = &e800_tc6393xb_info,
-	},
-	.num_resources = 2,
-	.resource      = eseries_tmio_resources,
-};
-
-/* ----------------------------------------------------------------------- */
-
-static struct platform_device *devices[] __initdata = {
-	&e800_fb_device,
-	&e800_tc6393xb_device,
-};
-
-static void __init e800_init(void)
-{
-	pxa2xx_mfp_config(ARRAY_AND_SIZE(e800_pin_config));
-	pxa_set_ffuart_info(NULL);
-	pxa_set_btuart_info(NULL);
-	pxa_set_stuart_info(NULL);
-	clk_add_alias("CLK_CK3P6MI", e800_tc6393xb_device.name,
-			"GPIO11_CLK", NULL),
-	eseries_get_tmio_gpios();
-	platform_add_devices(devices, ARRAY_SIZE(devices));
-	pxa_set_udc_info(&e800_udc_mach_info);
-	pxa_set_ac97_info(NULL);
-}
-
-MACHINE_START(E800, "Toshiba e800")
-	/* Maintainer: Ian Molton (spyro at f2s.com) */
-	.phys_io	= 0x40000000,
-	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
-	.boot_params	= 0xa0000100,
-	.map_io		= pxa_map_io,
-	.init_irq	= pxa25x_init_irq,
-	.fixup		= eseries_fixup,
-	.init_machine	= e800_init,
-	.timer		= &pxa_timer,
-MACHINE_END
-
diff --git a/arch/arm/mach-pxa/eseries.c b/arch/arm/mach-pxa/eseries.c
index 96ed130..1d67f02 100644
--- a/arch/arm/mach-pxa/eseries.c
+++ b/arch/arm/mach-pxa/eseries.c
@@ -15,6 +15,13 @@
 #include <linux/gpio.h>
 #include <linux/delay.h>
 #include <linux/platform_device.h>
+#include <linux/mfd/tc6387xb.h>
+#include <linux/mfd/tc6393xb.h>
+#include <linux/mfd/t7l66xb.h>
+#include <linux/mtd/nand.h>
+#include <linux/mtd/partitions.h>
+
+#include <video/w100fb.h>
 
 #include <asm/setup.h>
 #include <asm/mach/arch.h>
@@ -22,9 +29,12 @@
 
 #include <mach/pxa25x.h>
 #include <mach/eseries-gpio.h>
+#include <mach/audio.h>
+#include <mach/pxafb.h>
 #include <mach/udc.h>
 #include <mach/irda.h>
 
+#include "devices.h"
 #include "generic.h"
 #include "clock.h"
 
@@ -131,3 +141,802 @@ void eseries_register_clks(void)
 	clkdev_add_table(eseries_clkregs, ARRAY_SIZE(eseries_clkregs));
 }
 
+#ifdef CONFIG_MACH_E330
+/* -------------------- e330 tc6387xb parameters -------------------- */
+
+static struct tc6387xb_platform_data e330_tc6387xb_info = {
+	.enable   = &eseries_tmio_enable,
+	.disable  = &eseries_tmio_disable,
+	.suspend  = &eseries_tmio_suspend,
+	.resume   = &eseries_tmio_resume,
+};
+
+static struct platform_device e330_tc6387xb_device = {
+	.name           = "tc6387xb",
+	.id             = -1,
+	.dev            = {
+		.platform_data = &e330_tc6387xb_info,
+	},
+	.num_resources = 2,
+	.resource      = eseries_tmio_resources,
+};
+
+/* --------------------------------------------------------------- */
+
+static struct platform_device *e330_devices[] __initdata = {
+	&e330_tc6387xb_device,
+};
+
+static void __init e330_init(void)
+{
+	pxa_set_ffuart_info(NULL);
+	pxa_set_btuart_info(NULL);
+	pxa_set_stuart_info(NULL);
+	eseries_register_clks();
+	eseries_get_tmio_gpios();
+	platform_add_devices(ARRAY_AND_SIZE(e330_devices));
+	pxa_set_udc_info(&e7xx_udc_mach_info);
+}
+
+MACHINE_START(E330, "Toshiba e330")
+	/* Maintainer: Ian Molton (spyro at f2s.com) */
+	.phys_io	= 0x40000000,
+	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
+	.boot_params	= 0xa0000100,
+	.map_io		= pxa_map_io,
+	.init_irq	= pxa25x_init_irq,
+	.fixup		= eseries_fixup,
+	.init_machine	= e330_init,
+	.timer		= &pxa_timer,
+MACHINE_END
+#endif
+
+#ifdef CONFIG_MACH_E350
+/* -------------------- e350 t7l66xb parameters -------------------- */
+
+static struct t7l66xb_platform_data e350_t7l66xb_info = {
+	.irq_base               = IRQ_BOARD_START,
+	.enable                 = &eseries_tmio_enable,
+	.suspend                = &eseries_tmio_suspend,
+	.resume                 = &eseries_tmio_resume,
+};
+
+static struct platform_device e350_t7l66xb_device = {
+	.name           = "t7l66xb",
+	.id             = -1,
+	.dev            = {
+		.platform_data = &e350_t7l66xb_info,
+	},
+	.num_resources = 2,
+	.resource      = eseries_tmio_resources,
+};
+
+/* ---------------------------------------------------------- */
+
+static struct platform_device *e350_devices[] __initdata = {
+	&e350_t7l66xb_device,
+};
+
+static void __init e350_init(void)
+{
+	pxa_set_ffuart_info(NULL);
+	pxa_set_btuart_info(NULL);
+	pxa_set_stuart_info(NULL);
+	eseries_register_clks();
+	eseries_get_tmio_gpios();
+	platform_add_devices(ARRAY_AND_SIZE(e350_devices));
+	pxa_set_udc_info(&e7xx_udc_mach_info);
+}
+
+MACHINE_START(E350, "Toshiba e350")
+	/* Maintainer: Ian Molton (spyro at f2s.com) */
+	.phys_io	= 0x40000000,
+	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
+	.boot_params	= 0xa0000100,
+	.map_io		= pxa_map_io,
+	.init_irq	= pxa25x_init_irq,
+	.fixup		= eseries_fixup,
+	.init_machine	= e350_init,
+	.timer		= &pxa_timer,
+MACHINE_END
+#endif
+
+#ifdef CONFIG_MACH_E400
+/* ------------------------ E400 LCD definitions ------------------------ */
+
+static struct pxafb_mode_info e400_pxafb_mode_info = {
+	.pixclock       = 140703,
+	.xres           = 240,
+	.yres           = 320,
+	.bpp            = 16,
+	.hsync_len      = 4,
+	.left_margin    = 28,
+	.right_margin   = 8,
+	.vsync_len      = 3,
+	.upper_margin   = 5,
+	.lower_margin   = 6,
+	.sync           = 0,
+};
+
+static struct pxafb_mach_info e400_pxafb_mach_info = {
+	.modes          = &e400_pxafb_mode_info,
+	.num_modes      = 1,
+	.lcd_conn	= LCD_COLOR_TFT_16BPP,
+	.lccr3          = 0,
+	.pxafb_backlight_power  = NULL,
+};
+
+/* ------------------------ E400 MFP config ----------------------------- */
+
+static unsigned long e400_pin_config[] __initdata = {
+	/* Chip selects */
+	GPIO15_nCS_1,   /* CS1 - Flash */
+	GPIO80_nCS_4,   /* CS4 - TMIO */
+
+	/* Clocks */
+	GPIO12_32KHz,
+
+	/* BTUART */
+	GPIO42_BTUART_RXD,
+	GPIO43_BTUART_TXD,
+	GPIO44_BTUART_CTS,
+
+	/* TMIO controller */
+	GPIO19_GPIO, /* t7l66xb #PCLR */
+	GPIO45_GPIO, /* t7l66xb #SUSPEND (NOT BTUART!) */
+
+	/* wakeup */
+	GPIO0_GPIO | WAKEUP_ON_EDGE_RISE,
+};
+
+/* ---------------------------------------------------------------------- */
+
+static struct mtd_partition partition_a = {
+	.name = "Internal NAND flash",
+	.offset =  0,
+	.size =  MTDPART_SIZ_FULL,
+};
+
+static uint8_t scan_ff_pattern[] = { 0xff, 0xff };
+
+static struct nand_bbt_descr e400_t7l66xb_nand_bbt = {
+	.options = 0,
+	.offs = 4,
+	.len = 2,
+	.pattern = scan_ff_pattern
+};
+
+static struct tmio_nand_data e400_t7l66xb_nand_config = {
+	.num_partitions = 1,
+	.partition = &partition_a,
+	.badblock_pattern = &e400_t7l66xb_nand_bbt,
+};
+
+static struct t7l66xb_platform_data e400_t7l66xb_info = {
+	.irq_base 		= IRQ_BOARD_START,
+	.enable                 = &eseries_tmio_enable,
+	.suspend                = &eseries_tmio_suspend,
+	.resume                 = &eseries_tmio_resume,
+
+	.nand_data              = &e400_t7l66xb_nand_config,
+};
+
+static struct platform_device e400_t7l66xb_device = {
+	.name           = "t7l66xb",
+	.id             = -1,
+	.dev            = {
+		.platform_data = &e400_t7l66xb_info,
+	},
+	.num_resources = 2,
+	.resource      = eseries_tmio_resources,
+};
+
+/* ---------------------------------------------------------- */
+
+static struct platform_device *e400_devices[] __initdata = {
+	&e400_t7l66xb_device,
+};
+
+static void __init e400_init(void)
+{
+	pxa2xx_mfp_config(ARRAY_AND_SIZE(e400_pin_config));
+	pxa_set_ffuart_info(NULL);
+	pxa_set_btuart_info(NULL);
+	pxa_set_stuart_info(NULL);
+	/* Fixme - e400 may have a switched clock */
+	eseries_register_clks();
+	eseries_get_tmio_gpios();
+	set_pxa_fb_info(&e400_pxafb_mach_info);
+	platform_add_devices(ARRAY_AND_SIZE(e400_devices));
+	pxa_set_udc_info(&e7xx_udc_mach_info);
+}
+
+MACHINE_START(E400, "Toshiba e400")
+	/* Maintainer: Ian Molton (spyro at f2s.com) */
+	.phys_io	= 0x40000000,
+	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
+	.boot_params	= 0xa0000100,
+	.map_io		= pxa_map_io,
+	.init_irq	= pxa25x_init_irq,
+	.fixup		= eseries_fixup,
+	.init_machine	= e400_init,
+	.timer		= &pxa_timer,
+MACHINE_END
+#endif
+
+#ifdef CONFIG_MACH_E740
+/* ------------------------ e740 video support --------------------------- */
+
+static struct w100_gen_regs e740_lcd_regs = {
+	.lcd_format =            0x00008023,
+	.lcdd_cntl1 =            0x0f000000,
+	.lcdd_cntl2 =            0x0003ffff,
+	.genlcd_cntl1 =          0x00ffff03,
+	.genlcd_cntl2 =          0x003c0f03,
+	.genlcd_cntl3 =          0x000143aa,
+};
+
+static struct w100_mode e740_lcd_mode = {
+	.xres            = 240,
+	.yres            = 320,
+	.left_margin     = 20,
+	.right_margin    = 28,
+	.upper_margin    = 9,
+	.lower_margin    = 8,
+	.crtc_ss         = 0x80140013,
+	.crtc_ls         = 0x81150110,
+	.crtc_gs         = 0x80050005,
+	.crtc_vpos_gs    = 0x000a0009,
+	.crtc_rev        = 0x0040010a,
+	.crtc_dclk       = 0xa906000a,
+	.crtc_gclk       = 0x80050108,
+	.crtc_goe        = 0x80050108,
+	.pll_freq        = 57,
+	.pixclk_divider         = 4,
+	.pixclk_divider_rotated = 4,
+	.pixclk_src     = CLK_SRC_XTAL,
+	.sysclk_divider  = 1,
+	.sysclk_src     = CLK_SRC_PLL,
+	.crtc_ps1_active =       0x41060010,
+};
+
+static struct w100_gpio_regs e740_w100_gpio_info = {
+	.init_data1 = 0x21002103,
+	.gpio_dir1  = 0xffffdeff,
+	.gpio_oe1   = 0x03c00643,
+	.init_data2 = 0x003f003f,
+	.gpio_dir2  = 0xffffffff,
+	.gpio_oe2   = 0x000000ff,
+};
+
+static struct w100fb_mach_info e740_fb_info = {
+	.modelist   = &e740_lcd_mode,
+	.num_modes  = 1,
+	.regs       = &e740_lcd_regs,
+	.gpio       = &e740_w100_gpio_info,
+	.xtal_freq = 14318000,
+	.xtal_dbl   = 1,
+};
+
+static struct resource e740_fb_resources[] = {
+	[0] = {
+		.start          = 0x0c000000,
+		.end            = 0x0cffffff,
+		.flags          = IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device e740_fb_device = {
+	.name           = "w100fb",
+	.id             = -1,
+	.dev            = {
+		.platform_data  = &e740_fb_info,
+	},
+	.num_resources  = ARRAY_SIZE(e740_fb_resources),
+	.resource       = e740_fb_resources,
+};
+
+/* --------------------------- MFP Pin config -------------------------- */
+
+static unsigned long e740_pin_config[] __initdata = {
+	/* Chip selects */
+	GPIO15_nCS_1,   /* CS1 - Flash */
+	GPIO79_nCS_3,   /* CS3 - IMAGEON */
+	GPIO80_nCS_4,   /* CS4 - TMIO */
+
+	/* Clocks */
+	GPIO12_32KHz,
+
+	/* BTUART */
+	GPIO42_BTUART_RXD,
+	GPIO43_BTUART_TXD,
+	GPIO44_BTUART_CTS,
+
+	/* TMIO controller */
+	GPIO19_GPIO, /* t7l66xb #PCLR */
+	GPIO45_GPIO, /* t7l66xb #SUSPEND (NOT BTUART!) */
+
+	/* UDC */
+	GPIO13_GPIO,
+	GPIO3_GPIO,
+
+	/* IrDA */
+	GPIO38_GPIO | MFP_LPM_DRIVE_HIGH,
+
+	/* AC97 */
+	GPIO28_AC97_BITCLK,
+	GPIO29_AC97_SDATA_IN_0,
+	GPIO30_AC97_SDATA_OUT,
+	GPIO31_AC97_SYNC,
+
+	/* Audio power control */
+	GPIO16_GPIO,  /* AC97 codec AVDD2 supply (analogue power) */
+	GPIO40_GPIO,  /* Mic amp power */
+	GPIO41_GPIO,  /* Headphone amp power */
+
+	/* PC Card */
+	GPIO8_GPIO,   /* CD0 */
+	GPIO44_GPIO,  /* CD1 */
+	GPIO11_GPIO,  /* IRQ0 */
+	GPIO6_GPIO,   /* IRQ1 */
+	GPIO27_GPIO,  /* RST0 */
+	GPIO24_GPIO,  /* RST1 */
+	GPIO20_GPIO,  /* PWR0 */
+	GPIO23_GPIO,  /* PWR1 */
+	GPIO48_nPOE,
+	GPIO49_nPWE,
+	GPIO50_nPIOR,
+	GPIO51_nPIOW,
+	GPIO52_nPCE_1,
+	GPIO53_nPCE_2,
+	GPIO54_nPSKTSEL,
+	GPIO55_nPREG,
+	GPIO56_nPWAIT,
+	GPIO57_nIOIS16,
+
+	/* wakeup */
+	GPIO0_GPIO | WAKEUP_ON_EDGE_RISE,
+};
+
+/* -------------------- e740 t7l66xb parameters -------------------- */
+
+static struct t7l66xb_platform_data e740_t7l66xb_info = {
+	.irq_base 		= IRQ_BOARD_START,
+	.enable                 = &eseries_tmio_enable,
+	.suspend                = &eseries_tmio_suspend,
+	.resume                 = &eseries_tmio_resume,
+};
+
+static struct platform_device e740_t7l66xb_device = {
+	.name           = "t7l66xb",
+	.id             = -1,
+	.dev            = {
+		.platform_data = &e740_t7l66xb_info,
+	},
+	.num_resources = 2,
+	.resource      = eseries_tmio_resources,
+};
+
+/* ----------------------------------------------------------------------- */
+
+static struct platform_device *e740_devices[] __initdata = {
+	&e740_fb_device,
+	&e740_t7l66xb_device,
+};
+
+static void __init e740_init(void)
+{
+	pxa2xx_mfp_config(ARRAY_AND_SIZE(e740_pin_config));
+	pxa_set_ffuart_info(NULL);
+	pxa_set_btuart_info(NULL);
+	pxa_set_stuart_info(NULL);
+	eseries_register_clks();
+	clk_add_alias("CLK_CK48M", e740_t7l66xb_device.name,
+			"UDCCLK", &pxa25x_device_udc.dev),
+	eseries_get_tmio_gpios();
+	platform_add_devices(ARRAY_AND_SIZE(e740_devices));
+	pxa_set_udc_info(&e7xx_udc_mach_info);
+	pxa_set_ac97_info(NULL);
+	pxa_set_ficp_info(&e7xx_ficp_platform_data);
+}
+
+MACHINE_START(E740, "Toshiba e740")
+	/* Maintainer: Ian Molton (spyro at f2s.com) */
+	.phys_io	= 0x40000000,
+	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
+	.boot_params	= 0xa0000100,
+	.map_io		= pxa_map_io,
+	.init_irq	= pxa25x_init_irq,
+	.fixup		= eseries_fixup,
+	.init_machine	= e740_init,
+	.timer		= &pxa_timer,
+MACHINE_END
+#endif
+
+#ifdef CONFIG_MACH_E750
+/* ---------------------- E750 LCD definitions -------------------- */
+
+static struct w100_gen_regs e750_lcd_regs = {
+	.lcd_format =            0x00008003,
+	.lcdd_cntl1 =            0x00000000,
+	.lcdd_cntl2 =            0x0003ffff,
+	.genlcd_cntl1 =          0x00fff003,
+	.genlcd_cntl2 =          0x003c0f03,
+	.genlcd_cntl3 =          0x000143aa,
+};
+
+static struct w100_mode e750_lcd_mode = {
+	.xres            = 240,
+	.yres            = 320,
+	.left_margin     = 21,
+	.right_margin    = 22,
+	.upper_margin    = 5,
+	.lower_margin    = 4,
+	.crtc_ss         = 0x80150014,
+	.crtc_ls         = 0x8014000d,
+	.crtc_gs         = 0xc1000005,
+	.crtc_vpos_gs    = 0x00020147,
+	.crtc_rev        = 0x0040010a,
+	.crtc_dclk       = 0xa1700030,
+	.crtc_gclk       = 0x80cc0015,
+	.crtc_goe        = 0x80cc0015,
+	.crtc_ps1_active = 0x61060017,
+	.pll_freq        = 57,
+	.pixclk_divider         = 4,
+	.pixclk_divider_rotated = 4,
+	.pixclk_src     = CLK_SRC_XTAL,
+	.sysclk_divider  = 1,
+	.sysclk_src     = CLK_SRC_PLL,
+};
+
+static struct w100_gpio_regs e750_w100_gpio_info = {
+	.init_data1 = 0x01192f1b,
+	.gpio_dir1  = 0xd5ffdeff,
+	.gpio_oe1   = 0x000020bf,
+	.init_data2 = 0x010f010f,
+	.gpio_dir2  = 0xffffffff,
+	.gpio_oe2   = 0x000001cf,
+};
+
+static struct w100fb_mach_info e750_fb_info = {
+	.modelist   = &e750_lcd_mode,
+	.num_modes  = 1,
+	.regs       = &e750_lcd_regs,
+	.gpio       = &e750_w100_gpio_info,
+	.xtal_freq  = 14318000,
+	.xtal_dbl   = 1,
+};
+
+static struct resource e750_fb_resources[] = {
+	[0] = {
+		.start          = 0x0c000000,
+		.end            = 0x0cffffff,
+		.flags          = IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device e750_fb_device = {
+	.name           = "w100fb",
+	.id             = -1,
+	.dev            = {
+		.platform_data  = &e750_fb_info,
+	},
+	.num_resources  = ARRAY_SIZE(e750_fb_resources),
+	.resource       = e750_fb_resources,
+};
+
+/* -------------------- e750 MFP parameters -------------------- */
+
+static unsigned long e750_pin_config[] __initdata = {
+	/* Chip selects */
+	GPIO15_nCS_1,   /* CS1 - Flash */
+	GPIO79_nCS_3,   /* CS3 - IMAGEON */
+	GPIO80_nCS_4,   /* CS4 - TMIO */
+
+	/* Clocks */
+	GPIO11_3_6MHz,
+
+	/* BTUART */
+	GPIO42_BTUART_RXD,
+	GPIO43_BTUART_TXD,
+	GPIO44_BTUART_CTS,
+
+	/* TMIO controller */
+	GPIO19_GPIO, /* t7l66xb #PCLR */
+	GPIO45_GPIO, /* t7l66xb #SUSPEND (NOT BTUART!) */
+
+	/* UDC */
+	GPIO13_GPIO,
+	GPIO3_GPIO,
+
+	/* IrDA */
+	GPIO38_GPIO | MFP_LPM_DRIVE_HIGH,
+
+	/* AC97 */
+	GPIO28_AC97_BITCLK,
+	GPIO29_AC97_SDATA_IN_0,
+	GPIO30_AC97_SDATA_OUT,
+	GPIO31_AC97_SYNC,
+
+	/* Audio power control */
+	GPIO4_GPIO,  /* Headphone amp power */
+	GPIO7_GPIO,  /* Speaker amp power */
+	GPIO37_GPIO, /* Headphone detect */
+
+	/* PC Card */
+	GPIO8_GPIO,   /* CD0 */
+	GPIO44_GPIO,  /* CD1 */
+	GPIO11_GPIO,  /* IRQ0 */
+	GPIO6_GPIO,   /* IRQ1 */
+	GPIO27_GPIO,  /* RST0 */
+	GPIO24_GPIO,  /* RST1 */
+	GPIO20_GPIO,  /* PWR0 */
+	GPIO23_GPIO,  /* PWR1 */
+	GPIO48_nPOE,
+	GPIO49_nPWE,
+	GPIO50_nPIOR,
+	GPIO51_nPIOW,
+	GPIO52_nPCE_1,
+	GPIO53_nPCE_2,
+	GPIO54_nPSKTSEL,
+	GPIO55_nPREG,
+	GPIO56_nPWAIT,
+	GPIO57_nIOIS16,
+
+	/* wakeup */
+	GPIO0_GPIO | WAKEUP_ON_EDGE_RISE,
+};
+
+/* ----------------- e750 tc6393xb parameters ------------------ */
+
+static struct tc6393xb_platform_data e750_tc6393xb_info = {
+	.irq_base       = IRQ_BOARD_START,
+	.scr_pll2cr     = 0x0cc1,
+	.scr_gper       = 0,
+	.gpio_base      = -1,
+	.suspend        = &eseries_tmio_suspend,
+	.resume         = &eseries_tmio_resume,
+	.enable         = &eseries_tmio_enable,
+	.disable        = &eseries_tmio_disable,
+};
+
+static struct platform_device e750_tc6393xb_device = {
+	.name           = "tc6393xb",
+	.id             = -1,
+	.dev            = {
+		.platform_data = &e750_tc6393xb_info,
+	},
+	.num_resources = 2,
+	.resource      = eseries_tmio_resources,
+};
+
+/* ------------------------------------------------------------- */
+
+static struct platform_device *e750_devices[] __initdata = {
+	&e750_fb_device,
+	&e750_tc6393xb_device,
+};
+
+static void __init e750_init(void)
+{
+	pxa2xx_mfp_config(ARRAY_AND_SIZE(e750_pin_config));
+	pxa_set_ffuart_info(NULL);
+	pxa_set_btuart_info(NULL);
+	pxa_set_stuart_info(NULL);
+	clk_add_alias("CLK_CK3P6MI", e750_tc6393xb_device.name,
+			"GPIO11_CLK", NULL),
+	eseries_get_tmio_gpios();
+	platform_add_devices(ARRAY_AND_SIZE(e750_devices));
+	pxa_set_udc_info(&e7xx_udc_mach_info);
+	pxa_set_ac97_info(NULL);
+	pxa_set_ficp_info(&e7xx_ficp_platform_data);
+}
+
+MACHINE_START(E750, "Toshiba e750")
+	/* Maintainer: Ian Molton (spyro at f2s.com) */
+	.phys_io	= 0x40000000,
+	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
+	.boot_params	= 0xa0000100,
+	.map_io		= pxa_map_io,
+	.init_irq	= pxa25x_init_irq,
+	.fixup		= eseries_fixup,
+	.init_machine	= e750_init,
+	.timer		= &pxa_timer,
+MACHINE_END
+#endif
+
+#ifdef CONFIG_MACH_E800
+/* ------------------------ e800 LCD definitions ------------------------- */
+
+static unsigned long e800_pin_config[] __initdata = {
+	/* AC97 */
+	GPIO28_AC97_BITCLK,
+	GPIO29_AC97_SDATA_IN_0,
+	GPIO30_AC97_SDATA_OUT,
+	GPIO31_AC97_SYNC,
+};
+
+static struct w100_gen_regs e800_lcd_regs = {
+	.lcd_format =            0x00008003,
+	.lcdd_cntl1 =            0x02a00000,
+	.lcdd_cntl2 =            0x0003ffff,
+	.genlcd_cntl1 =          0x000ff2a3,
+	.genlcd_cntl2 =          0x000002a3,
+	.genlcd_cntl3 =          0x000102aa,
+};
+
+static struct w100_mode e800_lcd_mode[2] = {
+	[0] = {
+		.xres            = 480,
+		.yres            = 640,
+		.left_margin     = 52,
+		.right_margin    = 148,
+		.upper_margin    = 2,
+		.lower_margin    = 6,
+		.crtc_ss         = 0x80350034,
+		.crtc_ls         = 0x802b0026,
+		.crtc_gs         = 0x80160016,
+		.crtc_vpos_gs    = 0x00020003,
+		.crtc_rev        = 0x0040001d,
+		.crtc_dclk       = 0xe0000000,
+		.crtc_gclk       = 0x82a50049,
+		.crtc_goe        = 0x80ee001c,
+		.crtc_ps1_active = 0x00000000,
+		.pll_freq        = 128,
+		.pixclk_divider         = 4,
+		.pixclk_divider_rotated = 6,
+		.pixclk_src     = CLK_SRC_PLL,
+		.sysclk_divider  = 0,
+		.sysclk_src     = CLK_SRC_PLL,
+	},
+	[1] = {
+		.xres            = 240,
+		.yres            = 320,
+		.left_margin     = 15,
+		.right_margin    = 88,
+		.upper_margin    = 0,
+		.lower_margin    = 7,
+		.crtc_ss         = 0xd010000f,
+		.crtc_ls         = 0x80070003,
+		.crtc_gs         = 0x80000000,
+		.crtc_vpos_gs    = 0x01460147,
+		.crtc_rev        = 0x00400003,
+		.crtc_dclk       = 0xa1700030,
+		.crtc_gclk       = 0x814b0008,
+		.crtc_goe        = 0x80cc0015,
+		.crtc_ps1_active = 0x00000000,
+		.pll_freq        = 100,
+		.pixclk_divider         = 6, /* Wince uses 14 which gives a */
+		.pixclk_divider_rotated = 6, /* 7MHz Pclk. We use a 14MHz one */
+		.pixclk_src     = CLK_SRC_PLL,
+		.sysclk_divider  = 0,
+		.sysclk_src     = CLK_SRC_PLL,
+	}
+};
+
+
+static struct w100_gpio_regs e800_w100_gpio_info = {
+	.init_data1 = 0xc13fc019,
+	.gpio_dir1  = 0x3e40df7f,
+	.gpio_oe1   = 0x003c3000,
+	.init_data2 = 0x00000000,
+	.gpio_dir2  = 0x00000000,
+	.gpio_oe2   = 0x00000000,
+};
+
+static struct w100_mem_info e800_w100_mem_info = {
+	.ext_cntl        = 0x09640011,
+	.sdram_mode_reg  = 0x00600021,
+	.ext_timing_cntl = 0x10001545,
+	.io_cntl         = 0x7ddd7333,
+	.size            = 0x1fffff,
+};
+
+static void e800_tg_change(struct w100fb_par *par)
+{
+	unsigned long tmp;
+
+	tmp = w100fb_gpio_read(W100_GPIO_PORT_A);
+	if (par->mode->xres == 480)
+		tmp |= 0x100;
+	else
+		tmp &= ~0x100;
+	w100fb_gpio_write(W100_GPIO_PORT_A, tmp);
+}
+
+static struct w100_tg_info e800_tg_info = {
+	.change = e800_tg_change,
+};
+
+static struct w100fb_mach_info e800_fb_info = {
+	.modelist   = e800_lcd_mode,
+	.num_modes  = 2,
+	.regs       = &e800_lcd_regs,
+	.gpio       = &e800_w100_gpio_info,
+	.mem        = &e800_w100_mem_info,
+	.tg         = &e800_tg_info,
+	.xtal_freq  = 16000000,
+};
+
+static struct resource e800_fb_resources[] = {
+	[0] = {
+		.start          = 0x0c000000,
+		.end            = 0x0cffffff,
+		.flags          = IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device e800_fb_device = {
+	.name           = "w100fb",
+	.id             = -1,
+	.dev            = {
+		.platform_data  = &e800_fb_info,
+	},
+	.num_resources  = ARRAY_SIZE(e800_fb_resources),
+	.resource       = e800_fb_resources,
+};
+
+/* --------------------------- UDC definitions --------------------------- */
+
+static struct pxa2xx_udc_mach_info e800_udc_mach_info = {
+	.gpio_vbus   = GPIO_E800_USB_DISC,
+	.gpio_pullup = GPIO_E800_USB_PULLUP,
+	.gpio_pullup_inverted = 1
+};
+
+/* ----------------- e800 tc6393xb parameters ------------------ */
+
+static struct tc6393xb_platform_data e800_tc6393xb_info = {
+	.irq_base       = IRQ_BOARD_START,
+	.scr_pll2cr     = 0x0cc1,
+	.scr_gper       = 0,
+	.gpio_base      = -1,
+	.suspend        = &eseries_tmio_suspend,
+	.resume         = &eseries_tmio_resume,
+	.enable         = &eseries_tmio_enable,
+	.disable        = &eseries_tmio_disable,
+};
+
+static struct platform_device e800_tc6393xb_device = {
+	.name           = "tc6393xb",
+	.id             = -1,
+	.dev            = {
+		.platform_data = &e800_tc6393xb_info,
+	},
+	.num_resources = 2,
+	.resource      = eseries_tmio_resources,
+};
+
+/* ----------------------------------------------------------------------- */
+
+static struct platform_device *e800_devices[] __initdata = {
+	&e800_fb_device,
+	&e800_tc6393xb_device,
+};
+
+static void __init e800_init(void)
+{
+	pxa2xx_mfp_config(ARRAY_AND_SIZE(e800_pin_config));
+	pxa_set_ffuart_info(NULL);
+	pxa_set_btuart_info(NULL);
+	pxa_set_stuart_info(NULL);
+	clk_add_alias("CLK_CK3P6MI", e800_tc6393xb_device.name,
+			"GPIO11_CLK", NULL),
+	eseries_get_tmio_gpios();
+	platform_add_devices(ARRAY_AND_SIZE(e800_devices));
+	pxa_set_udc_info(&e800_udc_mach_info);
+	pxa_set_ac97_info(NULL);
+}
+
+MACHINE_START(E800, "Toshiba e800")
+	/* Maintainer: Ian Molton (spyro at f2s.com) */
+	.phys_io	= 0x40000000,
+	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
+	.boot_params	= 0xa0000100,
+	.map_io		= pxa_map_io,
+	.init_irq	= pxa25x_init_irq,
+	.fixup		= eseries_fixup,
+	.init_machine	= e800_init,
+	.timer		= &pxa_timer,
+MACHINE_END
+#endif
-- 
1.7.1
