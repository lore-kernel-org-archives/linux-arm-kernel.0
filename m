From: l.stach@pengutronix.de (Lucas Stach)
Date: Fri, 17 Feb 2017 20:02:44 +0100
Subject: [PATCH v3 2/4] ARM: imx6: remove PGC handling from GPC driver
In-Reply-To: <20170217190246.14881-1-l.stach@pengutronix.de>
References: <20170217190246.14881-1-l.stach@pengutronix.de>
Message-ID: <20170217190246.14881-2-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This removes all functionality regarding the power gating controller
from the GPC driver. This will be added back in a re-written driver
outside of the architecture code.

This keeps only the IRQ controller code in the architecture, as this
is closely coupled to the CPU idle implementation.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 arch/arm/mach-imx/gpc.c | 217 ------------------------------------------------
 1 file changed, 217 deletions(-)

diff --git a/arch/arm/mach-imx/gpc.c b/arch/arm/mach-imx/gpc.c
index 1dc2a34b9dbd..93f584ba0130 100644
--- a/arch/arm/mach-imx/gpc.c
+++ b/arch/arm/mach-imx/gpc.c
@@ -10,26 +10,17 @@
  * http://www.gnu.org/copyleft/gpl.html
  */
 
-#include <linux/clk.h>
-#include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/irq.h>
 #include <linux/irqchip.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
-#include <linux/platform_device.h>
-#include <linux/pm_domain.h>
-#include <linux/regulator/consumer.h>
 #include <linux/irqchip/arm-gic.h>
 #include "common.h"
 #include "hardware.h"
 
-#define GPC_CNTR		0x000
 #define GPC_IMR1		0x008
-#define GPC_PGC_GPU_PDN		0x260
-#define GPC_PGC_GPU_PUPSCR	0x264
-#define GPC_PGC_GPU_PDNSCR	0x268
 #define GPC_PGC_CPU_PDN		0x2a0
 #define GPC_PGC_CPU_PUPSCR	0x2a4
 #define GPC_PGC_CPU_PDNSCR	0x2a8
@@ -39,18 +30,6 @@
 #define IMR_NUM			4
 #define GPC_MAX_IRQS		(IMR_NUM * 32)
 
-#define GPU_VPU_PUP_REQ		BIT(1)
-#define GPU_VPU_PDN_REQ		BIT(0)
-
-#define GPC_CLK_MAX		6
-
-struct pu_domain {
-	struct generic_pm_domain base;
-	struct regulator *reg;
-	struct clk *clk[GPC_CLK_MAX];
-	int num_clks;
-};
-
 static void __iomem *gpc_base;
 static u32 gpc_wake_irqs[IMR_NUM];
 static u32 gpc_saved_imrs[IMR_NUM];
@@ -296,199 +275,3 @@ void __init imx_gpc_check_dt(void)
 		gpc_base = of_iomap(np, 0);
 	}
 }
