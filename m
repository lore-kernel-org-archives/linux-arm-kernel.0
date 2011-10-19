From: zoss@devai.org (Zoltan Devai)
Date: Wed, 19 Oct 2011 18:01:56 +0200
Subject: [PATCH v2 3/5] ARM: SPMP8000: Add clocksource and clockevent drivers
In-Reply-To: <1319040118-29773-1-git-send-email-zoss@devai.org>
References: <1318178172-7965-1-git-send-email-zoss@devai.org>
	<1319040118-29773-1-git-send-email-zoss@devai.org>
Message-ID: <1319040118-29773-4-git-send-email-zoss@devai.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a clocksource and clockevent for the SPMP8000 machine.

Cc: John Stultz <johnstul@us.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Grant Likely <grant.likely@secretlab.ca>
Signed-off-by: Zoltan Devai <zoss@devai.org>
---
 drivers/clocksource/Makefile        |    3 +-
 drivers/clocksource/spmp8000_tmrb.c |  159 +++++++++++++++++++++++++++++++++++
 2 files changed, 161 insertions(+), 1 deletions(-)
 create mode 100644 drivers/clocksource/spmp8000_tmrb.c

diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 8d81a1d..adb575e 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -9,4 +9,5 @@ obj-$(CONFIG_SH_TIMER_TMU)	+= sh_tmu.o
 obj-$(CONFIG_CLKBLD_I8253)	+= i8253.o
 obj-$(CONFIG_CLKSRC_MMIO)	+= mmio.o
 obj-$(CONFIG_DW_APB_TIMER)	+= dw_apb_timer.o
