From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 12 May 2014 00:11:30 +0200
Subject: [PATCH v3 9/9] ARM: S3C24XX: remove legacy clock code
In-Reply-To: <3427359.fjFAW0MSIR@phil>
References: <3427359.fjFAW0MSIR@phil>
Message-ID: <1893884.JnUtRi3rpi@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the move to the common clock framework completed for s3c2410, s3c2440
and s3c2442, the legacy clock code for these machines can go away too.

This also includes the legacy dclk code, as all legacy users are converted.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Tomasz Figa <t.figa@samsung.com>
---
 arch/arm/mach-s3c24xx/Kconfig                   |  11 -
 arch/arm/mach-s3c24xx/Makefile                  |   2 -
 arch/arm/mach-s3c24xx/clock-dclk.c              | 195 ----------------
 arch/arm/mach-s3c24xx/clock-s3c2410.c           | 284 ------------------------
 arch/arm/mach-s3c24xx/clock-s3c2440.c           | 217 ------------------
 arch/arm/mach-s3c24xx/clock-s3c244x.c           | 141 ------------
 arch/arm/mach-s3c24xx/common.h                  |   2 -
 arch/arm/mach-s3c24xx/include/mach/regs-clock.h |  18 --
 arch/arm/mach-s3c24xx/include/mach/regs-gpio.h  |   3 -
 arch/arm/mach-s3c24xx/pm.c                      |  12 -
 arch/arm/mach-s3c24xx/s3c2410.c                 |  62 ------
 arch/arm/mach-s3c24xx/s3c2442.c                 | 112 ----------
 arch/arm/mach-s3c24xx/s3c244x.c                 |  63 ------
 13 files changed, 1122 deletions(-)
 delete mode 100644 arch/arm/mach-s3c24xx/clock-dclk.c
 delete mode 100644 arch/arm/mach-s3c24xx/clock-s3c2410.c
 delete mode 100644 arch/arm/mach-s3c24xx/clock-s3c2440.c
 delete mode 100644 arch/arm/mach-s3c24xx/clock-s3c244x.c

diff --git a/arch/arm/mach-s3c24xx/Kconfig b/arch/arm/mach-s3c24xx/Kconfig
index 82602dc..93dc265 100644
--- a/arch/arm/mach-s3c24xx/Kconfig
+++ b/arch/arm/mach-s3c24xx/Kconfig
@@ -110,17 +110,6 @@ config CPU_S3C2443
 
 # common code
 
-config S3C2410_CLOCK
-	bool
-	help
-	  Clock code for the S3C2410, and similar processors which
-	  is currently includes the S3C2410, S3C2440, S3C2442.
-
-config S3C24XX_DCLK
-	bool
-	help
-	  Clock code for supporting DCLK/CLKOUT on S3C24XX architectures
-
 config S3C24XX_SMDK
 	bool
 	help
diff --git a/arch/arm/mach-s3c24xx/Makefile b/arch/arm/mach-s3c24xx/Makefile
index 9010eba..2235d0d 100644
--- a/arch/arm/mach-s3c24xx/Makefile
+++ b/arch/arm/mach-s3c24xx/Makefile
@@ -44,10 +44,8 @@ obj-$(CONFIG_PM)		+= pm.o irq-pm.o sleep.o
 
 # common code
 
-obj-$(CONFIG_S3C24XX_DCLK)	+= clock-dclk.o
 obj-$(CONFIG_S3C24XX_DMA)	+= dma.o
 
-obj-$(CONFIG_S3C2410_CLOCK)	+= clock-s3c2410.o
 obj-$(CONFIG_S3C2410_CPUFREQ_UTILS) += cpufreq-utils.o
 
 obj-$(CONFIG_S3C2410_IOTIMING)	+= iotiming-s3c2410.o
