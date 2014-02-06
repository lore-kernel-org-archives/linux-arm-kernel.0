From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 06 Feb 2014 20:12:57 +0100
Subject: [PATCH v2 12/12] ARM: exynos: Allow wake-up using GIC interrupts
In-Reply-To: <1391713977-22300-1-git-send-email-t.figa@samsung.com>
References: <1391713977-22300-1-git-send-email-t.figa@samsung.com>
Message-ID: <1391713977-22300-13-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch restores the ability to receive wake-up events from internal
GIC interrupts, e.g. RTC tick or alarm interrupts.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos/pm.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
index ada1c83..15af0ce 100644
--- a/arch/arm/mach-exynos/pm.c
+++ b/arch/arm/mach-exynos/pm.c
@@ -17,6 +17,7 @@
 #include <linux/suspend.h>
 #include <linux/syscore_ops.h>
 #include <linux/io.h>
+#include <linux/irqchip/arm-gic.h>
 #include <linux/err.h>
 #include <linux/clk.h>
 
@@ -35,6 +36,16 @@
 #include "common.h"
 #include "regs-pmu.h"
 
+/**
+ * struct exynos_wkup_irq - Exynos GIC to PMU IRQ mapping
+ * @hwirq: Hardware IRQ signal of the GIC
+ * @mask: Mask in PMU wake-up mask register
+ */
+struct exynos_wkup_irq {
+	unsigned int hwirq;
+	u32 mask;
+};
+
 static struct sleep_save exynos5_sys_save[] = {
 	SAVE_ITEM(EXYNOS5_SYS_I2C_CFG),
 };
@@ -48,8 +59,47 @@ static struct sleep_save exynos_core_save[] = {
 	SAVE_ITEM(S5P_SROM_BC3),
 };
 
+/*
+ * GIC wake-up support
+ */
+
 static u32 exynos_irqwake_intmask = 0xffffffff;
 
+static const struct exynos_wkup_irq exynos4_wkup_irq[] = {
+	{ 76, BIT(1) }, /* RTC alarm */
+	{ 77, BIT(2) }, /* RTC tick */
+	{ /* sentinel */ },
+};
+
+static const struct exynos_wkup_irq exynos5250_wkup_irq[] = {
+	{ 75, BIT(1) }, /* RTC alarm */
+	{ 76, BIT(2) }, /* RTC tick */
+	{ /* sentinel */ },
+};
+
+static int exynos_irq_set_wake(struct irq_data *data, unsigned int state)
+{
+	const struct exynos_wkup_irq *wkup_irq;
+
+	if (soc_is_exynos5250())
+		wkup_irq = exynos5250_wkup_irq;
+	else
+		wkup_irq = exynos4_wkup_irq;
+
+	while (wkup_irq->mask) {
+		if (wkup_irq->hwirq == data->hwirq) {
+			if (!state)
+				exynos_irqwake_intmask |= wkup_irq->mask;
+			else
+				exynos_irqwake_intmask &= ~wkup_irq->mask;
+			return 0;
+		}
+		++wkup_irq;
+	}
+
+	return -ENOENT;
+}
+
 /* For Cortex-A9 Diagnostic and Power control register */
 static unsigned int save_arm_register[2];
 
@@ -258,6 +308,9 @@ void __init exynos_pm_init(void)
 {
 	u32 tmp;
 
+	/* Platform-specific GIC callback */
+	gic_arch_extn.irq_set_wake = exynos_irq_set_wake;
+
 	/* All wakeup disable */
 	tmp = __raw_readl(S5P_WAKEUP_MASK);
 	tmp |= ((0xFF << 8) | (0x1F << 1));
-- 
1.8.5.2
