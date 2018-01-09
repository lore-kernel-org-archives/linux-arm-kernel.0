From: fabio.estevam@nxp.com (Fabio Estevam)
Date: Tue, 9 Jan 2018 13:24:43 -0200
Subject: [PATCH] ARM: imx: Remove epit support
Message-ID: <1515511483-24706-1-git-send-email-fabio.estevam@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently there is no user of EPIT, so remove such unused code.

If someone wants to add EPIT support back, then the person needs to
create a proper support into drivers/clocksource/ and add device
tree support, proper bindings, etc.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/mach-imx/Kconfig  |  13 ---
 arch/arm/mach-imx/Makefile |   1 -
 arch/arm/mach-imx/epit.c   | 228 ---------------------------------------------
 3 files changed, 242 deletions(-)
 delete mode 100644 arch/arm/mach-imx/epit.c

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 782699e..1831319 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -32,18 +32,6 @@ config MXC_DEBUG_BOARD
 	  data/address de-multiplexing and decode, signal level shift,
 	  interrupt control and various board functions.
 
-config HAVE_EPIT
-	bool
-
-config MXC_USE_EPIT
-	bool "Use EPIT instead of GPT"
-	depends on HAVE_EPIT
-	help
-	  Use EPIT as the system timer on systems that have it. Normally you
-	  don't have a reason to do so as the EPIT has the same features and
-	  uses the same clocks as the GPT. Anyway, on some systems the GPT
-	  may be in use for other purposes.
-
 config HAVE_IMX_ANATOP
 	bool
 
@@ -85,7 +73,6 @@ config SOC_IMX31
 config SOC_IMX35
 	bool
 	select ARCH_MXC_IOMUX_V3
-	select HAVE_EPIT
 	select MXC_AVIC
 	select PINCTRL_IMX35
 
diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 8ff7105..04ba789 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -20,7 +20,6 @@ obj-$(CONFIG_ARCH_MXC_IOMUX_V3) += iomux-v3.o
 obj-$(CONFIG_MXC_TZIC) += tzic.o
 obj-$(CONFIG_MXC_AVIC) += avic.o
 
-obj-$(CONFIG_MXC_USE_EPIT) += epit.o
 obj-$(CONFIG_MXC_DEBUG_BOARD) += 3ds_debugboard.o
 
 ifeq ($(CONFIG_CPU_IDLE),y)
