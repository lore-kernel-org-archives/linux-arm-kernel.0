From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 18 Feb 2014 16:34:42 +0100
Subject: [PATCH v4 2/7] ARM: imx6: gpc: Add PU power domain for GPU/VPU
In-Reply-To: <1392737687-25003-1-git-send-email-p.zabel@pengutronix.de>
References: <1392737687-25003-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1392737687-25003-3-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When generic pm domain support is enabled, the PGC can be used
to completely gate power to the PU power domain containing GPU3D,
GPU2D, and VPU cores.
This code triggers the PGC powerdown sequence to disable the GPU/VPU
isolation cells and gate power and then disables the PU regulator.
To reenable, the reverse powerup sequence is triggered after the PU
regulaotor is enabled again.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
Changes since v3:
 - Use fsl,power-domain property name to link devices to power domains
---
 arch/arm/mach-imx/Kconfig |   2 +
 arch/arm/mach-imx/gpc.c   | 173 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 175 insertions(+)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 33567aa..3c58f2e 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -808,6 +808,7 @@ config SOC_IMX6Q
 	select PL310_ERRATA_727915 if CACHE_PL310
 	select PL310_ERRATA_769419 if CACHE_PL310
 	select PM_OPP if PM
+	select PM_GENERIC_DOMAINS if PM
 
 	help
 	  This enables support for Freescale i.MX6 Quad processor.
@@ -827,6 +828,7 @@ config SOC_IMX6SL
 	select PL310_ERRATA_588369 if CACHE_PL310
 	select PL310_ERRATA_727915 if CACHE_PL310
 	select PL310_ERRATA_769419 if CACHE_PL310
+	select PM_GENERIC_DOMAINS if PM
 
 	help
 	  This enables support for Freescale i.MX6 SoloLite processor.
diff --git a/arch/arm/mach-imx/gpc.c b/arch/arm/mach-imx/gpc.c
index 586e017..abddcc1 100644
--- a/arch/arm/mach-imx/gpc.c
+++ b/arch/arm/mach-imx/gpc.c
@@ -10,19 +10,32 @@
  * http://www.gnu.org/copyleft/gpl.html
  */
 
+#include <linux/clk.h>
+#include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/irq.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
+#include <linux/platform_device.h>
+#include <linux/pm_domain.h>
+#include <linux/regulator/consumer.h>
 #include <linux/irqchip/arm-gic.h>
 #include "common.h"
+#include "hardware.h"
 
+#define GPC_CNTR		0x000
 #define GPC_IMR1		0x008
+#define GPC_PGC_GPU_PDN		0x260
+#define GPC_PGC_GPU_PUPSCR	0x264
+#define GPC_PGC_GPU_PDNSCR	0x268
 #define GPC_PGC_CPU_PDN		0x2a0
 
 #define IMR_NUM			4
 
+#define GPU_VPU_PUP_REQ		BIT(1)
+#define GPU_VPU_PDN_REQ		BIT(0)
+
 static void __iomem *gpc_base;
 static u32 gpc_wake_irqs[IMR_NUM];
 static u32 gpc_saved_imrs[IMR_NUM];
@@ -138,3 +151,163 @@ void __init imx_gpc_init(void)
 	gic_arch_extn.irq_unmask = imx_gpc_irq_unmask;
 	gic_arch_extn.irq_set_wake = imx_gpc_irq_set_wake;
 }
