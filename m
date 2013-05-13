From: shc_work@mail.ru (Alexander Shiyan)
Date: Mon, 13 May 2013 21:07:29 +0400
Subject: [PATCH 07/15] ARM: clps711x: p720t: Define PLD registers as GPIOs
In-Reply-To: <1368464857-5038-1-git-send-email-shc_work@mail.ru>
References: <1368464857-5038-1-git-send-email-shc_work@mail.ru>
Message-ID: <1368464857-5038-10-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-clps711x/board-p720t.c         | 245 +++++++++++++++++++++------
 arch/arm/mach-clps711x/include/mach/syspld.h | 116 -------------
 2 files changed, 193 insertions(+), 168 deletions(-)
 delete mode 100644 arch/arm/mach-clps711x/include/mach/syspld.h

diff --git a/arch/arm/mach-clps711x/board-p720t.c b/arch/arm/mach-clps711x/board-p720t.c
index 48d0737..601ef38 100644
--- a/arch/arm/mach-clps711x/board-p720t.c
+++ b/arch/arm/mach-clps711x/board-p720t.c
@@ -23,10 +23,12 @@
 #include <linux/string.h>
 #include <linux/mm.h>
 #include <linux/io.h>
+#include <linux/gpio.h>
 #include <linux/slab.h>
 #include <linux/leds.h>
 #include <linux/sizes.h>
 #include <linux/backlight.h>
+#include <linux/basic_mmio_gpio.h>
 #include <linux/platform_device.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/nand-gpio.h>
@@ -38,7 +40,6 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
-#include <mach/syspld.h>
 
 #include <video/platform_lcd.h>
 
@@ -52,6 +53,178 @@
 
 #define P720T_NAND_BASE		(CLPS711X_SDRAM1_BASE)
 
