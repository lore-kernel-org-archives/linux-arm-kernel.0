From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 19 Jun 2012 23:44:25 +0200
Subject: [PATCH] ARM: u300: convert to common clock
Message-ID: <1340142265-14549-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This converts the U300 clock implementation over to use the common
struct clk and moves the implementation down into drivers/clk.
Since VCO isn't used in tree it was removed, it's not hard to
put it back in if need be.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/Kconfig                       |    2 +-
 arch/arm/mach-u300/Makefile            |    2 +-
 arch/arm/mach-u300/clock.c             | 1504 --------------------------------
 arch/arm/mach-u300/clock.h             |   50 --
 arch/arm/mach-u300/core.c              |   21 +-
 arch/arm/mach-u300/timer.c             |    2 +-
 drivers/clk/Makefile                   |    1 +
 drivers/clk/clk-u300.c                 |  746 ++++++++++++++++
 include/linux/platform_data/clk-u300.h |    1 +
 9 files changed, 762 insertions(+), 1567 deletions(-)
 delete mode 100644 arch/arm/mach-u300/clock.c
 delete mode 100644 arch/arm/mach-u300/clock.h
 create mode 100644 drivers/clk/clk-u300.c
 create mode 100644 include/linux/platform_data/clk-u300.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 84449dd..41aee13 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -886,7 +886,7 @@ config ARCH_U300
 	select ARM_VIC
 	select GENERIC_CLOCKEVENTS
 	select CLKDEV_LOOKUP
-	select HAVE_MACH_CLKDEV
+	select COMMON_CLK
 	select GENERIC_GPIO
 	select ARCH_REQUIRE_GPIOLIB
 	help
diff --git a/arch/arm/mach-u300/Makefile b/arch/arm/mach-u300/Makefile
index fd3a5c3..7e47d37 100644
--- a/arch/arm/mach-u300/Makefile
+++ b/arch/arm/mach-u300/Makefile
@@ -2,7 +2,7 @@
 # Makefile for the linux kernel, U300 machine.
 #
 
-obj-y		:= core.o clock.o timer.o
+obj-y		:= core.o timer.o
 obj-m		:=
 obj-n		:=
 obj-		:=
