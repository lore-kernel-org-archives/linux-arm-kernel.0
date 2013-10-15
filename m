From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 15 Oct 2013 18:42:50 +0200
Subject: [PATCH] ARM: exynos: Allow wake-up using GIC interrupts
Message-ID: <1381855370-7500-1-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch restores the ability to receive wake-up events from internal
GIC interrupts, e.g. RTC tick or alarm interrupts.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos/include/mach/pm-core.h |  1 -
 arch/arm/mach-exynos/pm.c                   | 55 +++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-exynos/include/mach/pm-core.h b/arch/arm/mach-exynos/include/mach/pm-core.h
index 2b00833..be112ce 100644
--- a/arch/arm/mach-exynos/include/mach/pm-core.h
+++ b/arch/arm/mach-exynos/include/mach/pm-core.h
@@ -66,7 +66,6 @@ static inline void samsung_pm_saved_gpios(void)
 
 /* Compatibility definitions to make plat-samsung/pm.c compile */
 #define IRQ_EINT_BIT(x)		1
-#define s3c_irqwake_intallow	0
 #define s3c_irqwake_eintallow	0
 
 #endif /* __ASM_ARCH_PM_CORE_H */
diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
index c679db5..1f24e7f 100644
--- a/arch/arm/mach-exynos/pm.c
+++ b/arch/arm/mach-exynos/pm.c
@@ -212,14 +212,69 @@ static struct subsys_interface exynos_pm_interface = {
 	.add_dev	= exynos_pm_add,
 };
 
+struct exynos_wkup_irq {
+	unsigned int hwirq;
+	u32 mask;
+};
+
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
+unsigned long s3c_irqwake_intallow;
+
+int s3c_irq_wake(struct irq_data *data, unsigned int state)
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
+				s3c_irqwake_intmask |= wkup_irq->mask;
+			else
+				s3c_irqwake_intmask &= ~wkup_irq->mask;
+			return 0;
+		}
+		++wkup_irq;
+	}
+
+	return -ENOENT;
+}
+
 static __init int exynos_pm_drvinit(void)
 {
+	const struct exynos_wkup_irq *wkup_irq;
 	struct clk *pll_base;
 	unsigned int tmp;
 
 	if (soc_is_exynos5440())
 		return 0;
 
+	if (soc_is_exynos5250())
+		wkup_irq = exynos5250_wkup_irq;
+	else
+		wkup_irq = exynos4_wkup_irq;
+
+	while (wkup_irq->mask) {
+		s3c_irqwake_intallow |= wkup_irq->mask;
+		++wkup_irq;
+	}
+
+	gic_arch_extn.irq_set_wake = s3c_irq_wake;
+
 	s3c_pm_init();
 
 	/* All wakeup disable */
-- 
1.8.3.2