+#define P720T_MMGPIO_BASE	(CLPS711X_NR_GPIO)
+
+#define SYSPLD_PHYS_BASE	IOMEM(CS1_PHYS_BASE)
+
+#define PLD_INT			(SYSPLD_PHYS_BASE + 0x000000)
+#define PLD_INT_MMGPIO_BASE	(P720T_MMGPIO_BASE + 0)
+#define PLD_INT_PENIRQ		(PLD_INT_MMGPIO_BASE + 5)
+#define PLD_INT_UCB_IRQ		(PLD_INT_MMGPIO_BASE + 1)
+#define PLD_INT_KBD_ATN		(PLD_INT_MMGPIO_BASE + 0) /* EINT1 */
+
+#define PLD_PWR			(SYSPLD_PHYS_BASE + 0x000004)
+#define PLD_PWR_MMGPIO_BASE	(P720T_MMGPIO_BASE + 8)
+#define PLD_PWR_EXT		(PLD_PWR_MMGPIO_BASE + 5)
+#define PLD_PWR_MODE		(PLD_PWR_MMGPIO_BASE + 4) /* 1 = PWM, 0 = PFM */
+#define PLD_S4_ON		(PLD_PWR_MMGPIO_BASE + 3) /* LCD bias voltage enable */
+#define PLD_S3_ON		(PLD_PWR_MMGPIO_BASE + 2) /* LCD backlight enable */
+#define PLD_S2_ON		(PLD_PWR_MMGPIO_BASE + 1) /* LCD 3V3 supply enable */
+#define PLD_S1_ON		(PLD_PWR_MMGPIO_BASE + 0) /* LCD 3V supply enable */
+
+#define PLD_KBD			(SYSPLD_PHYS_BASE + 0x000008)
+#define PLD_KBD_MMGPIO_BASE	(P720T_MMGPIO_BASE + 16)
+#define PLD_KBD_WAKE		(PLD_KBD_MMGPIO_BASE + 1)
+#define PLD_KBD_EN		(PLD_KBD_MMGPIO_BASE + 0)
+
+#define PLD_SPI			(SYSPLD_PHYS_BASE + 0x00000c)
+#define PLD_SPI_MMGPIO_BASE	(P720T_MMGPIO_BASE + 24)
+#define PLD_SPI_EN		(PLD_SPI_MMGPIO_BASE + 0)
+
+#define PLD_IO			(SYSPLD_PHYS_BASE + 0x000010)
+#define PLD_IO_MMGPIO_BASE	(P720T_MMGPIO_BASE + 32)
+#define PLD_IO_BOOTSEL		(PLD_IO_MMGPIO_BASE + 6) /* Boot sel switch */
+#define PLD_IO_USER		(PLD_IO_MMGPIO_BASE + 5) /* User defined switch */
+#define PLD_IO_LED3		(PLD_IO_MMGPIO_BASE + 4)
+#define PLD_IO_LED2		(PLD_IO_MMGPIO_BASE + 3)
+#define PLD_IO_LED1		(PLD_IO_MMGPIO_BASE + 2)
+#define PLD_IO_LED0		(PLD_IO_MMGPIO_BASE + 1)
+#define PLD_IO_LEDEN		(PLD_IO_MMGPIO_BASE + 0)
+
+#define PLD_IRDA		(SYSPLD_PHYS_BASE + 0x000014)
+#define PLD_IRDA_MMGPIO_BASE	(P720T_MMGPIO_BASE + 40)
+#define PLD_IRDA_EN		(PLD_IRDA_MMGPIO_BASE + 0)
+
+#define PLD_COM2		(SYSPLD_PHYS_BASE + 0x000018)
+#define PLD_COM2_MMGPIO_BASE	(P720T_MMGPIO_BASE + 48)
+#define PLD_COM2_EN		(PLD_COM2_MMGPIO_BASE + 0)
+
+#define PLD_COM1		(SYSPLD_PHYS_BASE + 0x00001c)
+#define PLD_COM1_MMGPIO_BASE	(P720T_MMGPIO_BASE + 56)
+#define PLD_COM1_EN		(PLD_COM1_MMGPIO_BASE + 0)
+
+#define PLD_AUD			(SYSPLD_PHYS_BASE + 0x000020)
+#define PLD_AUD_MMGPIO_BASE	(P720T_MMGPIO_BASE + 64)
+#define PLD_AUD_DIV1		(PLD_AUD_MMGPIO_BASE + 6)
+#define PLD_AUD_DIV0		(PLD_AUD_MMGPIO_BASE + 5)
+#define PLD_AUD_CLK_SEL1	(PLD_AUD_MMGPIO_BASE + 4)
+#define PLD_AUD_CLK_SEL0	(PLD_AUD_MMGPIO_BASE + 3)
+#define PLD_AUD_MIC_PWR		(PLD_AUD_MMGPIO_BASE + 2)
+#define PLD_AUD_MIC_GAIN	(PLD_AUD_MMGPIO_BASE + 1)
+#define PLD_AUD_CODEC_EN	(PLD_AUD_MMGPIO_BASE + 0)
+
+#define PLD_CF			(SYSPLD_PHYS_BASE + 0x000024)
+#define PLD_CF_MMGPIO_BASE	(P720T_MMGPIO_BASE + 72)
+#define PLD_CF2_SLEEP		(PLD_CF_MMGPIO_BASE + 5)
+#define PLD_CF1_SLEEP		(PLD_CF_MMGPIO_BASE + 4)
+#define PLD_CF2_nPDREQ		(PLD_CF_MMGPIO_BASE + 3)
+#define PLD_CF1_nPDREQ		(PLD_CF_MMGPIO_BASE + 2)
+#define PLD_CF2_nIRQ		(PLD_CF_MMGPIO_BASE + 1)
+#define PLD_CF1_nIRQ		(PLD_CF_MMGPIO_BASE + 0)
+
+#define PLD_SDC			(SYSPLD_PHYS_BASE + 0x000028)
+#define PLD_SDC_MMGPIO_BASE	(P720T_MMGPIO_BASE + 80)
+#define PLD_SDC_INT_EN		(PLD_SDC_MMGPIO_BASE + 2)
+#define PLD_SDC_WP		(PLD_SDC_MMGPIO_BASE + 1)
+#define PLD_SDC_CD		(PLD_SDC_MMGPIO_BASE + 0)
+
+#define PLD_CODEC		(SYSPLD_PHYS_BASE + 0x400000)
+#define PLD_CODEC_MMGPIO_BASE	(P720T_MMGPIO_BASE + 88)
+#define PLD_CODEC_IRQ3		(PLD_CODEC_MMGPIO_BASE + 4)
+#define PLD_CODEC_IRQ2		(PLD_CODEC_MMGPIO_BASE + 3)
+#define PLD_CODEC_IRQ1		(PLD_CODEC_MMGPIO_BASE + 2)
+#define PLD_CODEC_EN		(PLD_CODEC_MMGPIO_BASE + 0)
+
+#define PLD_BRITE		(SYSPLD_PHYS_BASE + 0x400004)
+#define PLD_BRITE_MMGPIO_BASE	(P720T_MMGPIO_BASE + 96)
+#define PLD_BRITE_UP		(PLD_BRITE_MMGPIO_BASE + 1)
+#define PLD_BRITE_DN		(PLD_BRITE_MMGPIO_BASE + 0)
+
+#define PLD_LCDEN		(SYSPLD_PHYS_BASE + 0x400008)
+#define PLD_LCDEN_MMGPIO_BASE	(P720T_MMGPIO_BASE + 104)
+#define PLD_LCDEN_EN		(PLD_LCDEN_MMGPIO_BASE + 0)
+
+#define PLD_TCH			(SYSPLD_PHYS_BASE + 0x400010)
+#define PLD_TCH_MMGPIO_BASE	(P720T_MMGPIO_BASE + 112)
+#define PLD_TCH_PENIRQ		(PLD_TCH_MMGPIO_BASE + 1)
+#define PLD_TCH_EN		(PLD_TCH_MMGPIO_BASE + 0)
+
+#define PLD_GPIO		(SYSPLD_PHYS_BASE + 0x400014)
+#define PLD_GPIO_MMGPIO_BASE	(P720T_MMGPIO_BASE + 120)
+#define PLD_GPIO2		(PLD_GPIO_MMGPIO_BASE + 2)
+#define PLD_GPIO1		(PLD_GPIO_MMGPIO_BASE + 1)
+#define PLD_GPIO0		(PLD_GPIO_MMGPIO_BASE + 0)
+
+static struct gpio p720t_gpios[] __initconst = {
+	{ PLD_S1_ON,	GPIOF_OUT_INIT_LOW,	"PLD_S1_ON" },
+	{ PLD_S2_ON,	GPIOF_OUT_INIT_LOW,	"PLD_S2_ON" },
+	{ PLD_S3_ON,	GPIOF_OUT_INIT_LOW,	"PLD_S3_ON" },
+	{ PLD_S4_ON,	GPIOF_OUT_INIT_LOW,	"PLD_S4_ON" },
+	{ PLD_KBD_EN,	GPIOF_OUT_INIT_LOW,	"PLD_KBD_EN" },
+	{ PLD_SPI_EN,	GPIOF_OUT_INIT_LOW,	"PLD_SPI_EN" },
+	{ PLD_IO_USER,	GPIOF_OUT_INIT_LOW,	"PLD_IO_USER" },
+	{ PLD_IO_LED0,	GPIOF_OUT_INIT_LOW,	"PLD_IO_LED0" },
+	{ PLD_IO_LED1,	GPIOF_OUT_INIT_LOW,	"PLD_IO_LED1" },
+	{ PLD_IO_LED2,	GPIOF_OUT_INIT_LOW,	"PLD_IO_LED2" },
+	{ PLD_IO_LED3,	GPIOF_OUT_INIT_LOW,	"PLD_IO_LED3" },
+	{ PLD_IO_LEDEN,	GPIOF_OUT_INIT_LOW,	"PLD_IO_LEDEN" },
+	{ PLD_IRDA_EN,	GPIOF_OUT_INIT_LOW,	"PLD_IRDA_EN" },
+	{ PLD_COM1_EN,	GPIOF_OUT_INIT_HIGH,	"PLD_COM1_EN" },
+	{ PLD_COM2_EN,	GPIOF_OUT_INIT_HIGH,	"PLD_COM2_EN" },
+	{ PLD_CODEC_EN,	GPIOF_OUT_INIT_LOW,	"PLD_CODEC_EN" },
+	{ PLD_LCDEN_EN,	GPIOF_OUT_INIT_LOW,	"PLD_LCDEN_EN" },
+	{ PLD_TCH_EN,	GPIOF_OUT_INIT_LOW,	"PLD_TCH_EN" },
+	{ P720T_USERLED,GPIOF_OUT_INIT_LOW,	"USER_LED" },
+};
+
+static struct resource p720t_mmgpio_resource[] __initdata = {
+	DEFINE_RES_MEM_NAMED(0, 4, "dat"),
+};
+
+static struct bgpio_pdata p720t_mmgpio_pdata = {
+	.ngpio	= 8,
+};
+
+static struct platform_device p720t_mmgpio __initdata = {
+	.name		= "basic-mmio-gpio",
+	.id		= -1,
+	.resource	= p720t_mmgpio_resource,
+	.num_resources	= ARRAY_SIZE(p720t_mmgpio_resource),
+	.dev		= {
+		.platform_data	= &p720t_mmgpio_pdata,
+	},
+};
+
+static void __init p720t_mmgpio_init(void __iomem *addrbase, int gpiobase)
+{
+	p720t_mmgpio_resource[0].start = (unsigned long)addrbase;
+	p720t_mmgpio_pdata.base = gpiobase;
+
+	platform_device_register(&p720t_mmgpio);
+}
+
+static struct {
+	void __iomem	*addrbase;
+	int		gpiobase;
+} mmgpios[] __initconst = {
+	{ PLD_INT,	PLD_INT_MMGPIO_BASE },
+	{ PLD_PWR,	PLD_PWR_MMGPIO_BASE },
+	{ PLD_KBD,	PLD_KBD_MMGPIO_BASE },
+	{ PLD_SPI,	PLD_SPI_MMGPIO_BASE },
+	{ PLD_IO,	PLD_IO_MMGPIO_BASE },
+	{ PLD_IRDA,	PLD_IRDA_MMGPIO_BASE },
+	{ PLD_COM2,	PLD_COM2_MMGPIO_BASE },
+	{ PLD_COM1,	PLD_COM1_MMGPIO_BASE },
+	{ PLD_AUD,	PLD_AUD_MMGPIO_BASE },
+	{ PLD_CF,	PLD_CF_MMGPIO_BASE },
+	{ PLD_SDC,	PLD_SDC_MMGPIO_BASE },
+	{ PLD_CODEC,	PLD_CODEC_MMGPIO_BASE },
+	{ PLD_BRITE,	PLD_BRITE_MMGPIO_BASE },
+	{ PLD_LCDEN,	PLD_LCDEN_MMGPIO_BASE },
+	{ PLD_TCH,	PLD_TCH_MMGPIO_BASE },
+	{ PLD_GPIO,	PLD_GPIO_MMGPIO_BASE },
+};
+
 static struct resource p720t_nand_resource[] __initdata = {
 	DEFINE_RES_MEM(P720T_NAND_BASE, SZ_4),
 };
