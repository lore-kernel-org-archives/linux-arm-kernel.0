From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Wed, 10 Mar 2010 06:26:09 -0500
Subject: [PATCH] [ARM] pxa: move ssp into plat
Message-ID: <mailman.228.1268226846.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since ssp is shared between pxa and mmp, move ssp driver into plat directory.
---
 arch/arm/mach-mmp/Kconfig            |    5 +
 arch/arm/mach-pxa/Kconfig            |   10 -
 arch/arm/mach-pxa/Makefile           |    3 -
 arch/arm/mach-pxa/corgi_ssp.c        |    2 +-
 arch/arm/mach-pxa/include/mach/ssp.h |  109 --------
 arch/arm/mach-pxa/littleton.c        |    2 +-
 arch/arm/mach-pxa/poodle.c           |    4 +-
 arch/arm/mach-pxa/pxa3xx.c           |    2 +-
 arch/arm/mach-pxa/ssp.c              |  510 ----------------------------------
 arch/arm/plat-pxa/Kconfig            |   10 +
 arch/arm/plat-pxa/Makefile           |    1 +
 arch/arm/plat-pxa/include/plat/ssp.h |  109 ++++++++
 arch/arm/plat-pxa/ssp.c              |  510 ++++++++++++++++++++++++++++++++++
 sound/soc/pxa/pxa-ssp.c              |    2 +-
 14 files changed, 641 insertions(+), 638 deletions(-)
 delete mode 100644 arch/arm/mach-pxa/include/mach/ssp.h
 delete mode 100644 arch/arm/mach-pxa/ssp.c
 create mode 100644 arch/arm/plat-pxa/include/plat/ssp.h
 create mode 100644 arch/arm/plat-pxa/ssp.c

diff --git a/arch/arm/mach-mmp/Kconfig b/arch/arm/mach-mmp/Kconfig
index 6ab843e..06728b1 100644
--- a/arch/arm/mach-mmp/Kconfig
+++ b/arch/arm/mach-mmp/Kconfig
@@ -5,6 +5,7 @@ menu "Marvell PXA168/910/MMP2 Implmentations"
 config MACH_ASPENITE
 	bool "Marvell's PXA168 Aspenite Development Board"
 	select CPU_PXA168
+	select PXA_SSP
 	help
 	  Say 'Y' here if you want to support the Marvell PXA168-based
 	  Aspenite Development Board.
@@ -12,6 +13,7 @@ config MACH_ASPENITE
 config MACH_ZYLONITE2
 	bool "Marvell's PXA168 Zylonite2 Development Board"
 	select CPU_PXA168
+	select PXA_SSP
 	help
 	  Say 'Y' here if you want to support the Marvell PXA168-based
 	  Zylonite2 Development Board.
@@ -19,6 +21,7 @@ config MACH_ZYLONITE2
 config MACH_AVENGERS_LITE
 	bool "Marvell's PXA168 Avengers Lite Development Board"
 	select CPU_PXA168
+	select PXA_SSP
 	help
 	  Say 'Y' here if you want to support the Marvell PXA168-based
 	  Avengers Lite Development Board.
@@ -26,6 +29,7 @@ config MACH_AVENGERS_LITE
 config MACH_TAVOREVB
 	bool "Marvell's PXA910 TavorEVB Development Board"
 	select CPU_PXA910
+	select PXA_SSP
 	help
 	  Say 'Y' here if you want to support the Marvell PXA910-based
 	  TavorEVB Development Board.
@@ -33,6 +37,7 @@ config MACH_TAVOREVB
 config MACH_TTC_DKB
 	bool "Marvell's PXA910 TavorEVB Development Board"
 	select CPU_PXA910
+	select PXA_SSP
 	help
 	  Say 'Y' here if you want to support the Marvell PXA910-based
 	  TTC_DKB Development Board.
diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
index 38fbd0a..ef8744a 100644
--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -654,16 +654,6 @@ config PXA_SHARP_Cxx00
 	help
 	  Enable common support for Sharp Cxx00 models

-config PXA_SSP
-	tristate
-	help
-	  Enable support for PXA2xx SSP ports
-
-config PXA_SSP_LEGACY
-	bool
-	help
-	  Support of legacy SSP API
-
 config TOSA_BT
 	tristate "Control the state of built-in bluetooth chip on Sharp SL-6000"
 	depends on MACH_TOSA
diff --git a/arch/arm/mach-pxa/Makefile b/arch/arm/mach-pxa/Makefile
index 86bc87b..299d4f5 100644
--- a/arch/arm/mach-pxa/Makefile
+++ b/arch/arm/mach-pxa/Makefile
@@ -13,9 +13,6 @@ obj-$(CONFIG_PXA27x)		+= cpufreq-pxa2xx.o
 obj-$(CONFIG_PXA3xx)		+= cpufreq-pxa3xx.o
 endif

-# Generic drivers that other drivers may depend upon
-obj-$(CONFIG_PXA_SSP)		+= ssp.o
-
 # SoC-specific code
 obj-$(CONFIG_PXA25x)		+= mfp-pxa2xx.o pxa2xx.o pxa25x.o
 obj-$(CONFIG_PXA27x)		+= mfp-pxa2xx.o pxa2xx.o pxa27x.o
diff --git a/arch/arm/mach-pxa/corgi_ssp.c b/arch/arm/mach-pxa/corgi_ssp.c
index a5ee707..4ebc8e8 100644
--- a/arch/arm/mach-pxa/corgi_ssp.c
+++ b/arch/arm/mach-pxa/corgi_ssp.c
@@ -19,9 +19,9 @@
 #include <mach/hardware.h>
 #include <asm/mach-types.h>

-#include <mach/ssp.h>
 #include <mach/pxa2xx-gpio.h>
 #include <mach/regs-ssp.h>
+#include <plat/ssp.h>
 #include "sharpsl.h"

 static DEFINE_SPINLOCK(corgi_ssp_lock);
