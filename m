From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue,  4 Mar 2014 17:02:01 -0800
Subject: [PATCH] irqchip: gic: Silence sparse warnings
Message-ID: <1393981321-25721-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

drivers/irqchip/irq-gic.c:53:23: warning: duplicate [noderef]
drivers/irqchip/irq-gic.c:651:6: warning: symbol 'gic_raise_softirq' was not declared. Should it be static?
drivers/irqchip/irq-gic.c:872:29: warning: symbol 'gic_irq_domain_ops' was not declared. Should it be static?
drivers/irqchip/irq-gic.c:977:12: warning: symbol 'gic_of_init' was not declared. Should it be static?

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/irqchip/irq-gic.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 500e533b9648..a917b144895e 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -50,7 +50,7 @@
 
 union gic_base {
 	void __iomem *common_base;
-	void __percpu __iomem **percpu_base;
+	void __percpu * __iomem *percpu_base;
 };
 
 struct gic_chip_data {
@@ -648,7 +648,7 @@ static void __init gic_pm_init(struct gic_chip_data *gic)
 #endif
 
 #ifdef CONFIG_SMP
-void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
+static void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
 {
 	int cpu;
 	unsigned long flags, map = 0;
@@ -869,7 +869,7 @@ static struct notifier_block gic_cpu_notifier = {
 };
 #endif
 
-const struct irq_domain_ops gic_irq_domain_ops = {
+static const struct irq_domain_ops gic_irq_domain_ops = {
 	.map = gic_irq_domain_map,
 	.xlate = gic_irq_domain_xlate,
 };
@@ -974,7 +974,8 @@ void __init gic_init_bases(unsigned int gic_nr, int irq_start,
 #ifdef CONFIG_OF
 static int gic_cnt __initdata;
 
-int __init gic_of_init(struct device_node *node, struct device_node *parent)
+static int __init
+gic_of_init(struct device_node *node, struct device_node *parent)
 {
 	void __iomem *cpu_base;
 	void __iomem *dist_base;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
