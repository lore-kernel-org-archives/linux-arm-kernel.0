From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 30 May 2017 23:51:36 +0200
Subject: [PATCH 55/58] misc: remove atmel_tclib.c
In-Reply-To: <20170530215139.9983-1-alexandre.belloni@free-electrons.com>
References: <20170530215139.9983-1-alexandre.belloni@free-electrons.com>
Message-ID: <20170530215139.9983-56-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The last user of atmel_tclib is gone, remove it too.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/misc/Kconfig       |  33 --------
 drivers/misc/Makefile      |   1 -
 drivers/misc/atmel_tclib.c | 198 ---------------------------------------------
 include/linux/atmel_tc.h   |   9 ---
 4 files changed, 241 deletions(-)
 delete mode 100644 drivers/misc/atmel_tclib.c

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 2cba76e6fa3c..5946ac3399ad 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -51,39 +51,6 @@ config AD525X_DPOT_SPI
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad525x_dpot-spi.
 
-config ATMEL_TCLIB
-	bool "Atmel AT32/AT91 Timer/Counter Library"
-	depends on (AVR32 || ARCH_AT91)
-	help
-	  Select this if you want a library to allocate the Timer/Counter
-	  blocks found on many Atmel processors.  This facilitates using
-	  these blocks by different drivers despite processor differences.
-
-config ATMEL_TCB_CLKSRC
-	bool "TC Block Clocksource"
-	depends on ATMEL_TCLIB
-	default y
-	help
-	  Select this to get a high precision clocksource based on a
-	  TC block with a 5+ MHz base clock rate.  Two timer channels
-	  are combined to make a single 32-bit timer.
-
-	  When GENERIC_CLOCKEVENTS is defined, the third timer channel
-	  may be used as a clock event device supporting oneshot mode
-	  (delays of up to two seconds) based on the 32 KiHz clock.
-
-config ATMEL_TCB_CLKSRC_BLOCK
-	int
-	depends on ATMEL_TCB_CLKSRC
-	prompt "TC Block" if CPU_AT32AP700X
-	default 0
-	range 0 1
-	help
-	  Some chips provide more than one TC block, so you have the
-	  choice of which one to use for the clock framework.  The other
-	  TC can be used for other purposes, such as PWM generation and
-	  interval timing.
-
 config DUMMY_IRQ
 	tristate "Dummy IRQ handler"
 	default n
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 81ef3e67acc9..00adf5088699 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -8,7 +8,6 @@ obj-$(CONFIG_AD525X_DPOT_I2C)	+= ad525x_dpot-i2c.o
 obj-$(CONFIG_AD525X_DPOT_SPI)	+= ad525x_dpot-spi.o
 obj-$(CONFIG_INTEL_MID_PTI)	+= pti.o
 obj-$(CONFIG_ATMEL_SSC)		+= atmel-ssc.o
-obj-$(CONFIG_ATMEL_TCLIB)	+= atmel_tclib.o
 obj-$(CONFIG_DUMMY_IRQ)		+= dummy-irq.o
 obj-$(CONFIG_ICS932S401)	+= ics932s401.o
 obj-$(CONFIG_LKDTM)		+= lkdtm.o