-obj-$(CONFIG_CLKSRC_DBX500_PRCMU)	+= clksrc-dbx500-prcmu.o
\ No newline at end of file
+obj-$(CONFIG_CLKSRC_DBX500_PRCMU)	+= clksrc-dbx500-prcmu.o
+obj-$(CONFIG_ARCH_SPMP8000)	+= spmp8000_tmrb.o
diff --git a/drivers/clocksource/spmp8000_tmrb.c b/drivers/clocksource/spmp8000_tmrb.c
new file mode 100644
index 0000000..8c0f042
--- /dev/null
+++ b/drivers/clocksource/spmp8000_tmrb.c
@@ -0,0 +1,159 @@
+/*
+ * SPMP8000 machines timer functions
+ *
+ * Copyright (C) 2011 Zoltan Devai <zoss@devai.org>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/kernel.h>
+#include <linux/irq.h>
+#include <linux/io.h>
+#include <linux/err.h>
+#include <linux/bitops.h>
+#include <linux/interrupt.h>
+#include <linux/clockchips.h>
+#include <linux/clk.h>
+#include <asm/mach/time.h>
+
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+
+/* Timer constraints:
+ * - WDT: Can't clear the irq directly, only by resetting the whole counter
+ *   in the ISR, which means that IRQs will jitter
+ * - Timer_B: Can't reset the timer value, so at start, the first IRQ
+ *   will happen at some random time.
+ */
+#define SPMP8000_TMRB(tnum)	(tnum * 0x20)
+#define SPMP8000_TMRB_CTR	0x00
+#define SPMP8000_TMRB_CTR_TE	BIT(0)
+#define SPMP8000_TMRB_CTR_IE	BIT(1)
+#define SPMP8000_TMRB_CTR_OE	BIT(2)
+#define SPMP8000_TMRB_CTR_PWMON	BIT(3)
+#define SPMP8000_TMRB_CTR_UD	BIT(4)
+#define SPMP8000_TMRB_CTR_UDS	BIT(5)
+#define SPMP8000_TMRB_CTR_OM	BIT(6)
+#define SPMP8000_TMRB_CTR_ES_SH	8
+#define SPMP8000_TMRB_CTR_M_SH	10
+#define SPMP8000_TMRB_PSR	0x04
+#define SPMP8000_TMRB_LDR	0x08
+#define SPMP8000_TMRB_VLR	0x08
+#define SPMP8000_TMRB_ISR	0x0C
+#define SPMP8000_TMRB_CMP	0x10
+
+static unsigned long clkrate;
+static const unsigned int tickrate = 1012500;
+
+#define CS_TIMER	2
+#define CE_TIMER	1
+static void __iomem *cs_base;
+static void __iomem *ce_base;
+
+static void tmrb_set_mode(enum clock_event_mode mode,
+				struct clock_event_device *dev)
+{
+	switch (mode) {
+	case CLOCK_EVT_MODE_PERIODIC:
+		writel((tickrate / HZ), ce_base + SPMP8000_TMRB_LDR);
+		/* Configure as periodic, down counter, IEN, enable timer */
+		writel(SPMP8000_TMRB_CTR_TE | SPMP8000_TMRB_CTR_IE |
+				(1 << SPMP8000_TMRB_CTR_M_SH),
+				ce_base + SPMP8000_TMRB_CTR);
+		break;
+	case CLOCK_EVT_MODE_SHUTDOWN:
+	case CLOCK_EVT_MODE_UNUSED:
+		/* Disable timer */
+		writel(0, ce_base + SPMP8000_TMRB_CTR);
+		break;
+	default:
+		BUG();
+		break;
+	}
+}
+
+static struct clock_event_device tmrb1_clkevt = {
+	.name		= "tmrb1",
+	.features	= CLOCK_EVT_FEAT_PERIODIC,
+	.rating		= 200,
+	.set_mode	= tmrb_set_mode,
+};
+
+static irqreturn_t tmrb1_isr(int irq, void *dev_id)
+{
+	tmrb1_clkevt.event_handler(&tmrb1_clkevt);
+
+	/* Clear IRQ */
+	writel(0, ce_base + SPMP8000_TMRB_ISR);
+
+	return IRQ_HANDLED;
+};
+
+static struct irqaction tmrb1_irq = {
+	.name		= "tmrb1_irq",
+	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
+	.handler	= tmrb1_isr,
+};
+
+void __init spmp8000_sys_timer_init(void)
+{
+	struct device_node *np;
+	unsigned int irq;
+	void *tmrb_base;
+	const __be32 *prop;
+
+	np = of_find_compatible_node(NULL, NULL, "sunplus,spmp8000-timer");
+	if (!np)
+		panic("spmp8000: unable to find timer node in dtb\n");
+
+	tmrb_base = of_iomap(np, 0);
+	if (!tmrb_base)
+		panic("spmp8000: unable to map timer cpu registers\n");
+
+	irq = of_irq_to_resource(np, CE_TIMER, NULL);
+	if (irq == NO_IRQ)
+		panic("spmp8000: unable to get interrupts of timer\n");
+
+	prop = of_get_property(np, "clock-freq", NULL);
+	if (!prop)
+		panic("spmp8000: Can't get boot clock rate of timer\n");
+	clkrate = be32_to_cpup(prop);
+
+	of_node_put(np);
+
+	cs_base = tmrb_base + SPMP8000_TMRB(CS_TIMER);
+	ce_base = tmrb_base + SPMP8000_TMRB(CE_TIMER);
+
+	/* Clocksource */
+	/* Disable timer */
+	writel(0, cs_base + SPMP8000_TMRB_CTR);
+
+	/* Reset counter value
+	 * Not really possible unless setting end-1 LDR value and waiting
+	 * until the counter reaches that */
+
+	/* Prescale timer */
+	writel((clkrate / tickrate) - 1, cs_base + SPMP8000_TMRB_PSR);
+
+	/* Register the clocksource */
+	clocksource_mmio_init(cs_base + SPMP8000_TMRB_VLR, "tmrb2",
+				tickrate, 200, 16, clocksource_mmio_readl_up);
+
+	/* Configure as free running (0 - 0xFFFF), up counter, enable timer */
+	writel(SPMP8000_TMRB_CTR_TE | SPMP8000_TMRB_CTR_UD,
+		cs_base + SPMP8000_TMRB_CTR);
+
+	/* Clockevent */
+	setup_irq(irq, &tmrb1_irq);
+
+	/* Disable timer */
+	writel(0, ce_base + SPMP8000_TMRB_CTR);
+
+	/* Prescale timer */
+	writel((clkrate / tickrate) - 1, ce_base + SPMP8000_TMRB_PSR);
+
+	clockevents_register_device(&tmrb1_clkevt);
+}
-- 
1.7.4.1
