From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 12 Apr 2013 16:03:25 +0200
Subject: [PATCH 7/7] irqchip: exynos: pass irq_base from platform
In-Reply-To: <1365775405-115297-1-git-send-email-arnd@arndb.de>
References: <1365775405-115297-1-git-send-email-arnd@arndb.de>
Message-ID: <1365775405-115297-8-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The platform code knows the IRQ base, while the irqchip driver
should really not. This is a littly hacky because we still
hardwire the IRQ base to 160 for the combiner in the DT case,
when we should really use -1. Removing that line will cause
a linear IRQ domain to be use, as we should.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 arch/arm/mach-exynos/common.c     |  3 ++-
 arch/arm/mach-exynos/common.h     |  2 +-
 drivers/irqchip/exynos-combiner.c | 23 +++++++++++++----------
 3 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
index ecdd212..12f43fc 100644
--- a/arch/arm/mach-exynos/common.c
+++ b/arch/arm/mach-exynos/common.c
@@ -444,7 +444,8 @@ void __init exynos4_init_irq(void)
 #endif
 
 	if (!of_have_populated_dt())
-		combiner_init(S5P_VA_COMBINER_BASE, NULL, max_combiner_nr());
+		combiner_init(S5P_VA_COMBINER_BASE, NULL,
+			      max_combiner_nr(), COMBINER_IRQ(0, 0));
 
 	/*
 	 * The parameters of s5p_init_irq() are for VIC init.
diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
index 4ba8cbe..3e72d03 100644
--- a/arch/arm/mach-exynos/common.h
+++ b/arch/arm/mach-exynos/common.h
@@ -70,7 +70,7 @@ void exynos4212_register_clocks(void);
 
 struct device_node;
 void combiner_init(void __iomem *combiner_base, struct device_node *np,
-			unsigned int max_nr);
+			unsigned int max_nr, int irq_base);
 
 extern struct smp_operations exynos_smp_ops;
 
diff --git a/drivers/irqchip/exynos-combiner.c b/drivers/irqchip/exynos-combiner.c
index acb9c74..6855c92 100644
--- a/drivers/irqchip/exynos-combiner.c
+++ b/drivers/irqchip/exynos-combiner.c
@@ -206,27 +206,22 @@ static unsigned int combiner_lookup_irq(int group)
 
 void __init combiner_init(void __iomem *combiner_base,
 			  struct device_node *np,
-			  unsigned int max_nr)
+			  unsigned int max_nr,
+			  int irq_base)
 {
-	int i, irq, irq_base;
+	int i, irq;
 	unsigned int nr_irq;
 	struct combiner_chip_data *combiner_data;
 
 	nr_irq = max_nr * IRQ_IN_COMBINER;
 
-	irq_base = irq_alloc_descs(COMBINER_IRQ(0, 0), 1, nr_irq, 0);
-	if (IS_ERR_VALUE(irq_base)) {
-		irq_base = COMBINER_IRQ(0, 0);
-		pr_warning("%s: irq desc alloc failed. Continuing with %d as linux irq base\n", __func__, irq_base);
-	}
-
 	combiner_data = kcalloc(max_nr, sizeof (*combiner_data), GFP_KERNEL);
 	if (!combiner_data) {
 		pr_warning("%s: could not allocate combiner data\n", __func__);
 		return;
 	}
 
-	combiner_irq_domain = irq_domain_add_legacy(np, nr_irq, irq_base, 0,
+	combiner_irq_domain = irq_domain_add_simple(np, nr_irq, irq_base,
 				&combiner_irq_domain_ops, combiner_data);
 	if (WARN_ON(!combiner_irq_domain)) {
 		pr_warning("%s: irq domain init failed\n", __func__);
@@ -253,6 +248,7 @@ static int __init combiner_of_init(struct device_node *np,
 {
 	void __iomem *combiner_base;
 	unsigned int max_nr = 20;
+	int irq_base = -1;
 
 	combiner_base = of_iomap(np, 0);
 	if (!combiner_base) {
@@ -266,7 +262,14 @@ static int __init combiner_of_init(struct device_node *np,
 			__func__, max_nr);
 	}
 
-	combiner_init(combiner_base, np, max_nr);
+	/* 
+	 * FIXME: This is a hardwired COMBINER_IRQ(0,0). Once all devices
+	 * get their IRQ from DT, remove this in order to get dynamic
+	 * allocation.
+	 */
+	irq_base = 160;
+
+	combiner_init(combiner_base, np, max_nr, irq_base);
 
 	return 0;
 }
-- 
1.8.1.2