diff --git a/arch/arm/mach-imx/epit.c b/arch/arm/mach-imx/epit.c
deleted file mode 100644
index fb9a73a..0000000
--- a/arch/arm/mach-imx/epit.c
+++ /dev/null
@@ -1,228 +0,0 @@
-/*
- *  linux/arch/arm/plat-mxc/epit.c
- *
- *  Copyright (C) 2010 Sascha Hauer <s.hauer@pengutronix.de>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version 2
- * of the License, or (at your option) any later version.
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
- * MA 02110-1301, USA.
- */
-
-#define EPITCR		0x00
-#define EPITSR		0x04
-#define EPITLR		0x08
-#define EPITCMPR	0x0c
-#define EPITCNR		0x10
-
-#define EPITCR_EN			(1 << 0)
-#define EPITCR_ENMOD			(1 << 1)
-#define EPITCR_OCIEN			(1 << 2)
-#define EPITCR_RLD			(1 << 3)
-#define EPITCR_PRESC(x)			(((x) & 0xfff) << 4)
-#define EPITCR_SWR			(1 << 16)
-#define EPITCR_IOVW			(1 << 17)
-#define EPITCR_DBGEN			(1 << 18)
-#define EPITCR_WAITEN			(1 << 19)
-#define EPITCR_RES			(1 << 20)
-#define EPITCR_STOPEN			(1 << 21)
-#define EPITCR_OM_DISCON		(0 << 22)
-#define EPITCR_OM_TOGGLE		(1 << 22)
-#define EPITCR_OM_CLEAR			(2 << 22)
-#define EPITCR_OM_SET			(3 << 22)
-#define EPITCR_CLKSRC_OFF		(0 << 24)
-#define EPITCR_CLKSRC_PERIPHERAL	(1 << 24)
-#define EPITCR_CLKSRC_REF_HIGH		(1 << 24)
-#define EPITCR_CLKSRC_REF_LOW		(3 << 24)
-
-#define EPITSR_OCIF			(1 << 0)
-
-#include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <linux/clockchips.h>
-#include <linux/clk.h>
-#include <linux/err.h>
-#include <asm/mach/time.h>
-
-#include "common.h"
-#include "hardware.h"
-
-static struct clock_event_device clockevent_epit;
-
-static void __iomem *timer_base;
-
-static inline void epit_irq_disable(void)
-{
-	u32 val;
-
-	val = imx_readl(timer_base + EPITCR);
-	val &= ~EPITCR_OCIEN;
-	imx_writel(val, timer_base + EPITCR);
-}
-
-static inline void epit_irq_enable(void)
-{
-	u32 val;
-
-	val = imx_readl(timer_base + EPITCR);
-	val |= EPITCR_OCIEN;
-	imx_writel(val, timer_base + EPITCR);
-}
-
-static void epit_irq_acknowledge(void)
-{
-	imx_writel(EPITSR_OCIF, timer_base + EPITSR);
-}
-
-static int __init epit_clocksource_init(struct clk *timer_clk)
-{
-	unsigned int c = clk_get_rate(timer_clk);
-
-	return clocksource_mmio_init(timer_base + EPITCNR, "epit", c, 200, 32,
-			clocksource_mmio_readl_down);
-}
-
-/* clock event */
-
-static int epit_set_next_event(unsigned long evt,
-			      struct clock_event_device *unused)
-{
-	unsigned long tcmp;
-
-	tcmp = imx_readl(timer_base + EPITCNR);
-
-	imx_writel(tcmp - evt, timer_base + EPITCMPR);
-
-	return 0;
-}
-
-/* Left event sources disabled, no more interrupts appear */
-static int epit_shutdown(struct clock_event_device *evt)
-{
-	unsigned long flags;
-
-	/*
-	 * The timer interrupt generation is disabled at least
-	 * for enough time to call epit_set_next_event()
-	 */
-	local_irq_save(flags);
-
-	/* Disable interrupt in GPT module */
-	epit_irq_disable();
-
-	/* Clear pending interrupt */
-	epit_irq_acknowledge();
-
-	local_irq_restore(flags);
-
-	return 0;
-}
-
-static int epit_set_oneshot(struct clock_event_device *evt)
-{
-	unsigned long flags;
-
-	/*
-	 * The timer interrupt generation is disabled at least
-	 * for enough time to call epit_set_next_event()
-	 */
-	local_irq_save(flags);
-
-	/* Disable interrupt in GPT module */
-	epit_irq_disable();
-
-	/* Clear pending interrupt, only while switching mode */
-	if (!clockevent_state_oneshot(evt))
-		epit_irq_acknowledge();
-
-	/*
-	 * Do not put overhead of interrupt enable/disable into
-	 * epit_set_next_event(), the core has about 4 minutes
-	 * to call epit_set_next_event() or shutdown clock after
-	 * mode switching
-	 */
-	epit_irq_enable();
-	local_irq_restore(flags);
-
-	return 0;
-}
-
-/*
- * IRQ handler for the timer
- */
-static irqreturn_t epit_timer_interrupt(int irq, void *dev_id)
-{
-	struct clock_event_device *evt = &clockevent_epit;
-
-	epit_irq_acknowledge();
-
-	evt->event_handler(evt);
-
-	return IRQ_HANDLED;
-}
-
-static struct irqaction epit_timer_irq = {
-	.name		= "i.MX EPIT Timer Tick",
-	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
-	.handler	= epit_timer_interrupt,
-};
-
-static struct clock_event_device clockevent_epit = {
-	.name			= "epit",
-	.features		= CLOCK_EVT_FEAT_ONESHOT,
-	.set_state_shutdown	= epit_shutdown,
-	.tick_resume		= epit_shutdown,
-	.set_state_oneshot	= epit_set_oneshot,
-	.set_next_event		= epit_set_next_event,
-	.rating			= 200,
-};
-
-static int __init epit_clockevent_init(struct clk *timer_clk)
-{
-	clockevent_epit.cpumask = cpumask_of(0);
-	clockevents_config_and_register(&clockevent_epit,
-					clk_get_rate(timer_clk),
-					0x800, 0xfffffffe);
-
-	return 0;
-}
-
-void __init epit_timer_init(void __iomem *base, int irq)
-{
-	struct clk *timer_clk;
-
-	timer_clk = clk_get_sys("imx-epit.0", NULL);
-	if (IS_ERR(timer_clk)) {
-		pr_err("i.MX epit: unable to get clk\n");
-		return;
-	}
-
-	clk_prepare_enable(timer_clk);
-
-	timer_base = base;
-
-	/*
-	 * Initialise to a known state (all timers off, and timing reset)
-	 */
-	imx_writel(0x0, timer_base + EPITCR);
-
-	imx_writel(0xffffffff, timer_base + EPITLR);
-	imx_writel(EPITCR_EN | EPITCR_CLKSRC_REF_HIGH | EPITCR_WAITEN,
-		   timer_base + EPITCR);
-
-	/* init and register the timer to the framework */
-	epit_clocksource_init(timer_clk);
-	epit_clockevent_init(timer_clk);
-
-	/* Make irqs happen */
-	setup_irq(irq, &epit_timer_irq);
-}
-- 
2.7.4