diff --git a/arch/arm/mach-s3c24xx/clock-dclk.c b/arch/arm/mach-s3c24xx/clock-dclk.c
deleted file mode 100644
index 1edd9b2..0000000
--- a/arch/arm/mach-s3c24xx/clock-dclk.c
+++ /dev/null
@@ -1,195 +0,0 @@
-/*
- * Copyright (c) 2004-2008 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *	http://armlinux.simtec.co.uk/
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * S3C24XX - definitions for DCLK and CLKOUT registers
- */
-
-#include <linux/kernel.h>
-#include <linux/errno.h>
-#include <linux/clk.h>
-#include <linux/io.h>
-
-#include <mach/regs-clock.h>
-#include <mach/regs-gpio.h>
-
-#include <plat/clock.h>
-#include <plat/cpu.h>
-
-/* clocks that could be registered by external code */
-
-static int s3c24xx_dclk_enable(struct clk *clk, int enable)
-{
-	unsigned long dclkcon = __raw_readl(S3C24XX_DCLKCON);
-
-	if (enable)
-		dclkcon |= clk->ctrlbit;
-	else
-		dclkcon &= ~clk->ctrlbit;
-
-	__raw_writel(dclkcon, S3C24XX_DCLKCON);
-
-	return 0;
-}
-
-static int s3c24xx_dclk_setparent(struct clk *clk, struct clk *parent)
-{
-	unsigned long dclkcon;
-	unsigned int uclk;
-
-	if (parent == &clk_upll)
-		uclk = 1;
-	else if (parent == &clk_p)
-		uclk = 0;
-	else
-		return -EINVAL;
-
-	clk->parent = parent;
-
-	dclkcon = __raw_readl(S3C24XX_DCLKCON);
-
-	if (clk->ctrlbit == S3C2410_DCLKCON_DCLK0EN) {
-		if (uclk)
-			dclkcon |= S3C2410_DCLKCON_DCLK0_UCLK;
-		else
-			dclkcon &= ~S3C2410_DCLKCON_DCLK0_UCLK;
-	} else {
-		if (uclk)
-			dclkcon |= S3C2410_DCLKCON_DCLK1_UCLK;
-		else
-			dclkcon &= ~S3C2410_DCLKCON_DCLK1_UCLK;
-	}
-
-	__raw_writel(dclkcon, S3C24XX_DCLKCON);
-
-	return 0;
-}
-static unsigned long s3c24xx_calc_div(struct clk *clk, unsigned long rate)
-{
-	unsigned long div;
-
-	if ((rate == 0) || !clk->parent)
-		return 0;
-
-	div = clk_get_rate(clk->parent) / rate;
-	if (div < 2)
-		div = 2;
-	else if (div > 16)
-		div = 16;
-
-	return div;
-}
-
-static unsigned long s3c24xx_round_dclk_rate(struct clk *clk,
-	unsigned long rate)
-{
-	unsigned long div = s3c24xx_calc_div(clk, rate);
-
-	if (div == 0)
-		return 0;
-
-	return clk_get_rate(clk->parent) / div;
-}
-
-static int s3c24xx_set_dclk_rate(struct clk *clk, unsigned long rate)
-{
-	unsigned long mask, data, div = s3c24xx_calc_div(clk, rate);
-
-	if (div == 0)
-		return -EINVAL;
-
-	if (clk == &s3c24xx_dclk0) {
-		mask = S3C2410_DCLKCON_DCLK0_DIV_MASK |
-			S3C2410_DCLKCON_DCLK0_CMP_MASK;
-		data = S3C2410_DCLKCON_DCLK0_DIV(div) |
-			S3C2410_DCLKCON_DCLK0_CMP((div + 1) / 2);
-	} else if (clk == &s3c24xx_dclk1) {
-		mask = S3C2410_DCLKCON_DCLK1_DIV_MASK |
-			S3C2410_DCLKCON_DCLK1_CMP_MASK;
-		data = S3C2410_DCLKCON_DCLK1_DIV(div) |
-			S3C2410_DCLKCON_DCLK1_CMP((div + 1) / 2);
-	} else
-		return -EINVAL;
-
-	clk->rate = clk_get_rate(clk->parent) / div;
-	__raw_writel(((__raw_readl(S3C24XX_DCLKCON) & ~mask) | data),
-		S3C24XX_DCLKCON);
-	return clk->rate;
-}
-static int s3c24xx_clkout_setparent(struct clk *clk, struct clk *parent)
-{
-	unsigned long mask;
-	unsigned long source;
-
-	/* calculate the MISCCR setting for the clock */
-
-	if (parent == &clk_mpll)
-		source = S3C2410_MISCCR_CLK0_MPLL;
-	else if (parent == &clk_upll)
-		source = S3C2410_MISCCR_CLK0_UPLL;
-	else if (parent == &clk_f)
-		source = S3C2410_MISCCR_CLK0_FCLK;
-	else if (parent == &clk_h)
-		source = S3C2410_MISCCR_CLK0_HCLK;
-	else if (parent == &clk_p)
-		source = S3C2410_MISCCR_CLK0_PCLK;
-	else if (clk == &s3c24xx_clkout0 && parent == &s3c24xx_dclk0)
-		source = S3C2410_MISCCR_CLK0_DCLK0;
-	else if (clk == &s3c24xx_clkout1 && parent == &s3c24xx_dclk1)
-		source = S3C2410_MISCCR_CLK0_DCLK0;
-	else
-		return -EINVAL;
-
-	clk->parent = parent;
-
-	if (clk == &s3c24xx_clkout0)
-		mask = S3C2410_MISCCR_CLK0_MASK;
-	else {
-		source <<= 4;
-		mask = S3C2410_MISCCR_CLK1_MASK;
-	}
-
-	s3c2410_modify_misccr(mask, source);
-	return 0;
-}
-
-/* external clock definitions */
-
-static struct clk_ops dclk_ops = {
-	.set_parent	= s3c24xx_dclk_setparent,
-	.set_rate	= s3c24xx_set_dclk_rate,
-	.round_rate	= s3c24xx_round_dclk_rate,
-};
-
-struct clk s3c24xx_dclk0 = {
-	.name		= "dclk0",
-	.ctrlbit	= S3C2410_DCLKCON_DCLK0EN,
-	.enable	        = s3c24xx_dclk_enable,
-	.ops		= &dclk_ops,
-};
-
-struct clk s3c24xx_dclk1 = {
-	.name		= "dclk1",
-	.ctrlbit	= S3C2410_DCLKCON_DCLK1EN,
-	.enable		= s3c24xx_dclk_enable,
-	.ops		= &dclk_ops,
-};
-
-static struct clk_ops clkout_ops = {
-	.set_parent	= s3c24xx_clkout_setparent,
-};
-
-struct clk s3c24xx_clkout0 = {
-	.name		= "clkout0",
-	.ops		= &clkout_ops,
-};
-
-struct clk s3c24xx_clkout1 = {
-	.name		= "clkout1",
-	.ops		= &clkout_ops,
-};
diff --git a/arch/arm/mach-s3c24xx/clock-s3c2410.c b/arch/arm/mach-s3c24xx/clock-s3c2410.c
deleted file mode 100644
index d1afcf9..0000000
--- a/arch/arm/mach-s3c24xx/clock-s3c2410.c
+++ /dev/null
@@ -1,284 +0,0 @@
-/*
- * Copyright (c) 2006 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * S3C2410,S3C2440,S3C2442 Clock control support
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
-*/
-
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/list.h>
-#include <linux/errno.h>
-#include <linux/err.h>
-#include <linux/device.h>
-#include <linux/clk.h>
-#include <linux/mutex.h>
-#include <linux/delay.h>
-#include <linux/serial_core.h>
-#include <linux/serial_s3c.h>
-#include <linux/io.h>
-
-#include <asm/mach/map.h>
-
-#include <mach/hardware.h>
-#include <mach/regs-clock.h>
-#include <mach/regs-gpio.h>
-
-#include <plat/clock.h>
-#include <plat/cpu.h>
-
-int s3c2410_clkcon_enable(struct clk *clk, int enable)
-{
-	unsigned int clocks = clk->ctrlbit;
-	unsigned long clkcon;
-
-	clkcon = __raw_readl(S3C2410_CLKCON);
-
-	if (enable)
-		clkcon |= clocks;
-	else
-		clkcon &= ~clocks;
-
-	/* ensure none of the special function bits set */
-	clkcon &= ~(S3C2410_CLKCON_IDLE|S3C2410_CLKCON_POWER);
-
-	__raw_writel(clkcon, S3C2410_CLKCON);
-
-	return 0;
-}
-
-static int s3c2410_upll_enable(struct clk *clk, int enable)
-{
-	unsigned long clkslow = __raw_readl(S3C2410_CLKSLOW);
-	unsigned long orig = clkslow;
-
-	if (enable)
-		clkslow &= ~S3C2410_CLKSLOW_UCLK_OFF;
-	else
-		clkslow |= S3C2410_CLKSLOW_UCLK_OFF;
-
-	__raw_writel(clkslow, S3C2410_CLKSLOW);
-
-	/* if we started the UPLL, then allow to settle */
-
-	if (enable && (orig & S3C2410_CLKSLOW_UCLK_OFF))
-		udelay(200);
-
-	return 0;
-}
-
-/* standard clock definitions */
-
-static struct clk init_clocks_off[] = {
-	{
-		.name		= "nand",
-		.parent		= &clk_h,
-		.enable		= s3c2410_clkcon_enable,
-		.ctrlbit	= S3C2410_CLKCON_NAND,
-	}, {
-		.name		= "sdi",
-		.parent		= &clk_p,
-		.enable		= s3c2410_clkcon_enable,
-		.ctrlbit	= S3C2410_CLKCON_SDI,
-	}, {
-		.name		= "adc",
-		.parent		= &clk_p,
-		.enable		= s3c2410_clkcon_enable,
-		.ctrlbit	= S3C2410_CLKCON_ADC,
-	}, {
-		.name		= "i2c",
-		.parent		= &clk_p,
-		.enable		= s3c2410_clkcon_enable,
-		.ctrlbit	= S3C2410_CLKCON_IIC,
-	}, {
-		.name		= "iis",
-		.parent		= &clk_p,
-		.enable		= s3c2410_clkcon_enable,
-		.ctrlbit	= S3C2410_CLKCON_IIS,
-	}, {
-		.name		= "spi",
-		.parent		= &clk_p,
-		.enable		= s3c2410_clkcon_enable,
-		.ctrlbit	= S3C2410_CLKCON_SPI,
-	}
-};
-
-static struct clk clk_lcd = {
-	.name		= "lcd",
-	.parent		= &clk_h,
-	.enable		= s3c2410_clkcon_enable,
-	.ctrlbit	= S3C2410_CLKCON_LCDC,
-};
-
-static struct clk clk_gpio = {
-	.name		= "gpio",
-	.parent		= &clk_p,
-	.enable		= s3c2410_clkcon_enable,
-	.ctrlbit	= S3C2410_CLKCON_GPIO,
-};
-
-static struct clk clk_usb_host = {
-	.name		= "usb-host",
-	.parent		= &clk_h,
-	.enable		= s3c2410_clkcon_enable,
-	.ctrlbit	= S3C2410_CLKCON_USBH,
-};
-
-static struct clk clk_usb_device = {
-	.name		= "usb-device",
-	.parent		= &clk_h,
-	.enable		= s3c2410_clkcon_enable,
-	.ctrlbit	= S3C2410_CLKCON_USBD,
-};
-
-static struct clk clk_timers = {
-	.name		= "timers",
-	.parent		= &clk_p,
-	.enable		= s3c2410_clkcon_enable,
-	.ctrlbit	= S3C2410_CLKCON_PWMT,
-};
-
-struct clk s3c24xx_clk_uart0 = {
-	.name		= "uart",
-	.devname	= "s3c2410-uart.0",
-	.parent		= &clk_p,
-	.enable		= s3c2410_clkcon_enable,
-	.ctrlbit	= S3C2410_CLKCON_UART0,
-};
-
-struct clk s3c24xx_clk_uart1 = {
-	.name		= "uart",
-	.devname	= "s3c2410-uart.1",
-	.parent		= &clk_p,
-	.enable		= s3c2410_clkcon_enable,
-	.ctrlbit	= S3C2410_CLKCON_UART1,
-};
-
-struct clk s3c24xx_clk_uart2 = {
-	.name		= "uart",
-	.devname	= "s3c2410-uart.2",
-	.parent		= &clk_p,
-	.enable		= s3c2410_clkcon_enable,
-	.ctrlbit	= S3C2410_CLKCON_UART2,
-};
-
-static struct clk clk_rtc = {
-	.name		= "rtc",
-	.parent		= &clk_p,
-	.enable		= s3c2410_clkcon_enable,
-	.ctrlbit	= S3C2410_CLKCON_RTC,
-};
-
-static struct clk clk_watchdog = {
-	.name		= "watchdog",
-	.parent		= &clk_p,
-	.ctrlbit	= 0,
-};
-
-static struct clk clk_usb_bus_host = {
-	.name		= "usb-bus-host",
-	.parent		= &clk_usb_bus,
-};
-
-static struct clk clk_usb_bus_gadget = {
-	.name		= "usb-bus-gadget",
-	.parent		= &clk_usb_bus,
-};
-
-static struct clk *init_clocks[] = {
-	&clk_lcd,
-	&clk_gpio,
-	&clk_usb_host,
-	&clk_usb_device,
-	&clk_timers,
-	&s3c24xx_clk_uart0,
-	&s3c24xx_clk_uart1,
-	&s3c24xx_clk_uart2,
-	&clk_rtc,
-	&clk_watchdog,
-	&clk_usb_bus_host,
-	&clk_usb_bus_gadget,
-};
-
-/* s3c2410_baseclk_add()
- *
- * Add all the clocks used by the s3c2410 or compatible CPUs
- * such as the S3C2440 and S3C2442.
- *
- * We cannot use a system device as we are needed before any
- * of the init-calls that initialise the devices are actually
- * done.
-*/
-
-int __init s3c2410_baseclk_add(void)
-{
-	unsigned long clkslow = __raw_readl(S3C2410_CLKSLOW);
-	unsigned long clkcon  = __raw_readl(S3C2410_CLKCON);
-	struct clk *xtal;
-	int ret;
-	int ptr;
-
-	clk_upll.enable = s3c2410_upll_enable;
-
-	if (s3c24xx_register_clock(&clk_usb_bus) < 0)
-		printk(KERN_ERR "failed to register usb bus clock\n");
-
-	/* register clocks from clock array */
-
-	for (ptr = 0; ptr < ARRAY_SIZE(init_clocks); ptr++) {
-		struct clk *clkp = init_clocks[ptr];
-
-		/* ensure that we note the clock state */
-
-		clkp->usage = clkcon & clkp->ctrlbit ? 1 : 0;
-
-		ret = s3c24xx_register_clock(clkp);
-		if (ret < 0) {
-			printk(KERN_ERR "Failed to register clock %s (%d)\n",
-			       clkp->name, ret);
-		}
-	}
-
-	/* We must be careful disabling the clocks we are not intending to
-	 * be using at boot time, as subsystems such as the LCD which do
-	 * their own DMA requests to the bus can cause the system to lockup
-	 * if they where in the middle of requesting bus access.
-	 *
-	 * Disabling the LCD clock if the LCD is active is very dangerous,
-	 * and therefore the bootloader should be careful to not enable
-	 * the LCD clock if it is not needed.
-	*/
-
-	/* install (and disable) the clocks we do not need immediately */
-
-	s3c_register_clocks(init_clocks_off, ARRAY_SIZE(init_clocks_off));
-	s3c_disable_clocks(init_clocks_off, ARRAY_SIZE(init_clocks_off));
-
-	/* show the clock-slow value */
-
-	xtal = clk_get(NULL, "xtal");
-
-	printk("CLOCK: Slow mode (%ld.%ld MHz), %s, MPLL %s, UPLL %s\n",
-	       print_mhz(clk_get_rate(xtal) /
-			 ( 2 * S3C2410_CLKSLOW_GET_SLOWVAL(clkslow))),
-	       (clkslow & S3C2410_CLKSLOW_SLOW) ? "slow" : "fast",
-	       (clkslow & S3C2410_CLKSLOW_MPLL_OFF) ? "off" : "on",
-	       (clkslow & S3C2410_CLKSLOW_UCLK_OFF) ? "off" : "on");
-
-	return 0;
-}
diff --git a/arch/arm/mach-s3c24xx/clock-s3c2440.c b/arch/arm/mach-s3c24xx/clock-s3c2440.c
deleted file mode 100644
index 5527226..0000000
--- a/arch/arm/mach-s3c24xx/clock-s3c2440.c
+++ /dev/null
@@ -1,217 +0,0 @@
-/* linux/arch/arm/mach-s3c2440/clock.c
- *
- * Copyright (c) 2004-2005 Simtec Electronics
- *	http://armlinux.simtec.co.uk/
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * S3C2440 Clock support
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
-*/
-
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/list.h>
-#include <linux/errno.h>
-#include <linux/err.h>
-#include <linux/device.h>
-#include <linux/interrupt.h>
-#include <linux/ioport.h>
-#include <linux/mutex.h>
-#include <linux/clk.h>
-#include <linux/io.h>
-#include <linux/serial_core.h>
-#include <linux/serial_s3c.h>
-
-#include <mach/hardware.h>
-#include <linux/atomic.h>
-#include <asm/irq.h>
-
-#include <mach/regs-clock.h>
-
-#include <plat/clock.h>
-#include <plat/cpu.h>
-
-/* S3C2440 extended clock support */
-
-static unsigned long s3c2440_camif_upll_round(struct clk *clk,
-					      unsigned long rate)
-{
-	unsigned long parent_rate = clk_get_rate(clk->parent);
-	int div;
-
-	if (rate > parent_rate)
-		return parent_rate;
-
-	/* note, we remove the +/- 1 calculations for the divisor */
-
-	div = (parent_rate / rate) / 2;
-
-	if (div < 1)
-		div = 1;
-	else if (div > 16)
-		div = 16;
-
-	return parent_rate / (div * 2);
-}
-
-static int s3c2440_camif_upll_setrate(struct clk *clk, unsigned long rate)
-{
-	unsigned long parent_rate = clk_get_rate(clk->parent);
-	unsigned long camdivn =  __raw_readl(S3C2440_CAMDIVN);
-
-	rate = s3c2440_camif_upll_round(clk, rate);
-
-	camdivn &= ~(S3C2440_CAMDIVN_CAMCLK_SEL | S3C2440_CAMDIVN_CAMCLK_MASK);
-
-	if (rate != parent_rate) {
-		camdivn |= S3C2440_CAMDIVN_CAMCLK_SEL;
-		camdivn |= (((parent_rate / rate) / 2) - 1);
-	}
-
-	__raw_writel(camdivn, S3C2440_CAMDIVN);
-
-	return 0;
-}
-
-static unsigned long s3c2440_camif_upll_getrate(struct clk *clk)
-{
-	unsigned long parent_rate = clk_get_rate(clk->parent);
-	unsigned long camdivn =  __raw_readl(S3C2440_CAMDIVN);
-
-	if (!(camdivn & S3C2440_CAMDIVN_CAMCLK_SEL))
-		return parent_rate;
-
-	camdivn &= S3C2440_CAMDIVN_CAMCLK_MASK;
-
-	return parent_rate / (camdivn + 1) / 2;
-}
-
-/* Extra S3C2440 clocks */
-
-static struct clk s3c2440_clk_cam = {
-	.name		= "camif",
-	.enable		= s3c2410_clkcon_enable,
-	.ctrlbit	= S3C2440_CLKCON_CAMERA,
-};
-
-static struct clk s3c2440_clk_cam_upll = {
-	.name		= "camif-upll",
-	.ops		= &(struct clk_ops) {
-		.set_rate	= s3c2440_camif_upll_setrate,
-		.get_rate	= s3c2440_camif_upll_getrate,
-		.round_rate	= s3c2440_camif_upll_round,
-	},
-};
-
-static struct clk s3c2440_clk_ac97 = {
-	.name		= "ac97",
-	.enable		= s3c2410_clkcon_enable,
-	.ctrlbit	= S3C2440_CLKCON_AC97,
-};
-
-#define S3C24XX_VA_UART0      (S3C_VA_UART)
-#define S3C24XX_VA_UART1      (S3C_VA_UART + 0x4000 )
-#define S3C24XX_VA_UART2      (S3C_VA_UART + 0x8000 )
-#define S3C24XX_VA_UART3      (S3C_VA_UART + 0xC000 )
-
-static unsigned long  s3c2440_fclk_n_getrate(struct clk *clk)
-{
-	unsigned long ucon0, ucon1, ucon2, divisor;
-
-	/* the fun of calculating the uart divisors on the s3c2440 */
-	ucon0 = __raw_readl(S3C24XX_VA_UART0 + S3C2410_UCON);
-	ucon1 = __raw_readl(S3C24XX_VA_UART1 + S3C2410_UCON);
-	ucon2 = __raw_readl(S3C24XX_VA_UART2 + S3C2410_UCON);
-
-	ucon0 &= S3C2440_UCON0_DIVMASK;
-	ucon1 &= S3C2440_UCON1_DIVMASK;
-	ucon2 &= S3C2440_UCON2_DIVMASK;
-
-	if (ucon0 != 0)
-		divisor = (ucon0 >> S3C2440_UCON_DIVSHIFT) + 6;
-	else if (ucon1 != 0)
-		divisor = (ucon1 >> S3C2440_UCON_DIVSHIFT) + 21;
-	else if (ucon2 != 0)
-		divisor = (ucon2 >> S3C2440_UCON_DIVSHIFT) + 36;
-	else
-		/* manual calims 44, seems to be 9 */
-		divisor = 9;
-
-	return clk_get_rate(clk->parent) / divisor;
-}
-
-static struct clk s3c2440_clk_fclk_n = {
-	.name		= "fclk_n",
-	.parent		= &clk_f,
-	.ops		= &(struct clk_ops) {
-		.get_rate	= s3c2440_fclk_n_getrate,
-	},
-};
-
-static struct clk_lookup s3c2440_clk_lookup[] = {
-	CLKDEV_INIT(NULL, "clk_uart_baud1", &s3c24xx_uclk),
-	CLKDEV_INIT(NULL, "clk_uart_baud2", &clk_p),
-	CLKDEV_INIT(NULL, "clk_uart_baud3", &s3c2440_clk_fclk_n),
-	CLKDEV_INIT("s3c2440-uart.0", "uart", &s3c24xx_clk_uart0),
-	CLKDEV_INIT("s3c2440-uart.1", "uart", &s3c24xx_clk_uart1),
-	CLKDEV_INIT("s3c2440-uart.2", "uart", &s3c24xx_clk_uart2),
-	CLKDEV_INIT("s3c2440-camif", "camera", &s3c2440_clk_cam_upll),
-};
-
-static int __init_refok s3c2440_clk_add(struct device *dev, struct subsys_interface *sif)
-{
-	struct clk *clock_upll;
-	struct clk *clock_h;
-	struct clk *clock_p;
-
-	clock_p = clk_get(NULL, "pclk");
-	clock_h = clk_get(NULL, "hclk");
-	clock_upll = clk_get(NULL, "upll");
-
-	if (IS_ERR(clock_p) || IS_ERR(clock_h) || IS_ERR(clock_upll)) {
-		printk(KERN_ERR "S3C2440: Failed to get parent clocks\n");
-		return -EINVAL;
-	}
-
-	s3c2440_clk_cam.parent = clock_h;
-	s3c2440_clk_ac97.parent = clock_p;
-	s3c2440_clk_cam_upll.parent = clock_upll;
-	s3c24xx_register_clock(&s3c2440_clk_fclk_n);
-
-	s3c24xx_register_clock(&s3c2440_clk_ac97);
-	s3c24xx_register_clock(&s3c2440_clk_cam);
-	s3c24xx_register_clock(&s3c2440_clk_cam_upll);
-	clkdev_add_table(s3c2440_clk_lookup, ARRAY_SIZE(s3c2440_clk_lookup));
-
-	clk_disable(&s3c2440_clk_ac97);
-	clk_disable(&s3c2440_clk_cam);
-
-	return 0;
-}
-
-static struct subsys_interface s3c2440_clk_interface = {
-	.name		= "s3c2440_clk",
-	.subsys		= &s3c2440_subsys,
-	.add_dev	= s3c2440_clk_add,
-};
-
-static __init int s3c24xx_clk_init(void)
-{
-	return subsys_interface_register(&s3c2440_clk_interface);
-}
-
-arch_initcall(s3c24xx_clk_init);
diff --git a/arch/arm/mach-s3c24xx/clock-s3c244x.c b/arch/arm/mach-s3c24xx/clock-s3c244x.c
deleted file mode 100644
index 6d9b688..0000000
--- a/arch/arm/mach-s3c24xx/clock-s3c244x.c
+++ /dev/null
@@ -1,141 +0,0 @@
-/* linux/arch/arm/plat-s3c24xx/s3c24xx-clock.c
- *
- * Copyright (c) 2004-2008 Simtec Electronics
- *	http://armlinux.simtec.co.uk/
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * S3C2440/S3C2442 Common clock support
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
-*/
-
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/list.h>
-#include <linux/errno.h>
-#include <linux/err.h>
-#include <linux/device.h>
-#include <linux/interrupt.h>
-#include <linux/ioport.h>
-#include <linux/clk.h>
-#include <linux/io.h>
-
-#include <mach/hardware.h>
-#include <linux/atomic.h>
-#include <asm/irq.h>
-
-#include <mach/regs-clock.h>
-
-#include <plat/clock.h>
-#include <plat/cpu.h>
-
-static int s3c2440_setparent_armclk(struct clk *clk, struct clk *parent)
-{
-	unsigned long camdivn;
-	unsigned long dvs;
-
-	if (parent == &clk_f)
-		dvs = 0;
-	else if (parent == &clk_h)
-		dvs = S3C2440_CAMDIVN_DVSEN;
-	else
-		return -EINVAL;
-
-	clk->parent = parent;
-
-	camdivn  = __raw_readl(S3C2440_CAMDIVN);
-	camdivn &= ~S3C2440_CAMDIVN_DVSEN;
-	camdivn |= dvs;
-	__raw_writel(camdivn, S3C2440_CAMDIVN);
-
-	return 0;
-}
-
-static struct clk clk_arm = {
-	.name		= "armclk",
-	.id		= -1,
-	.ops		= &(struct clk_ops) {
-		.set_parent	= s3c2440_setparent_armclk,
-	},
-};
-
-static int s3c244x_clk_add(struct device *dev, struct subsys_interface *sif)
-{
-	unsigned long camdivn = __raw_readl(S3C2440_CAMDIVN);
-	unsigned long clkdivn;
-	struct clk *clock_upll;
-	int ret;
-
-	printk("S3C244X: Clock Support, DVS %s\n",
-	       (camdivn & S3C2440_CAMDIVN_DVSEN) ? "on" : "off");
-
-	clk_arm.parent = (camdivn & S3C2440_CAMDIVN_DVSEN) ? &clk_h : &clk_f;
-
-	ret = s3c24xx_register_clock(&clk_arm);
-	if (ret < 0) {
-		printk(KERN_ERR "S3C24XX: Failed to add armclk (%d)\n", ret);
-		return ret;
-	}
-
-	clock_upll = clk_get(NULL, "upll");
-	if (IS_ERR(clock_upll)) {
-		printk(KERN_ERR "S3C244X: Failed to get upll clock\n");
-		return -ENOENT;
-	}
-
-	/* check rate of UPLL, and if it is near 96MHz, then change
-	 * to using half the UPLL rate for the system */
-
-	if (clk_get_rate(clock_upll) > (94 * MHZ)) {
-		clk_usb_bus.rate = clk_get_rate(clock_upll) / 2;
-
-		spin_lock(&clocks_lock);
-
-		clkdivn = __raw_readl(S3C2410_CLKDIVN);
-		clkdivn |= S3C2440_CLKDIVN_UCLK;
-		__raw_writel(clkdivn, S3C2410_CLKDIVN);
-
-		spin_unlock(&clocks_lock);
-	}
-
-	return 0;
-}
-
-static struct subsys_interface s3c2440_clk_interface = {
-	.name		= "s3c2440_clk",
-	.subsys		= &s3c2440_subsys,
-	.add_dev	= s3c244x_clk_add,
-};
-
-static int s3c2440_clk_init(void)
-{
-	return subsys_interface_register(&s3c2440_clk_interface);
-}
-
-arch_initcall(s3c2440_clk_init);
-
-static struct subsys_interface s3c2442_clk_interface = {
-	.name		= "s3c2442_clk",
-	.subsys		= &s3c2442_subsys,
-	.add_dev	= s3c244x_clk_add,
-};
-
-static int s3c2442_clk_init(void)
-{
-	return subsys_interface_register(&s3c2442_clk_interface);
-}
-
-arch_initcall(s3c2442_clk_init);
diff --git a/arch/arm/mach-s3c24xx/common.h b/arch/arm/mach-s3c24xx/common.h
index 2d65541..ac3ff12 100644
--- a/arch/arm/mach-s3c24xx/common.h
+++ b/arch/arm/mach-s3c24xx/common.h
@@ -67,10 +67,8 @@ extern struct syscore_ops s3c2416_irq_syscore_ops;
 #if defined(CONFIG_CPU_S3C2440) || defined(CONFIG_CPU_S3C2442)
 extern void s3c244x_map_io(void);
 extern void s3c244x_init_uarts(struct s3c2410_uartcfg *cfg, int no);
