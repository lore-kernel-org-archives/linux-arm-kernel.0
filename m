From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 5 Mar 2014 14:56:51 +0800
Subject: [PATCH v5 2/5] ARM: imx6: gpc: Add PU power domain for GPU/VPU
In-Reply-To: <1393603427-6199-3-git-send-email-p.zabel@pengutronix.de>
References: <1393603427-6199-1-git-send-email-p.zabel@pengutronix.de>
 <1393603427-6199-3-git-send-email-p.zabel@pengutronix.de>
Message-ID: <20140305065649.GJ8784@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 28, 2014 at 05:03:44PM +0100, Philipp Zabel wrote:
> When generic pm domain support is enabled, the PGC can be used
> to completely gate power to the PU power domain containing GPU3D,
> GPU2D, and VPU cores.
> This code triggers the PGC powerdown sequence to disable the GPU/VPU
> isolation cells and gate power and then disables the PU regulator.
> To reenable, the reverse powerup sequence is triggered after the PU
> regulator is enabled again.
> The GPU and VPU devices in the PU power domain temporarily need
> to be clocked during powerup, so that the reset machinery can work.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
> Changes since v4:
>  - Add pu_domain struct to contain regulator and clocks
>  - Obtain clocks from device tree instead of from bus notifier
>  - Add compatible value for imx6sl (untested)
> ---
>  arch/arm/mach-imx/Kconfig |   2 +
>  arch/arm/mach-imx/gpc.c   | 182 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 184 insertions(+)
> 
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index 33567aa..3c58f2e 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -808,6 +808,7 @@ config SOC_IMX6Q
>  	select PL310_ERRATA_727915 if CACHE_PL310
>  	select PL310_ERRATA_769419 if CACHE_PL310
>  	select PM_OPP if PM
> +	select PM_GENERIC_DOMAINS if PM

Would it make more sense to have HAVE_IMX_GPC select it instead?

>  
>  	help
>  	  This enables support for Freescale i.MX6 Quad processor.
> @@ -827,6 +828,7 @@ config SOC_IMX6SL
>  	select PL310_ERRATA_588369 if CACHE_PL310
>  	select PL310_ERRATA_727915 if CACHE_PL310
>  	select PL310_ERRATA_769419 if CACHE_PL310
> +	select PM_GENERIC_DOMAINS if PM
>  
>  	help
>  	  This enables support for Freescale i.MX6 SoloLite processor.
> diff --git a/arch/arm/mach-imx/gpc.c b/arch/arm/mach-imx/gpc.c
> index 586e017..a0f587e 100644
> --- a/arch/arm/mach-imx/gpc.c
> +++ b/arch/arm/mach-imx/gpc.c
> @@ -10,19 +10,40 @@
>   * http://www.gnu.org/copyleft/gpl.html
>   */
>  
> +#include <linux/clk.h>
> +#include <linux/delay.h>
>  #include <linux/io.h>
>  #include <linux/irq.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
>  #include <linux/of_irq.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_clock.h>

Is this header still needed?

