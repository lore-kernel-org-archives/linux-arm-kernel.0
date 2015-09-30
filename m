From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 30 Sep 2015 18:10:57 +0200
Subject: [PATCH 04/16] clk: at91: make use of syscon to share PMC registers in
 several drivers
In-Reply-To: <1443629469-15086-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1443629469-15086-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1443629469-15086-5-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Boris Brezillon <boris.brezillon@free-electrons.com>

The PMC block is providing several functionnalities:
 - system clk management
 - cpuidle
 - platform suspend

Replace the void __iomem *regs field by a regmap (retrieved using syscon)
so that we can later share the regmap across several drivers without
exporting a new specific API or a global void __iomem * variable.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/mach-at91/Kconfig |  1 +
 drivers/clk/at91/pmc.c     | 12 ++++++++----
 drivers/clk/at91/pmc.h     | 11 ++++++++---
 3 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index 89a755b90db2..3b2f594f2ce7 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -95,6 +95,7 @@ config HAVE_AT91_USB_CLK
 config COMMON_CLK_AT91
 	bool
 	select COMMON_CLK
+	select MFD_SYSCON
 
 config HAVE_AT91_SMD
 	bool
diff --git a/drivers/clk/at91/pmc.c b/drivers/clk/at91/pmc.c
index d1844f1f3729..ba458eae4bda 100644
--- a/drivers/clk/at91/pmc.c
+++ b/drivers/clk/at91/pmc.c
@@ -19,6 +19,7 @@
 #include <linux/irqchip/chained_irq.h>
 #include <linux/irqdomain.h>
 #include <linux/of_irq.h>
+#include <linux/mfd/syscon.h>
 
 #include <asm/proc-fns.h>
 
@@ -215,6 +216,7 @@ static const struct at91_pmc_caps sama5d3_caps = {
 };
 
 static struct at91_pmc *__init at91_pmc_init(struct device_node *np,
+					     struct regmap *regmap,
 					     void __iomem *regbase, int virq,
 					     const struct at91_pmc_caps *caps)
 {
@@ -230,7 +232,7 @@ static struct at91_pmc *__init at91_pmc_init(struct device_node *np,
 		return NULL;
 
 	spin_lock_init(&pmc->lock);
-	pmc->regbase = regbase;
+	pmc->regmap = regmap;
 	pmc->virq = virq;
 	pmc->caps = caps;
 
@@ -380,16 +382,18 @@ static void __init of_at91_pmc_setup(struct device_node *np,
 	void (*clk_setup)(struct device_node *, struct at91_pmc *);
 	const struct of_device_id *clk_id;
 	void __iomem *regbase = of_iomap(np, 0);
+	struct regmap *regmap;
 	int virq;
 
-	if (!regbase)
-		return;
+	regmap = syscon_node_to_regmap(np);
+	if (IS_ERR(regmap))
+		panic("Could not retrieve syscon regmap");
 
 	virq = irq_of_parse_and_map(np, 0);
 	if (!virq)
 		return;
 
-	pmc = at91_pmc_init(np, regbase, virq, caps);
+	pmc = at91_pmc_init(np, regmap, regbase, virq, caps);
 	if (!pmc)
 		return;
 	for_each_child_of_node(np, childnp) {
diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
index 8b87771c69b2..0247eb0e171b 100644
--- a/drivers/clk/at91/pmc.h
+++ b/drivers/clk/at91/pmc.h
@@ -14,6 +14,7 @@
 
 #include <linux/io.h>
 #include <linux/irqdomain.h>
+#include <linux/regmap.h>
 #include <linux/spinlock.h>
 
 struct clk_range {
@@ -28,7 +29,7 @@ struct at91_pmc_caps {
 };
 
 struct at91_pmc {
-	void __iomem *regbase;
+	struct regmap *regmap;
 	int virq;
 	spinlock_t lock;
 	const struct at91_pmc_caps *caps;
@@ -48,12 +49,16 @@ static inline void pmc_unlock(struct at91_pmc *pmc)
 
 static inline u32 pmc_read(struct at91_pmc *pmc, int offset)
 {
-	return readl(pmc->regbase + offset);
+	unsigned int ret = 0;
+
+	regmap_read(pmc->regmap, offset, &ret);
+
+	return ret;
 }
 
 static inline void pmc_write(struct at91_pmc *pmc, int offset, u32 value)
 {
-	writel(value, pmc->regbase + offset);
+	regmap_write(pmc->regmap, offset, value);
 }
 
 int of_at91_get_clk_range(struct device_node *np, const char *propname,
-- 
2.1.4