-
-static void _imx6q_pm_pu_power_off(struct generic_pm_domain *genpd)
-{
-	int iso, iso2sw;
-	u32 val;
-
-	/* Read ISO and ISO2SW power down delays */
-	val = readl_relaxed(gpc_base + GPC_PGC_GPU_PDNSCR);
-	iso = val & 0x3f;
-	iso2sw = (val >> 8) & 0x3f;
-
-	/* Gate off PU domain when GPU/VPU when powered down */
-	writel_relaxed(0x1, gpc_base + GPC_PGC_GPU_PDN);
-
-	/* Request GPC to power down GPU/VPU */
-	val = readl_relaxed(gpc_base + GPC_CNTR);
-	val |= GPU_VPU_PDN_REQ;
-	writel_relaxed(val, gpc_base + GPC_CNTR);
-
-	/* Wait ISO + ISO2SW IPG clock cycles */
-	ndelay((iso + iso2sw) * 1000 / 66);
-}
-
-static int imx6q_pm_pu_power_off(struct generic_pm_domain *genpd)
-{
-	struct pu_domain *pu = container_of(genpd, struct pu_domain, base);
-
-	_imx6q_pm_pu_power_off(genpd);
-
-	if (pu->reg)
-		regulator_disable(pu->reg);
-
-	return 0;
-}
-
-static int imx6q_pm_pu_power_on(struct generic_pm_domain *genpd)
-{
-	struct pu_domain *pu = container_of(genpd, struct pu_domain, base);
-	int i, ret, sw, sw2iso;
-	u32 val;
-
-	if (pu->reg)
-		ret = regulator_enable(pu->reg);
-	if (pu->reg && ret) {
-		pr_err("%s: failed to enable regulator: %d\n", __func__, ret);
-		return ret;
-	}
-
-	/* Enable reset clocks for all devices in the PU domain */
-	for (i = 0; i < pu->num_clks; i++)
-		clk_prepare_enable(pu->clk[i]);
-
-	/* Gate off PU domain when GPU/VPU when powered down */
-	writel_relaxed(0x1, gpc_base + GPC_PGC_GPU_PDN);
-
-	/* Read ISO and ISO2SW power down delays */
-	val = readl_relaxed(gpc_base + GPC_PGC_GPU_PUPSCR);
-	sw = val & 0x3f;
-	sw2iso = (val >> 8) & 0x3f;
-
-	/* Request GPC to power up GPU/VPU */
-	val = readl_relaxed(gpc_base + GPC_CNTR);
-	val |= GPU_VPU_PUP_REQ;
-	writel_relaxed(val, gpc_base + GPC_CNTR);
-
-	/* Wait ISO + ISO2SW IPG clock cycles */
-	ndelay((sw + sw2iso) * 1000 / 66);
-
-	/* Disable reset clocks for all devices in the PU domain */
-	for (i = 0; i < pu->num_clks; i++)
-		clk_disable_unprepare(pu->clk[i]);
-
-	return 0;
-}
-
-static struct generic_pm_domain imx6q_arm_domain = {
-	.name = "ARM",
-};
-
-static struct pu_domain imx6q_pu_domain = {
-	.base = {
-		.name = "PU",
-		.power_off = imx6q_pm_pu_power_off,
-		.power_on = imx6q_pm_pu_power_on,
-	},
-};
-
-static struct generic_pm_domain imx6sl_display_domain = {
-	.name = "DISPLAY",
-};
-
-static struct generic_pm_domain *imx_gpc_domains[] = {
-	&imx6q_arm_domain,
-	&imx6q_pu_domain.base,
-	&imx6sl_display_domain,
-};
-
-static struct genpd_onecell_data imx_gpc_onecell_data = {
-	.domains = imx_gpc_domains,
-	.num_domains = ARRAY_SIZE(imx_gpc_domains),
-};
-
-static int imx_gpc_genpd_init(struct device *dev, struct regulator *pu_reg)
-{
-	struct clk *clk;
-	int i, ret;
-
-	imx6q_pu_domain.reg = pu_reg;
-
-	for (i = 0; ; i++) {
-		clk = of_clk_get(dev->of_node, i);
-		if (IS_ERR(clk))
-			break;
-		if (i >= GPC_CLK_MAX) {
-			dev_err(dev, "more than %d clocks\n", GPC_CLK_MAX);
-			goto clk_err;
-		}
-		imx6q_pu_domain.clk[i] = clk;
-	}
-	imx6q_pu_domain.num_clks = i;
-
-	/* Enable power always in case bootloader disabled it. */
-	imx6q_pm_pu_power_on(&imx6q_pu_domain.base);
-
-	if (!IS_ENABLED(CONFIG_PM_GENERIC_DOMAINS))
-		return 0;
-
-	imx6q_pu_domain.base.states = devm_kzalloc(dev,
-					sizeof(*imx6q_pu_domain.base.states),
-					GFP_KERNEL);
-	if (!imx6q_pu_domain.base.states)
-		return -ENOMEM;
-
-	imx6q_pu_domain.base.states[0].power_off_latency_ns = 25000;
-	imx6q_pu_domain.base.states[0].power_on_latency_ns = 2000000;
-	imx6q_pu_domain.base.state_count = 1;
-
-	for (i = 0; i < ARRAY_SIZE(imx_gpc_domains); i++)
-		pm_genpd_init(imx_gpc_domains[i], NULL, false);
-
-	ret =  of_genpd_add_provider_onecell(dev->of_node,
-					     &imx_gpc_onecell_data);
-	if (ret)
-		goto power_off;
-
-	return 0;
-
-power_off:
-	imx6q_pm_pu_power_off(&imx6q_pu_domain.base);
-clk_err:
-	while (i--)
-		clk_put(imx6q_pu_domain.clk[i]);
-	imx6q_pu_domain.reg = NULL;
-	return -EINVAL;
-}
-
-static int imx_gpc_probe(struct platform_device *pdev)
-{
-	struct regulator *pu_reg;
-	int ret;
-
-	/* bail out if DT too old and doesn't provide the necessary info */
-	if (!of_property_read_bool(pdev->dev.of_node, "#power-domain-cells"))
-		return 0;
-
-	pu_reg = devm_regulator_get_optional(&pdev->dev, "pu");
-	if (PTR_ERR(pu_reg) == -ENODEV)
-		pu_reg = NULL;
-	if (IS_ERR(pu_reg)) {
-		ret = PTR_ERR(pu_reg);
-		dev_err(&pdev->dev, "failed to get pu regulator: %d\n", ret);
-		return ret;
-	}
-
-	return imx_gpc_genpd_init(&pdev->dev, pu_reg);
-}
-
-static const struct of_device_id imx_gpc_dt_ids[] = {
-	{ .compatible = "fsl,imx6q-gpc" },
-	{ .compatible = "fsl,imx6sl-gpc" },
-	{ }
-};
-
-static struct platform_driver imx_gpc_driver = {
-	.driver = {
-		.name = "imx-gpc",
-		.of_match_table = imx_gpc_dt_ids,
-	},
-	.probe = imx_gpc_probe,
-};
-
-static int __init imx_pgc_init(void)
-{
-	return platform_driver_register(&imx_gpc_driver);
-}
-subsys_initcall(imx_pgc_init);
-- 
2.11.0