diff --git a/drivers/misc/atmel_tclib.c b/drivers/misc/atmel_tclib.c
deleted file mode 100644
index ac24a4bd63f7..000000000000
--- a/drivers/misc/atmel_tclib.c
+++ /dev/null
@@ -1,198 +0,0 @@
-#include <linux/atmel_tc.h>
-#include <linux/clk.h>
-#include <linux/err.h>
-#include <linux/init.h>
-#include <linux/io.h>
-#include <linux/ioport.h>
-#include <linux/kernel.h>
-#include <linux/platform_device.h>
-#include <linux/module.h>
-#include <linux/slab.h>
-#include <linux/export.h>
-#include <linux/of.h>
-
-/*
- * This is a thin library to solve the problem of how to portably allocate
- * one of the TC blocks.  For simplicity, it doesn't currently expect to
- * share individual timers between different drivers.
- */
-
-#if defined(CONFIG_AVR32)
-/* AVR32 has these divide PBB */
-const u8 atmel_tc_divisors[5] = { 0, 4, 8, 16, 32, };
-EXPORT_SYMBOL(atmel_tc_divisors);
-
-#elif defined(CONFIG_ARCH_AT91)
-/* AT91 has these divide MCK */
-const u8 atmel_tc_divisors[5] = { 2, 8, 32, 128, 0, };
-EXPORT_SYMBOL(atmel_tc_divisors);
-
-#endif
-
-static DEFINE_SPINLOCK(tc_list_lock);
-static LIST_HEAD(tc_list);
-
-/**
- * atmel_tc_alloc - allocate a specified TC block
- * @block: which block to allocate
- *
- * Caller allocates a block.  If it is available, a pointer to a
- * pre-initialized struct atmel_tc is returned. The caller can access
- * the registers directly through the "regs" field.
- */
-struct atmel_tc *atmel_tc_alloc(unsigned block)
-{
-	struct atmel_tc		*tc;
-	struct platform_device	*pdev = NULL;
-
-	spin_lock(&tc_list_lock);
-	list_for_each_entry(tc, &tc_list, node) {
-		if (tc->allocated)
-			continue;
-
-		if ((tc->pdev->dev.of_node && tc->id == block) ||
-		    (tc->pdev->id == block)) {
-			pdev = tc->pdev;
-			tc->allocated = true;
-			break;
-		}
-	}
-	spin_unlock(&tc_list_lock);
-
-	return pdev ? tc : NULL;
-}
-EXPORT_SYMBOL_GPL(atmel_tc_alloc);
-
-/**
- * atmel_tc_free - release a specified TC block
- * @tc: Timer/counter block that was returned by atmel_tc_alloc()
- *
- * This reverses the effect of atmel_tc_alloc(), invalidating the resource
- * returned by that routine and making the TC available to other drivers.
- */
-void atmel_tc_free(struct atmel_tc *tc)
-{
-	spin_lock(&tc_list_lock);
-	if (tc->allocated)
-		tc->allocated = false;
-	spin_unlock(&tc_list_lock);
-}
-EXPORT_SYMBOL_GPL(atmel_tc_free);
-
-#if defined(CONFIG_OF)
-static struct atmel_tcb_config tcb_rm9200_config = {
-	.counter_width = 16,
-};
-
-static struct atmel_tcb_config tcb_sam9x5_config = {
-	.counter_width = 32,
-};
-
-static const struct of_device_id atmel_tcb_dt_ids[] = {
-	{
-		.compatible = "atmel,at91rm9200-tcb",
-		.data = &tcb_rm9200_config,
-	}, {
-		.compatible = "atmel,at91sam9x5-tcb",
-		.data = &tcb_sam9x5_config,
-	}, {
-		/* sentinel */
-	}
-};
-
-MODULE_DEVICE_TABLE(of, atmel_tcb_dt_ids);
-#endif
-
-static int __init tc_probe(struct platform_device *pdev)
-{
-	struct atmel_tc *tc;
-	struct clk	*clk;
-	int		irq;
-	struct resource	*r;
-	unsigned int	i;
-
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
-		return -EINVAL;
-
-	tc = devm_kzalloc(&pdev->dev, sizeof(struct atmel_tc), GFP_KERNEL);
-	if (!tc)
-		return -ENOMEM;
-
-	tc->pdev = pdev;
-
-	clk = devm_clk_get(&pdev->dev, "t0_clk");
-	if (IS_ERR(clk))
-		return PTR_ERR(clk);
-
-	tc->slow_clk = devm_clk_get(&pdev->dev, "slow_clk");
-	if (IS_ERR(tc->slow_clk))
-		return PTR_ERR(tc->slow_clk);
-
-	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	tc->regs = devm_ioremap_resource(&pdev->dev, r);
-	if (IS_ERR(tc->regs))
-		return PTR_ERR(tc->regs);
-
-	/* Now take SoC information if available */
-	if (pdev->dev.of_node) {
-		const struct of_device_id *match;
-		match = of_match_node(atmel_tcb_dt_ids, pdev->dev.of_node);
-		if (match)
-			tc->tcb_config = match->data;
-
-		tc->id = of_alias_get_id(tc->pdev->dev.of_node, "tcb");
-	} else {
-		tc->id = pdev->id;
-	}
-
-	tc->clk[0] = clk;
-	tc->clk[1] = devm_clk_get(&pdev->dev, "t1_clk");
-	if (IS_ERR(tc->clk[1]))
-		tc->clk[1] = clk;
-	tc->clk[2] = devm_clk_get(&pdev->dev, "t2_clk");
-	if (IS_ERR(tc->clk[2]))
-		tc->clk[2] = clk;
-
-	tc->irq[0] = irq;
-	tc->irq[1] = platform_get_irq(pdev, 1);
-	if (tc->irq[1] < 0)
-		tc->irq[1] = irq;
-	tc->irq[2] = platform_get_irq(pdev, 2);
-	if (tc->irq[2] < 0)
-		tc->irq[2] = irq;
-
-	for (i = 0; i < 3; i++)
-		writel(ATMEL_TC_ALL_IRQ, tc->regs + ATMEL_TC_REG(i, IDR));
-
-	spin_lock(&tc_list_lock);
-	list_add_tail(&tc->node, &tc_list);
-	spin_unlock(&tc_list_lock);
-
-	platform_set_drvdata(pdev, tc);
-
-	return 0;
-}
-
-static void tc_shutdown(struct platform_device *pdev)
-{
-	int i;
-	struct atmel_tc *tc = platform_get_drvdata(pdev);
-
-	for (i = 0; i < 3; i++)
-		writel(ATMEL_TC_ALL_IRQ, tc->regs + ATMEL_TC_REG(i, IDR));
-}
-
-static struct platform_driver tc_driver = {
-	.driver = {
-		.name	= "atmel_tcb",
-		.of_match_table	= of_match_ptr(atmel_tcb_dt_ids),
-	},
-	.shutdown = tc_shutdown,
-};
-
-static int __init tc_init(void)
-{
-	return platform_driver_probe(&tc_driver, tc_probe);
-}
-arch_initcall(tc_init);
diff --git a/include/linux/atmel_tc.h b/include/linux/atmel_tc.h
index 468fdfa643f0..92f182345222 100644
--- a/include/linux/atmel_tc.h
+++ b/include/linux/atmel_tc.h
@@ -34,14 +34,6 @@
 struct clk;
 
 /**
- * struct atmel_tcb_config - SoC data for a Timer/Counter Block
- * @counter_width: size in bits of a timer counter register
- */
-struct atmel_tcb_config {
-	size_t	counter_width;
-};
-
-/**
  * struct atmel_tc - information about a Timer/Counter Block
  * @pdev: physical device
  * @regs: mapping through which the I/O registers can be accessed
@@ -64,7 +56,6 @@ struct atmel_tc {
 	struct platform_device	*pdev;
 	void __iomem		*regs;
 	int                     id;
-	const struct atmel_tcb_config *tcb_config;
 	int			irq[3];
 	struct clk		*clk[3];
 	struct clk		*slow_clk;
-- 
2.11.0