-extern void s3c244x_init_clocks(int xtal);
 extern void s3c244x_restart(enum reboot_mode mode, const char *cmd);
 #else
-#define s3c244x_init_clocks NULL
 #define s3c244x_init_uarts NULL
 #endif
 
diff --git a/arch/arm/mach-s3c24xx/include/mach/regs-clock.h b/arch/arm/mach-s3c24xx/include/mach/regs-clock.h
index 3415b60..3db6c10 100644
--- a/arch/arm/mach-s3c24xx/include/mach/regs-clock.h
+++ b/arch/arm/mach-s3c24xx/include/mach/regs-clock.h
@@ -42,24 +42,6 @@
 #define S3C2410_CLKCON_IIS	     (1<<17)
 #define S3C2410_CLKCON_SPI	     (1<<18)
 
-/* DCLKCON register addresses in gpio.h */
-
-#define S3C2410_DCLKCON_DCLK0EN	     (1<<0)
-#define S3C2410_DCLKCON_DCLK0_PCLK   (0<<1)
-#define S3C2410_DCLKCON_DCLK0_UCLK   (1<<1)
-#define S3C2410_DCLKCON_DCLK0_DIV(x) (((x) - 1 )<<4)
-#define S3C2410_DCLKCON_DCLK0_CMP(x) (((x) - 1 )<<8)
-#define S3C2410_DCLKCON_DCLK0_DIV_MASK ((0xf)<<4)
-#define S3C2410_DCLKCON_DCLK0_CMP_MASK ((0xf)<<8)
-
-#define S3C2410_DCLKCON_DCLK1EN	     (1<<16)
-#define S3C2410_DCLKCON_DCLK1_PCLK   (0<<17)
-#define S3C2410_DCLKCON_DCLK1_UCLK   (1<<17)
-#define S3C2410_DCLKCON_DCLK1_DIV(x) (((x) - 1) <<20)
-#define S3C2410_DCLKCON_DCLK1_CMP(x) (((x) - 1) <<24)
-#define S3C2410_DCLKCON_DCLK1_DIV_MASK ((0xf) <<20)
-#define S3C2410_DCLKCON_DCLK1_CMP_MASK ((0xf) <<24)
-
 #define S3C2410_CLKDIVN_PDIVN	     (1<<0)
 #define S3C2410_CLKDIVN_HDIVN	     (1<<1)
 