diff --git a/arch/arm/mach-pxa/include/mach/ssp.h
b/arch/arm/mach-pxa/include/mach/ssp.h
deleted file mode 100644
index be1be5b..0000000
--- a/arch/arm/mach-pxa/include/mach/ssp.h
+++ /dev/null
@@ -1,109 +0,0 @@
-/*
- *  ssp.h
- *
- *  Copyright (C) 2003 Russell King, All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This driver supports the following PXA CPU/SSP ports:-
- *
- *       PXA250     SSP
- *       PXA255     SSP, NSSP
- *       PXA26x     SSP, NSSP, ASSP
- *       PXA27x     SSP1, SSP2, SSP3
- *       PXA3xx     SSP1, SSP2, SSP3, SSP4
- */
-
-#ifndef __ASM_ARCH_SSP_H
-#define __ASM_ARCH_SSP_H
-
-#include <linux/list.h>
-#include <linux/io.h>
-
-enum pxa_ssp_type {
-	SSP_UNDEFINED = 0,
-	PXA25x_SSP,  /* pxa 210, 250, 255, 26x */
-	PXA25x_NSSP, /* pxa 255, 26x (including ASSP) */
-	PXA27x_SSP,
-};
-
-struct ssp_device {
-	struct platform_device *pdev;
-	struct list_head	node;
-
-	struct clk	*clk;
-	void __iomem	*mmio_base;
-	unsigned long	phys_base;
-
-	const char	*label;
-	int		port_id;
-	int		type;
-	int		use_count;
-	int		irq;
-	int		drcmr_rx;
-	int		drcmr_tx;
-};
-
-#ifdef CONFIG_PXA_SSP_LEGACY
-/*
- * SSP initialisation flags
- */
-#define SSP_NO_IRQ	0x1		/* don't register an irq handler in SSP driver */
-
-struct ssp_state {
-	u32	cr0;
-	u32 cr1;
-	u32 to;
-	u32 psp;
-};
-
-struct ssp_dev {
-	struct ssp_device *ssp;
-	u32 port;
-	u32 mode;
-	u32 flags;
-	u32 psp_flags;
-	u32 speed;
-	int irq;
-};
-
-int ssp_write_word(struct ssp_dev *dev, u32 data);
-int ssp_read_word(struct ssp_dev *dev, u32 *data);
-int ssp_flush(struct ssp_dev *dev);
-void ssp_enable(struct ssp_dev *dev);
-void ssp_disable(struct ssp_dev *dev);
-void ssp_save_state(struct ssp_dev *dev, struct ssp_state *ssp);
-void ssp_restore_state(struct ssp_dev *dev, struct ssp_state *ssp);
-int ssp_init(struct ssp_dev *dev, u32 port, u32 init_flags);
-int ssp_config(struct ssp_dev *dev, u32 mode, u32 flags, u32
psp_flags, u32 speed);
-void ssp_exit(struct ssp_dev *dev);
-#endif /* CONFIG_PXA_SSP_LEGACY */
-
-/**
- * ssp_write_reg - Write to a SSP register
- *
- * @dev: SSP device to access
- * @reg: Register to write to
- * @val: Value to be written.
- */
-static inline void ssp_write_reg(struct ssp_device *dev, u32 reg, u32 val)
-{
-	__raw_writel(val, dev->mmio_base + reg);
-}
-
-/**
- * ssp_read_reg - Read from a SSP register
- *
- * @dev: SSP device to access
- * @reg: Register to read from
- */
-static inline u32 ssp_read_reg(struct ssp_device *dev, u32 reg)
-{
-	return __raw_readl(dev->mmio_base + reg);
-}
-
-struct ssp_device *ssp_request(int port, const char *label);
-void ssp_free(struct ssp_device *);
-#endif /* __ASM_ARCH_SSP_H */
diff --git a/arch/arm/mach-pxa/littleton.c b/arch/arm/mach-pxa/littleton.c
index fa527b2..b9d3c20 100644
--- a/arch/arm/mach-pxa/littleton.c
+++ b/arch/arm/mach-pxa/littleton.c
@@ -41,12 +41,12 @@

 #include <mach/pxa300.h>
 #include <mach/pxafb.h>
-#include <mach/ssp.h>
 #include <mach/mmc.h>
 #include <mach/pxa2xx_spi.h>
 #include <mach/pxa27x_keypad.h>
 #include <mach/littleton.h>
 #include <plat/i2c.h>
+#include <plat/ssp.h>
 #include <plat/pxa3xx_nand.h>

 #include "generic.h"
diff --git a/arch/arm/mach-pxa/poodle.c b/arch/arm/mach-pxa/poodle.c
index d58a524..90343c3 100644
--- a/arch/arm/mach-pxa/poodle.c
+++ b/arch/arm/mach-pxa/poodle.c
@@ -40,13 +40,13 @@
 #include <mach/pxa25x.h>
 #include <mach/mmc.h>
 #include <mach/udc.h>
-#include <plat/i2c.h>
 #include <mach/irda.h>
 #include <mach/poodle.h>
 #include <mach/pxafb.h>
 #include <mach/sharpsl.h>
-#include <mach/ssp.h>
 #include <mach/pxa2xx_spi.h>
+#include <plat/i2c.h>
+#include <plat/ssp.h>

 #include <asm/hardware/scoop.h>
 #include <asm/hardware/locomo.h>
diff --git a/arch/arm/mach-pxa/pxa3xx.c b/arch/arm/mach-pxa/pxa3xx.c
index fcb0721..bbb0b76 100644
--- a/arch/arm/mach-pxa/pxa3xx.c
+++ b/arch/arm/mach-pxa/pxa3xx.c
@@ -29,9 +29,9 @@
 #include <mach/ohci.h>
 #include <mach/pm.h>
 #include <mach/dma.h>
-#include <mach/ssp.h>
 #include <mach/regs-intc.h>
 #include <plat/i2c.h>
+#include <plat/ssp.h>

 #include "generic.h"
 #include "devices.h"
