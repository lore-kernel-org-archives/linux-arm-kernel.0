From: linux@arm.linux.org.uk (Russell King)
Date: Thu, 04 Mar 2010 19:11:57 +0000
Subject: [PATCH] ARM: Indirect round/set_rate operations through clk
	structure
References: <git-1267729916-dfa670a4d0328179183bdaf01411c7f29b2ad886@rmk-PC>
Message-ID: <git-1267729916-ae808d90a7a03e196b781c56ce2266c469fb5c5c@rmk-PC>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-integrator/impd1.c               |   10 +++++-
 arch/arm/mach-integrator/include/mach/clkdev.h |    4 +-
 arch/arm/mach-integrator/integrator_cp.c       |    8 ++++-
 arch/arm/mach-realview/core.c                  |    8 ++++-
 arch/arm/mach-realview/include/mach/clkdev.h   |    4 +-
 arch/arm/mach-versatile/core.c                 |    8 ++++-
 arch/arm/mach-versatile/include/mach/clkdev.h  |    4 +-
 arch/arm/plat-versatile/clock.c                |   38 ++++++++++++++++-------
 arch/arm/plat-versatile/include/plat/clock.h   |   15 +++++++++
 9 files changed, 76 insertions(+), 23 deletions(-)
 create mode 100644 arch/arm/plat-versatile/include/plat/clock.h

diff --git a/arch/arm/mach-integrator/impd1.c b/arch/arm/mach-integrator/impd1.c
index 2f9de62..1a0ee93 100644
--- a/arch/arm/mach-integrator/impd1.c
+++ b/arch/arm/mach-integrator/impd1.c
@@ -71,6 +71,12 @@ static void impd1_setvco(struct clk *clk, struct icst_vco vco)
 #endif
 }
 
+static const struct clk_ops impd1_clk_ops = {
+	.round	= icst_clk_round,
+	.set	= icst_clk_set,
+	.setvco	= impd1_setvco,
+};
+
 void impd1_tweak_control(struct device *dev, u32 mask, u32 val)
 {
 	struct impd1_module *impd1 = dev_get_drvdata(dev);
@@ -366,10 +372,10 @@ static int impd1_probe(struct lm_device *dev)
 		(unsigned long)dev->resource.start);
 
 	for (i = 0; i < ARRAY_SIZE(impd1->vcos); i++) {
+		impd1->vcos[i].ops = &impd1_clk_ops,
 		impd1->vcos[i].owner = THIS_MODULE,
 		impd1->vcos[i].params = &impd1_vco_params,
-		impd1->vcos[i].data = impd1,
-		impd1->vcos[i].setvco = impd1_setvco;
+		impd1->vcos[i].data = impd1;
 	}
 	impd1->vcos[0].vcoreg = impd1->base + IMPD1_OSC1;
 	impd1->vcos[1].vcoreg = impd1->base + IMPD1_OSC2;
diff --git a/arch/arm/mach-integrator/include/mach/clkdev.h b/arch/arm/mach-integrator/include/mach/clkdev.h
index ed67e8e..bfe0767 100644
--- a/arch/arm/mach-integrator/include/mach/clkdev.h
+++ b/arch/arm/mach-integrator/include/mach/clkdev.h
@@ -2,14 +2,14 @@
 #define __ASM_MACH_CLKDEV_H
 
 #include <linux/module.h>
-#include <asm/hardware/icst.h>
+#include <plat/clock.h>
 
 struct clk {
 	unsigned long		rate;
+	const struct clk_ops	*ops;
 	struct module		*owner;
 	const struct icst_params *params;
 	void __iomem		*vcoreg;
-	void			(*setvco)(struct clk *, struct icst_vco vco);
 	void			*data;
 };
 
diff --git a/arch/arm/mach-integrator/integrator_cp.c b/arch/arm/mach-integrator/integrator_cp.c
index 5908580..54edb6b 100644
--- a/arch/arm/mach-integrator/integrator_cp.c
+++ b/arch/arm/mach-integrator/integrator_cp.c
@@ -293,10 +293,16 @@ static void cp_auxvco_set(struct clk *clk, struct icst_vco vco)
 	writel(0, CM_LOCK);
 }
 
+static const struct clk_ops cp_auxclk_ops = {
+	.round	= icst_clk_round,
+	.set	= icst_clk_set,
+	.setvco	= cp_auxvco_set,
+};
+
 static struct clk cp_auxclk = {
+	.ops	= &cp_auxclk_ops,
 	.params	= &cp_auxvco_params,
 	.vcoreg	= CM_AUXOSC,
-	.setvco = cp_auxvco_set,
 };
 
 static struct clk_lookup cp_lookups[] = {
diff --git a/arch/arm/mach-realview/core.c b/arch/arm/mach-realview/core.c
index 043b93b..1b468bd 100644
--- a/arch/arm/mach-realview/core.c
+++ b/arch/arm/mach-realview/core.c
@@ -281,9 +281,15 @@ static void realview_oscvco_set(struct clk *clk, struct icst_vco vco)
 	writel(0, sys_lock);
 }
 