diff --git a/arch/arm/mach-s3c24xx/include/mach/regs-gpio.h b/arch/arm/mach-s3c24xx/include/mach/regs-gpio.h
index c2ef016..c6583cf 100644
--- a/arch/arm/mach-s3c24xx/include/mach/regs-gpio.h
+++ b/arch/arm/mach-s3c24xx/include/mach/regs-gpio.h
@@ -457,9 +457,6 @@
 
 /* miscellaneous control */
 #define S3C2410_MISCCR	   S3C2410_GPIOREG(0x80)
-#define S3C2410_DCLKCON	   S3C2410_GPIOREG(0x84)
-
-#define S3C24XX_DCLKCON	   S3C24XX_GPIOREG2(0x84)
 
 /* see clock.h for dclk definitions */
 
diff --git a/arch/arm/mach-s3c24xx/pm.c b/arch/arm/mach-s3c24xx/pm.c
index 16281bd..3d8cf30 100644
--- a/arch/arm/mach-s3c24xx/pm.c
+++ b/arch/arm/mach-s3c24xx/pm.c
@@ -80,12 +80,6 @@ static struct sleep_save core_save[] = {
 #endif /* CONFIG_SAMSUNG_CLOCK */
 };
 
-#ifdef CONFIG_SAMSUNG_CLOCK
-static struct sleep_save misc_save[] = {
-	SAVE_ITEM(S3C2410_DCLKCON),
-};
-#endif
-
 /* s3c_pm_check_resume_pin
  *
  * check to see if the pin is configured correctly for sleep mode, and
@@ -143,16 +137,10 @@ void s3c_pm_configure_extint(void)
 void s3c_pm_restore_core(void)
 {
 	s3c_pm_do_restore_core(core_save, ARRAY_SIZE(core_save));
-#ifdef CONFIG_SAMSUNG_CLOCK
-	s3c_pm_do_restore(misc_save, ARRAY_SIZE(misc_save));
-#endif
 }
 
 void s3c_pm_save_core(void)
 {
-#ifdef CONFIG_SAMSUNG_CLOCK
-	s3c_pm_do_save(misc_save, ARRAY_SIZE(misc_save));
-#endif
 	s3c_pm_do_save(core_save, ARRAY_SIZE(core_save));
 }
 
diff --git a/arch/arm/mach-s3c24xx/s3c2410.c b/arch/arm/mach-s3c24xx/s3c2410.c
index 5280173..7eab888 100644
--- a/arch/arm/mach-s3c24xx/s3c2410.c
+++ b/arch/arm/mach-s3c24xx/s3c2410.c
@@ -83,71 +83,9 @@ void __init s3c2410_map_io(void)
 	iotable_init(s3c2410_iodesc, ARRAY_SIZE(s3c2410_iodesc));
 }
 
-#ifdef CONFIG_SAMSUNG_CLOCK
 void __init_or_cpufreq s3c2410_setup_clocks(void)
 {
-	struct clk *xtal_clk;
-	unsigned long tmp;
-	unsigned long xtal;
-	unsigned long fclk;
-	unsigned long hclk;
-	unsigned long pclk;
-
-	xtal_clk = clk_get(NULL, "xtal");
-	xtal = clk_get_rate(xtal_clk);
-	clk_put(xtal_clk);
-
-	/* now we've got our machine bits initialised, work out what
-	 * clocks we've got */
-
-	fclk = s3c24xx_get_pll(__raw_readl(S3C2410_MPLLCON), xtal);
-
-	tmp = __raw_readl(S3C2410_CLKDIVN);
-
-	/* work out clock scalings */
-
-	hclk = fclk / ((tmp & S3C2410_CLKDIVN_HDIVN) ? 2 : 1);
-	pclk = hclk / ((tmp & S3C2410_CLKDIVN_PDIVN) ? 2 : 1);
-
-	/* print brieft summary of clocks, etc */
-
-	printk("S3C2410: core %ld.%03ld MHz, memory %ld.%03ld MHz, peripheral %ld.%03ld MHz\n",
-	       print_mhz(fclk), print_mhz(hclk), print_mhz(pclk));
-
-	/* initialise the clocks here, to allow other things like the
-	 * console to use them
-	 */
-
-	s3c24xx_setup_clocks(fclk, hclk, pclk);
-}
-
-/* fake ARMCLK for use with cpufreq, etc. */
-
-static struct clk s3c2410_armclk = {
-	.name	= "armclk",
-	.parent	= &clk_f,
-	.id	= -1,
-};
-
-static struct clk_lookup s3c2410_clk_lookup[] = {
-	CLKDEV_INIT(NULL, "clk_uart_baud0", &clk_p),
-	CLKDEV_INIT(NULL, "clk_uart_baud1", &s3c24xx_uclk),
-};
-
-void __init s3c2410_init_clocks(int xtal)
-{
-	s3c24xx_register_baseclocks(xtal);
-	s3c2410_setup_clocks();
-	s3c2410_baseclk_add();
-	s3c24xx_register_clock(&s3c2410_armclk);
-	clkdev_add_table(s3c2410_clk_lookup, ARRAY_SIZE(s3c2410_clk_lookup));
-	samsung_wdt_reset_init(S3C24XX_VA_WATCHDOG);
 }