> +#include <linux/pm_domain.h>
> +#include <linux/regulator/consumer.h>
>  #include <linux/irqchip/arm-gic.h>
>  #include "common.h"
> +#include "hardware.h"
>  
> +#define GPC_CNTR		0x000
>  #define GPC_IMR1		0x008
> +#define GPC_PGC_GPU_PDN		0x260
> +#define GPC_PGC_GPU_PUPSCR	0x264
> +#define GPC_PGC_GPU_PDNSCR	0x268
>  #define GPC_PGC_CPU_PDN		0x2a0
>  
>  #define IMR_NUM			4
>  
> +#define GPU_VPU_PUP_REQ		BIT(1)
> +#define GPU_VPU_PDN_REQ		BIT(0)
> +
> +struct pu_domain {
> +	struct generic_pm_domain base;
> +	struct regulator *reg;
> +	struct clk *clk[6];

Define a macro for this number?

> +	int num_clks;
> +};
> +
>  static void __iomem *gpc_base;
>  static u32 gpc_wake_irqs[IMR_NUM];
>  static u32 gpc_saved_imrs[IMR_NUM];
> @@ -138,3 +159,164 @@ void __init imx_gpc_init(void)
>  	gic_arch_extn.irq_unmask = imx_gpc_irq_unmask;
>  	gic_arch_extn.irq_set_wake = imx_gpc_irq_set_wake;
>  }
> +
> +#ifdef CONFIG_PM
> +
> +static int imx6q_pm_pu_power_off(struct generic_pm_domain *genpd)
> +{
> +	struct pu_domain *pu = container_of(genpd, struct pu_domain, base);
> +	int iso, iso2sw;
> +	u32 val;
> +
> +	/* Read ISO and ISO2SW power down delays */
> +	val = readl_relaxed(gpc_base + GPC_PGC_GPU_PDNSCR);
> +	iso = val & 0x3f;
> +	iso2sw = (val >> 8) & 0x3f;
> +
> +	/* Gate off PU domain when GPU/VPU when powered down */
> +	writel_relaxed(0x1, gpc_base + GPC_PGC_GPU_PDN);
> +
> +	/* Request GPC to power down GPU/VPU */
> +	val = readl_relaxed(gpc_base + GPC_CNTR);
> +	val |= GPU_VPU_PDN_REQ;
> +	writel_relaxed(val, gpc_base + GPC_CNTR);
> +
> +	/* Wait ISO + ISO2SW IPG clock cycles */
> +	ndelay((iso + iso2sw) * 1000 / 66);
> +
> +	regulator_disable(pu->reg);
> +
> +	return 0;
> +}
> +
> +static int imx6q_pm_pu_power_on(struct generic_pm_domain *genpd)
> +{
> +	struct pu_domain *pu = container_of(genpd, struct pu_domain, base);
> +	int i, ret, sw, sw2iso;
> +	u32 val;
> +
> +	ret = regulator_enable(pu->reg);
> +	if (ret) {
> +		pr_err("%s: failed to enable regulator: %d\n", __func__, ret);
> +		return ret;
> +	}
> +
> +	/* Enable reset clocks for all devices in the PU domain */
> +	for (i = 0; i < pu->num_clks; i++)
> +		clk_prepare_enable(pu->clk[i]);
> +
> +	/* Gate off PU domain when GPU/VPU when powered down */
> +	writel_relaxed(0x1, gpc_base + GPC_PGC_GPU_PDN);
> +
> +	/* Read ISO and ISO2SW power down delays */
> +	val = readl_relaxed(gpc_base + GPC_PGC_GPU_PUPSCR);
> +	sw = val & 0x3f;
> +	sw2iso = (val >> 8) & 0x3f;
> +
> +	/* Request GPC to power up GPU/VPU */
> +	val = readl_relaxed(gpc_base + GPC_CNTR);
> +	val |= GPU_VPU_PUP_REQ;
> +	writel_relaxed(val, gpc_base + GPC_CNTR);
> +
> +	/* Wait ISO + ISO2SW IPG clock cycles */
> +	ndelay((sw + sw2iso) * 1000 / 66);
> +
> +	/* Disable reset clocks for all devices in the PU domain */
> +	for (i = 0; i < pu->num_clks; i++)
> +		clk_disable_unprepare(pu->clk[i]);
> +
> +	return 0;
> +}
> +
> +static struct generic_pm_domain imx6q_arm_domain = {
> +	.name = "ARM",
> +};
> +
> +static struct pu_domain imx6q_pu_domain = {
> +	.base = {
> +		.name = "PU",
> +		.power_off = imx6q_pm_pu_power_off,
> +		.power_on = imx6q_pm_pu_power_on,
> +		.power_off_latency_ns = 25000,
> +		.power_on_latency_ns = 2000000,
> +	},
> +};
> +
> +static struct generic_pm_domain imx6sl_display_domain = {
> +	.name = "DISPLAY",
> +};
> +
> +static struct generic_pm_domain *imx_gpc_domains[] = {
> +	&imx6q_arm_domain,
> +	&imx6q_pu_domain.base,
> +	&imx6sl_display_domain,
> +};
> +
> +static struct genpd_onecell_data imx_gpc_onecell_data = {
> +	.domains = imx_gpc_domains,
> +	.domain_num = ARRAY_SIZE(imx_gpc_domains),
> +};
> +
> +#endif /* CONFIG_PM */
> +
> +static int imx_gpc_probe(struct platform_device *pdev)
> +{
> +	struct regulator *pu_reg;
> +	struct clk *clk;
> +	bool is_off;
> +	int ret, i;
> +
> +	pu_reg = devm_regulator_get(&pdev->dev, "pu");
> +	if (IS_ERR(pu_reg)) {
> +		ret = PTR_ERR(pu_reg);
> +		dev_err(&pdev->dev, "failed to get pu regulator: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* The regulator is initially enabled */
> +	ret = regulator_enable(pu_reg);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "failed to enable pu regulator: %d\n", ret);
> +		return ret;
> +	}
> +	imx6q_pu_domain.base.of_node = pdev->dev.of_node;

How does this work with !CONFIG_PM build?

Shawn

> +	imx6q_pu_domain.reg = pu_reg;
> +
> +	for (i = 0; ; i++) {
> +		clk = of_clk_get(pdev->dev.of_node, i);
> +		if (IS_ERR(clk))
> +			break;
> +		imx6q_pu_domain.clk[i] = clk;
> +	}
> +	imx6q_pu_domain.num_clks = i;
> +
> +	is_off = IS_ENABLED(CONFIG_PM_RUNTIME);
> +	if (is_off)
> +		imx6q_pm_pu_power_off(&imx6q_pu_domain.base);
> +
> +	pm_genpd_init(&imx6q_pu_domain.base, NULL, is_off);
> +	of_genpd_add_provider(pdev->dev.of_node, of_genpd_xlate_onecell,
> +			      &imx_gpc_onecell_data);
> +	return 0;
> +}
> +
> +static struct of_device_id imx_gpc_dt_ids[] = {
> +	{ .compatible = "fsl,imx6q-gpc" },
> +	{ .compatible = "fsl,imx6sl-gpc" },
> +	{ }
> +};
> +
> +static struct platform_driver imx_gpc_driver = {
> +	.driver = {
> +		.name = "imx-gpc",
> +		.owner = THIS_MODULE,
> +		.of_match_table = imx_gpc_dt_ids,
> +	},
> +	.probe = imx_gpc_probe,
> +};
> +
> +static int __init imx_pgc_init(void)
> +{
> +	return platform_driver_register(&imx_gpc_driver);
> +}
> +subsys_initcall(imx_pgc_init);
> -- 
> 1.8.5.3
> 