diff --git a/arch/arm/mach-u300/clock.c b/arch/arm/mach-u300/clock.c
deleted file mode 100644
index 5535dd0..0000000
--- a/arch/arm/mach-u300/clock.c
+++ /dev/null
@@ -1,1504 +0,0 @@
-/*
- *
- * arch/arm/mach-u300/clock.c
- *
- *
- * Copyright (C) 2007-2009 ST-Ericsson AB
- * License terms: GNU General Public License (GPL) version 2
- * Define clocks in the app platform.
- * Author: Linus Walleij <linus.walleij@stericsson.com>
- * Author: Jonas Aaberg <jonas.aberg@stericsson.com>
- *
- */
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/list.h>
-#include <linux/errno.h>
-#include <linux/err.h>
-#include <linux/string.h>
-#include <linux/clk.h>
-#include <linux/mutex.h>
-#include <linux/spinlock.h>
-#include <linux/debugfs.h>
-#include <linux/device.h>
-#include <linux/init.h>
-#include <linux/timer.h>
-#include <linux/io.h>
-#include <linux/seq_file.h>
-#include <linux/clkdev.h>
-
-#include <mach/hardware.h>
-#include <mach/syscon.h>
-
-#include "clock.h"
-
-/*
- * TODO:
- * - move all handling of the CCR register into this file and create
- *   a spinlock for the CCR register
- * - switch to the clkdevice lookup mechanism that maps clocks to
- *   device ID:s instead when it becomes available in kernel 2.6.29.
- * - implement rate get/set for all clocks that need it.
- */
-
-/*
- * Syscon clock I/O registers lock so clock requests don't collide
- * NOTE: this is a local lock only used to lock access to clock and
- * reset registers in syscon.
- */
-static DEFINE_SPINLOCK(syscon_clkreg_lock);
-static DEFINE_SPINLOCK(syscon_resetreg_lock);
-
-/*
- * The clocking hierarchy currently looks like this.
- * NOTE: the idea is NOT to show how the clocks are routed on the chip!
- * The ideas is to show dependencies, so a clock higher up in the
- * hierarchy has to be on in order for another clock to be on. Now,
- * both CPU and DMA can actually be on top of the hierarchy, and that
- * is not modeled currently. Instead we have the backbone AMBA bus on
- * top. This bus cannot be programmed in any way but conceptually it
- * needs to be active for the bridges and devices to transport data.
- *
- * Please be aware that a few clocks are hw controlled, which mean that
- * the hw itself can turn on/off or change the rate of the clock when
- * needed!
- *
- *  AMBA bus
- *  |
- *  +- CPU
- *  +- FSMC NANDIF NAND Flash interface
- *  +- SEMI Shared Memory interface
- *  +- ISP Image Signal Processor (U335 only)
- *  +- CDS (U335 only)
- *  +- DMA Direct Memory Access Controller
- *  +- AAIF APP/ACC Inteface (Mobile Scalable Link, MSL)
- *  +- APEX
- *  +- VIDEO_ENC AVE2/3 Video Encoder
- *  +- XGAM Graphics Accelerator Controller
- *  +- AHB
- *  |
- *  +- ahb:0 AHB Bridge
- *  |  |
- *  |  +- ahb:1 INTCON Interrupt controller
- *  |  +- ahb:3 MSPRO  Memory Stick Pro controller
- *  |  +- ahb:4 EMIF   External Memory interface
- *  |
- *  +- fast:0 FAST bridge
- *  |  |
- *  |  +- fast:1 MMCSD MMC/SD card reader controller
- *  |  +- fast:2 I2S0  PCM I2S channel 0 controller
- *  |  +- fast:3 I2S1  PCM I2S channel 1 controller
- *  |  +- fast:4 I2C0  I2C channel 0 controller
- *  |  +- fast:5 I2C1  I2C channel 1 controller
- *  |  +- fast:6 SPI   SPI controller
- *  |  +- fast:7 UART1 Secondary UART (U335 only)
- *  |
- *  +- slow:0 SLOW bridge
- *     |
- *     +- slow:1 SYSCON (not possible to control)
- *     +- slow:2 WDOG Watchdog
- *     +- slow:3 UART0 primary UART
- *     +- slow:4 TIMER_APP Application timer - used in Linux
- *     +- slow:5 KEYPAD controller
- *     +- slow:6 GPIO controller
- *     +- slow:7 RTC controller
- *     +- slow:8 BT Bus Tracer (not used currently)
- *     +- slow:9 EH Event Handler (not used currently)
- *     +- slow:a TIMER_ACC Access style timer (not used currently)
- *     +- slow:b PPM (U335 only, what is that?)
- */
-
-/*
- * Reset control functions. We remember if a block has been
- * taken out of reset and don't remove the reset assertion again
- * and vice versa. Currently we only remove resets so the
- * enablement function is defined out.
- */
-static void syscon_block_reset_enable(struct clk *clk)
-{
-	u16 val;
-	unsigned long iflags;
-
-	/* Not all blocks support resetting */
-	if (!clk->res_reg || !clk->res_mask)
-		return;
-	spin_lock_irqsave(&syscon_resetreg_lock, iflags);
-	val = readw(clk->res_reg);
-	val |= clk->res_mask;
-	writew(val, clk->res_reg);
-	spin_unlock_irqrestore(&syscon_resetreg_lock, iflags);
-	clk->reset = true;
-}
-
-static void syscon_block_reset_disable(struct clk *clk)
-{
-	u16 val;
-	unsigned long iflags;
-
-	/* Not all blocks support resetting */
-	if (!clk->res_reg || !clk->res_mask)
-		return;
-	spin_lock_irqsave(&syscon_resetreg_lock, iflags);
-	val = readw(clk->res_reg);
-	val &= ~clk->res_mask;
-	writew(val, clk->res_reg);
-	spin_unlock_irqrestore(&syscon_resetreg_lock, iflags);
-	clk->reset = false;
-}
-
-int __clk_get(struct clk *clk)
-{
-	u16 val;
-
-	/* The MMC and MSPRO clocks need some special set-up */
-	if (!strcmp(clk->name, "MCLK")) {
-		/* Set default MMC clock divisor to 18.9 MHz */
-		writew(0x0054U, U300_SYSCON_VBASE + U300_SYSCON_MMF0R);
-		val = readw(U300_SYSCON_VBASE + U300_SYSCON_MMCR);
-		/* Disable the MMC feedback clock */
-		val &= ~U300_SYSCON_MMCR_MMC_FB_CLK_SEL_ENABLE;
-		/* Disable MSPRO frequency */
-		val &= ~U300_SYSCON_MMCR_MSPRO_FREQSEL_ENABLE;
-		writew(val, U300_SYSCON_VBASE + U300_SYSCON_MMCR);
-	}
-	if (!strcmp(clk->name, "MSPRO")) {
-		val = readw(U300_SYSCON_VBASE + U300_SYSCON_MMCR);
-		/* Disable the MMC feedback clock */
-		val &= ~U300_SYSCON_MMCR_MMC_FB_CLK_SEL_ENABLE;
-		/* Enable MSPRO frequency */
-		val |= U300_SYSCON_MMCR_MSPRO_FREQSEL_ENABLE;
-		writew(val, U300_SYSCON_VBASE + U300_SYSCON_MMCR);
-	}
-	return 1;
-}
-EXPORT_SYMBOL(__clk_get);
-
-void __clk_put(struct clk *clk)
-{
-}
-EXPORT_SYMBOL(__clk_put);
-
-static void syscon_clk_disable(struct clk *clk)
-{
-	unsigned long iflags;
-
-	/* Don't touch the hardware controlled clocks */
-	if (clk->hw_ctrld)
-		return;
-
-	spin_lock_irqsave(&syscon_clkreg_lock, iflags);
-	writew(clk->clk_val, U300_SYSCON_VBASE + U300_SYSCON_SBCDR);
-	spin_unlock_irqrestore(&syscon_clkreg_lock, iflags);
-}
-
-static void syscon_clk_enable(struct clk *clk)
-{
-	unsigned long iflags;
-
-	/* Don't touch the hardware controlled clocks */
-	if (clk->hw_ctrld)
-		return;
-
-	spin_lock_irqsave(&syscon_clkreg_lock, iflags);
-	writew(clk->clk_val, U300_SYSCON_VBASE + U300_SYSCON_SBCER);
-	spin_unlock_irqrestore(&syscon_clkreg_lock, iflags);
-}
-
-static u16 syscon_clk_get_rate(void)
-{
-	u16 val;
-	unsigned long iflags;
-
-	spin_lock_irqsave(&syscon_clkreg_lock, iflags);
-	val = readw(U300_SYSCON_VBASE + U300_SYSCON_CCR);
-	val &= U300_SYSCON_CCR_CLKING_PERFORMANCE_MASK;
-	spin_unlock_irqrestore(&syscon_clkreg_lock, iflags);
-	return val;
-}
-
-#ifdef CONFIG_MACH_U300_USE_I2S_AS_MASTER
-static void enable_i2s0_vcxo(void)
-{
-	u16 val;
-	unsigned long iflags;
-
-	spin_lock_irqsave(&syscon_clkreg_lock, iflags);
-	/* Set I2S0 to use the VCXO 26 MHz clock */
-	val = readw(U300_SYSCON_VBASE + U300_SYSCON_CCR);
-	val |= U300_SYSCON_CCR_TURN_VCXO_ON;
-	writew(val, U300_SYSCON_VBASE + U300_SYSCON_CCR);
-	val |= U300_SYSCON_CCR_I2S0_USE_VCXO;
-	writew(val, U300_SYSCON_VBASE + U300_SYSCON_CCR);
-	val = readw(U300_SYSCON_VBASE + U300_SYSCON_CEFR);
-	val |= U300_SYSCON_CEFR_I2S0_CLK_EN;
-	writew(val, U300_SYSCON_VBASE + U300_SYSCON_CEFR);
-	spin_unlock_irqrestore(&syscon_clkreg_lock, iflags);
-}
-
-static void enable_i2s1_vcxo(void)
-{
-	u16 val;
-	unsigned long iflags;
-
-	spin_lock_irqsave(&syscon_clkreg_lock, iflags);
-	/* Set I2S1 to use the VCXO 26 MHz clock */
-	val = readw(U300_SYSCON_VBASE + U300_SYSCON_CCR);
-	val |= U300_SYSCON_CCR_TURN_VCXO_ON;
-	writew(val, U300_SYSCON_VBASE + U300_SYSCON_CCR);
-	val |= U300_SYSCON_CCR_I2S1_USE_VCXO;
-	writew(val, U300_SYSCON_VBASE + U300_SYSCON_CCR);
-	val = readw(U300_SYSCON_VBASE + U300_SYSCON_CEFR);
-	val |= U300_SYSCON_CEFR_I2S1_CLK_EN;
-	writew(val, U300_SYSCON_VBASE + U300_SYSCON_CEFR);
-	spin_unlock_irqrestore(&syscon_clkreg_lock, iflags);
-}
-
-static void disable_i2s0_vcxo(void)
-{
-	u16 val;
-	unsigned long iflags;
-
-	spin_lock_irqsave(&syscon_clkreg_lock, iflags);
-	/* Disable I2S0 use of the VCXO 26 MHz clock */
-	val = readw(U300_SYSCON_VBASE + U300_SYSCON_CCR);
-	val &= ~U300_SYSCON_CCR_I2S0_USE_VCXO;
-	writew(val, U300_SYSCON_VBASE + U300_SYSCON_CCR);
-	/* Deactivate VCXO if no one else is using VCXO */
-	if (!(val & U300_SYSCON_CCR_I2S1_USE_VCXO))
-		val &= ~U300_SYSCON_CCR_TURN_VCXO_ON;
-	writew(val, U300_SYSCON_VBASE + U300_SYSCON_CCR);
-	val = readw(U300_SYSCON_VBASE + U300_SYSCON_CEFR);
-	val &= ~U300_SYSCON_CEFR_I2S0_CLK_EN;
-	writew(val, U300_SYSCON_VBASE + U300_SYSCON_CEFR);
-	spin_unlock_irqrestore(&syscon_clkreg_lock, iflags);
-}
-
-static void disable_i2s1_vcxo(void)
-{
-	u16 val;
-	unsigned long iflags;
-
-	spin_lock_irqsave(&syscon_clkreg_lock, iflags);
-	/* Disable I2S1 use of the VCXO 26 MHz clock */
-	val = readw(U300_SYSCON_VBASE + U300_SYSCON_CCR);
-	val &= ~U300_SYSCON_CCR_I2S1_USE_VCXO;
-	writew(val, U300_SYSCON_VBASE + U300_SYSCON_CCR);
-	/* Deactivate VCXO if no one else is using VCXO */
-	if (!(val & U300_SYSCON_CCR_I2S0_USE_VCXO))
-		val &= ~U300_SYSCON_CCR_TURN_VCXO_ON;
-	writew(val, U300_SYSCON_VBASE + U300_SYSCON_CCR);
-	val = readw(U300_SYSCON_VBASE + U300_SYSCON_CEFR);
-	val &= ~U300_SYSCON_CEFR_I2S0_CLK_EN;
-	writew(val, U300_SYSCON_VBASE + U300_SYSCON_CEFR);
-	spin_unlock_irqrestore(&syscon_clkreg_lock, iflags);
-}
-#endif /* CONFIG_MACH_U300_USE_I2S_AS_MASTER */
-
-
-static void syscon_clk_rate_set_mclk(unsigned long rate)
-{
-	u16 val;
-	u32 reg;
-	unsigned long iflags;
-
-	switch (rate) {
-	case 18900000:
-		val = 0x0054;
-		break;
-	case 20800000:
-		val = 0x0044;
-		break;
-	case 23100000:
-		val = 0x0043;
-		break;
-	case 26000000:
-		val = 0x0033;
-		break;
-	case 29700000:
-		val = 0x0032;
-		break;
-	case 34700000:
-		val = 0x0022;
-		break;
-	case 41600000:
-		val = 0x0021;
-		break;
-	case 52000000:
-		val = 0x0011;
-		break;
-	case 104000000:
-		val = 0x0000;
-		break;
-	default:
-		printk(KERN_ERR "Trying to set MCLK to unknown speed! %ld\n",
-		       rate);
-		return;
-	}
-
-	spin_lock_irqsave(&syscon_clkreg_lock, iflags);
-	reg = readw(U300_SYSCON_VBASE + U300_SYSCON_MMF0R) &
-		~U300_SYSCON_MMF0R_MASK;
-	writew(reg | val, U300_SYSCON_VBASE + U300_SYSCON_MMF0R);
-	spin_unlock_irqrestore(&syscon_clkreg_lock, iflags);
-}
-
-void syscon_clk_rate_set_cpuclk(unsigned long rate)
-{
-	u16 val;
-	unsigned long iflags;
-
-	switch (rate) {
-	case 13000000:
-		val = U300_SYSCON_CCR_CLKING_PERFORMANCE_LOW_POWER;
-		break;
-	case 52000000:
-		val = U300_SYSCON_CCR_CLKING_PERFORMANCE_INTERMEDIATE;
-		break;
-	case 104000000:
-		val = U300_SYSCON_CCR_CLKING_PERFORMANCE_HIGH;
-		break;
-	case 208000000:
-		val = U300_SYSCON_CCR_CLKING_PERFORMANCE_BEST;
-		break;
-	default:
-		return;
-	}
-	spin_lock_irqsave(&syscon_clkreg_lock, iflags);
-	val |= readw(U300_SYSCON_VBASE + U300_SYSCON_CCR) &
-		~U300_SYSCON_CCR_CLKING_PERFORMANCE_MASK ;
-	writew(val, U300_SYSCON_VBASE + U300_SYSCON_CCR);
-	spin_unlock_irqrestore(&syscon_clkreg_lock, iflags);
-}
-EXPORT_SYMBOL(syscon_clk_rate_set_cpuclk);
-
-void clk_disable(struct clk *clk)
-{
-	unsigned long iflags;
-
-	spin_lock_irqsave(&clk->lock, iflags);
-	if (clk->usecount > 0 && !(--clk->usecount)) {
-		/* some blocks lack clocking registers and cannot be disabled */
-		if (clk->disable)
-			clk->disable(clk);
-		if (likely((u32)clk->parent))
-			clk_disable(clk->parent);
-	}
-#ifdef CONFIG_MACH_U300_USE_I2S_AS_MASTER
-	if (unlikely(!strcmp(clk->name, "I2S0")))
-		disable_i2s0_vcxo();
-	if (unlikely(!strcmp(clk->name, "I2S1")))
-		disable_i2s1_vcxo();
-#endif
-	spin_unlock_irqrestore(&clk->lock, iflags);
-}
-EXPORT_SYMBOL(clk_disable);
-
-int clk_enable(struct clk *clk)
-{
-	int ret = 0;
-	unsigned long iflags;
-
-	spin_lock_irqsave(&clk->lock, iflags);
-	if (clk->usecount++ == 0) {
-		if (likely((u32)clk->parent))
-			ret = clk_enable(clk->parent);
-
-		if (unlikely(ret != 0))
-			clk->usecount--;
-		else {
-			/* remove reset line (we never enable reset again) */
-			syscon_block_reset_disable(clk);
-			/* clocks without enable function are always on */
-			if (clk->enable)
-				clk->enable(clk);
-#ifdef CONFIG_MACH_U300_USE_I2S_AS_MASTER
-			if (unlikely(!strcmp(clk->name, "I2S0")))
-				enable_i2s0_vcxo();
-			if (unlikely(!strcmp(clk->name, "I2S1")))
-				enable_i2s1_vcxo();
-#endif
-		}
-	}
-	spin_unlock_irqrestore(&clk->lock, iflags);
-	return ret;
-
-}
-EXPORT_SYMBOL(clk_enable);
-
-/* Returns the clock rate in Hz */
-static unsigned long clk_get_rate_cpuclk(struct clk *clk)
-{
-	u16 val;
-
-	val = syscon_clk_get_rate();
-
-	switch (val) {
-	case U300_SYSCON_CCR_CLKING_PERFORMANCE_LOW_POWER:
-	case U300_SYSCON_CCR_CLKING_PERFORMANCE_LOW:
-		return 13000000;
-	case U300_SYSCON_CCR_CLKING_PERFORMANCE_INTERMEDIATE:
-		return 52000000;
-	case U300_SYSCON_CCR_CLKING_PERFORMANCE_HIGH:
-		return 104000000;
-	case U300_SYSCON_CCR_CLKING_PERFORMANCE_BEST:
-		return 208000000;
-	default:
-		break;
-	}
-	return clk->rate;
-}
-
-static unsigned long clk_get_rate_ahb_clk(struct clk *clk)
-{
-	u16 val;
-
-	val = syscon_clk_get_rate();
-
-	switch (val) {
-	case U300_SYSCON_CCR_CLKING_PERFORMANCE_LOW_POWER:
-	case U300_SYSCON_CCR_CLKING_PERFORMANCE_LOW:
-		return 6500000;
-	case U300_SYSCON_CCR_CLKING_PERFORMANCE_INTERMEDIATE:
-		return 26000000;
-	case U300_SYSCON_CCR_CLKING_PERFORMANCE_HIGH:
-	case U300_SYSCON_CCR_CLKING_PERFORMANCE_BEST:
-		return 52000000;
-	default:
-		break;
-	}
-	return clk->rate;
-
-}
-
-static unsigned long clk_get_rate_emif_clk(struct clk *clk)
-{
-	u16 val;
-
-	val = syscon_clk_get_rate();
-
-	switch (val) {
-	case U300_SYSCON_CCR_CLKING_PERFORMANCE_LOW_POWER:
-	case U300_SYSCON_CCR_CLKING_PERFORMANCE_LOW:
-		return 13000000;
-	case U300_SYSCON_CCR_CLKING_PERFORMANCE_INTERMEDIATE:
-		return 52000000;
-	case U300_SYSCON_CCR_CLKING_PERFORMANCE_HIGH:
-	case U300_SYSCON_CCR_CLKING_PERFORMANCE_BEST:
-		return 104000000;
-	default:
-		break;
-	}
-	return clk->rate;
-
-}
-
-static unsigned long clk_get_rate_xgamclk(struct clk *clk)
-{
-	u16 val;
-
-	val = syscon_clk_get_rate();
-
-	switch (val) {
-	case U300_SYSCON_CCR_CLKING_PERFORMANCE_LOW_POWER:
-	case U300_SYSCON_CCR_CLKING_PERFORMANCE_LOW:
-		return 6500000;
-	case U300_SYSCON_CCR_CLKING_PERFORMANCE_INTERMEDIATE:
-		return 26000000;
-	case U300_SYSCON_CCR_CLKING_PERFORMANCE_HIGH:
-	case U300_SYSCON_CCR_CLKING_PERFORMANCE_BEST:
-		return 52000000;
-	default:
-		break;
-	}
-
-	return clk->rate;
-}
-
-static unsigned long clk_get_rate_mclk(struct clk *clk)
-{
-	u16 val;
-
-	val = syscon_clk_get_rate();
-
-	switch (val) {
-	case U300_SYSCON_CCR_CLKING_PERFORMANCE_LOW_POWER:
-		/*
-		 * Here, the 208 MHz PLL gets shut down and the always
-		 * on 13 MHz PLL used for RTC etc kicks into use
-		 * instead.
-		 */
-		return 13000000;
-	case U300_SYSCON_CCR_CLKING_PERFORMANCE_LOW:
-	case U300_SYSCON_CCR_CLKING_PERFORMANCE_INTERMEDIATE:
-	case U300_SYSCON_CCR_CLKING_PERFORMANCE_HIGH:
-	case U300_SYSCON_CCR_CLKING_PERFORMANCE_BEST:
-	{
-		/*
-		 * This clock is under program control. The register is
-		 * divided in two nybbles, bit 7-4 gives cycles-1 to count
-		 * high, bit 3-0 gives cycles-1 to count low. Distribute
-		 * these with no more than 1 cycle difference between
-		 * low and high and add low and high to get the actual
-		 * divisor. The base PLL is 208 MHz. Writing 0x00 will
-		 * divide by 1 and 1 so the highest frequency possible
-		 * is 104 MHz.
-		 *
-		 * e.g. 0x54 =>
-		 * f = 208 / ((5+1) + (4+1)) = 208 / 11 = 18.9 MHz
-		 */
-		u16 val = readw(U300_SYSCON_VBASE + U300_SYSCON_MMF0R) &
-			U300_SYSCON_MMF0R_MASK;
-		switch (val) {
-		case 0x0054:
-			return 18900000;
-		case 0x0044:
-			return 20800000;
-		case 0x0043:
-			return 23100000;
-		case 0x0033:
-			return 26000000;
-		case 0x0032:
-			return 29700000;
-		case 0x0022:
-			return 34700000;
-		case 0x0021:
-			return 41600000;
-		case 0x0011:
-			return 52000000;
-		case 0x0000:
-			return 104000000;
-		default:
-			break;
-		}
-	}
-	default:
-		break;
-	}
-
-	return clk->rate;
-}
-
-static unsigned long clk_get_rate_i2s_i2c_spi(struct clk *clk)
-{
-	u16 val;
-
-	val = syscon_clk_get_rate();
-
-	switch (val) {
-	case U300_SYSCON_CCR_CLKING_PERFORMANCE_LOW_POWER:
-	case U300_SYSCON_CCR_CLKING_PERFORMANCE_LOW:
-		return 13000000;
-	case U300_SYSCON_CCR_CLKING_PERFORMANCE_INTERMEDIATE:
-	case U300_SYSCON_CCR_CLKING_PERFORMANCE_HIGH:
-	case U300_SYSCON_CCR_CLKING_PERFORMANCE_BEST:
-		return 26000000;
-	default:
-		break;
-	}
-
-	return clk->rate;
-}
-
-unsigned long clk_get_rate(struct clk *clk)
-{
-	if (clk->get_rate)
-		return clk->get_rate(clk);
-	else
-		return clk->rate;
-}
-EXPORT_SYMBOL(clk_get_rate);
-
-static unsigned long clk_round_rate_mclk(struct clk *clk, unsigned long rate)
-{
-	if (rate <= 18900000)
-		return 18900000;
-	if (rate <= 20800000)
-		return 20800000;
-	if (rate <= 23100000)
-		return 23100000;
-	if (rate <= 26000000)
-		return 26000000;
-	if (rate <= 29700000)
-		return 29700000;
-	if (rate <= 34700000)
-		return 34700000;
-	if (rate <= 41600000)
-		return 41600000;
-	if (rate <= 52000000)
-		return 52000000;
-	return -EINVAL;
-}
-
-static unsigned long clk_round_rate_cpuclk(struct clk *clk, unsigned long rate)
-{
-	if (rate <= 13000000)
-		return 13000000;
-	if (rate <= 52000000)
-		return 52000000;
-	if (rate <= 104000000)
-		return 104000000;
-	if (rate <= 208000000)
-		return 208000000;
-	return -EINVAL;
-}
-
-/*
- * This adjusts a requested rate to the closest exact rate
- * a certain clock can provide. For a fixed clock it's
- * mostly clk->rate.
- */
-long clk_round_rate(struct clk *clk, unsigned long rate)
-{
-	/* TODO: get appropriate switches for EMIFCLK, AHBCLK and MCLK */
-	/* Else default to fixed value */
-
-	if (clk->round_rate) {
-		return (long) clk->round_rate(clk, rate);
-	} else {
-		printk(KERN_ERR "clock: Failed to round rate of %s\n",
-		       clk->name);
-	}
-	return (long) clk->rate;
-}
-EXPORT_SYMBOL(clk_round_rate);
-
-static int clk_set_rate_mclk(struct clk *clk, unsigned long rate)
-{
-	syscon_clk_rate_set_mclk(clk_round_rate(clk, rate));
-	return 0;
-}
-
-static int clk_set_rate_cpuclk(struct clk *clk, unsigned long rate)
-{
-	syscon_clk_rate_set_cpuclk(clk_round_rate(clk, rate));
-	return 0;
-}
-
-int clk_set_rate(struct clk *clk, unsigned long rate)
-{
-	/* TODO: set for EMIFCLK and AHBCLK */
-	/* Else assume the clock is fixed and fail */
-	if (clk->set_rate) {
-		return clk->set_rate(clk, rate);
-	} else {
-		printk(KERN_ERR "clock: Failed to set %s to %ld hz\n",
-		       clk->name, rate);
-		return -EINVAL;
-	}
-}
-EXPORT_SYMBOL(clk_set_rate);
-
-/*
- * Clock definitions. The clock parents are set to respective
- * bridge and the clock framework makes sure that the clocks have
- * parents activated and are brought out of reset when in use.
- *
- * Clocks that have hw_ctrld = true are hw controlled, and the hw
- * can by itself turn these clocks on and off.
- * So in other words, we don't really have to care about them.
- */
-
-static struct clk amba_clk = {
-	.name	    = "AMBA",
-	.rate	    = 52000000, /* this varies! */
-	.hw_ctrld   = true,
-	.reset	    = false,
-	.lock       = __SPIN_LOCK_UNLOCKED(amba_clk.lock),
-};
-
-/*
- * These blocks are connected directly to the AMBA bus
- * with no bridge.
- */
-
-static struct clk cpu_clk = {
-	.name	    = "CPU",
-	.parent	    = &amba_clk,
-	.rate	    = 208000000, /* this varies! */
-	.hw_ctrld   = true,
-	.reset	    = true,
-	.res_reg    = U300_SYSCON_VBASE + U300_SYSCON_RRR,
-	.res_mask   = U300_SYSCON_RRR_CPU_RESET_EN,
-	.set_rate   = clk_set_rate_cpuclk,
-	.get_rate   = clk_get_rate_cpuclk,
-	.round_rate = clk_round_rate_cpuclk,
-	.lock       = __SPIN_LOCK_UNLOCKED(cpu_clk.lock),
-};
-
-static struct clk nandif_clk = {
-	.name       = "FSMC",
-	.parent	    = &amba_clk,
-	.hw_ctrld   = false,
-	.reset	    = true,
-	.res_reg    = U300_SYSCON_VBASE + U300_SYSCON_RRR,
-	.res_mask   = U300_SYSCON_RRR_NANDIF_RESET_EN,
-	.clk_val    = U300_SYSCON_SBCER_NANDIF_CLK_EN,
-	.enable     = syscon_clk_enable,
-	.disable    = syscon_clk_disable,
-	.lock       = __SPIN_LOCK_UNLOCKED(nandif_clk.lock),
-};
-
-static struct clk semi_clk = {
-	.name       = "SEMI",
-	.parent	    = &amba_clk,
-	.rate       = 0, /* FIXME */
-	/* It is not possible to reset SEMI */
-	.hw_ctrld   = false,
-	.reset	    = false,
-	.clk_val    = U300_SYSCON_SBCER_SEMI_CLK_EN,
-	.enable     = syscon_clk_enable,
-	.disable    = syscon_clk_disable,
-	.lock       = __SPIN_LOCK_UNLOCKED(semi_clk.lock),
-};
-
-#ifdef CONFIG_MACH_U300_BS335
-static struct clk isp_clk = {
-	.name	    = "ISP",
-	.parent	    = &amba_clk,
-	.rate	    = 0, /* FIXME */
-	.hw_ctrld   = false,
-	.reset	    = true,
-	.res_reg    = U300_SYSCON_VBASE + U300_SYSCON_RRR,
-	.res_mask   = U300_SYSCON_RRR_ISP_RESET_EN,
-	.clk_val    = U300_SYSCON_SBCER_ISP_CLK_EN,
-	.enable     = syscon_clk_enable,
-	.disable    = syscon_clk_disable,
-	.lock       = __SPIN_LOCK_UNLOCKED(isp_clk.lock),
-};
-
-static struct clk cds_clk = {
-	.name	    = "CDS",
-	.parent	    = &amba_clk,
-	.rate	    = 0, /* FIXME */
-	.hw_ctrld   = false,
-	.reset	    = true,
-	.res_reg    = U300_SYSCON_VBASE + U300_SYSCON_RRR,
-	.res_mask   = U300_SYSCON_RRR_CDS_RESET_EN,
-	.clk_val    = U300_SYSCON_SBCER_CDS_CLK_EN,
-	.enable     = syscon_clk_enable,
-	.disable    = syscon_clk_disable,
-	.lock       = __SPIN_LOCK_UNLOCKED(cds_clk.lock),
-};
-#endif
-
-static struct clk dma_clk = {
-	.name       = "DMA",
-	.parent	    = &amba_clk,
-	.rate       = 52000000, /* this varies! */
-	.hw_ctrld   = true,
-	.reset	    = true,
-	.res_reg    = U300_SYSCON_VBASE + U300_SYSCON_RRR,
-	.res_mask   = U300_SYSCON_RRR_DMAC_RESET_EN,
-	.clk_val    = U300_SYSCON_SBCER_DMAC_CLK_EN,
-	.enable     = syscon_clk_enable,
-	.disable    = syscon_clk_disable,
-	.lock       = __SPIN_LOCK_UNLOCKED(dma_clk.lock),
-};
-
-static struct clk aaif_clk = {
-	.name       = "AAIF",
-	.parent	    = &amba_clk,
-	.rate       = 52000000, /* this varies! */
-	.hw_ctrld   = true,
-	.reset	    = true,
-	.res_reg    = U300_SYSCON_VBASE + U300_SYSCON_RRR,
-	.res_mask   = U300_SYSCON_RRR_AAIF_RESET_EN,
-	.clk_val    = U300_SYSCON_SBCER_AAIF_CLK_EN,
-	.enable     = syscon_clk_enable,
-	.disable    = syscon_clk_disable,
-	.lock       = __SPIN_LOCK_UNLOCKED(aaif_clk.lock),
-};
-
-static struct clk apex_clk = {
-	.name       = "APEX",
-	.parent	    = &amba_clk,
-	.rate       = 0, /* FIXME */
-	.hw_ctrld   = true,
-	.reset	    = true,
-	.res_reg    = U300_SYSCON_VBASE + U300_SYSCON_RRR,
-	.res_mask   = U300_SYSCON_RRR_APEX_RESET_EN,
-	.clk_val    = U300_SYSCON_SBCER_APEX_CLK_EN,
-	.enable     = syscon_clk_enable,
-	.disable    = syscon_clk_disable,
-	.lock       = __SPIN_LOCK_UNLOCKED(apex_clk.lock),
-};
-
-static struct clk video_enc_clk = {
-	.name       = "VIDEO_ENC",
-	.parent	    = &amba_clk,
-	.rate       = 208000000, /* this varies! */
-	.hw_ctrld   = false,
-	.reset	    = false,
-	.res_reg    = U300_SYSCON_VBASE + U300_SYSCON_RRR,
-	/* This has XGAM in the name but refers to the video encoder */
-	.res_mask   = U300_SYSCON_RRR_XGAM_VC_SYNC_RESET_EN,
-	.clk_val    = U300_SYSCON_SBCER_VIDEO_ENC_CLK_EN,
-	.enable     = syscon_clk_enable,
-	.disable    = syscon_clk_disable,
-	.lock       = __SPIN_LOCK_UNLOCKED(video_enc_clk.lock),
-};
-
-static struct clk xgam_clk = {
-	.name       = "XGAMCLK",
-	.parent	    = &amba_clk,
-	.rate       = 52000000, /* this varies! */
-	.hw_ctrld   = false,
-	.reset	    = true,
-	.res_reg    = U300_SYSCON_VBASE + U300_SYSCON_RRR,
-	.res_mask   = U300_SYSCON_RRR_XGAM_RESET_EN,
-	.clk_val    = U300_SYSCON_SBCER_XGAM_CLK_EN,
-	.get_rate   = clk_get_rate_xgamclk,
-	.enable     = syscon_clk_enable,
-	.disable    = syscon_clk_disable,
-	.lock       = __SPIN_LOCK_UNLOCKED(xgam_clk.lock),
-};
-
-/* This clock is used to activate the video encoder */
-static struct clk ahb_clk = {
-	.name	    = "AHB",
-	.parent	    = &amba_clk,
-	.rate	    = 52000000, /* this varies! */
-	.hw_ctrld   = false, /* This one is set to false due to HW bug */
-	.reset	    = true,
-	.res_reg    = U300_SYSCON_VBASE + U300_SYSCON_RRR,
-	.res_mask   = U300_SYSCON_RRR_AHB_RESET_EN,
-	.clk_val    = U300_SYSCON_SBCER_AHB_CLK_EN,
-	.enable     = syscon_clk_enable,
-	.disable    = syscon_clk_disable,
-	.get_rate   = clk_get_rate_ahb_clk,
-	.lock       = __SPIN_LOCK_UNLOCKED(ahb_clk.lock),
-};
-
-
-/*
- * Clocks on the AHB bridge
- */
-
-static struct clk ahb_subsys_clk = {
-	.name	    = "AHB_SUBSYS",
-	.parent	    = &amba_clk,
-	.rate	    = 52000000, /* this varies! */
-	.hw_ctrld   = true,
-	.reset	    = false,
-	.clk_val    = U300_SYSCON_SBCER_AHB_SUBSYS_BRIDGE_CLK_EN,
-	.enable     = syscon_clk_enable,
-	.disable    = syscon_clk_disable,
-	.get_rate   = clk_get_rate_ahb_clk,
-	.lock       = __SPIN_LOCK_UNLOCKED(ahb_subsys_clk.lock),
-};
-
-static struct clk intcon_clk = {
-	.name	    = "INTCON",
-	.parent	    = &ahb_subsys_clk,
-	.rate	    = 52000000, /* this varies! */
-	.hw_ctrld   = false,
-	.reset	    = true,
-	.res_reg    = U300_SYSCON_VBASE + U300_SYSCON_RRR,
-	.res_mask   = U300_SYSCON_RRR_INTCON_RESET_EN,
-	/* INTCON can be reset but not clock-gated */
-	.lock       = __SPIN_LOCK_UNLOCKED(intcon_clk.lock),
-
-};
-
-static struct clk mspro_clk = {
-	.name       = "MSPRO",
-	.parent	    = &ahb_subsys_clk,
-	.rate       = 0, /* FIXME */
-	.hw_ctrld   = false,
-	.reset	    = true,
-	.res_reg    = U300_SYSCON_VBASE + U300_SYSCON_RRR,
-	.res_mask   = U300_SYSCON_RRR_MSPRO_RESET_EN,
-	.clk_val    = U300_SYSCON_SBCER_MSPRO_CLK_EN,
-	.enable     = syscon_clk_enable,
-	.disable    = syscon_clk_disable,
-	.lock       = __SPIN_LOCK_UNLOCKED(mspro_clk.lock),
-};
-
-static struct clk emif_clk = {
-	.name	    = "EMIF",
-	.parent	    = &ahb_subsys_clk,
-	.rate	    = 104000000, /* this varies! */
-	.hw_ctrld   = false,
-	.reset	    = true,
-	.res_reg    = U300_SYSCON_VBASE + U300_SYSCON_RRR,
-	.res_mask   = U300_SYSCON_RRR_EMIF_RESET_EN,
-	.clk_val    = U300_SYSCON_SBCER_EMIF_CLK_EN,
-	.enable     = syscon_clk_enable,
-	.disable    = syscon_clk_disable,
-	.get_rate   = clk_get_rate_emif_clk,
-	.lock       = __SPIN_LOCK_UNLOCKED(emif_clk.lock),
-};
-
-
-/*
- * Clocks on the FAST bridge
- */
-static struct clk fast_clk = {
-	.name	    = "FAST_BRIDGE",
-	.parent	    = &amba_clk,
-	.rate	    = 13000000, /* this varies! */
-	.hw_ctrld   = true,
-	.reset	    = true,
-	.res_reg    = U300_SYSCON_VBASE + U300_SYSCON_RFR,
-	.res_mask   = U300_SYSCON_RFR_FAST_BRIDGE_RESET_ENABLE,
-	.clk_val    = U300_SYSCON_SBCER_FAST_BRIDGE_CLK_EN,
-	.enable     = syscon_clk_enable,
-	.disable    = syscon_clk_disable,
-	.lock       = __SPIN_LOCK_UNLOCKED(fast_clk.lock),
-};
-
-/*
- * The MMCI apb_pclk is hardwired to the same terminal as the
- * external MCI clock. Thus this will be referenced twice.
- */
-static struct clk mmcsd_clk = {
-	.name       = "MCLK",
-	.parent	    = &fast_clk,
-	.rate       = 18900000, /* this varies! */
-	.hw_ctrld   = false,
-	.reset	    = true,
-	.res_reg    = U300_SYSCON_VBASE + U300_SYSCON_RFR,
-	.res_mask   = U300_SYSCON_RFR_MMC_RESET_ENABLE,
-	.clk_val    = U300_SYSCON_SBCER_MMC_CLK_EN,
-	.get_rate   = clk_get_rate_mclk,
-	.set_rate   = clk_set_rate_mclk,
-	.round_rate = clk_round_rate_mclk,
-	.disable    = syscon_clk_disable,
-	.enable     = syscon_clk_enable,
-	.lock       = __SPIN_LOCK_UNLOCKED(mmcsd_clk.lock),
-};
-
-static struct clk i2s0_clk = {
-	.name       = "i2s0",
-	.parent	    = &fast_clk,
-	.rate       = 26000000, /* this varies! */
-	.hw_ctrld   = true,
-	.reset	    = true,
-	.res_reg    = U300_SYSCON_VBASE + U300_SYSCON_RFR,
-	.res_mask   = U300_SYSCON_RFR_PCM_I2S0_RESET_ENABLE,
-	.clk_val    = U300_SYSCON_SBCER_I2S0_CORE_CLK_EN,
-	.enable     = syscon_clk_enable,
-	.disable    = syscon_clk_disable,
-	.get_rate   = clk_get_rate_i2s_i2c_spi,
-	.lock       = __SPIN_LOCK_UNLOCKED(i2s0_clk.lock),
-};
-
-static struct clk i2s1_clk = {
-	.name       = "i2s1",
-	.parent	    = &fast_clk,
-	.rate       = 26000000, /* this varies! */
-	.hw_ctrld   = true,
-	.reset	    = true,
-	.res_reg    = U300_SYSCON_VBASE + U300_SYSCON_RFR,
-	.res_mask   = U300_SYSCON_RFR_PCM_I2S1_RESET_ENABLE,
-	.clk_val    = U300_SYSCON_SBCER_I2S1_CORE_CLK_EN,
-	.enable     = syscon_clk_enable,
-	.disable    = syscon_clk_disable,
-	.get_rate   = clk_get_rate_i2s_i2c_spi,
-	.lock       = __SPIN_LOCK_UNLOCKED(i2s1_clk.lock),
-};
-
-static struct clk i2c0_clk = {
-	.name       = "I2C0",
-	.parent	    = &fast_clk,
-	.rate       = 26000000, /* this varies! */
-	.hw_ctrld   = false,
-	.reset	    = true,
-	.res_reg    = U300_SYSCON_VBASE + U300_SYSCON_RFR,
-	.res_mask   = U300_SYSCON_RFR_I2C0_RESET_ENABLE,
-	.clk_val    = U300_SYSCON_SBCER_I2C0_CLK_EN,
-	.enable     = syscon_clk_enable,
-	.disable    = syscon_clk_disable,
-	.get_rate   = clk_get_rate_i2s_i2c_spi,
-	.lock       = __SPIN_LOCK_UNLOCKED(i2c0_clk.lock),
-};
-
-static struct clk i2c1_clk = {
-	.name       = "I2C1",
-	.parent	    = &fast_clk,
-	.rate       = 26000000, /* this varies! */
-	.hw_ctrld   = false,
-	.reset	    = true,
-	.res_reg    = U300_SYSCON_VBASE + U300_SYSCON_RFR,
-	.res_mask   = U300_SYSCON_RFR_I2C1_RESET_ENABLE,
-	.clk_val    = U300_SYSCON_SBCER_I2C1_CLK_EN,
-	.enable     = syscon_clk_enable,
-	.disable    = syscon_clk_disable,
-	.get_rate   = clk_get_rate_i2s_i2c_spi,
-	.lock       = __SPIN_LOCK_UNLOCKED(i2c1_clk.lock),
-};
-
-/*
- * The SPI apb_pclk is hardwired to the same terminal as the
- * external SPI clock. Thus this will be referenced twice.
- */
-static struct clk spi_clk = {
-	.name       = "SPI",
-	.parent	    = &fast_clk,
-	.rate       = 26000000, /* this varies! */
-	.hw_ctrld   = false,
-	.reset	    = true,
-	.res_reg    = U300_SYSCON_VBASE + U300_SYSCON_RFR,
-	.res_mask   = U300_SYSCON_RFR_SPI_RESET_ENABLE,
-	.clk_val    = U300_SYSCON_SBCER_SPI_CLK_EN,
-	.enable     = syscon_clk_enable,
-	.disable    = syscon_clk_disable,
-	.get_rate   = clk_get_rate_i2s_i2c_spi,
-	.lock       = __SPIN_LOCK_UNLOCKED(spi_clk.lock),
-};
-
-#ifdef CONFIG_MACH_U300_BS335
-static struct clk uart1_pclk = {
-	.name	    = "UART1_PCLK",
-	.parent	    = &fast_clk,
-	.hw_ctrld   = false,
-	.reset	    = true,
-	.res_reg    = U300_SYSCON_VBASE + U300_SYSCON_RFR,
-	.res_mask   = U300_SYSCON_RFR_UART1_RESET_ENABLE,
-	.clk_val    = U300_SYSCON_SBCER_UART1_CLK_EN,
-	.enable     = syscon_clk_enable,
-	.disable    = syscon_clk_disable,
-	.lock       = __SPIN_LOCK_UNLOCKED(uart1_pclk.lock),
-};
-
-/* This one is hardwired to PLL13 */
-static struct clk uart1_clk = {
-	.name	    = "UART1_CLK",
-	.rate	    = 13000000,
-	.hw_ctrld   = true,
-	.lock       = __SPIN_LOCK_UNLOCKED(uart1_clk.lock),
-};
-#endif
-
-
-/*
- * Clocks on the SLOW bridge
- */
-static struct clk slow_clk = {
-	.name	    = "SLOW_BRIDGE",
-	.parent	    = &amba_clk,
-	.rate	    = 13000000,
-	.hw_ctrld   = true,
-	.reset	    = true,
-	.res_reg    = U300_SYSCON_VBASE + U300_SYSCON_RSR,
-	.res_mask   = U300_SYSCON_RSR_SLOW_BRIDGE_RESET_EN,
-	.clk_val    = U300_SYSCON_SBCER_SLOW_BRIDGE_CLK_EN,
-	.enable     = syscon_clk_enable,
-	.disable    = syscon_clk_disable,
-	.lock       = __SPIN_LOCK_UNLOCKED(slow_clk.lock),
-};
-
-/* TODO: implement SYSCON clock? */
-
-static struct clk wdog_clk = {
-	.name	    = "WDOG",
-	.parent	    = &slow_clk,
-	.hw_ctrld   = false,
-	.rate	    = 32768,
-	.reset	    = false,
-	/* This is always on, cannot be enabled/disabled or reset */
-	.lock       = __SPIN_LOCK_UNLOCKED(wdog_clk.lock),
-};
-
-static struct clk uart0_pclk = {
-	.name	    = "UART0_PCLK",
-	.parent	    = &slow_clk,
-	.hw_ctrld   = false,
-	.reset	    = true,
-	.res_reg    = U300_SYSCON_VBASE + U300_SYSCON_RSR,
-	.res_mask   = U300_SYSCON_RSR_UART_RESET_EN,
-	.clk_val    = U300_SYSCON_SBCER_UART_CLK_EN,
-	.enable     = syscon_clk_enable,
-	.disable    = syscon_clk_disable,
-	.lock       = __SPIN_LOCK_UNLOCKED(uart0_pclk.lock),
-};
-
-/* This one is hardwired to PLL13 */
-static struct clk uart0_clk = {
-	.name	    = "UART0_CLK",
-	.parent	    = &slow_clk,
-	.rate	    = 13000000,
-	.hw_ctrld   = true,
-	.lock       = __SPIN_LOCK_UNLOCKED(uart0_clk.lock),
-};
-
-static struct clk keypad_clk = {
-	.name       = "KEYPAD",
-	.parent	    = &slow_clk,
-	.rate       = 32768,
-	.hw_ctrld   = false,
-	.reset	    = true,
-	.res_reg    = U300_SYSCON_VBASE + U300_SYSCON_RSR,
-	.res_mask   = U300_SYSCON_RSR_KEYPAD_RESET_EN,
-	.clk_val    = U300_SYSCON_SBCER_KEYPAD_CLK_EN,
-	.enable     = syscon_clk_enable,
-	.disable    = syscon_clk_disable,
-	.lock       = __SPIN_LOCK_UNLOCKED(keypad_clk.lock),
-};
-
-static struct clk gpio_clk = {
-	.name       = "GPIO",
-	.parent	    = &slow_clk,
-	.rate       = 13000000,
-	.hw_ctrld   = true,
-	.reset	    = true,
-	.res_reg    = U300_SYSCON_VBASE + U300_SYSCON_RSR,
-	.res_mask   = U300_SYSCON_RSR_GPIO_RESET_EN,
-	.clk_val    = U300_SYSCON_SBCER_GPIO_CLK_EN,
-	.enable     = syscon_clk_enable,
-	.disable    = syscon_clk_disable,
-	.lock       = __SPIN_LOCK_UNLOCKED(gpio_clk.lock),
-};
-
-static struct clk rtc_clk = {
-	.name	    = "RTC",
-	.parent	    = &slow_clk,
-	.rate	    = 32768,
-	.hw_ctrld   = true,
-	.reset	    = true,
-	.res_reg    = U300_SYSCON_VBASE + U300_SYSCON_RSR,
-	.res_mask   = U300_SYSCON_RSR_RTC_RESET_EN,
-	/* This clock is always on, cannot be enabled/disabled */
-	.lock       = __SPIN_LOCK_UNLOCKED(rtc_clk.lock),
-};
-
-static struct clk bustr_clk = {
-	.name       = "BUSTR",
-	.parent	    = &slow_clk,
-	.rate       = 13000000,
-	.hw_ctrld   = true,
-	.reset	    = true,
-	.res_reg    = U300_SYSCON_VBASE + U300_SYSCON_RSR,
-	.res_mask   = U300_SYSCON_RSR_BTR_RESET_EN,
-	.clk_val    = U300_SYSCON_SBCER_BTR_CLK_EN,
-	.enable     = syscon_clk_enable,
-	.disable    = syscon_clk_disable,
-	.lock       = __SPIN_LOCK_UNLOCKED(bustr_clk.lock),
-};
-
-static struct clk evhist_clk = {
-	.name       = "EVHIST",
-	.parent	    = &slow_clk,
-	.rate       = 13000000,
-	.hw_ctrld   = true,
-	.reset	    = true,
-	.res_reg    = U300_SYSCON_VBASE + U300_SYSCON_RSR,
-	.res_mask   = U300_SYSCON_RSR_EH_RESET_EN,
-	.clk_val    = U300_SYSCON_SBCER_EH_CLK_EN,
-	.enable     = syscon_clk_enable,
-	.disable    = syscon_clk_disable,
-	.lock       = __SPIN_LOCK_UNLOCKED(evhist_clk.lock),
-};
-
-static struct clk timer_clk = {
-	.name       = "TIMER",
-	.parent	    = &slow_clk,
-	.rate       = 13000000,
-	.hw_ctrld   = true,
-	.reset	    = true,
-	.res_reg    = U300_SYSCON_VBASE + U300_SYSCON_RSR,
-	.res_mask   = U300_SYSCON_RSR_ACC_TMR_RESET_EN,
-	.clk_val    = U300_SYSCON_SBCER_ACC_TMR_CLK_EN,
-	.enable     = syscon_clk_enable,
-	.disable    = syscon_clk_disable,
-	.lock       = __SPIN_LOCK_UNLOCKED(timer_clk.lock),
-};
-
-/*
- * There is a binary divider in the hardware that divides
- * the 13MHz PLL by 13 down to 1 MHz.
- */
-static struct clk app_timer_clk = {
-	.name       = "TIMER_APP",
-	.parent	    = &slow_clk,
-	.rate       = 1000000,
-	.hw_ctrld   = true,
-	.reset	    = true,
-	.res_reg    = U300_SYSCON_VBASE + U300_SYSCON_RSR,
-	.res_mask   = U300_SYSCON_RSR_APP_TMR_RESET_EN,
-	.clk_val    = U300_SYSCON_SBCER_APP_TMR_CLK_EN,
-	.enable     = syscon_clk_enable,
-	.disable    = syscon_clk_disable,
-	.lock       = __SPIN_LOCK_UNLOCKED(app_timer_clk.lock),
-};
-
-#ifdef CONFIG_MACH_U300_BS335
-static struct clk ppm_clk = {
-	.name	    = "PPM",
-	.parent	    = &slow_clk,
-	.rate	    = 0, /* FIXME */
-	.hw_ctrld   = true, /* TODO: Look up if it is hw ctrld or not */
-	.reset	    = true,
-	.res_reg    = U300_SYSCON_VBASE + U300_SYSCON_RSR,
-	.res_mask   = U300_SYSCON_RSR_PPM_RESET_EN,
-	.clk_val    = U300_SYSCON_SBCER_PPM_CLK_EN,
-	.enable     = syscon_clk_enable,
-	.disable    = syscon_clk_disable,
-	.lock       = __SPIN_LOCK_UNLOCKED(ppm_clk.lock),
-};
-#endif
-
-#define DEF_LOOKUP(devid, clkref)		\
-	{					\
-	.dev_id = devid,			\
-	.clk = clkref,				\
-	}
-
-#define DEF_LOOKUP_CON(devid, conid, clkref)	\
-	{					\
-	.dev_id = devid,			\
-	.con_id = conid,			\
-	.clk = clkref,				\
-	}
-
-/*
- * Here we only define clocks that are meaningful to
- * look up through clockdevice.
- */
-static struct clk_lookup lookups[] = {
-	/* Connected directly to the AMBA bus */
-	DEF_LOOKUP("amba",      &amba_clk),
-	DEF_LOOKUP("cpu",       &cpu_clk),
-	DEF_LOOKUP("fsmc-nand", &nandif_clk),
-	DEF_LOOKUP("semi",      &semi_clk),
-#ifdef CONFIG_MACH_U300_BS335
-	DEF_LOOKUP("isp",       &isp_clk),
-	DEF_LOOKUP("cds",       &cds_clk),
-#endif
-	DEF_LOOKUP("dma",       &dma_clk),
-	DEF_LOOKUP("msl",       &aaif_clk),
-	DEF_LOOKUP("apex",      &apex_clk),
-	DEF_LOOKUP("video_enc", &video_enc_clk),
-	DEF_LOOKUP("xgam",      &xgam_clk),
-	DEF_LOOKUP("ahb",       &ahb_clk),
-	/* AHB bridge clocks */
-	DEF_LOOKUP("ahb_subsys", &ahb_subsys_clk),
-	DEF_LOOKUP("intcon",    &intcon_clk),
-	DEF_LOOKUP_CON("intcon", "apb_pclk", &intcon_clk),
-	DEF_LOOKUP("mspro",     &mspro_clk),
-	DEF_LOOKUP("pl172",     &emif_clk),
-	DEF_LOOKUP_CON("pl172", "apb_pclk", &emif_clk),
-	/* FAST bridge clocks */
-	DEF_LOOKUP("fast",      &fast_clk),
-	DEF_LOOKUP("mmci",      &mmcsd_clk),
-	DEF_LOOKUP_CON("mmci", "apb_pclk", &mmcsd_clk),
-	/*
-	 * The .0 and .1 identifiers on these comes from the platform device
-	 * .id field and are assigned when the platform devices are registered.
-	 */
-	DEF_LOOKUP("i2s.0",     &i2s0_clk),
-	DEF_LOOKUP("i2s.1",     &i2s1_clk),
-	DEF_LOOKUP("stu300.0",  &i2c0_clk),
-	DEF_LOOKUP("stu300.1",  &i2c1_clk),
-	DEF_LOOKUP("pl022",     &spi_clk),
-	DEF_LOOKUP_CON("pl022", "apb_pclk", &spi_clk),
-#ifdef CONFIG_MACH_U300_BS335
-	DEF_LOOKUP("uart1",     &uart1_clk),
-	DEF_LOOKUP_CON("uart1", "apb_pclk", &uart1_pclk),
-#endif
-	/* SLOW bridge clocks */
-	DEF_LOOKUP("slow",      &slow_clk),
-	DEF_LOOKUP("coh901327_wdog",      &wdog_clk),
-	DEF_LOOKUP("uart0",     &uart0_clk),
-	DEF_LOOKUP_CON("uart0", "apb_pclk", &uart0_pclk),
-	DEF_LOOKUP("apptimer",  &app_timer_clk),
-	DEF_LOOKUP("coh901461-keypad",    &keypad_clk),
-	DEF_LOOKUP("u300-gpio", &gpio_clk),
-	DEF_LOOKUP("rtc-coh901331",      &rtc_clk),
-	DEF_LOOKUP("bustr",     &bustr_clk),
-	DEF_LOOKUP("evhist",    &evhist_clk),
-	DEF_LOOKUP("timer",     &timer_clk),
-#ifdef CONFIG_MACH_U300_BS335
-	DEF_LOOKUP("ppm",       &ppm_clk),
-#endif
-};
-
-static void __init clk_register(void)
-{
-	/* Register the lookups */
-	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
-}
-
-#if (defined(CONFIG_DEBUG_FS) && defined(CONFIG_U300_DEBUG))
-/*
- * The following makes it possible to view the status (especially
- * reference count and reset status) for the clocks in the platform
- * by looking into the special file <debugfs>/u300_clocks
- */
-
-/* A list of all clocks in the platform */
-static struct clk *clks[] = {
-	/* Top node clock for the AMBA bus */
-	&amba_clk,
-	/* Connected directly to the AMBA bus */
-	&cpu_clk,
-	&nandif_clk,
-	&semi_clk,
-#ifdef CONFIG_MACH_U300_BS335
-	&isp_clk,
-	&cds_clk,
-#endif
-	&dma_clk,
-	&aaif_clk,
-	&apex_clk,
-	&video_enc_clk,
-	&xgam_clk,
-	&ahb_clk,
-
-	/* AHB bridge clocks */
-	&ahb_subsys_clk,
-	&intcon_clk,
-	&mspro_clk,
-	&emif_clk,
-	/* FAST bridge clocks */
-	&fast_clk,
-	&mmcsd_clk,
-	&i2s0_clk,
-	&i2s1_clk,
-	&i2c0_clk,
-	&i2c1_clk,
-	&spi_clk,
-#ifdef CONFIG_MACH_U300_BS335
-	&uart1_clk,
-	&uart1_pclk,
-#endif
-	/* SLOW bridge clocks */
-	&slow_clk,
-	&wdog_clk,
-	&uart0_clk,
-	&uart0_pclk,
-	&app_timer_clk,
-	&keypad_clk,
-	&gpio_clk,
-	&rtc_clk,
-	&bustr_clk,
-	&evhist_clk,
-	&timer_clk,
-#ifdef CONFIG_MACH_U300_BS335
-	&ppm_clk,
-#endif
-};
-
-static int u300_clocks_show(struct seq_file *s, void *data)
-{
-	struct clk *clk;
-	int i;
-
-	seq_printf(s, "CLOCK           DEVICE          RESET STATE\t" \
-		   "ACTIVE\tUSERS\tHW CTRL FREQ\n");
-	seq_printf(s, "---------------------------------------------" \
-		   "-----------------------------------------\n");
-	for (i = 0; i < ARRAY_SIZE(clks); i++) {
-		clk = clks[i];
-		if (clk != ERR_PTR(-ENOENT)) {
-			/* Format clock and device name nicely */
-			char cdp[33];
-			int chars;
-
-			chars = snprintf(&cdp[0], 17, "%s", clk->name);
-			while (chars < 16) {
-				cdp[chars] = ' ';
-				chars++;
-			}
-			chars = snprintf(&cdp[16], 17, "%s", clk->dev ?
-					 dev_name(clk->dev) : "N/A");
-			while (chars < 16) {
-				cdp[chars+16] = ' ';
-				chars++;
-			}
-			cdp[32] = '\0';
-			if (clk->get_rate || clk->rate != 0)
-				seq_printf(s,
-					   "%s%s\t%s\t%d\t%s\t%lu Hz\n",
-					   &cdp[0],
-					   clk->reset ?
-					   "ASSERTED" : "RELEASED",
-					   clk->usecount ? "ON" : "OFF",
-					   clk->usecount,
-					   clk->hw_ctrld  ? "YES" : "NO ",
-					   clk_get_rate(clk));
-			else
-				seq_printf(s,
-					   "%s%s\t%s\t%d\t%s\t" \
-					   "(unknown rate)\n",
-					   &cdp[0],
-					   clk->reset ?
-					   "ASSERTED" : "RELEASED",
-					   clk->usecount ? "ON" : "OFF",
-					   clk->usecount,
-					   clk->hw_ctrld  ? "YES" : "NO ");
-		}
-	}
-	return 0;
-}
-
-static int u300_clocks_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, u300_clocks_show, NULL);
-}
-
-static const struct file_operations u300_clocks_operations = {
-	.open		= u300_clocks_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
-static int __init init_clk_read_debugfs(void)
-{
-	/* Expose a simple debugfs interface to view all clocks */
-	(void) debugfs_create_file("u300_clocks", S_IFREG | S_IRUGO,
-				   NULL, NULL,
-				   &u300_clocks_operations);
-	return 0;
-}
-/*
- * This needs to come in after the core_initcall() for the
- * overall clocks, because debugfs is not available until
- * the subsystems come up.
- */
-module_init(init_clk_read_debugfs);
-#endif
-
-int __init u300_clock_init(void)
-{
-	u16 val;
-
-	/*
-	 * FIXME: shall all this powermanagement stuff really live here???
-	 */
-
-	/* Set system to run at PLL208, max performance, a known state. */
-	val = readw(U300_SYSCON_VBASE + U300_SYSCON_CCR);
-	val &= ~U300_SYSCON_CCR_CLKING_PERFORMANCE_MASK;
-	writew(val, U300_SYSCON_VBASE + U300_SYSCON_CCR);
-	/* Wait for the PLL208 to lock if not locked in yet */
-	while (!(readw(U300_SYSCON_VBASE + U300_SYSCON_CSR) &
-		 U300_SYSCON_CSR_PLL208_LOCK_IND));
-
-	/* Power management enable */
-	val = readw(U300_SYSCON_VBASE + U300_SYSCON_PMCR);
-	val |= U300_SYSCON_PMCR_PWR_MGNT_ENABLE;
-	writew(val, U300_SYSCON_VBASE + U300_SYSCON_PMCR);
-
-	clk_register();
-
-	/*
-	 * Some of these may be on when we boot the system so make sure they
-	 * are turned OFF.
-	 */
-	syscon_block_reset_enable(&timer_clk);
-	timer_clk.disable(&timer_clk);
-
-	/*
-	 * These shall be turned on by default when we boot the system
-	 * so make sure they are ON. (Adding CPU here is a bit too much.)
-	 * These clocks will be claimed by drivers later.
-	 */
-	syscon_block_reset_disable(&semi_clk);
-	syscon_block_reset_disable(&emif_clk);
-	clk_enable(&semi_clk);
-	clk_enable(&emif_clk);
-
-	return 0;
-}
diff --git a/arch/arm/mach-u300/clock.h b/arch/arm/mach-u300/clock.h
deleted file mode 100644
index 4f50ca8..0000000
--- a/arch/arm/mach-u300/clock.h
+++ /dev/null
@@ -1,50 +0,0 @@
-/*
- * arch/arm/mach-u300/include/mach/clock.h
- *
- * Copyright (C) 2004 - 2005 Nokia corporation
- * Written by Tuukka Tikkanen <tuukka.tikkanen@elektrobit.com>
- * Based on clocks.h by Tony Lindgren, Gordon McNutt and RidgeRun, Inc
- * Copyright (C) 2007-2009 ST-Ericsson AB
- * Adopted to ST-Ericsson U300 platforms by
- * Jonas Aaberg <jonas.aberg@stericsson.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- */
-
-#ifndef __MACH_CLOCK_H
-#define __MACH_CLOCK_H
-
-#include <linux/clk.h>
-
-struct clk {
-	struct list_head node;
-	struct module *owner;
-	struct device *dev;
-	const char *name;
-	struct clk *parent;
-
-	spinlock_t lock;
-	unsigned long rate;
-	bool reset;
-	__u16 clk_val;
-	__s8 usecount;
-	void __iomem * res_reg;
-	__u16 res_mask;
-
-	bool hw_ctrld;
-
-	void (*recalc) (struct clk *);
-	int (*set_rate) (struct clk *, unsigned long);
-	unsigned long (*get_rate) (struct clk *);
-	unsigned long (*round_rate) (struct clk *, unsigned long);
-	void (*init) (struct clk *);
-	void (*enable) (struct clk *);
-	void (*disable) (struct clk *);
-};
-
-int u300_clock_init(void);
-
-#endif
diff --git a/arch/arm/mach-u300/core.c b/arch/arm/mach-u300/core.c
index 3333974..03acf18 100644
--- a/arch/arm/mach-u300/core.c
+++ b/arch/arm/mach-u300/core.c
@@ -30,6 +30,7 @@
 #include <linux/pinctrl/consumer.h>
 #include <linux/pinctrl/pinconf-generic.h>
 #include <linux/dma-mapping.h>
+#include <linux/platform_data/clk-u300.h>
 
 #include <asm/types.h>
 #include <asm/setup.h>
@@ -44,7 +45,6 @@
 #include <mach/dma_channels.h>
 #include <mach/gpio-u300.h>
 
-#include "clock.h"
 #include "spi.h"
 #include "i2c.h"
 #include "u300-gpio.h"
@@ -1658,12 +1658,20 @@ void __init u300_init_irq(void)
 	int i;
 
 	/* initialize clocking early, we want to clock the INTCON */
-	u300_clock_init();
+	u300_clk_init(U300_SYSCON_VBASE);
+
+	/* Bootstrap EMIF and SEMI clocks */
+	clk = clk_get_sys("pl172", NULL);
+	BUG_ON(IS_ERR(clk));
+	clk_prepare_enable(clk);
+	clk = clk_get_sys("semi", NULL);
+	BUG_ON(IS_ERR(clk));
+	clk_prepare_enable(clk);
 
 	/* Clock the interrupt controller */
 	clk = clk_get_sys("intcon", NULL);
 	BUG_ON(IS_ERR(clk));
-	clk_enable(clk);
+	clk_prepare_enable(clk);
 
 	for (i = 0; i < U300_VIC_IRQS_END; i++)
 		set_bit(i, (unsigned long *) &mask[0]);
@@ -1811,13 +1819,6 @@ void __init u300_init_devices(void)
 	/* Check what platform we run and print some status information */
 	u300_init_check_chip();
 
-	/* Set system to run at PLL208, max performance, a known state. */
-	val = readw(U300_SYSCON_VBASE + U300_SYSCON_CCR);
-	val &= ~U300_SYSCON_CCR_CLKING_PERFORMANCE_MASK;
-	writew(val, U300_SYSCON_VBASE + U300_SYSCON_CCR);
-	/* Wait for the PLL208 to lock if not locked in yet */
-	while (!(readw(U300_SYSCON_VBASE + U300_SYSCON_CSR) &
-		 U300_SYSCON_CSR_PLL208_LOCK_IND));
 	/* Initialize SPI device with some board specifics */
 	u300_spi_init(&pl022_device);
 
diff --git a/arch/arm/mach-u300/timer.c b/arch/arm/mach-u300/timer.c
index bc1c789..56ac06d 100644
--- a/arch/arm/mach-u300/timer.c
+++ b/arch/arm/mach-u300/timer.c
@@ -354,7 +354,7 @@ static void __init u300_timer_init(void)
 	/* Clock the interrupt controller */
 	clk = clk_get_sys("apptimer", NULL);
 	BUG_ON(IS_ERR(clk));
-	clk_enable(clk);
+	clk_prepare_enable(clk);
 	rate = clk_get_rate(clk);
 
 	setup_sched_clock(u300_read_sched_clock, 32, rate);
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index b9a5158..550b9b5 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -5,3 +5,4 @@ obj-$(CONFIG_COMMON_CLK)	+= clk.o clk-fixed-rate.o clk-gate.o \
 # SoCs specific
 obj-$(CONFIG_ARCH_MXS)		+= mxs/
 obj-$(CONFIG_PLAT_SPEAR)	+= spear/
+obj-$(CONFIG_ARCH_U300)		+= clk-u300.o
diff --git a/drivers/clk/clk-u300.c b/drivers/clk/clk-u300.c
new file mode 100644
index 0000000..a15f792
--- /dev/null
+++ b/drivers/clk/clk-u300.c
@@ -0,0 +1,746 @@
+/*
+ * U300 clock implementation
+ * Copyright (C) 2007-2012 ST-Ericsson AB
+ * License terms: GNU General Public License (GPL) version 2
+ * Author: Linus Walleij <linus.walleij@stericsson.com>
+ * Author: Jonas Aaberg <jonas.aberg@stericsson.com>
+ */
+#include <linux/clk.h>
+#include <linux/clkdev.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/clk-provider.h>
+#include <linux/spinlock.h>
+#include <mach/syscon.h>
+
+/*
+ * The clocking hierarchy currently looks like this.
+ * NOTE: the idea is NOT to show how the clocks are routed on the chip!
+ * The ideas is to show dependencies, so a clock higher up in the
+ * hierarchy has to be on in order for another clock to be on. Now,
+ * both CPU and DMA can actually be on top of the hierarchy, and that
+ * is not modeled currently. Instead we have the backbone AMBA bus on
+ * top. This bus cannot be programmed in any way but conceptually it
+ * needs to be active for the bridges and devices to transport data.
+ *
+ * Please be aware that a few clocks are hw controlled, which mean that
+ * the hw itself can turn on/off or change the rate of the clock when
+ * needed!
+ *
+ *  AMBA bus
+ *  |
+ *  +- CPU
+ *  +- FSMC NANDIF NAND Flash interface
+ *  +- SEMI Shared Memory interface
+ *  +- ISP Image Signal Processor (U335 only)
+ *  +- CDS (U335 only)
+ *  +- DMA Direct Memory Access Controller
+ *  +- AAIF APP/ACC Inteface (Mobile Scalable Link, MSL)
+ *  +- APEX
+ *  +- VIDEO_ENC AVE2/3 Video Encoder
+ *  +- XGAM Graphics Accelerator Controller
+ *  +- AHB
+ *  |
+ *  +- ahb:0 AHB Bridge
+ *  |  |
+ *  |  +- ahb:1 INTCON Interrupt controller
+ *  |  +- ahb:3 MSPRO  Memory Stick Pro controller
+ *  |  +- ahb:4 EMIF   External Memory interface
+ *  |
+ *  +- fast:0 FAST bridge
+ *  |  |
+ *  |  +- fast:1 MMCSD MMC/SD card reader controller
+ *  |  +- fast:2 I2S0  PCM I2S channel 0 controller
+ *  |  +- fast:3 I2S1  PCM I2S channel 1 controller
+ *  |  +- fast:4 I2C0  I2C channel 0 controller
+ *  |  +- fast:5 I2C1  I2C channel 1 controller
+ *  |  +- fast:6 SPI   SPI controller
+ *  |  +- fast:7 UART1 Secondary UART (U335 only)
+ *  |
+ *  +- slow:0 SLOW bridge
+ *     |
+ *     +- slow:1 SYSCON (not possible to control)
+ *     +- slow:2 WDOG Watchdog
+ *     +- slow:3 UART0 primary UART
+ *     +- slow:4 TIMER_APP Application timer - used in Linux
+ *     +- slow:5 KEYPAD controller
+ *     +- slow:6 GPIO controller
+ *     +- slow:7 RTC controller
+ *     +- slow:8 BT Bus Tracer (not used currently)
+ *     +- slow:9 EH Event Handler (not used currently)
+ *     +- slow:a TIMER_ACC Access style timer (not used currently)
+ *     +- slow:b PPM (U335 only, what is that?)
+ */
+
+/* Global syscon virtual base */
+static void __iomem *syscon_vbase;
+
+/**
+ * struct clk_syscon - U300 syscon clock
+ * @hw: corresponding clock hardware entry
+ * @hw_ctrld: whether this clock is hardware controlled (for refcount etc)
+ *	and does not need any magic pokes to be enabled/disabled
+ * @reset: state holder, whether this block's reset line is asserted or not
+ * @res_reg: reset line enable/disable flag register
+ * @res_bit: bit for resetting or taking this consumer out of reset
+ * @en_reg: clock line enable/disable flag register
+ * @en_bit: bit for enabling/disabling this consumer clock line
+ * @clk_val: magic value to poke in the register to enable/disable
+ *	this one clock
+ */
+struct clk_syscon {
+	struct clk_hw hw;
+	bool hw_ctrld;
+	bool reset;
+	void __iomem *res_reg;
+	u8 res_bit;
+	void __iomem *en_reg;
+	u8 en_bit;
+	u16 clk_val;
+};
+
+#define to_syscon(_hw) container_of(_hw, struct clk_syscon, hw)
+
+static DEFINE_SPINLOCK(syscon_resetreg_lock);
+
+/*
+ * Reset control functions. We remember if a block has been
+ * taken out of reset and don't remove the reset assertion again
+ * and vice versa. Currently we only remove resets so the
+ * enablement function is defined out.
+ */
+static void syscon_block_reset_enable(struct clk_syscon *sclk)
+{
+	unsigned long iflags;
+	u16 val;
+
+	/* Not all blocks support resetting */
+	if (!sclk->res_reg)
+		return;
+	spin_lock_irqsave(&syscon_resetreg_lock, iflags);
+	val = readw(sclk->res_reg);
+	val |= BIT(sclk->res_bit);
+	writew(val, sclk->res_reg);
+	spin_unlock_irqrestore(&syscon_resetreg_lock, iflags);
+	sclk->reset = true;
+}
+
+static void syscon_block_reset_disable(struct clk_syscon *sclk)
+{
+	unsigned long iflags;
+	u16 val;
+
+	/* Not all blocks support resetting */
+	if (!sclk->res_reg)
+		return;
+	spin_lock_irqsave(&syscon_resetreg_lock, iflags);
+	val = readw(sclk->res_reg);
+	val &= ~BIT(sclk->res_bit);
+	writew(val, sclk->res_reg);
+	spin_unlock_irqrestore(&syscon_resetreg_lock, iflags);
+	sclk->reset = false;
+}
+
+static int syscon_clk_prepare(struct clk_hw *hw)
+{
+	struct clk_syscon *sclk = to_syscon(hw);
+
+	/* If the block is in reset, bring it out */
+	if (sclk->reset)
+		syscon_block_reset_disable(sclk);
+	return 0;
+}
+
+static void syscon_clk_unprepare(struct clk_hw *hw)
+{
+	struct clk_syscon *sclk = to_syscon(hw);
+
+	/* Please don't force the console into reset */
+	if (sclk->clk_val == U300_SYSCON_SBCER_UART_CLK_EN)
+		return;
+	/* When unpreparing, force block into reset */
+	if (!sclk->reset)
+		syscon_block_reset_enable(sclk);
+}
+
+static int syscon_clk_enable(struct clk_hw *hw)
+{
+	struct clk_syscon *sclk = to_syscon(hw);
+
+	/* Don't touch the hardware controlled clocks */
+	if (sclk->hw_ctrld)
+		return 0;
+	/* These cannot be controlled */
+	if (sclk->clk_val == 0xFFFFU)
+		return 0;
+
+	writew(sclk->clk_val, syscon_vbase + U300_SYSCON_SBCER);
+	return 0;
+}
+
+static void syscon_clk_disable(struct clk_hw *hw)
+{
+	struct clk_syscon *sclk = to_syscon(hw);
+
+	/* Don't touch the hardware controlled clocks */
+	if (sclk->hw_ctrld)
+		return;
+	if (sclk->clk_val == 0xFFFFU)
+		return;
+	/* Please don't disable the console port */
+	if (sclk->clk_val == U300_SYSCON_SBCER_UART_CLK_EN)
+		return;
+
+	writew(sclk->clk_val, syscon_vbase + U300_SYSCON_SBCDR);
+}
+
+static int syscon_clk_is_enabled(struct clk_hw *hw)
+{
+	struct clk_syscon *sclk = to_syscon(hw);
+	u16 val;
+
+	/* If no enable register defined, it's always-on */
+	if (!sclk->en_reg)
+		return 1;
+
+	val = readw(sclk->en_reg);
+	val &= BIT(sclk->en_bit);
+
+	return val ? 1 : 0;
+}
+
+static u16 syscon_get_perf(void)
+{
+	u16 val;
+
+	val = readw(syscon_vbase + U300_SYSCON_CCR);
+	val &= U300_SYSCON_CCR_CLKING_PERFORMANCE_MASK;
+	return val;
+}
+
+static unsigned long
+syscon_clk_recalc_rate(struct clk_hw *hw,
+		       unsigned long parent_rate)
+{
+	struct clk_syscon *sclk = to_syscon(hw);
+	u16 perf = syscon_get_perf();
+
+	switch(sclk->clk_val) {
+	case U300_SYSCON_SBCER_FAST_BRIDGE_CLK_EN:
+	case U300_SYSCON_SBCER_I2C0_CLK_EN:
+	case U300_SYSCON_SBCER_I2C1_CLK_EN:
+	case U300_SYSCON_SBCER_MMC_CLK_EN:
+	case U300_SYSCON_SBCER_SPI_CLK_EN:
+		/* The FAST clocks have one progression */
+		switch(perf) {
+		case U300_SYSCON_CCR_CLKING_PERFORMANCE_LOW_POWER:
+		case U300_SYSCON_CCR_CLKING_PERFORMANCE_LOW:
+			return 13000000;
+		default:
+			return parent_rate; /* 26 MHz */
+		}
+	case U300_SYSCON_SBCER_DMAC_CLK_EN:
+	case U300_SYSCON_SBCER_NANDIF_CLK_EN:
+	case U300_SYSCON_SBCER_XGAM_CLK_EN:
+		/* AMBA interconnect peripherals */
+		switch(perf) {
+		case U300_SYSCON_CCR_CLKING_PERFORMANCE_LOW_POWER:
+		case U300_SYSCON_CCR_CLKING_PERFORMANCE_LOW:
+			return 6500000;
+		case U300_SYSCON_CCR_CLKING_PERFORMANCE_INTERMEDIATE:
+			return 26000000;
+		default:
+			return parent_rate; /* 52 MHz */
+		}
+	case U300_SYSCON_SBCER_SEMI_CLK_EN:
+	case U300_SYSCON_SBCER_EMIF_CLK_EN:
+		/* EMIF speeds */
+		switch(perf) {
+		case U300_SYSCON_CCR_CLKING_PERFORMANCE_LOW_POWER:
+		case U300_SYSCON_CCR_CLKING_PERFORMANCE_LOW:
+			return 13000000;
+		case U300_SYSCON_CCR_CLKING_PERFORMANCE_INTERMEDIATE:
+			return 52000000;
+		default:
+			return 104000000;
+		}
+	case U300_SYSCON_SBCER_CPU_CLK_EN:
+		/* And the fast CPU clock */
+		switch(perf) {
+		case U300_SYSCON_CCR_CLKING_PERFORMANCE_LOW_POWER:
+		case U300_SYSCON_CCR_CLKING_PERFORMANCE_LOW:
+			return 13000000;
+		case U300_SYSCON_CCR_CLKING_PERFORMANCE_INTERMEDIATE:
+			return 52000000;
+		case U300_SYSCON_CCR_CLKING_PERFORMANCE_HIGH:
+			return 104000000;
+		default:
+			return parent_rate; /* 208 MHz */
+		}
+	default:
+		/*
+		 * The SLOW clocks and default just inherit the rate of
+		 * their parent (typically PLL13 13 MHz).
+		 */
+		return parent_rate;
+	}
+}
+
+static long
+syscon_clk_round_rate(struct clk_hw *hw, unsigned long rate,
+		      unsigned long *prate)
+{
+	struct clk_syscon *sclk = to_syscon(hw);
+
+	if (sclk->clk_val != U300_SYSCON_SBCER_CPU_CLK_EN)
+		return *prate;
+	/* We really only support setting the rate of the CPU clock */
+	if (rate <= 13000000)
+		return 13000000;
+	if (rate <= 52000000)
+		return 52000000;
+	if (rate <= 104000000)
+		return 104000000;
+	return 208000000;
+}
+
+static int syscon_clk_set_rate(struct clk_hw *hw, unsigned long rate,
+			       unsigned long parent_rate)
+{
+	struct clk_syscon *sclk = to_syscon(hw);
+	u16 val;
+
+	/* We only support setting the rate of the CPU clock */
+	if (sclk->clk_val != U300_SYSCON_SBCER_CPU_CLK_EN)
+		return -EINVAL;
+	switch (rate) {
+	case 13000000:
+		val = U300_SYSCON_CCR_CLKING_PERFORMANCE_LOW_POWER;
+		break;
+	case 52000000:
+		val = U300_SYSCON_CCR_CLKING_PERFORMANCE_INTERMEDIATE;
+		break;
+	case 104000000:
+		val = U300_SYSCON_CCR_CLKING_PERFORMANCE_HIGH;
+		break;
+	case 208000000:
+		val = U300_SYSCON_CCR_CLKING_PERFORMANCE_BEST;
+		break;
+	default:
+		return -EINVAL;
+	}
+	val |= readw(syscon_vbase + U300_SYSCON_CCR) &
+		~U300_SYSCON_CCR_CLKING_PERFORMANCE_MASK ;
+	writew(val, syscon_vbase + U300_SYSCON_CCR);
+	return 0;
+}
+
+static const struct clk_ops syscon_clk_ops = {
+	.prepare = syscon_clk_prepare,
+	.unprepare = syscon_clk_unprepare,
+	.enable = syscon_clk_enable,
+	.disable = syscon_clk_disable,
+	.is_enabled = syscon_clk_is_enabled,
+	.recalc_rate = syscon_clk_recalc_rate,
+	.round_rate = syscon_clk_round_rate,
+	.set_rate = syscon_clk_set_rate,
+};
+
+static struct clk * __init
+syscon_clk_register(struct device *dev, const char *name,
+		    const char *parent_name, unsigned long flags,
+		    bool hw_ctrld,
+		    void __iomem *res_reg, u8 res_bit,
+		    void __iomem *en_reg, u8 en_bit,
+		    u16 clk_val)
+{
+	struct clk *clk;
+	struct clk_syscon *sclk;
+	struct clk_init_data init;
+
+	sclk = kzalloc(sizeof(struct clk_syscon), GFP_KERNEL);
+	if (!sclk) {
+		pr_err("could not allocate syscon clock %s\n",
+			name);
+		return ERR_PTR(-ENOMEM);
+	}
+	init.name = name;
+	init.ops = &syscon_clk_ops;
+	init.flags = flags;
+	init.parent_names = (parent_name ? &parent_name : NULL);
+	init.num_parents = (parent_name ? 1 : 0);
+	sclk->hw.init = &init;
+	sclk->hw_ctrld = hw_ctrld;
+	/* Assume the block is in reset at registration */
+	sclk->reset = true;
+	sclk->res_reg = res_reg;
+	sclk->res_bit = res_bit;
+	sclk->en_reg = en_reg;
+	sclk->en_bit = en_bit;
+	sclk->clk_val = clk_val;
+
+	clk = clk_register(dev, &sclk->hw);
+	if (IS_ERR(clk))
+		kfree(sclk);
+
+	return clk;
+}
+
+/**
+ * struct clk_mclk - U300 MCLK clock (MMC/SD clock)
+ * @hw: corresponding clock hardware entry
+ * @is_mspro: if this is the memory stick clock rather than MMC/SD
+ */
+struct clk_mclk {
+	struct clk_hw hw;
+	bool is_mspro;
+};
+
+#define to_mclk(_hw) container_of(_hw, struct clk_mclk, hw)
+
+static int mclk_clk_prepare(struct clk_hw *hw)
+{
+	struct clk_mclk *mclk = to_mclk(hw);
+	u16 val;
+
+	/* The MMC and MSPRO clocks need some special set-up */
+	if (!mclk->is_mspro) {
+		/* Set default MMC clock divisor to 18.9 MHz */
+		writew(0x0054U, syscon_vbase + U300_SYSCON_MMF0R);
+		val = readw(syscon_vbase + U300_SYSCON_MMCR);
+		/* Disable the MMC feedback clock */
+		val &= ~U300_SYSCON_MMCR_MMC_FB_CLK_SEL_ENABLE;
+		/* Disable MSPRO frequency */
+		val &= ~U300_SYSCON_MMCR_MSPRO_FREQSEL_ENABLE;
+		writew(val, syscon_vbase + U300_SYSCON_MMCR);
+	} else {
+		val = readw(syscon_vbase + U300_SYSCON_MMCR);
+		/* Disable the MMC feedback clock */
+		val &= ~U300_SYSCON_MMCR_MMC_FB_CLK_SEL_ENABLE;
+		/* Enable MSPRO frequency */
+		val |= U300_SYSCON_MMCR_MSPRO_FREQSEL_ENABLE;
+		writew(val, syscon_vbase + U300_SYSCON_MMCR);
+	}
+
+	return 0;
+}
+
+static unsigned long
+mclk_clk_recalc_rate(struct clk_hw *hw,
+		     unsigned long parent_rate)
+{
+	u16 perf = syscon_get_perf();
+
+	switch (perf) {
+	case U300_SYSCON_CCR_CLKING_PERFORMANCE_LOW_POWER:
+		/*
+		 * Here, the 208 MHz PLL gets shut down and the always
+		 * on 13 MHz PLL used for RTC etc kicks into use
+		 * instead.
+		 */
+		return 13000000;
+	case U300_SYSCON_CCR_CLKING_PERFORMANCE_LOW:
+	case U300_SYSCON_CCR_CLKING_PERFORMANCE_INTERMEDIATE:
+	case U300_SYSCON_CCR_CLKING_PERFORMANCE_HIGH:
+	case U300_SYSCON_CCR_CLKING_PERFORMANCE_BEST:
+	{
+		/*
+		 * This clock is under program control. The register is
+		 * divided in two nybbles, bit 7-4 gives cycles-1 to count
+		 * high, bit 3-0 gives cycles-1 to count low. Distribute
+		 * these with no more than 1 cycle difference between
+		 * low and high and add low and high to get the actual
+		 * divisor. The base PLL is 208 MHz. Writing 0x00 will
+		 * divide by 1 and 1 so the highest frequency possible
+		 * is 104 MHz.
+		 *
+		 * e.g. 0x54 =>
+		 * f = 208 / ((5+1) + (4+1)) = 208 / 11 = 18.9 MHz
+		 */
+		u16 val = readw(syscon_vbase + U300_SYSCON_MMF0R) &
+			U300_SYSCON_MMF0R_MASK;
+		switch (val) {
+		case 0x0054:
+			return 18900000;
+		case 0x0044:
+			return 20800000;
+		case 0x0043:
+			return 23100000;
+		case 0x0033:
+			return 26000000;
+		case 0x0032:
+			return 29700000;
+		case 0x0022:
+			return 34700000;
+		case 0x0021:
+			return 41600000;
+		case 0x0011:
+			return 52000000;
+		case 0x0000:
+			return 104000000;
+		default:
+			break;
+		}
+	}
+	default:
+		break;
+	}
+	return parent_rate;
+}
+
+static long
+mclk_clk_round_rate(struct clk_hw *hw, unsigned long rate,
+		    unsigned long *prate)
+{
+	if (rate <= 18900000)
+		return 18900000;
+	if (rate <= 20800000)
+		return 20800000;
+	if (rate <= 23100000)
+		return 23100000;
+	if (rate <= 26000000)
+		return 26000000;
+	if (rate <= 29700000)
+		return 29700000;
+	if (rate <= 34700000)
+		return 34700000;
+	if (rate <= 41600000)
+		return 41600000;
+	/* Highest rate */
+	return 52000000;
+}
+
+static int mclk_clk_set_rate(struct clk_hw *hw, unsigned long rate,
+			     unsigned long parent_rate)
+{
+	u16 val;
+	u16 reg;
+
+	switch (rate) {
+	case 18900000:
+		val = 0x0054;
+		break;
+	case 20800000:
+		val = 0x0044;
+		break;
+	case 23100000:
+		val = 0x0043;
+		break;
+	case 26000000:
+		val = 0x0033;
+		break;
+	case 29700000:
+		val = 0x0032;
+		break;
+	case 34700000:
+		val = 0x0022;
+		break;
+	case 41600000:
+		val = 0x0021;
+		break;
+	case 52000000:
+		val = 0x0011;
+		break;
+	case 104000000:
+		val = 0x0000;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	reg = readw(syscon_vbase + U300_SYSCON_MMF0R) &
+		~U300_SYSCON_MMF0R_MASK;
+	writew(reg | val, syscon_vbase + U300_SYSCON_MMF0R);
+	return 0;
+}
+
+static const struct clk_ops mclk_ops = {
+	.prepare = mclk_clk_prepare,
+	.recalc_rate = mclk_clk_recalc_rate,
+	.round_rate = mclk_clk_round_rate,
+	.set_rate = mclk_clk_set_rate,
+};
+
+static struct clk * __init
+mclk_clk_register(struct device *dev, const char *name,
+		  const char *parent_name, bool is_mspro)
+{
+	struct clk *clk;
+	struct clk_mclk *mclk;
+	struct clk_init_data init;
+
+	mclk = kzalloc(sizeof(struct clk_mclk), GFP_KERNEL);
+	if (!mclk) {
+		pr_err("could not allocate MMC/SD clock %s\n",
+		       name);
+		return ERR_PTR(-ENOMEM);
+	}
+	init.name = "mclk";
+	init.ops = &mclk_ops;
+	init.flags = 0;
+	init.parent_names = (parent_name ? &parent_name : NULL);
+	init.num_parents = (parent_name ? 1 : 0);
+	mclk->hw.init = &init;
+	mclk->is_mspro = is_mspro;
+
+	clk = clk_register(dev, &mclk->hw);
+	if (IS_ERR(clk))
+		kfree(mclk);
+
+	return clk;
+}
+
+void __init u300_clk_init(void __iomem *base)
+{
+	u16 val;
+	struct clk *clk;
+
+	syscon_vbase = base;
+
+	/* Set system to run at PLL208, max performance, a known state. */
+	val = readw(syscon_vbase + U300_SYSCON_CCR);
+	val &= ~U300_SYSCON_CCR_CLKING_PERFORMANCE_MASK;
+	writew(val, syscon_vbase + U300_SYSCON_CCR);
+	/* Wait for the PLL208 to lock if not locked in yet */
+	while (!(readw(syscon_vbase + U300_SYSCON_CSR) &
+		 U300_SYSCON_CSR_PLL208_LOCK_IND));
+
+	/* Power management enable */
+	val = readw(syscon_vbase + U300_SYSCON_PMCR);
+	val |= U300_SYSCON_PMCR_PWR_MGNT_ENABLE;
+	writew(val, syscon_vbase + U300_SYSCON_PMCR);
+
+	/* These are always available (RTC and PLL13) */
+	clk = clk_register_fixed_rate(NULL, "app_32_clk", NULL,
+				      CLK_IS_ROOT, 32768);
+	/* The watchdog sits directly on the 32 kHz clock */
+	clk_register_clkdev(clk, NULL, "coh901327_wdog");
+	clk = clk_register_fixed_rate(NULL, "pll13", NULL,
+				      CLK_IS_ROOT, 13000000);
+
+	/* These derive from PLL208 */
+	clk = clk_register_fixed_rate(NULL, "pll208", NULL,
+				      CLK_IS_ROOT, 208000000);
+	clk = clk_register_fixed_factor(NULL, "app_208_clk", "pll208",
+					0, 1, 1);
+	clk = clk_register_fixed_factor(NULL, "app_104_clk", "pll208",
+					0, 1, 2);
+	clk = clk_register_fixed_factor(NULL, "app_52_clk", "pll208",
+					0, 1, 4);
+	/* The 52 MHz is divided down to 26 MHz */
+	clk = clk_register_fixed_factor(NULL, "app_26_clk", "app_52_clk",
+					0, 1, 2);
+
+	/* Directly on the AMBA interconnect */
+	clk = syscon_clk_register(NULL, "cpu_clk", "app_208_clk", 0, true,
+				  syscon_vbase + U300_SYSCON_RRR, 3,
+				  syscon_vbase + U300_SYSCON_CERR, 3,
+				  U300_SYSCON_SBCER_CPU_CLK_EN);
+	clk = syscon_clk_register(NULL, "dmac_clk", "app_52_clk", 0, true,
+				  syscon_vbase + U300_SYSCON_RRR, 4,
+				  syscon_vbase + U300_SYSCON_CERR, 4,
+				  U300_SYSCON_SBCER_DMAC_CLK_EN);
+	clk_register_clkdev(clk, NULL, "dma");
+	clk = syscon_clk_register(NULL, "fsmc_clk", "app_52_clk", 0, false,
+				  syscon_vbase + U300_SYSCON_RRR, 6,
+				  syscon_vbase + U300_SYSCON_CERR, 6,
+				  U300_SYSCON_SBCER_NANDIF_CLK_EN);
+	clk_register_clkdev(clk, NULL, "fsmc-nand");
+	clk = syscon_clk_register(NULL, "xgam_clk", "app_52_clk", 0, true,
+				  syscon_vbase + U300_SYSCON_RRR, 8,
+				  syscon_vbase + U300_SYSCON_CERR, 8,
+				  U300_SYSCON_SBCER_XGAM_CLK_EN);
+	clk_register_clkdev(clk, NULL, "xgam");
+	clk = syscon_clk_register(NULL, "semi_clk", "app_104_clk", 0, false,
+				  syscon_vbase + U300_SYSCON_RRR, 9,
+				  syscon_vbase + U300_SYSCON_CERR, 9,
+				  U300_SYSCON_SBCER_SEMI_CLK_EN);
+	clk_register_clkdev(clk, NULL, "semi");
+
+	/* AHB bridge clocks */
+	clk = syscon_clk_register(NULL, "ahb_subsys_clk", "app_52_clk", 0, true,
+				  syscon_vbase + U300_SYSCON_RRR, 10,
+				  syscon_vbase + U300_SYSCON_CERR, 10,
+				  U300_SYSCON_SBCER_AHB_SUBSYS_BRIDGE_CLK_EN);
+	clk = syscon_clk_register(NULL, "intcon_clk", "ahb_subsys_clk", 0, false,
+				  syscon_vbase + U300_SYSCON_RRR, 12,
+				  syscon_vbase + U300_SYSCON_CERR, 12,
+				  /* Cannot be enabled, just taken out of reset */
+				  0xFFFFU);
+	clk_register_clkdev(clk, NULL, "intcon");
+	clk = syscon_clk_register(NULL, "emif_clk", "ahb_subsys_clk", 0, false,
+				  syscon_vbase + U300_SYSCON_RRR, 5,
+				  syscon_vbase + U300_SYSCON_CERR, 5,
+				  U300_SYSCON_SBCER_EMIF_CLK_EN);
+	clk_register_clkdev(clk, NULL, "pl172");
+
+	/* FAST bridge clocks */
+	clk = syscon_clk_register(NULL, "fast_clk", "app_26_clk", 0, true,
+				  syscon_vbase + U300_SYSCON_RFR, 0,
+				  syscon_vbase + U300_SYSCON_CEFR, 0,
+				  U300_SYSCON_SBCER_FAST_BRIDGE_CLK_EN);
+	clk = syscon_clk_register(NULL, "i2c0_p_clk", "fast_clk", 0, false,
+				  syscon_vbase + U300_SYSCON_RFR, 1,
+				  syscon_vbase + U300_SYSCON_CEFR, 1,
+				  U300_SYSCON_SBCER_I2C0_CLK_EN);
+	clk_register_clkdev(clk, NULL, "stu300.0");
+	clk = syscon_clk_register(NULL, "i2c1_p_clk", "fast_clk", 0, false,
+				  syscon_vbase + U300_SYSCON_RFR, 2,
+				  syscon_vbase + U300_SYSCON_CEFR, 2,
+				  U300_SYSCON_SBCER_I2C1_CLK_EN);
+	clk_register_clkdev(clk, NULL, "stu300.1");
+	clk = syscon_clk_register(NULL, "mmc_p_clk", "fast_clk", 0, false,
+				  syscon_vbase + U300_SYSCON_RFR, 5,
+				  syscon_vbase + U300_SYSCON_CEFR, 5,
+				  U300_SYSCON_SBCER_MMC_CLK_EN);
+	clk_register_clkdev(clk, "apb_pclk", "mmci");
+	clk = syscon_clk_register(NULL, "spi_p_clk", "fast_clk", 0, false,
+				  syscon_vbase + U300_SYSCON_RFR, 6,
+				  syscon_vbase + U300_SYSCON_CEFR, 6,
+				  U300_SYSCON_SBCER_SPI_CLK_EN);
+	/* The SPI has no external clock for the outward bus, uses the pclk */
+	clk_register_clkdev(clk, NULL, "pl022");
+	clk_register_clkdev(clk, "apb_pclk", "pl022");
+
+	/* SLOW bridge clocks */
+	clk = syscon_clk_register(NULL, "slow_clk", "pll13", 0, true,
+				  syscon_vbase + U300_SYSCON_RSR, 0,
+				  syscon_vbase + U300_SYSCON_CESR, 0,
+				  U300_SYSCON_SBCER_SLOW_BRIDGE_CLK_EN);
+	clk = syscon_clk_register(NULL, "uart0_clk", "slow_clk", 0, false,
+				  syscon_vbase + U300_SYSCON_RSR, 1,
+				  syscon_vbase + U300_SYSCON_CESR, 1,
+				  U300_SYSCON_SBCER_UART_CLK_EN);
+	/* Same clock is used for APB and outward bus */
+	clk_register_clkdev(clk, NULL, "uart0");
+	clk_register_clkdev(clk, "apb_pclk", "uart0");
+	clk = syscon_clk_register(NULL, "gpio_clk", "slow_clk", 0, false,
+				  syscon_vbase + U300_SYSCON_RSR, 4,
+				  syscon_vbase + U300_SYSCON_CESR, 4,
+				  U300_SYSCON_SBCER_GPIO_CLK_EN);
+	clk_register_clkdev(clk, NULL, "u300-gpio");
+	clk = syscon_clk_register(NULL, "keypad_clk", "slow_clk", 0, false,
+				  syscon_vbase + U300_SYSCON_RSR, 5,
+				  syscon_vbase + U300_SYSCON_CESR, 6,
+				  U300_SYSCON_SBCER_KEYPAD_CLK_EN);
+	clk_register_clkdev(clk, NULL, "coh901461-keypad");
+	clk = syscon_clk_register(NULL, "rtc_clk", "slow_clk", 0, true,
+				  syscon_vbase + U300_SYSCON_RSR, 6,
+				  /* No clock enable register bit */
+				  NULL, 0, 0xFFFFU);
+	clk_register_clkdev(clk, NULL, "rtc-coh901331");
+	clk = syscon_clk_register(NULL, "app_tmr_clk", "slow_clk", 0, false,
+				  syscon_vbase + U300_SYSCON_RSR, 7,
+				  syscon_vbase + U300_SYSCON_CESR, 7,
+				  U300_SYSCON_SBCER_APP_TMR_CLK_EN);
+	clk_register_clkdev(clk, NULL, "apptimer");
+	clk = syscon_clk_register(NULL, "acc_tmr_clk", "slow_clk", 0, false,
+				  syscon_vbase + U300_SYSCON_RSR, 8,
+				  syscon_vbase + U300_SYSCON_CESR, 8,
+				  U300_SYSCON_SBCER_ACC_TMR_CLK_EN);
+	clk_register_clkdev(clk, NULL, "timer");
+
+	/* Then this special MMC/SD clock */
+	clk = mclk_clk_register(NULL, "mmc_clk", "mmc_p_clk", false);
+	clk_register_clkdev(clk, NULL, "mmci");
+}
diff --git a/include/linux/platform_data/clk-u300.h b/include/linux/platform_data/clk-u300.h
new file mode 100644
index 0000000..8429e73
--- /dev/null
+++ b/include/linux/platform_data/clk-u300.h
@@ -0,0 +1 @@
+void __init u300_clk_init(void __iomem *base);
-- 
1.7.9.2