diff --git a/arch/arm/mach-pxa/ssp.c b/arch/arm/mach-pxa/ssp.c
deleted file mode 100644
index a81d6db..0000000
--- a/arch/arm/mach-pxa/ssp.c
+++ /dev/null
@@ -1,510 +0,0 @@
-/*
- *  linux/arch/arm/mach-pxa/ssp.c
- *
- *  based on linux/arch/arm/mach-sa1100/ssp.c by Russell King
- *
- *  Copyright (C) 2003 Russell King.
- *  Copyright (C) 2003 Wolfson Microelectronics PLC
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- *  PXA2xx SSP driver.  This provides the generic core for simple
- *  IO-based SSP applications and allows easy port setup for DMA access.
- *
- *  Author: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
- */
-
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/sched.h>
-#include <linux/slab.h>
-#include <linux/errno.h>
-#include <linux/interrupt.h>
-#include <linux/ioport.h>
-#include <linux/init.h>
-#include <linux/mutex.h>
-#include <linux/clk.h>
-#include <linux/err.h>
-#include <linux/platform_device.h>
-#include <linux/io.h>
-
-#include <asm/irq.h>
-#include <mach/hardware.h>
-#include <mach/ssp.h>
-#include <mach/regs-ssp.h>
-
-#ifdef CONFIG_PXA_SSP_LEGACY
-
-#define TIMEOUT 100000
-
-static irqreturn_t ssp_interrupt(int irq, void *dev_id)
-{
-	struct ssp_dev *dev = dev_id;
-	struct ssp_device *ssp = dev->ssp;
-	unsigned int status;
-
-	status = __raw_readl(ssp->mmio_base + SSSR);
-	__raw_writel(status, ssp->mmio_base + SSSR);
-
-	if (status & SSSR_ROR)
-		printk(KERN_WARNING "SSP(%d): receiver overrun\n", dev->port);
-
-	if (status & SSSR_TUR)
-		printk(KERN_WARNING "SSP(%d): transmitter underrun\n", dev->port);
-
-	if (status & SSSR_BCE)
-		printk(KERN_WARNING "SSP(%d): bit count error\n", dev->port);
-
-	return IRQ_HANDLED;
-}
-
-/**
- * ssp_write_word - write a word to the SSP port
- * @data: 32-bit, MSB justified data to write.
- *
- * Wait for a free entry in the SSP transmit FIFO, and write a data
- * word to the SSP port.
- *
- * The caller is expected to perform the necessary locking.
- *
- * Returns:
- *   %-ETIMEDOUT	timeout occurred
- *   0			success
- */
-int ssp_write_word(struct ssp_dev *dev, u32 data)
-{
-	struct ssp_device *ssp = dev->ssp;
-	int timeout = TIMEOUT;
-
-	while (!(__raw_readl(ssp->mmio_base + SSSR) & SSSR_TNF)) {
-	        if (!--timeout)
-	        	return -ETIMEDOUT;
-		cpu_relax();
-	}
-
-	__raw_writel(data, ssp->mmio_base + SSDR);
-
-	return 0;
-}
-
-/**
- * ssp_read_word - read a word from the SSP port
- *
- * Wait for a data word in the SSP receive FIFO, and return the
- * received data.  Data is LSB justified.
- *
- * Note: Currently, if data is not expected to be received, this
- * function will wait for ever.
- *
- * The caller is expected to perform the necessary locking.
- *
- * Returns:
- *   %-ETIMEDOUT	timeout occurred
- *   32-bit data	success
- */
-int ssp_read_word(struct ssp_dev *dev, u32 *data)
-{
-	struct ssp_device *ssp = dev->ssp;
-	int timeout = TIMEOUT;
-
-	while (!(__raw_readl(ssp->mmio_base + SSSR) & SSSR_RNE)) {
-	        if (!--timeout)
-	        	return -ETIMEDOUT;
-		cpu_relax();
-	}
-
-	*data = __raw_readl(ssp->mmio_base + SSDR);
-	return 0;
-}
-
-/**
- * ssp_flush - flush the transmit and receive FIFOs
- *
- * Wait for the SSP to idle, and ensure that the receive FIFO
- * is empty.
- *
- * The caller is expected to perform the necessary locking.
- */
-int ssp_flush(struct ssp_dev *dev)
-{
-	struct ssp_device *ssp = dev->ssp;
-	int timeout = TIMEOUT * 2;
-
-	/* ensure TX FIFO is empty instead of not full */
-	if (cpu_is_pxa3xx()) {
-		while (__raw_readl(ssp->mmio_base + SSSR) & 0xf00) {
-			if (!--timeout)
-				return -ETIMEDOUT;
-			cpu_relax();
-		}
-		timeout = TIMEOUT * 2;
-	}
-
-	do {
-		while (__raw_readl(ssp->mmio_base + SSSR) & SSSR_RNE) {
-		        if (!--timeout)
-		        	return -ETIMEDOUT;
-			(void)__raw_readl(ssp->mmio_base + SSDR);
-		}
-	        if (!--timeout)
-	        	return -ETIMEDOUT;
-	} while (__raw_readl(ssp->mmio_base + SSSR) & SSSR_BSY);
-
-	return 0;
-}
-
-/**
- * ssp_enable - enable the SSP port
- *
- * Turn on the SSP port.
- */
-void ssp_enable(struct ssp_dev *dev)
-{
-	struct ssp_device *ssp = dev->ssp;
-	uint32_t sscr0;
-
-	sscr0 = __raw_readl(ssp->mmio_base + SSCR0);
-	sscr0 |= SSCR0_SSE;
-	__raw_writel(sscr0, ssp->mmio_base + SSCR0);
-}
-
-/**
- * ssp_disable - shut down the SSP port
- *
- * Turn off the SSP port, optionally powering it down.
- */
-void ssp_disable(struct ssp_dev *dev)
-{
-	struct ssp_device *ssp = dev->ssp;
-	uint32_t sscr0;
-
-	sscr0 = __raw_readl(ssp->mmio_base + SSCR0);
-	sscr0 &= ~SSCR0_SSE;
-	__raw_writel(sscr0, ssp->mmio_base + SSCR0);
-}
-
-/**
- * ssp_save_state - save the SSP configuration
- * @ssp: pointer to structure to save SSP configuration
- *
- * Save the configured SSP state for suspend.
- */
-void ssp_save_state(struct ssp_dev *dev, struct ssp_state *state)
-{
-	struct ssp_device *ssp = dev->ssp;
-
-	state->cr0 = __raw_readl(ssp->mmio_base + SSCR0);
-	state->cr1 = __raw_readl(ssp->mmio_base + SSCR1);
-	state->to  = __raw_readl(ssp->mmio_base + SSTO);
-	state->psp = __raw_readl(ssp->mmio_base + SSPSP);
-
-	ssp_disable(dev);
-}
-
-/**
- * ssp_restore_state - restore a previously saved SSP configuration
- * @ssp: pointer to configuration saved by ssp_save_state
- *
- * Restore the SSP configuration saved previously by ssp_save_state.
- */
-void ssp_restore_state(struct ssp_dev *dev, struct ssp_state *state)
-{
-	struct ssp_device *ssp = dev->ssp;
-	uint32_t sssr = SSSR_ROR | SSSR_TUR | SSSR_BCE;
-
-	__raw_writel(sssr, ssp->mmio_base + SSSR);
-
-	__raw_writel(state->cr0 & ~SSCR0_SSE, ssp->mmio_base + SSCR0);
-	__raw_writel(state->cr1, ssp->mmio_base + SSCR1);
-	__raw_writel(state->to,  ssp->mmio_base + SSTO);
-	__raw_writel(state->psp, ssp->mmio_base + SSPSP);
-	__raw_writel(state->cr0, ssp->mmio_base + SSCR0);
-}
-
-/**
- * ssp_config - configure SSP port settings
- * @mode: port operating mode
- * @flags: port config flags
- * @psp_flags: port PSP config flags
- * @speed: port speed
- *
- * Port MUST be disabled by ssp_disable before making any config changes.
- */
-int ssp_config(struct ssp_dev *dev, u32 mode, u32 flags, u32
psp_flags, u32 speed)
-{
-	struct ssp_device *ssp = dev->ssp;
-
-	dev->mode = mode;
-	dev->flags = flags;
-	dev->psp_flags = psp_flags;
-	dev->speed = speed;
-
-	/* set up port type, speed, port settings */
-	__raw_writel((dev->speed | dev->mode), ssp->mmio_base + SSCR0);
-	__raw_writel(dev->flags, ssp->mmio_base + SSCR1);
-	__raw_writel(dev->psp_flags, ssp->mmio_base + SSPSP);
-
-	return 0;
-}
-
-/**
- * ssp_init - setup the SSP port
- *
- * initialise and claim resources for the SSP port.
- *
- * Returns:
- *   %-ENODEV	if the SSP port is unavailable
- *   %-EBUSY	if the resources are already in use
- *   %0		on success
- */
-int ssp_init(struct ssp_dev *dev, u32 port, u32 init_flags)
-{
-	struct ssp_device *ssp;
-	int ret;
-
-	ssp = ssp_request(port, "SSP");
-	if (ssp == NULL)
-		return -ENODEV;
-
-	dev->ssp = ssp;
-	dev->port = port;
-
-	/* do we need to get irq */
-	if (!(init_flags & SSP_NO_IRQ)) {
-		ret = request_irq(ssp->irq, ssp_interrupt,
-				0, "SSP", dev);
-	    	if (ret)
-			goto out_region;
-		dev->irq = ssp->irq;
-	} else
-		dev->irq = NO_IRQ;
-
-	/* turn on SSP port clock */
-	clk_enable(ssp->clk);
-	return 0;
-
-out_region:
-	ssp_free(ssp);
-	return ret;
-}
-
-/**
- * ssp_exit - undo the effects of ssp_init
- *
- * release and free resources for the SSP port.
- */
-void ssp_exit(struct ssp_dev *dev)
-{
-	struct ssp_device *ssp = dev->ssp;
-
-	ssp_disable(dev);
-	if (dev->irq != NO_IRQ)
-		free_irq(dev->irq, dev);
-	clk_disable(ssp->clk);
-	ssp_free(ssp);
-}
-#endif /* CONFIG_PXA_SSP_LEGACY */
-
-static DEFINE_MUTEX(ssp_lock);
-static LIST_HEAD(ssp_list);
-
-struct ssp_device *ssp_request(int port, const char *label)
-{
-	struct ssp_device *ssp = NULL;
-
-	mutex_lock(&ssp_lock);
-
-	list_for_each_entry(ssp, &ssp_list, node) {
-		if (ssp->port_id == port && ssp->use_count == 0) {
-			ssp->use_count++;
-			ssp->label = label;
-			break;
-		}
-	}
-
-	mutex_unlock(&ssp_lock);
-
-	if (&ssp->node == &ssp_list)
-		return NULL;
-
-	return ssp;
-}
-EXPORT_SYMBOL(ssp_request);
-
-void ssp_free(struct ssp_device *ssp)
-{
-	mutex_lock(&ssp_lock);
-	if (ssp->use_count) {
-		ssp->use_count--;
-		ssp->label = NULL;
-	} else
-		dev_err(&ssp->pdev->dev, "device already free\n");
-	mutex_unlock(&ssp_lock);
-}
-EXPORT_SYMBOL(ssp_free);
-
-static int __devinit ssp_probe(struct platform_device *pdev)
-{
-	const struct platform_device_id *id = platform_get_device_id(pdev);
-	struct resource *res;
-	struct ssp_device *ssp;
-	int ret = 0;
-
-	ssp = kzalloc(sizeof(struct ssp_device), GFP_KERNEL);
-	if (ssp == NULL) {
-		dev_err(&pdev->dev, "failed to allocate memory");
-		return -ENOMEM;
-	}
-	ssp->pdev = pdev;
-
-	ssp->clk = clk_get(&pdev->dev, NULL);
-	if (IS_ERR(ssp->clk)) {
-		ret = PTR_ERR(ssp->clk);
-		goto err_free;
-	}
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (res == NULL) {
-		dev_err(&pdev->dev, "no memory resource defined\n");
-		ret = -ENODEV;
-		goto err_free_clk;
-	}
-
-	res = request_mem_region(res->start, res->end - res->start + 1,
-			pdev->name);
-	if (res == NULL) {
-		dev_err(&pdev->dev, "failed to request memory resource\n");
-		ret = -EBUSY;
-		goto err_free_clk;
-	}
-
-	ssp->phys_base = res->start;
-
-	ssp->mmio_base = ioremap(res->start, res->end - res->start + 1);
-	if (ssp->mmio_base == NULL) {
-		dev_err(&pdev->dev, "failed to ioremap() registers\n");
-		ret = -ENODEV;
-		goto err_free_mem;
-	}
-
-	ssp->irq = platform_get_irq(pdev, 0);
-	if (ssp->irq < 0) {
-		dev_err(&pdev->dev, "no IRQ resource defined\n");
-		ret = -ENODEV;
-		goto err_free_io;
-	}
-
-	res = platform_get_resource(pdev, IORESOURCE_DMA, 0);
-	if (res == NULL) {
-		dev_err(&pdev->dev, "no SSP RX DRCMR defined\n");
-		ret = -ENODEV;
-		goto err_free_io;
-	}
-	ssp->drcmr_rx = res->start;
-
-	res = platform_get_resource(pdev, IORESOURCE_DMA, 1);
-	if (res == NULL) {
-		dev_err(&pdev->dev, "no SSP TX DRCMR defined\n");
-		ret = -ENODEV;
-		goto err_free_io;
-	}
-	ssp->drcmr_tx = res->start;
-
-	/* PXA2xx/3xx SSP ports starts from 1 and the internal pdev->id
-	 * starts from 0, do a translation here
-	 */
-	ssp->port_id = pdev->id + 1;
-	ssp->use_count = 0;
-	ssp->type = (int)id->driver_data;
-
-	mutex_lock(&ssp_lock);
-	list_add(&ssp->node, &ssp_list);
-	mutex_unlock(&ssp_lock);
-
-	platform_set_drvdata(pdev, ssp);
-	return 0;
-
-err_free_io:
-	iounmap(ssp->mmio_base);
-err_free_mem:
-	release_mem_region(res->start, res->end - res->start + 1);
-err_free_clk:
-	clk_put(ssp->clk);
-err_free:
-	kfree(ssp);
-	return ret;
-}
-
-static int __devexit ssp_remove(struct platform_device *pdev)
-{
-	struct resource *res;
-	struct ssp_device *ssp;
-
-	ssp = platform_get_drvdata(pdev);
-	if (ssp == NULL)
-		return -ENODEV;
-
-	iounmap(ssp->mmio_base);
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	release_mem_region(res->start, res->end - res->start + 1);
-
-	clk_put(ssp->clk);
-
-	mutex_lock(&ssp_lock);
-	list_del(&ssp->node);
-	mutex_unlock(&ssp_lock);
-
-	kfree(ssp);
-	return 0;
-}
-
-static const struct platform_device_id ssp_id_table[] = {
-	{ "pxa25x-ssp",		PXA25x_SSP },
-	{ "pxa25x-nssp",	PXA25x_NSSP },
-	{ "pxa27x-ssp",		PXA27x_SSP },
-	{ },
-};
-
-static struct platform_driver ssp_driver = {
-	.probe		= ssp_probe,
-	.remove		= __devexit_p(ssp_remove),
-	.driver		= {
-		.owner	= THIS_MODULE,
-		.name	= "pxa2xx-ssp",
-	},
-	.id_table	= ssp_id_table,
-};
-
-static int __init pxa_ssp_init(void)
-{
-	return platform_driver_register(&ssp_driver);
-}
-
-static void __exit pxa_ssp_exit(void)
-{
-	platform_driver_unregister(&ssp_driver);
-}
-
-arch_initcall(pxa_ssp_init);
-module_exit(pxa_ssp_exit);
-
-#ifdef CONFIG_PXA_SSP_LEGACY
-EXPORT_SYMBOL(ssp_write_word);
-EXPORT_SYMBOL(ssp_read_word);
-EXPORT_SYMBOL(ssp_flush);
-EXPORT_SYMBOL(ssp_enable);
-EXPORT_SYMBOL(ssp_disable);
-EXPORT_SYMBOL(ssp_save_state);
-EXPORT_SYMBOL(ssp_restore_state);
-EXPORT_SYMBOL(ssp_init);
-EXPORT_SYMBOL(ssp_exit);
-EXPORT_SYMBOL(ssp_config);
-#endif
-
-MODULE_DESCRIPTION("PXA SSP driver");
-MODULE_AUTHOR("Liam Girdwood");
-MODULE_LICENSE("GPL");
-
diff --git a/arch/arm/plat-pxa/Kconfig b/arch/arm/plat-pxa/Kconfig
index b158e98..994f4b8 100644
--- a/arch/arm/plat-pxa/Kconfig
+++ b/arch/arm/plat-pxa/Kconfig
@@ -1,3 +1,13 @@
 if PLAT_PXA

