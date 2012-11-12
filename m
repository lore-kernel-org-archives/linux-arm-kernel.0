From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 12 Nov 2012 22:46:15 +0530
Subject: [PATCH] fixup! ARM: SPEAr3xx: shirq: simplify and move the shared irq
 multiplexor to DT
In-Reply-To: <71bbb1faf3cd048953dcf24ef9ce6d9dd37fe8e1.1352608333.git.viresh.kumar@linaro.org>
References: <71bbb1faf3cd048953dcf24ef9ce6d9dd37fe8e1.1352608333.git.viresh.kumar@linaro.org>
Message-ID: <d9fab7cf89c07d00311f9b3dbf7c0987f813c71d.1352740385.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---

Hi Arnd,

This is the fixup of the major issues you pointed out. Please go ahead
and apply this series. I will then move all this out of plat.

 arch/arm/mach-spear3xx/spear3xx.c        |  6 +--
 arch/arm/plat-spear/include/plat/shirq.h |  6 ++-
 arch/arm/plat-spear/shirq.c              | 70 ++++++++++++++------------------
 3 files changed, 39 insertions(+), 43 deletions(-)

diff --git a/arch/arm/mach-spear3xx/spear3xx.c b/arch/arm/mach-spear3xx/spear3xx.c
index 781aec9..f1aaf5b 100644
--- a/arch/arm/mach-spear3xx/spear3xx.c
+++ b/arch/arm/mach-spear3xx/spear3xx.c
@@ -122,9 +122,9 @@ struct sys_timer spear3xx_timer = {
 
 static const struct of_device_id vic_of_match[] __initconst = {
 	{ .compatible = "arm,pl190-vic", .data = vic_of_init, },
-	{ .compatible = "st,spear300-shirq", .data = spear3xx_shirq_of_init, },
-	{ .compatible = "st,spear310-shirq", .data = spear3xx_shirq_of_init, },
-	{ .compatible = "st,spear320-shirq", .data = spear3xx_shirq_of_init, },
+	{ .compatible = "st,spear300-shirq", .data = spear300_shirq_of_init, },
+	{ .compatible = "st,spear310-shirq", .data = spear310_shirq_of_init, },
+	{ .compatible = "st,spear320-shirq", .data = spear320_shirq_of_init, },
 	{ /* Sentinel */ }
 };
 
diff --git a/arch/arm/plat-spear/include/plat/shirq.h b/arch/arm/plat-spear/include/plat/shirq.h
index 1215afe..c51b355 100644
--- a/arch/arm/plat-spear/include/plat/shirq.h
+++ b/arch/arm/plat-spear/include/plat/shirq.h
@@ -56,7 +56,11 @@ struct spear_shirq {
 	struct shirq_regs regs;
 };
 
-int __init spear3xx_shirq_of_init(struct device_node *np,
+int __init spear300_shirq_of_init(struct device_node *np,
+		struct device_node *parent);
+int __init spear310_shirq_of_init(struct device_node *np,
+		struct device_node *parent);
+int __init spear320_shirq_of_init(struct device_node *np,
 		struct device_node *parent);
 
 #endif /* __PLAT_SHIRQ_H */
diff --git a/arch/arm/plat-spear/shirq.c b/arch/arm/plat-spear/shirq.c
index 3912646..955c724 100644
--- a/arch/arm/plat-spear/shirq.c
+++ b/arch/arm/plat-spear/shirq.c
@@ -246,10 +246,17 @@ static void __init spear_shirq_register(struct spear_shirq *shirq)
 }
 
 static int __init shirq_init(struct spear_shirq **shirq_blocks, int block_nr,
-		void __iomem *base, struct device_node *np)
+		struct device_node *np)
 {
 	int i, irq_base, hwirq = 0, irq_nr = 0;
 	static struct irq_domain *shirq_domain;
+	void __iomem *base;
+
+	base = of_iomap(np, 0);
+	if (!base) {
+		pr_err("%s: failed to map shirq registers\n", __func__);
+		return -ENXIO;
+	}
 
 	for (i = 0; i < block_nr; i++)
 		irq_nr += shirq_blocks[i]->irq_nr;
@@ -257,15 +264,14 @@ static int __init shirq_init(struct spear_shirq **shirq_blocks, int block_nr,
 	irq_base = irq_alloc_descs(-1, 0, irq_nr, 0);
 	if (IS_ERR_VALUE(irq_base)) {
 		pr_err("%s: irq desc alloc failed\n", __func__);
-		return -ENXIO;
+		goto err_unmap;
 	}
 
 	shirq_domain = irq_domain_add_legacy(np, irq_nr, irq_base, 0,
 			&irq_domain_simple_ops, NULL);
 	if (WARN_ON(!shirq_domain)) {
 		pr_warn("%s: irq domain init failed\n", __func__);
-		irq_free_descs(irq_base, irq_nr);
-		return -ENXIO;
+		goto err_free_desc;
 	}
 
 	for (i = 0; i < block_nr; i++) {
@@ -279,45 +285,31 @@ static int __init shirq_init(struct spear_shirq **shirq_blocks, int block_nr,
 	}
 
 	return 0;
+
+err_free_desc:
+	irq_free_descs(irq_base, irq_nr);
+err_unmap:
+	iounmap(base);
+	return -ENXIO;
 }
 
-int __init spear3xx_shirq_of_init(struct device_node *np,
+int __init spear300_shirq_of_init(struct device_node *np,
 		struct device_node *parent)
 {
-	struct spear_shirq **shirq_blocks;
-	void __iomem *base;
-	int block_nr, ret;
-
-	base = of_iomap(np, 0);
-	if (!base) {
-		pr_err("%s: failed to map shirq registers\n", __func__);
-		return -ENXIO;
-	}
-
-	if (of_device_is_compatible(np, "st,spear300-shirq")) {
-		shirq_blocks = spear300_shirq_blocks;
-		block_nr = ARRAY_SIZE(spear300_shirq_blocks);
-	} else if (of_device_is_compatible(np, "st,spear310-shirq")) {
-		shirq_blocks = spear310_shirq_blocks;
-		block_nr = ARRAY_SIZE(spear310_shirq_blocks);
-	} else if (of_device_is_compatible(np, "st,spear320-shirq")) {
-		shirq_blocks = spear320_shirq_blocks;
-		block_nr = ARRAY_SIZE(spear320_shirq_blocks);
-	} else {
-		pr_err("%s: unknown platform\n", __func__);
-		ret = -EINVAL;
-		goto unmap;
-	}
-
-	ret = shirq_init(shirq_blocks, block_nr, base, np);
-	if (ret) {
-		pr_err("%s: shirq initialization failed\n", __func__);
-		goto unmap;
-	}
+	return shirq_init(spear300_shirq_blocks,
+			ARRAY_SIZE(spear300_shirq_blocks), np);
+}
 
-	return ret;
+int __init spear310_shirq_of_init(struct device_node *np,
+		struct device_node *parent)
+{
+	return shirq_init(spear310_shirq_blocks,
+			ARRAY_SIZE(spear310_shirq_blocks), np);
+}
 
-unmap:
-	iounmap(base);
-	return ret;
+int __init spear320_shirq_of_init(struct device_node *np,
+		struct device_node *parent)
+{
+	return shirq_init(spear320_shirq_blocks,
+			ARRAY_SIZE(spear320_shirq_blocks), np);
 }
-- 
1.7.12.rc2.18.g61b472e