-#else
-void __init_or_cpufreq s3c2410_setup_clocks(void)
-{
-}
-#endif
 
 struct bus_type s3c2410_subsys = {
 	.name = "s3c2410-core",
diff --git a/arch/arm/mach-s3c24xx/s3c2442.c b/arch/arm/mach-s3c24xx/s3c2442.c
index 564c6503..fb9da2b 100644
--- a/arch/arm/mach-s3c24xx/s3c2442.c
+++ b/arch/arm/mach-s3c24xx/s3c2442.c
@@ -53,118 +53,6 @@
 
 #include "common.h"
 
-#ifdef CONFIG_SAMSUNG_CLOCK
-/* S3C2442 extended clock support */
-
-static unsigned long s3c2442_camif_upll_round(struct clk *clk,
-					      unsigned long rate)
-{
-	unsigned long parent_rate = clk_get_rate(clk->parent);
-	int div;
-
-	if (rate > parent_rate)
-		return parent_rate;
-
-	div = parent_rate / rate;
-
-	if (div == 3)
-		return parent_rate / 3;
-
-	/* note, we remove the +/- 1 calculations for the divisor */
-
-	div /= 2;
-
-	if (div < 1)
-		div = 1;
-	else if (div > 16)
-		div = 16;
-
-	return parent_rate / (div * 2);
-}
-
-static int s3c2442_camif_upll_setrate(struct clk *clk, unsigned long rate)
-{
-	unsigned long parent_rate = clk_get_rate(clk->parent);
-	unsigned long camdivn =  __raw_readl(S3C2440_CAMDIVN);
-
-	rate = s3c2442_camif_upll_round(clk, rate);
-
-	camdivn &= ~S3C2442_CAMDIVN_CAMCLK_DIV3;
-
-	if (rate == parent_rate) {
-		camdivn &= ~S3C2440_CAMDIVN_CAMCLK_SEL;
-	} else if ((parent_rate / rate) == 3) {
-		camdivn |= S3C2440_CAMDIVN_CAMCLK_SEL;
-		camdivn |= S3C2442_CAMDIVN_CAMCLK_DIV3;
-	} else {
-		camdivn &= ~S3C2440_CAMDIVN_CAMCLK_MASK;
-		camdivn |= S3C2440_CAMDIVN_CAMCLK_SEL;
-		camdivn |= (((parent_rate / rate) / 2) - 1);
-	}
-
-	__raw_writel(camdivn, S3C2440_CAMDIVN);
-
-	return 0;
-}
-
-/* Extra S3C2442 clocks */
-
-static struct clk s3c2442_clk_cam = {
-	.name		= "camif",
-	.id		= -1,
-	.enable		= s3c2410_clkcon_enable,
-	.ctrlbit	= S3C2440_CLKCON_CAMERA,
-};
-
-static struct clk s3c2442_clk_cam_upll = {
-	.name		= "camif-upll",
-	.id		= -1,
-	.ops		= &(struct clk_ops) {
-		.set_rate	= s3c2442_camif_upll_setrate,
-		.round_rate	= s3c2442_camif_upll_round,
-	},
-};
-
-static int s3c2442_clk_add(struct device *dev, struct subsys_interface *sif)
-{
-	struct clk *clock_upll;
-	struct clk *clock_h;
-	struct clk *clock_p;
-
-	clock_p = clk_get(NULL, "pclk");
-	clock_h = clk_get(NULL, "hclk");
-	clock_upll = clk_get(NULL, "upll");
-
-	if (IS_ERR(clock_p) || IS_ERR(clock_h) || IS_ERR(clock_upll)) {
-		printk(KERN_ERR "S3C2442: Failed to get parent clocks\n");
-		return -EINVAL;
-	}
-
-	s3c2442_clk_cam.parent = clock_h;
-	s3c2442_clk_cam_upll.parent = clock_upll;
-
-	s3c24xx_register_clock(&s3c2442_clk_cam);
-	s3c24xx_register_clock(&s3c2442_clk_cam_upll);
-
-	clk_disable(&s3c2442_clk_cam);
-
-	return 0;
-}
-
-static struct subsys_interface s3c2442_clk_interface = {
-	.name		= "s3c2442_clk",
-	.subsys		= &s3c2442_subsys,
-	.add_dev	= s3c2442_clk_add,
-};
-
-static __init int s3c2442_clk_init(void)
-{
-	return subsys_interface_register(&s3c2442_clk_interface);
-}
-
-arch_initcall(s3c2442_clk_init);
-#endif
-
 static struct device s3c2442_dev = {
 	.bus		= &s3c2442_subsys,
 };
diff --git a/arch/arm/mach-s3c24xx/s3c244x.c b/arch/arm/mach-s3c24xx/s3c244x.c
index 1d665d5..4a64bcc 100644
--- a/arch/arm/mach-s3c24xx/s3c244x.c
+++ b/arch/arm/mach-s3c24xx/s3c244x.c
@@ -78,72 +78,9 @@ void __init s3c244x_map_io(void)
 	s3c2410_device_dclk.name = "s3c2440-dclk";
 }
 