+static const struct clk_ops oscvco_clk_ops = {
+	.round	= icst_clk_round,
+	.set	= icst_clk_set,
+	.setvco	= realview_oscvco_set,
+};
+
 static struct clk oscvco_clk = {
+	.ops	= &oscvco_clk_ops,
 	.params	= &realview_oscvco_params,
-	.setvco = realview_oscvco_set,
 };
 
 /*
diff --git a/arch/arm/mach-realview/include/mach/clkdev.h b/arch/arm/mach-realview/include/mach/clkdev.h
index baea03c..e58d077 100644
--- a/arch/arm/mach-realview/include/mach/clkdev.h
+++ b/arch/arm/mach-realview/include/mach/clkdev.h
@@ -1,13 +1,13 @@
 #ifndef __ASM_MACH_CLKDEV_H
 #define __ASM_MACH_CLKDEV_H
 
-#include <asm/hardware/icst.h>
+#include <plat/clock.h>
 
 struct clk {
 	unsigned long		rate;
+	const struct clk_ops	*ops;
 	const struct icst_params *params;
 	void __iomem		*vcoreg;
-	void			(*setvco)(struct clk *, struct icst_vco vco);
 };
 
 #define __clk_get(clk) ({ 1; })
diff --git a/arch/arm/mach-versatile/core.c b/arch/arm/mach-versatile/core.c
index 957bbde..60baba6 100644
--- a/arch/arm/mach-versatile/core.c
+++ b/arch/arm/mach-versatile/core.c
@@ -381,9 +381,15 @@ static void versatile_oscvco_set(struct clk *clk, struct icst_vco vco)
 	writel(0, sys_lock);
 }
 
+static const struct clk_ops osc4_clk_ops = {
+	.round	= icst_clk_round,
+	.set	= icst_clk_set,
+	.setvco	= versatile_oscvco_set,
+};
+
 static struct clk osc4_clk = {
+	.ops	= &osc4_clk_ops,
 	.params	= &versatile_oscvco_params,
-	.setvco	= versatile_oscvco_set,
 };
 
 /*
diff --git a/arch/arm/mach-versatile/include/mach/clkdev.h b/arch/arm/mach-versatile/include/mach/clkdev.h
index baea03c..e58d077 100644
--- a/arch/arm/mach-versatile/include/mach/clkdev.h
+++ b/arch/arm/mach-versatile/include/mach/clkdev.h
@@ -1,13 +1,13 @@
 #ifndef __ASM_MACH_CLKDEV_H
 #define __ASM_MACH_CLKDEV_H
 
-#include <asm/hardware/icst.h>
+#include <plat/clock.h>
 
 struct clk {
 	unsigned long		rate;
+	const struct clk_ops	*ops;
 	const struct icst_params *params;
 	void __iomem		*vcoreg;
-	void			(*setvco)(struct clk *, struct icst_vco vco);
 };
 
 #define __clk_get(clk) ({ 1; })
diff --git a/arch/arm/plat-versatile/clock.c b/arch/arm/plat-versatile/clock.c
index 2fa34de..5c8b656 100644
--- a/arch/arm/plat-versatile/clock.c
+++ b/arch/arm/plat-versatile/clock.c
@@ -37,24 +37,38 @@ EXPORT_SYMBOL(clk_get_rate);
 
 long clk_round_rate(struct clk *clk, unsigned long rate)
 {
-	struct icst_vco vco;
-	vco = icst_hz_to_vco(clk->params, rate);
-	return icst_hz(clk->params, vco);
+	long ret = -EIO;
+	if (clk->ops && clk->ops->round)
+		ret = clk->ops->round(clk, rate);
+	return ret;
 }
 EXPORT_SYMBOL(clk_round_rate);
 
 int clk_set_rate(struct clk *clk, unsigned long rate)
 {
 	int ret = -EIO;
-
-	if (clk->setvco) {
-		struct icst_vco vco;
-
-		vco = icst_hz_to_vco(clk->params, rate);
-		clk->rate = icst_hz(clk->params, vco);
-		clk->setvco(clk, vco);
-		ret = 0;
-	}
+	if (clk->ops && clk->ops->set)
+		ret = clk->ops->set(clk, rate);
 	return ret;
 }
 EXPORT_SYMBOL(clk_set_rate);
+
+long icst_clk_round(struct clk *clk, unsigned long rate)
+{
+	struct icst_vco vco;
+	vco = icst_hz_to_vco(clk->params, rate);
+	return icst_hz(clk->params, vco);
+}
+EXPORT_SYMBOL(icst_clk_round);
+
+int icst_clk_set(struct clk *clk, unsigned long rate)
+{
+	struct icst_vco vco;
+
+	vco = icst_hz_to_vco(clk->params, rate);
+	clk->rate = icst_hz(clk->params, vco);
+	clk->ops->setvco(clk, vco);
+
+	return 0;
+}
+EXPORT_SYMBOL(icst_clk_set);
diff --git a/arch/arm/plat-versatile/include/plat/clock.h b/arch/arm/plat-versatile/include/plat/clock.h
new file mode 100644
index 0000000..3cfb024
--- /dev/null
+++ b/arch/arm/plat-versatile/include/plat/clock.h
@@ -0,0 +1,15 @@
+#ifndef PLAT_CLOCK_H
+#define PLAT_CLOCK_H
+
+#include <asm/hardware/icst.h>
+
+struct clk_ops {
+	long	(*round)(struct clk *, unsigned long);
+	int	(*set)(struct clk *, unsigned long);
+	void	(*setvco)(struct clk *, struct icst_vco);
+};
+
+int icst_clk_set(struct clk *, unsigned long);
+long icst_clk_round(struct clk *, unsigned long);
+
+#endif