+
+static struct regulator *pu_reg;
+
+static int imx6q_pm_pu_power_off(struct generic_pm_domain *genpd)
+{
+	u32 val;
+	int iso, iso2sw;
+
+	/* Read ISO and ISO2SW power down delays */
+	val = readl_relaxed(gpc_base + GPC_PGC_GPU_PDNSCR);
+	iso = val & 0x3f;
+	iso2sw = (val >> 8) & 0x3f;
+
+	/* Gate off PU domain when GPU/VPU when powered down */
+	writel_relaxed(0x1, gpc_base + GPC_PGC_GPU_PDN);
+
+	/* Request GPC to power down GPU/VPU */
+	val = readl_relaxed(gpc_base + GPC_CNTR);
+	val |= GPU_VPU_PDN_REQ;
+	writel_relaxed(val, gpc_base + GPC_CNTR);
+
+	/* Wait ISO + ISO2SW IPG clock cycles */
+	ndelay((iso + iso2sw) * 1000 / 66);
+
+	regulator_disable(pu_reg);
+
+	return 0;
+}
+
+static int imx6q_pm_pu_power_on(struct generic_pm_domain *genpd)
+{
+	int ret;
+	u32 val;
+	int sw, sw2iso;
+
+	ret = regulator_enable(pu_reg);
+	if (ret) {
+		pr_err("%s: failed to enable regulator: %d\n", __func__, ret);
+		return ret;
+	}
+
+	/* Gate off PU domain when GPU/VPU when powered down */
+	writel_relaxed(0x1, gpc_base + GPC_PGC_GPU_PDN);
+
+	/* Read ISO and ISO2SW power down delays */
+	val = readl_relaxed(gpc_base + GPC_PGC_GPU_PUPSCR);
+	sw = val & 0x3f;
+	sw2iso = (val >> 8) & 0x3f;
+
+	/* Request GPC to power up GPU/VPU */
+	val = readl_relaxed(gpc_base + GPC_CNTR);
+	val |= GPU_VPU_PUP_REQ;
+	writel_relaxed(val, gpc_base + GPC_CNTR);
+
+	/* Wait ISO + ISO2SW IPG clock cycles */
+	ndelay((sw + sw2iso) * 1000 / 66);
+
+	return 0;
+}
+
+static struct generic_pm_domain imx6q_pu_domain = {
+	.name = "PU",
+	.power_off = imx6q_pm_pu_power_off,
+	.power_on = imx6q_pm_pu_power_on,
+};
+
+static int imx6q_pm_notifier_call(struct notifier_block *nb,
+				  unsigned long event, void *data)
+{
+	struct generic_pm_domain *genpd;
+	struct device *dev = data;
+	struct device_node *np;
+	int ret;
+
+	switch (event) {
+	case BUS_NOTIFY_BIND_DRIVER:
+		np = of_parse_phandle(dev->of_node, "fsl,power-domain", 0);
+		if (!np || np != imx6q_pu_domain.of_node)
+			return NOTIFY_DONE;
+
+		ret = pm_genpd_of_add_device(np, dev);
+		if (ret)
+			dev_err(dev, "failed to add to power domain: %d\n",
+				ret);
+		break;
+	case BUS_NOTIFY_UNBOUND_DRIVER:
+		genpd = dev_to_genpd(dev);
+		if (IS_ERR(genpd) || genpd != &imx6q_pu_domain)
+			return NOTIFY_DONE;
+
+		ret = pm_genpd_remove_device(genpd, dev);
+		if (ret)
+			dev_err(dev, "failed to remove from power domain: %d\n",
+				ret);
+		break;
+	}
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block imx6q_platform_nb = {
+	.notifier_call = imx6q_pm_notifier_call,
+};
+
+static int imx_gpc_probe(struct platform_device *pdev)
+{
+	struct device_node *np;
+	bool is_off;
+	int ret;
+
+	np = of_get_child_by_name(pdev->dev.of_node, "pu-power-domain");
+	if (!np) {
+		dev_err(&pdev->dev, "missing pu-power-domain node\n");
+		return -EINVAL;
+	}
+	imx6q_pu_domain.of_node = np;
+
+	pu_reg = devm_regulator_get(&pdev->dev, "pu");
+	if (IS_ERR(pu_reg)) {
+		ret = PTR_ERR(pu_reg);
+		dev_err(&pdev->dev, "failed to get pu regulator: %d\n", ret);
+		return ret;
+	}
+
+	/* The regulator is initially enabled */
+	ret = regulator_enable(pu_reg);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to enable pu regulator: %d\n", ret);
+		return ret;
+	}
+
+	is_off = IS_ENABLED(CONFIG_PM_RUNTIME);
+	if (is_off)
+		imx6q_pm_pu_power_off(&imx6q_pu_domain);
+
+	pm_genpd_init(&imx6q_pu_domain, NULL, is_off);
+	bus_register_notifier(&platform_bus_type, &imx6q_platform_nb);
+
+	return 0;
+}
+
+static struct of_device_id imx_gpc_dt_ids[] = {
+	{ .compatible = "fsl,imx6q-gpc" },
+	{ }
+};
+
+static struct platform_driver imx_gpc_driver = {
+	.driver = {
+		.name = "imx-gpc",
+		.owner = THIS_MODULE,
+		.of_match_table = imx_gpc_dt_ids,
+	},
+	.probe = imx_gpc_probe,
+};
+
+static int __init imx_pgc_init(void)
+{
+	return platform_driver_register(&imx_gpc_driver);
+}
+subsys_initcall(imx_pgc_init);
-- 
1.8.5.3