-#ifdef CONFIG_SAMSUNG_CLOCK
 void __init_or_cpufreq s3c244x_setup_clocks(void)
 {
-	struct clk *xtal_clk;
-	unsigned long clkdiv;
-	unsigned long camdiv;
-	unsigned long xtal;
-	unsigned long hclk, fclk, pclk;
-	int hdiv = 1;
-
-	xtal_clk = clk_get(NULL, "xtal");
-	xtal = clk_get_rate(xtal_clk);
-	clk_put(xtal_clk);
-
-	fclk = s3c24xx_get_pll(__raw_readl(S3C2410_MPLLCON), xtal) * 2;
-
-	clkdiv = __raw_readl(S3C2410_CLKDIVN);
-	camdiv = __raw_readl(S3C2440_CAMDIVN);
-
-	/* work out clock scalings */
-
-	switch (clkdiv & S3C2440_CLKDIVN_HDIVN_MASK) {
-	case S3C2440_CLKDIVN_HDIVN_1:
-		hdiv = 1;
-		break;
-
-	case S3C2440_CLKDIVN_HDIVN_2:
-		hdiv = 2;
-		break;
-
-	case S3C2440_CLKDIVN_HDIVN_4_8:
-		hdiv = (camdiv & S3C2440_CAMDIVN_HCLK4_HALF) ? 8 : 4;
-		break;
-
-	case S3C2440_CLKDIVN_HDIVN_3_6:
-		hdiv = (camdiv & S3C2440_CAMDIVN_HCLK3_HALF) ? 6 : 3;
-		break;
-	}
-
-	hclk = fclk / hdiv;
-	pclk = hclk / ((clkdiv & S3C2440_CLKDIVN_PDIVN) ? 2 : 1);
-
-	/* print brief summary of clocks, etc */
-
-	printk("S3C244X: core %ld.%03ld MHz, memory %ld.%03ld MHz, peripheral %ld.%03ld MHz\n",
-	       print_mhz(fclk), print_mhz(hclk), print_mhz(pclk));
-
-	s3c24xx_setup_clocks(fclk, hclk, pclk);
-}
-
-void __init s3c244x_init_clocks(int xtal)
-{
-	/* initialise the clocks here, to allow other things like the
-	 * console to use them, and to add new ones after the initialisation
-	 */
-
-	s3c24xx_register_baseclocks(xtal);
-	s3c244x_setup_clocks();
-	s3c2410_baseclk_add();
-	samsung_wdt_reset_init(S3C24XX_VA_WATCHDOG);
 }
-#else
-void __init_or_cpufreq s3c244x_setup_clocks(void)
-{
-}
-#endif
 
 /* Since the S3C2442 and S3C2440 share items, put both subsystems here */
 
-- 
1.9.0