+config PXA_SSP
+	tristate
+	help
+	  Enable support for PXA2xx SSP ports
+
+config PXA_SSP_LEGACY
+	bool
+	help
+	  Support of legacy SSP API
+
 endif
diff --git a/arch/arm/plat-pxa/Makefile b/arch/arm/plat-pxa/Makefile
index 0264bfb..4aacdd1 100644
--- a/arch/arm/plat-pxa/Makefile
+++ b/arch/arm/plat-pxa/Makefile
@@ -9,3 +9,4 @@ obj-$(CONFIG_PXA3xx)		+= mfp.o
 obj-$(CONFIG_ARCH_MMP)		+= mfp.o

 obj-$(CONFIG_HAVE_PWM)		+= pwm.o
+obj-$(CONFIG_PXA_SSP)		+= ssp.o
diff --git a/arch/arm/plat-pxa/include/plat/ssp.h
b/arch/arm/plat-pxa/include/plat/ssp.h
new file mode 100644
index 0000000..fc83ba7
--- /dev/null
+++ b/arch/arm/plat-pxa/include/plat/ssp.h
@@ -0,0 +1,109 @@
+/*
+ *  ssp.h
+ *
+ *  Copyright (C) 2003 Russell King, All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This driver supports the following PXA CPU/SSP ports:-
+ *
+ *       PXA250     SSP
+ *       PXA255     SSP, NSSP
+ *       PXA26x     SSP, NSSP, ASSP
+ *       PXA27x     SSP1, SSP2, SSP3
+ *       PXA3xx     SSP1, SSP2, SSP3, SSP4
+ */
+
+#ifndef __ASM_PLAT_SSP_H
+#define __ASM_PLAT_SSP_H
+
+#include <linux/list.h>
+#include <linux/io.h>
+
+enum pxa_ssp_type {
+	SSP_UNDEFINED = 0,
+	PXA25x_SSP,  /* pxa 210, 250, 255, 26x */
+	PXA25x_NSSP, /* pxa 255, 26x (including ASSP) */
+	PXA27x_SSP,
+};
+
+struct ssp_device {
+	struct platform_device *pdev;
+	struct list_head	node;
+
+	struct clk	*clk;
+	void __iomem	*mmio_base;
+	unsigned long	phys_base;
+
+	const char	*label;
+	int		port_id;
+	int		type;
+	int		use_count;
+	int		irq;
+	int		drcmr_rx;
+	int		drcmr_tx;
+};
+
+#ifdef CONFIG_PXA_SSP_LEGACY
+/*
+ * SSP initialisation flags
+ */
+#define SSP_NO_IRQ	0x1		/* don't register an irq handler in SSP driver */
+
+struct ssp_state {
+	u32	cr0;
+	u32 cr1;
+	u32 to;
+	u32 psp;
+};
+
+struct ssp_dev {
+	struct ssp_device *ssp;
+	u32 port;
+	u32 mode;
+	u32 flags;
+	u32 psp_flags;
+	u32 speed;
+	int irq;
+};
+
+int ssp_write_word(struct ssp_dev *dev, u32 data);
+int ssp_read_word(struct ssp_dev *dev, u32 *data);
+int ssp_flush(struct ssp_dev *dev);
+void ssp_enable(struct ssp_dev *dev);
+void ssp_disable(struct ssp_dev *dev);
+void ssp_save_state(struct ssp_dev *dev, struct ssp_state *ssp);
+void ssp_restore_state(struct ssp_dev *dev, struct ssp_state *ssp);
+int ssp_init(struct ssp_dev *dev, u32 port, u32 init_flags);
+int ssp_config(struct ssp_dev *dev, u32 mode, u32 flags, u32
psp_flags, u32 speed);
+void ssp_exit(struct ssp_dev *dev);
+#endif /* CONFIG_PXA_SSP_LEGACY */
+
+/**
+ * ssp_write_reg - Write to a SSP register
+ *
+ * @dev: SSP device to access
+ * @reg: Register to write to
+ * @val: Value to be written.
+ */
+static inline void ssp_write_reg(struct ssp_device *dev, u32 reg, u32 val)
+{
+	__raw_writel(val, dev->mmio_base + reg);
+}
+
+/**
+ * ssp_read_reg - Read from a SSP register
+ *
+ * @dev: SSP device to access
+ * @reg: Register to read from
+ */
+static inline u32 ssp_read_reg(struct ssp_device *dev, u32 reg)
+{
+	return __raw_readl(dev->mmio_base + reg);
+}
+
+struct ssp_device *ssp_request(int port, const char *label);
+void ssp_free(struct ssp_device *);
+#endif /* __ASM_PLAT_SSP_H */
diff --git a/arch/arm/plat-pxa/ssp.c b/arch/arm/plat-pxa/ssp.c
new file mode 100644
index 0000000..d4a7673
--- /dev/null
+++ b/arch/arm/plat-pxa/ssp.c
@@ -0,0 +1,510 @@
+/*
+ *  linux/arch/arm/mach-pxa/ssp.c
+ *
+ *  based on linux/arch/arm/mach-sa1100/ssp.c by Russell King
+ *
+ *  Copyright (C) 2003 Russell King.
+ *  Copyright (C) 2003 Wolfson Microelectronics PLC
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ *  PXA2xx SSP driver.  This provides the generic core for simple
+ *  IO-based SSP applications and allows easy port setup for DMA access.
+ *
+ *  Author: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/errno.h>
+#include <linux/interrupt.h>
+#include <linux/ioport.h>
+#include <linux/init.h>
+#include <linux/mutex.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+
+#include <asm/irq.h>
+#include <mach/hardware.h>
+#include <mach/regs-ssp.h>
+#include <plat/ssp.h>
+
+#ifdef CONFIG_PXA_SSP_LEGACY
+
+#define TIMEOUT 100000
+
+static irqreturn_t ssp_interrupt(int irq, void *dev_id)
+{
+	struct ssp_dev *dev = dev_id;
+	struct ssp_device *ssp = dev->ssp;
+	unsigned int status;
+
+	status = __raw_readl(ssp->mmio_base + SSSR);
+	__raw_writel(status, ssp->mmio_base + SSSR);
+
+	if (status & SSSR_ROR)
+		printk(KERN_WARNING "SSP(%d): receiver overrun\n", dev->port);
+
+	if (status & SSSR_TUR)
+		printk(KERN_WARNING "SSP(%d): transmitter underrun\n", dev->port);
+
+	if (status & SSSR_BCE)
+		printk(KERN_WARNING "SSP(%d): bit count error\n", dev->port);
+
+	return IRQ_HANDLED;
+}
+
+/**
+ * ssp_write_word - write a word to the SSP port
+ * @data: 32-bit, MSB justified data to write.
+ *
+ * Wait for a free entry in the SSP transmit FIFO, and write a data
+ * word to the SSP port.
+ *
+ * The caller is expected to perform the necessary locking.
+ *
+ * Returns:
+ *   %-ETIMEDOUT	timeout occurred
+ *   0			success
+ */
+int ssp_write_word(struct ssp_dev *dev, u32 data)
+{
+	struct ssp_device *ssp = dev->ssp;
+	int timeout = TIMEOUT;
+
+	while (!(__raw_readl(ssp->mmio_base + SSSR) & SSSR_TNF)) {
+	        if (!--timeout)
+	        	return -ETIMEDOUT;
+		cpu_relax();
+	}
+
+	__raw_writel(data, ssp->mmio_base + SSDR);
+
+	return 0;
+}
+
+/**
+ * ssp_read_word - read a word from the SSP port
+ *
+ * Wait for a data word in the SSP receive FIFO, and return the
+ * received data.  Data is LSB justified.
+ *
+ * Note: Currently, if data is not expected to be received, this
+ * function will wait for ever.
+ *
+ * The caller is expected to perform the necessary locking.
+ *
+ * Returns:
+ *   %-ETIMEDOUT	timeout occurred
+ *   32-bit data	success
+ */
+int ssp_read_word(struct ssp_dev *dev, u32 *data)
+{
+	struct ssp_device *ssp = dev->ssp;
+	int timeout = TIMEOUT;
+
+	while (!(__raw_readl(ssp->mmio_base + SSSR) & SSSR_RNE)) {
+	        if (!--timeout)
+	        	return -ETIMEDOUT;
+		cpu_relax();
+	}
+
+	*data = __raw_readl(ssp->mmio_base + SSDR);
+	return 0;
+}
+
+/**
+ * ssp_flush - flush the transmit and receive FIFOs
+ *
+ * Wait for the SSP to idle, and ensure that the receive FIFO
+ * is empty.
+ *
+ * The caller is expected to perform the necessary locking.
+ */
+int ssp_flush(struct ssp_dev *dev)
+{
+	struct ssp_device *ssp = dev->ssp;
+	int timeout = TIMEOUT * 2;
+
+	/* ensure TX FIFO is empty instead of not full */
+	if (cpu_is_pxa3xx()) {
+		while (__raw_readl(ssp->mmio_base + SSSR) & 0xf00) {
+			if (!--timeout)
+				return -ETIMEDOUT;
+			cpu_relax();
+		}
+		timeout = TIMEOUT * 2;
+	}
+
+	do {
+		while (__raw_readl(ssp->mmio_base + SSSR) & SSSR_RNE) {
+		        if (!--timeout)
+		        	return -ETIMEDOUT;
+			(void)__raw_readl(ssp->mmio_base + SSDR);
+		}
+	        if (!--timeout)
+	        	return -ETIMEDOUT;
+	} while (__raw_readl(ssp->mmio_base + SSSR) & SSSR_BSY);
+
+	return 0;
+}
+
+/**
+ * ssp_enable - enable the SSP port
+ *
+ * Turn on the SSP port.
+ */
+void ssp_enable(struct ssp_dev *dev)
+{
+	struct ssp_device *ssp = dev->ssp;
+	uint32_t sscr0;
+
+	sscr0 = __raw_readl(ssp->mmio_base + SSCR0);
+	sscr0 |= SSCR0_SSE;
+	__raw_writel(sscr0, ssp->mmio_base + SSCR0);
+}
+
+/**
+ * ssp_disable - shut down the SSP port
+ *
+ * Turn off the SSP port, optionally powering it down.
+ */
+void ssp_disable(struct ssp_dev *dev)
+{
+	struct ssp_device *ssp = dev->ssp;
+	uint32_t sscr0;
+
+	sscr0 = __raw_readl(ssp->mmio_base + SSCR0);
+	sscr0 &= ~SSCR0_SSE;
+	__raw_writel(sscr0, ssp->mmio_base + SSCR0);
+}
+
+/**
+ * ssp_save_state - save the SSP configuration
+ * @ssp: pointer to structure to save SSP configuration
+ *
+ * Save the configured SSP state for suspend.
+ */
+void ssp_save_state(struct ssp_dev *dev, struct ssp_state *state)
+{
+	struct ssp_device *ssp = dev->ssp;
+
+	state->cr0 = __raw_readl(ssp->mmio_base + SSCR0);
+	state->cr1 = __raw_readl(ssp->mmio_base + SSCR1);
+	state->to  = __raw_readl(ssp->mmio_base + SSTO);
+	state->psp = __raw_readl(ssp->mmio_base + SSPSP);
+
+	ssp_disable(dev);
+}
+
+/**
+ * ssp_restore_state - restore a previously saved SSP configuration
+ * @ssp: pointer to configuration saved by ssp_save_state
+ *
+ * Restore the SSP configuration saved previously by ssp_save_state.
+ */
+void ssp_restore_state(struct ssp_dev *dev, struct ssp_state *state)
+{
+	struct ssp_device *ssp = dev->ssp;
+	uint32_t sssr = SSSR_ROR | SSSR_TUR | SSSR_BCE;
+
+	__raw_writel(sssr, ssp->mmio_base + SSSR);
+
+	__raw_writel(state->cr0 & ~SSCR0_SSE, ssp->mmio_base + SSCR0);
+	__raw_writel(state->cr1, ssp->mmio_base + SSCR1);
+	__raw_writel(state->to,  ssp->mmio_base + SSTO);
+	__raw_writel(state->psp, ssp->mmio_base + SSPSP);
+	__raw_writel(state->cr0, ssp->mmio_base + SSCR0);
+}
+
+/**
+ * ssp_config - configure SSP port settings
+ * @mode: port operating mode
+ * @flags: port config flags
+ * @psp_flags: port PSP config flags
+ * @speed: port speed
+ *
+ * Port MUST be disabled by ssp_disable before making any config changes.
+ */
+int ssp_config(struct ssp_dev *dev, u32 mode, u32 flags, u32
psp_flags, u32 speed)
+{
+	struct ssp_device *ssp = dev->ssp;
+
+	dev->mode = mode;
+	dev->flags = flags;
+	dev->psp_flags = psp_flags;
+	dev->speed = speed;
+
+	/* set up port type, speed, port settings */
+	__raw_writel((dev->speed | dev->mode), ssp->mmio_base + SSCR0);
+	__raw_writel(dev->flags, ssp->mmio_base + SSCR1);
+	__raw_writel(dev->psp_flags, ssp->mmio_base + SSPSP);
+
+	return 0;
+}
+
+/**
+ * ssp_init - setup the SSP port
+ *
+ * initialise and claim resources for the SSP port.
+ *
+ * Returns:
+ *   %-ENODEV	if the SSP port is unavailable
+ *   %-EBUSY	if the resources are already in use
+ *   %0		on success
+ */
+int ssp_init(struct ssp_dev *dev, u32 port, u32 init_flags)
+{
+	struct ssp_device *ssp;
+	int ret;
+
+	ssp = ssp_request(port, "SSP");
+	if (ssp == NULL)
+		return -ENODEV;
+
+	dev->ssp = ssp;
+	dev->port = port;
+
+	/* do we need to get irq */
+	if (!(init_flags & SSP_NO_IRQ)) {
+		ret = request_irq(ssp->irq, ssp_interrupt,
+				0, "SSP", dev);
+	    	if (ret)
+			goto out_region;
+		dev->irq = ssp->irq;
+	} else
+		dev->irq = NO_IRQ;
+
+	/* turn on SSP port clock */
+	clk_enable(ssp->clk);
+	return 0;
+
+out_region:
+	ssp_free(ssp);
+	return ret;
+}
+
+/**
+ * ssp_exit - undo the effects of ssp_init
+ *
+ * release and free resources for the SSP port.
+ */
+void ssp_exit(struct ssp_dev *dev)
+{
+	struct ssp_device *ssp = dev->ssp;
+
+	ssp_disable(dev);
+	if (dev->irq != NO_IRQ)
+		free_irq(dev->irq, dev);
+	clk_disable(ssp->clk);
+	ssp_free(ssp);
+}
+#endif /* CONFIG_PXA_SSP_LEGACY */
+
+static DEFINE_MUTEX(ssp_lock);
+static LIST_HEAD(ssp_list);
+
+struct ssp_device *ssp_request(int port, const char *label)
+{
+	struct ssp_device *ssp = NULL;
+
+	mutex_lock(&ssp_lock);
+
+	list_for_each_entry(ssp, &ssp_list, node) {
+		if (ssp->port_id == port && ssp->use_count == 0) {
+			ssp->use_count++;
+			ssp->label = label;
+			break;
+		}
+	}
+
+	mutex_unlock(&ssp_lock);
+
+	if (&ssp->node == &ssp_list)
+		return NULL;
+
+	return ssp;
+}
+EXPORT_SYMBOL(ssp_request);
+
+void ssp_free(struct ssp_device *ssp)
+{
+	mutex_lock(&ssp_lock);
+	if (ssp->use_count) {
+		ssp->use_count--;
+		ssp->label = NULL;
+	} else
+		dev_err(&ssp->pdev->dev, "device already free\n");
+	mutex_unlock(&ssp_lock);
+}
+EXPORT_SYMBOL(ssp_free);
+
+static int __devinit ssp_probe(struct platform_device *pdev)
+{
+	const struct platform_device_id *id = platform_get_device_id(pdev);
+	struct resource *res;
+	struct ssp_device *ssp;
+	int ret = 0;
+
+	ssp = kzalloc(sizeof(struct ssp_device), GFP_KERNEL);
+	if (ssp == NULL) {
+		dev_err(&pdev->dev, "failed to allocate memory");
+		return -ENOMEM;
+	}
+	ssp->pdev = pdev;
+
+	ssp->clk = clk_get(&pdev->dev, NULL);
+	if (IS_ERR(ssp->clk)) {
+		ret = PTR_ERR(ssp->clk);
+		goto err_free;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (res == NULL) {
+		dev_err(&pdev->dev, "no memory resource defined\n");
+		ret = -ENODEV;
+		goto err_free_clk;
+	}
+
+	res = request_mem_region(res->start, res->end - res->start + 1,
+			pdev->name);
+	if (res == NULL) {
+		dev_err(&pdev->dev, "failed to request memory resource\n");
+		ret = -EBUSY;
+		goto err_free_clk;
+	}
+
+	ssp->phys_base = res->start;
+
+	ssp->mmio_base = ioremap(res->start, res->end - res->start + 1);
+	if (ssp->mmio_base == NULL) {
+		dev_err(&pdev->dev, "failed to ioremap() registers\n");
+		ret = -ENODEV;
+		goto err_free_mem;
+	}
+
+	ssp->irq = platform_get_irq(pdev, 0);
+	if (ssp->irq < 0) {
+		dev_err(&pdev->dev, "no IRQ resource defined\n");
+		ret = -ENODEV;
+		goto err_free_io;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_DMA, 0);
+	if (res == NULL) {
+		dev_err(&pdev->dev, "no SSP RX DRCMR defined\n");
+		ret = -ENODEV;
+		goto err_free_io;
+	}
+	ssp->drcmr_rx = res->start;
+
+	res = platform_get_resource(pdev, IORESOURCE_DMA, 1);
+	if (res == NULL) {
+		dev_err(&pdev->dev, "no SSP TX DRCMR defined\n");
+		ret = -ENODEV;
+		goto err_free_io;
+	}
+	ssp->drcmr_tx = res->start;
+
+	/* PXA2xx/3xx SSP ports starts from 1 and the internal pdev->id
+	 * starts from 0, do a translation here
+	 */
+	ssp->port_id = pdev->id + 1;
+	ssp->use_count = 0;
+	ssp->type = (int)id->driver_data;
+
+	mutex_lock(&ssp_lock);
+	list_add(&ssp->node, &ssp_list);
+	mutex_unlock(&ssp_lock);
+
+	platform_set_drvdata(pdev, ssp);
+	return 0;
+
+err_free_io:
+	iounmap(ssp->mmio_base);
+err_free_mem:
+	release_mem_region(res->start, res->end - res->start + 1);
+err_free_clk:
+	clk_put(ssp->clk);
+err_free:
+	kfree(ssp);
+	return ret;
+}
+
+static int __devexit ssp_remove(struct platform_device *pdev)
+{
+	struct resource *res;
+	struct ssp_device *ssp;
+
+	ssp = platform_get_drvdata(pdev);
+	if (ssp == NULL)
+		return -ENODEV;
+
+	iounmap(ssp->mmio_base);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	release_mem_region(res->start, res->end - res->start + 1);
+
+	clk_put(ssp->clk);
+
+	mutex_lock(&ssp_lock);
+	list_del(&ssp->node);
+	mutex_unlock(&ssp_lock);
+
+	kfree(ssp);
+	return 0;
+}
+
+static const struct platform_device_id ssp_id_table[] = {
+	{ "pxa25x-ssp",		PXA25x_SSP },
+	{ "pxa25x-nssp",	PXA25x_NSSP },
+	{ "pxa27x-ssp",		PXA27x_SSP },
+	{ },
+};
+
+static struct platform_driver ssp_driver = {
+	.probe		= ssp_probe,
+	.remove		= __devexit_p(ssp_remove),
+	.driver		= {
+		.owner	= THIS_MODULE,
+		.name	= "pxa2xx-ssp",
+	},
+	.id_table	= ssp_id_table,
+};
+
+static int __init pxa_ssp_init(void)
+{
+	return platform_driver_register(&ssp_driver);
+}
+
+static void __exit pxa_ssp_exit(void)
+{
+	platform_driver_unregister(&ssp_driver);
+}
+
+arch_initcall(pxa_ssp_init);
+module_exit(pxa_ssp_exit);
+
+#ifdef CONFIG_PXA_SSP_LEGACY
+EXPORT_SYMBOL(ssp_write_word);
+EXPORT_SYMBOL(ssp_read_word);
+EXPORT_SYMBOL(ssp_flush);
+EXPORT_SYMBOL(ssp_enable);
+EXPORT_SYMBOL(ssp_disable);
+EXPORT_SYMBOL(ssp_save_state);
+EXPORT_SYMBOL(ssp_restore_state);
+EXPORT_SYMBOL(ssp_init);
+EXPORT_SYMBOL(ssp_exit);
+EXPORT_SYMBOL(ssp_config);
+#endif
+
+MODULE_DESCRIPTION("PXA SSP driver");
+MODULE_AUTHOR("Liam Girdwood");
+MODULE_LICENSE("GPL");
+
diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index cf00df9..ef75995 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -33,7 +33,7 @@
 #include <mach/dma.h>
 #include <mach/regs-ssp.h>
 #include <mach/audio.h>
-#include <mach/ssp.h>
+#include <plat/ssp.h>

 #include "pxa2xx-pcm.h"
 #include "pxa-ssp.h"
-- 
1.5.6.5