@@ -93,11 +266,15 @@ static struct platform_device p720t_nand_pdev __initdata = {
 static void p720t_lcd_power_set(struct plat_lcd_data *pd, unsigned int power)
 {
 	if (power) {
-		PLD_LCDEN = PLD_LCDEN_EN;
-		PLD_PWR |= PLD_S4_ON | PLD_S2_ON | PLD_S1_ON;
+		gpio_set_value(PLD_LCDEN_EN, 1);
+		gpio_set_value(PLD_S1_ON, 1);
+		gpio_set_value(PLD_S2_ON, 1);
+		gpio_set_value(PLD_S4_ON, 1);
 	} else {
-		PLD_PWR &= ~(PLD_S4_ON | PLD_S2_ON | PLD_S1_ON);
-		PLD_LCDEN = 0;
+		gpio_set_value(PLD_S1_ON, 0);
+		gpio_set_value(PLD_S2_ON, 0);
+		gpio_set_value(PLD_S4_ON, 0);
+		gpio_set_value(PLD_LCDEN_EN, 0);
 	}
 }
 
@@ -107,10 +284,7 @@ static struct plat_lcd_data p720t_lcd_power_pdata = {
 
 static void p720t_lcd_backlight_set_intensity(int intensity)
 {
-	if (intensity)
-		PLD_PWR |= PLD_S3_ON;
-	else
-		PLD_PWR = 0;
+	gpio_set_value(PLD_S3_ON, intensity);
 }
 
 static struct generic_bl_info p720t_lcd_backlight_pdata = {
@@ -120,19 +294,6 @@ static struct generic_bl_info p720t_lcd_backlight_pdata = {
 	.set_bl_intensity	= p720t_lcd_backlight_set_intensity,
 };
 
-/*
- * Map the P720T system PLD. It occupies two address spaces:
- * 0x10000000 and 0x10400000. We map both regions as one.
- */
-static struct map_desc p720t_io_desc[] __initdata = {
-	{
-		.virtual	= SYSPLD_VIRT_BASE,
-		.pfn		= __phys_to_pfn(SYSPLD_PHYS_BASE),
-		.length		= SZ_8M,
-		.type		= MT_DEVICE,
-	},
-};
-
 static void __init
 fixup_p720t(struct tag *tag, char **cmdline, struct meminfo *mi)
 {
@@ -158,33 +319,6 @@ fixup_p720t(struct tag *tag, char **cmdline, struct meminfo *mi)
 	}
 }
 
-static void __init p720t_map_io(void)
-{
-	clps711x_map_io();
-	iotable_init(p720t_io_desc, ARRAY_SIZE(p720t_io_desc));
-}
-
-static void __init p720t_init_early(void)
-{
-	/*
-	 * Power down as much as possible in case we don't
-	 * have the drivers loaded.
-	 */
-	PLD_LCDEN = 0;
-	PLD_PWR  &= ~(PLD_S4_ON|PLD_S3_ON|PLD_S2_ON|PLD_S1_ON);
-
-	PLD_KBD   = 0;
-	PLD_IO    = 0;
-	PLD_IRDA  = 0;
-	PLD_CODEC = 0;
-	PLD_TCH   = 0;
-	PLD_SPI   = 0;
-	if (!IS_ENABLED(CONFIG_DEBUG_LL)) {
-		PLD_COM2 = 0;
-		PLD_COM1 = 0;
-	}
-}
-
 static struct gpio_led p720t_gpio_leds[] = {
 	{
 		.name			= "User LED",
@@ -200,12 +334,20 @@ static struct gpio_led_platform_data p720t_gpio_led_pdata __initdata = {
 
 static void __init p720t_init(void)
 {
+	int i;
+
 	clps711x_devices_init();
+
+	for (i = 0; i < ARRAY_SIZE(mmgpios); i++)
+		p720t_mmgpio_init(mmgpios[i].addrbase, mmgpios[i].gpiobase);
+
+	platform_device_register(&p720t_nand_pdev);
 }
 
 static void __init p720t_init_late(void)
 {
-	platform_device_register(&p720t_nand_pdev);
+	WARN_ON(gpio_request_array(p720t_gpios, ARRAY_SIZE(p720t_gpios)));
+
 	platform_device_register_data(&platform_bus, "platform-lcd", 0,
 				      &p720t_lcd_power_pdata,
 				      sizeof(p720t_lcd_power_pdata));
@@ -223,8 +365,7 @@ MACHINE_START(P720T, "ARM-Prospector720T")
 	.atag_offset	= 0x100,
 	.nr_irqs	= CLPS711X_NR_IRQS,
 	.fixup		= fixup_p720t,
-	.map_io		= p720t_map_io,
-	.init_early	= p720t_init_early,
+	.map_io		= clps711x_map_io,
 	.init_irq	= clps711x_init_irq,
 	.init_time	= clps711x_timer_init,
 	.init_machine	= p720t_init,
diff --git a/arch/arm/mach-clps711x/include/mach/syspld.h b/arch/arm/mach-clps711x/include/mach/syspld.h
deleted file mode 100644
index 9a43315..0000000
--- a/arch/arm/mach-clps711x/include/mach/syspld.h
+++ /dev/null
@@ -1,116 +0,0 @@
-/*
- *  arch/arm/mach-clps711x/include/mach/syspld.h
- *
- *  System Control PLD register definitions.
- *
- *  Copyright (C) 2000 Deep Blue Solutions Ltd.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-#ifndef __ASM_ARCH_SYSPLD_H
-#define __ASM_ARCH_SYSPLD_H
-
-#define SYSPLD_PHYS_BASE	(0x10000000)
-#define SYSPLD_VIRT_BASE	IO_ADDRESS(SYSPLD_PHYS_BASE)
-
-#define SYSPLD_REG(type, off)	(*(volatile type *)(SYSPLD_VIRT_BASE + (off)))
-
-#define PLD_INT		SYSPLD_REG(u32, 0x000000)
-#define PLD_INT_PENIRQ		(1 << 5)
-#define PLD_INT_UCB_IRQ		(1 << 1)
-#define PLD_INT_KBD_ATN		(1 << 0)	/* EINT1 */
-
-#define PLD_PWR		SYSPLD_REG(u32, 0x000004)
-#define PLD_PWR_EXT		(1 << 5)
-#define PLD_PWR_MODE		(1 << 4)	/* 1 = PWM, 0 = PFM */
-#define PLD_S4_ON		(1 << 3)	/* LCD bias voltage enable */
-#define PLD_S3_ON		(1 << 2)	/* LCD backlight enable */
-#define PLD_S2_ON		(1 << 1)	/* LCD 3V3 supply enable */
-#define PLD_S1_ON		(1 << 0)	/* LCD 3V supply enable */
-
-#define PLD_KBD		SYSPLD_REG(u32, 0x000008)
-#define PLD_KBD_WAKE		(1 << 1)
-#define PLD_KBD_EN		(1 << 0)
-
-#define PLD_SPI		SYSPLD_REG(u32, 0x00000c)
-#define PLD_SPI_EN		(1 << 0)
-
-#define PLD_IO		SYSPLD_REG(u32, 0x000010)
-#define PLD_IO_BOOTSEL		(1 << 6)	/* boot sel switch */
-#define PLD_IO_USER		(1 << 5)	/* user defined switch */
-#define PLD_IO_LED3		(1 << 4)
-#define PLD_IO_LED2		(1 << 3)
-#define PLD_IO_LED1		(1 << 2)
-#define PLD_IO_LED0		(1 << 1)
-#define PLD_IO_LEDEN		(1 << 0)
-
-#define PLD_IRDA	SYSPLD_REG(u32, 0x000014)
-#define PLD_IRDA_EN		(1 << 0)
-
-#define PLD_COM2	SYSPLD_REG(u32, 0x000018)
-#define PLD_COM2_EN		(1 << 0)
-
-#define PLD_COM1	SYSPLD_REG(u32, 0x00001c)
-#define PLD_COM1_EN		(1 << 0)
-
-#define PLD_AUD		SYSPLD_REG(u32, 0x000020)
-#define PLD_AUD_DIV1		(1 << 6)
-#define PLD_AUD_DIV0		(1 << 5)
-#define PLD_AUD_CLK_SEL1	(1 << 4)
-#define PLD_AUD_CLK_SEL0	(1 << 3)
-#define PLD_AUD_MIC_PWR		(1 << 2)
-#define PLD_AUD_MIC_GAIN	(1 << 1)
-#define PLD_AUD_CODEC_EN	(1 << 0)
-
-#define PLD_CF		SYSPLD_REG(u32, 0x000024)
-#define PLD_CF2_SLEEP		(1 << 5)
-#define PLD_CF1_SLEEP		(1 << 4)
-#define PLD_CF2_nPDREQ		(1 << 3)
-#define PLD_CF1_nPDREQ		(1 << 2)
-#define PLD_CF2_nIRQ		(1 << 1)
-#define PLD_CF1_nIRQ		(1 << 0)
-
-#define PLD_SDC		SYSPLD_REG(u32, 0x000028)
-#define PLD_SDC_INT_EN		(1 << 2)
-#define PLD_SDC_WP		(1 << 1)
-#define PLD_SDC_CD		(1 << 0)
-
-#define PLD_FPGA	SYSPLD_REG(u32, 0x00002c)
-
-#define PLD_CODEC	SYSPLD_REG(u32, 0x400000)
-#define PLD_CODEC_IRQ3		(1 << 4)
-#define PLD_CODEC_IRQ2		(1 << 3)
-#define PLD_CODEC_IRQ1		(1 << 2)
-#define PLD_CODEC_EN		(1 << 0)
-
-#define PLD_BRITE	SYSPLD_REG(u32, 0x400004)
-#define PLD_BRITE_UP		(1 << 1)
-#define PLD_BRITE_DN		(1 << 0)
-
-#define PLD_LCDEN	SYSPLD_REG(u32, 0x400008)
-#define PLD_LCDEN_EN		(1 << 0)
-
-#define PLD_ID		SYSPLD_REG(u32, 0x40000c)
-
-#define PLD_TCH		SYSPLD_REG(u32, 0x400010)
-#define PLD_TCH_PENIRQ		(1 << 1)
-#define PLD_TCH_EN		(1 << 0)
-
-#define PLD_GPIO	SYSPLD_REG(u32, 0x400014)
-#define PLD_GPIO2		(1 << 2)
-#define PLD_GPIO1		(1 << 1)
-#define PLD_GPIO0		(1 << 0)
-
-#endif
-- 
1.8.1.5
