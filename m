From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Sun, 31 Jan 2016 12:51:50 +0100
Subject: [PATCH v4 1/4] soc: mediatek: Refine scpsys to support multiple
 platform
In-Reply-To: <1453270097-53853-2-git-send-email-jamesjj.liao@mediatek.com>
References: <1453270097-53853-1-git-send-email-jamesjj.liao@mediatek.com>
 <1453270097-53853-2-git-send-email-jamesjj.liao@mediatek.com>
Message-ID: <56ADF556.6070402@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 20/01/16 07:08, James Liao wrote:
> Refine scpsys driver common code to support multiple SoC / platform.
>
> Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
> ---
>   drivers/soc/mediatek/mtk-scpsys.c | 418 ++++++++++++++++++++------------------
>   drivers/soc/mediatek/mtk-scpsys.h |  55 +++++
>   2 files changed, 270 insertions(+), 203 deletions(-)
>   create mode 100644 drivers/soc/mediatek/mtk-scpsys.h

In general this approach looks fine to me, comments below.

>
> diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
> index 0221387..339adfc 100644
> --- a/drivers/soc/mediatek/mtk-scpsys.c
> +++ b/drivers/soc/mediatek/mtk-scpsys.c
> @@ -11,29 +11,17 @@
>    * GNU General Public License for more details.
>    */
>   #include <linux/clk.h>
> -#include <linux/delay.h>
> +#include <linux/init.h>
>   #include <linux/io.h>
> -#include <linux/kernel.h>
>   #include <linux/mfd/syscon.h>

When at it, do we need this include?

> -#include <linux/init.h>
>   #include <linux/of_device.h>
>   #include <linux/platform_device.h>
>   #include <linux/pm_domain.h>
> -#include <linux/regmap.h>
> -#include <linux/soc/mediatek/infracfg.h>
>   #include <linux/regulator/consumer.h>
> -#include <dt-bindings/power/mt8173-power.h>
> +#include <linux/soc/mediatek/infracfg.h>
> +
> +#include "mtk-scpsys.h"
>
> -#define SPM_VDE_PWR_CON			0x0210
> -#define SPM_MFG_PWR_CON			0x0214
> -#define SPM_VEN_PWR_CON			0x0230
> -#define SPM_ISP_PWR_CON			0x0238
> -#define SPM_DIS_PWR_CON			0x023c
> -#define SPM_VEN2_PWR_CON		0x0298
> -#define SPM_AUDIO_PWR_CON		0x029c
> -#define SPM_MFG_2D_PWR_CON		0x02c0
> -#define SPM_MFG_ASYNC_PWR_CON		0x02c4
> -#define SPM_USB_PWR_CON			0x02cc

I would prefer to keep this defines and declare SoC specific ones where 
necessary. It makes the code more readable.

>   #define SPM_PWR_STATUS			0x060c
>   #define SPM_PWR_STATUS_2ND		0x0610
>
> @@ -43,154 +31,6 @@
>   #define PWR_ON_2ND_BIT			BIT(3)
>   #define PWR_CLK_DIS_BIT			BIT(4)
>
> -#define PWR_STATUS_DISP			BIT(3)
> -#define PWR_STATUS_MFG			BIT(4)
> -#define PWR_STATUS_ISP			BIT(5)
> -#define PWR_STATUS_VDEC			BIT(7)
> -#define PWR_STATUS_VENC_LT		BIT(20)
> -#define PWR_STATUS_VENC			BIT(21)
> -#define PWR_STATUS_MFG_2D		BIT(22)
> -#define PWR_STATUS_MFG_ASYNC		BIT(23)
> -#define PWR_STATUS_AUDIO		BIT(24)
> -#define PWR_STATUS_USB			BIT(25)
> -

Same here.

> -enum clk_id {
> -	MT8173_CLK_NONE,
> -	MT8173_CLK_MM,
> -	MT8173_CLK_MFG,
> -	MT8173_CLK_VENC,
> -	MT8173_CLK_VENC_LT,
> -	MT8173_CLK_MAX,
> -};
> -
> -#define MAX_CLKS	2
> -
> -struct scp_domain_data {
> -	const char *name;
> -	u32 sta_mask;
> -	int ctl_offs;
> -	u32 sram_pdn_bits;
> -	u32 sram_pdn_ack_bits;
> -	u32 bus_prot_mask;
> -	enum clk_id clk_id[MAX_CLKS];
> -	bool active_wakeup;
> -};
> -
> -static const struct scp_domain_data scp_domain_data[] __initconst = {
> -	[MT8173_POWER_DOMAIN_VDEC] = {
> -		.name = "vdec",
> -		.sta_mask = PWR_STATUS_VDEC,
> -		.ctl_offs = SPM_VDE_PWR_CON,
> -		.sram_pdn_bits = GENMASK(11, 8),
> -		.sram_pdn_ack_bits = GENMASK(12, 12),
> -		.clk_id = {MT8173_CLK_MM},
> -	},
> -	[MT8173_POWER_DOMAIN_VENC] = {
> -		.name = "venc",
> -		.sta_mask = PWR_STATUS_VENC,
> -		.ctl_offs = SPM_VEN_PWR_CON,
> -		.sram_pdn_bits = GENMASK(11, 8),
> -		.sram_pdn_ack_bits = GENMASK(15, 12),
> -		.clk_id = {MT8173_CLK_MM, MT8173_CLK_VENC},
> -	},
> -	[MT8173_POWER_DOMAIN_ISP] = {
> -		.name = "isp",
> -		.sta_mask = PWR_STATUS_ISP,
> -		.ctl_offs = SPM_ISP_PWR_CON,
> -		.sram_pdn_bits = GENMASK(11, 8),
> -		.sram_pdn_ack_bits = GENMASK(13, 12),
> -		.clk_id = {MT8173_CLK_MM},
> -	},
> -	[MT8173_POWER_DOMAIN_MM] = {
> -		.name = "mm",
> -		.sta_mask = PWR_STATUS_DISP,
> -		.ctl_offs = SPM_DIS_PWR_CON,
> -		.sram_pdn_bits = GENMASK(11, 8),
> -		.sram_pdn_ack_bits = GENMASK(12, 12),
> -		.clk_id = {MT8173_CLK_MM},
> -		.bus_prot_mask = MT8173_TOP_AXI_PROT_EN_MM_M0 |
> -			MT8173_TOP_AXI_PROT_EN_MM_M1,
> -	},
> -	[MT8173_POWER_DOMAIN_VENC_LT] = {
> -		.name = "venc_lt",
> -		.sta_mask = PWR_STATUS_VENC_LT,
> -		.ctl_offs = SPM_VEN2_PWR_CON,
> -		.sram_pdn_bits = GENMASK(11, 8),
> -		.sram_pdn_ack_bits = GENMASK(15, 12),
> -		.clk_id = {MT8173_CLK_MM, MT8173_CLK_VENC_LT},
> -	},
> -	[MT8173_POWER_DOMAIN_AUDIO] = {
> -		.name = "audio",
> -		.sta_mask = PWR_STATUS_AUDIO,
> -		.ctl_offs = SPM_AUDIO_PWR_CON,
> -		.sram_pdn_bits = GENMASK(11, 8),
> -		.sram_pdn_ack_bits = GENMASK(15, 12),
> -		.clk_id = {MT8173_CLK_NONE},
> -	},
> -	[MT8173_POWER_DOMAIN_USB] = {
> -		.name = "usb",
> -		.sta_mask = PWR_STATUS_USB,
> -		.ctl_offs = SPM_USB_PWR_CON,
> -		.sram_pdn_bits = GENMASK(11, 8),
> -		.sram_pdn_ack_bits = GENMASK(15, 12),
> -		.clk_id = {MT8173_CLK_NONE},
> -		.active_wakeup = true,
> -	},
> -	[MT8173_POWER_DOMAIN_MFG_ASYNC] = {
> -		.name = "mfg_async",
> -		.sta_mask = PWR_STATUS_MFG_ASYNC,
> -		.ctl_offs = SPM_MFG_ASYNC_PWR_CON,
> -		.sram_pdn_bits = GENMASK(11, 8),
> -		.sram_pdn_ack_bits = 0,
> -		.clk_id = {MT8173_CLK_MFG},
> -	},
> -	[MT8173_POWER_DOMAIN_MFG_2D] = {
> -		.name = "mfg_2d",
> -		.sta_mask = PWR_STATUS_MFG_2D,
> -		.ctl_offs = SPM_MFG_2D_PWR_CON,
> -		.sram_pdn_bits = GENMASK(11, 8),
> -		.sram_pdn_ack_bits = GENMASK(13, 12),
> -		.clk_id = {MT8173_CLK_NONE},
> -	},
> -	[MT8173_POWER_DOMAIN_MFG] = {
> -		.name = "mfg",
> -		.sta_mask = PWR_STATUS_MFG,
> -		.ctl_offs = SPM_MFG_PWR_CON,
> -		.sram_pdn_bits = GENMASK(13, 8),
> -		.sram_pdn_ack_bits = GENMASK(21, 16),
> -		.clk_id = {MT8173_CLK_NONE},
> -		.bus_prot_mask = MT8173_TOP_AXI_PROT_EN_MFG_S |
> -			MT8173_TOP_AXI_PROT_EN_MFG_M0 |
> -			MT8173_TOP_AXI_PROT_EN_MFG_M1 |
> -			MT8173_TOP_AXI_PROT_EN_MFG_SNOOP_OUT,
> -	},
> -};
> -
> -#define NUM_DOMAINS	ARRAY_SIZE(scp_domain_data)
> -
> -struct scp;
> -
> -struct scp_domain {
> -	struct generic_pm_domain genpd;
> -	struct scp *scp;
> -	struct clk *clk[MAX_CLKS];
> -	u32 sta_mask;
> -	void __iomem *ctl_addr;
> -	u32 sram_pdn_bits;
> -	u32 sram_pdn_ack_bits;
> -	u32 bus_prot_mask;
> -	bool active_wakeup;
> -	struct regulator *supply;
> -};
> -
> -struct scp {
> -	struct scp_domain domains[NUM_DOMAINS];
> -	struct genpd_onecell_data pd_data;
> -	struct device *dev;
> -	void __iomem *base;
> -	struct regmap *infracfg;
> -};
> -
>   static int scpsys_domain_is_on(struct scp_domain *scpd)
>   {
>   	struct scp *scp = scpd->scp;
> @@ -412,57 +252,69 @@ static bool scpsys_active_wakeup(struct device *dev)
>   	return scpd->active_wakeup;
>   }
>
> -static int __init scpsys_probe(struct platform_device *pdev)
> +static void init_clks(struct platform_device *pdev, struct clk *clk[CLK_MAX])
> +{
> +	enum clk_id clk_ids[] = {
> +		CLK_MM,
> +		CLK_MFG,
> +		CLK_VENC,
> +		CLK_VENC_LT
> +	};
> +
> +	static const char * const clk_names[] = {
> +		"mm",
> +		"mfg",
> +		"venc",
> +		"venc_lt",
> +	};
> +
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(clk_ids); i++)
> +		clk[clk_ids[i]] = devm_clk_get(&pdev->dev, clk_names[i]);
> +}
> +
> +struct scp *init_scp(struct platform_device *pdev,
> +			const struct scp_domain_data *scp_domain_data, int num)
>   {
>   	struct genpd_onecell_data *pd_data;
>   	struct resource *res;
> -	int i, j, ret;
> +	int i, j;
>   	struct scp *scp;
> -	struct clk *clk[MT8173_CLK_MAX];
> +	struct clk *clk[CLK_MAX];
>
>   	scp = devm_kzalloc(&pdev->dev, sizeof(*scp), GFP_KERNEL);
>   	if (!scp)
> -		return -ENOMEM;
> +		return ERR_PTR(-ENOMEM);
>
>   	scp->dev = &pdev->dev;
>
>   	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>   	scp->base = devm_ioremap_resource(&pdev->dev, res);
>   	if (IS_ERR(scp->base))
> -		return PTR_ERR(scp->base);
> -
> -	pd_data = &scp->pd_data;
> -
> -	pd_data->domains = devm_kzalloc(&pdev->dev,
> -			sizeof(*pd_data->domains) * NUM_DOMAINS, GFP_KERNEL);
> -	if (!pd_data->domains)
> -		return -ENOMEM;
> -
> -	clk[MT8173_CLK_MM] = devm_clk_get(&pdev->dev, "mm");
> -	if (IS_ERR(clk[MT8173_CLK_MM]))
> -		return PTR_ERR(clk[MT8173_CLK_MM]);
> -
> -	clk[MT8173_CLK_MFG] = devm_clk_get(&pdev->dev, "mfg");
> -	if (IS_ERR(clk[MT8173_CLK_MFG]))
> -		return PTR_ERR(clk[MT8173_CLK_MFG]);
> -
> -	clk[MT8173_CLK_VENC] = devm_clk_get(&pdev->dev, "venc");
> -	if (IS_ERR(clk[MT8173_CLK_VENC]))
> -		return PTR_ERR(clk[MT8173_CLK_VENC]);
> -
> -	clk[MT8173_CLK_VENC_LT] = devm_clk_get(&pdev->dev, "venc_lt");
> -	if (IS_ERR(clk[MT8173_CLK_VENC_LT]))
> -		return PTR_ERR(clk[MT8173_CLK_VENC_LT]);
> +		return ERR_CAST(scp->base);
>
>   	scp->infracfg = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
>   			"infracfg");
>   	if (IS_ERR(scp->infracfg)) {
>   		dev_err(&pdev->dev, "Cannot find infracfg controller: %ld\n",
>   				PTR_ERR(scp->infracfg));
> -		return PTR_ERR(scp->infracfg);
> +		return ERR_CAST(scp->infracfg);
>   	}
>
> -	for (i = 0; i < NUM_DOMAINS; i++) {
> +	scp->domains = devm_kzalloc(&pdev->dev,
> +				sizeof(*scp->domains) * num, GFP_KERNEL);
> +	if (!scp->domains)
> +		return ERR_PTR(-ENOMEM);
> +
> +	pd_data = &scp->pd_data;
> +
> +	pd_data->domains = devm_kzalloc(&pdev->dev,
> +			sizeof(*pd_data->domains) * num, GFP_KERNEL);
> +	if (!pd_data->domains)
> +		return ERR_PTR(-ENOMEM);
> +
> +	for (i = 0; i < num; i++) {
>   		struct scp_domain *scpd = &scp->domains[i];
>   		const struct scp_domain_data *data = &scp_domain_data[i];
>
> @@ -471,17 +323,31 @@ static int __init scpsys_probe(struct platform_device *pdev)
>   			if (PTR_ERR(scpd->supply) == -ENODEV)
>   				scpd->supply = NULL;
>   			else
> -				return PTR_ERR(scpd->supply);
> +				return ERR_CAST(scpd->supply);
>   		}
>   	}
>
> -	pd_data->num_domains = NUM_DOMAINS;
> +	pd_data->num_domains = num;
>
> -	for (i = 0; i < NUM_DOMAINS; i++) {
> +	init_clks(pdev, clk);
> +
> +	for (i = 0; i < num; i++) {
>   		struct scp_domain *scpd = &scp->domains[i];
>   		struct generic_pm_domain *genpd = &scpd->genpd;
>   		const struct scp_domain_data *data = &scp_domain_data[i];
>
> +		for (j = 0; j < MAX_CLKS && data->clk_id[j]; j++) {
> +			struct clk *c = clk[data->clk_id[j]];
> +
> +			if (IS_ERR(c)) {
> +				dev_err(&pdev->dev, "%s: clk unavailable\n",
> +					data->name);
> +				return ERR_CAST(c);
> +			}
> +
> +			scpd->clk[j] = c;
> +		}
> +
>   		pd_data->domains[i] = genpd;
>   		scpd->scp = scp;
>
> @@ -491,13 +357,25 @@ static int __init scpsys_probe(struct platform_device *pdev)
>   		scpd->sram_pdn_ack_bits = data->sram_pdn_ack_bits;
>   		scpd->bus_prot_mask = data->bus_prot_mask;
>   		scpd->active_wakeup = data->active_wakeup;
> -		for (j = 0; j < MAX_CLKS && data->clk_id[j]; j++)
> -			scpd->clk[j] = clk[data->clk_id[j]];
>
>   		genpd->name = data->name;
>   		genpd->power_off = scpsys_power_off;
>   		genpd->power_on = scpsys_power_on;
>   		genpd->dev_ops.active_wakeup = scpsys_active_wakeup;
> +	}
> +
> +	return scp;
> +}
> +
> +void mtk_register_power_domains(struct platform_device *pdev,
> +				struct scp *scp, int num)
> +{
> +	struct genpd_onecell_data *pd_data;
> +	int i, ret;
> +
> +	for (i = 0; i < num; i++) {
> +		struct scp_domain *scpd = &scp->domains[i];
> +		struct generic_pm_domain *genpd = &scpd->genpd;
>
>   		/*
>   		 * Initially turn on all domains to make the domains usable
> @@ -516,6 +394,125 @@ static int __init scpsys_probe(struct platform_device *pdev)
>   	 * valid.
>   	 */
>
> +	pd_data = &scp->pd_data;
> +
> +	ret = of_genpd_add_provider_onecell(pdev->dev.of_node, pd_data);
> +	if (ret)
> +		dev_err(&pdev->dev, "Failed to add OF provider: %d\n", ret);
> +}
> +
> +/*
> + * MT8173 power domain support
> + */
> +
> +#include <dt-bindings/power/mt8173-power.h>

Please put the includes at the beginning of the file.
Same for mt2701 of course.

Thanks,
Matthias

> +
> +static const struct scp_domain_data scp_domain_data_mt8173[] __initconst = {
> +	[MT8173_POWER_DOMAIN_VDEC] = {
> +		.name = "vdec",
> +		.sta_mask = BIT(7),
> +		.ctl_offs = 0x0210,
> +		.sram_pdn_bits = GENMASK(11, 8),
> +		.sram_pdn_ack_bits = GENMASK(12, 12),
> +		.clk_id = {CLK_MM},
> +	},
> +	[MT8173_POWER_DOMAIN_VENC] = {
> +		.name = "venc",
> +		.sta_mask = BIT(21),
> +		.ctl_offs = 0x0230,
> +		.sram_pdn_bits = GENMASK(11, 8),
> +		.sram_pdn_ack_bits = GENMASK(15, 12),
> +		.clk_id = {CLK_MM, CLK_VENC},
> +	},
> +	[MT8173_POWER_DOMAIN_ISP] = {
> +		.name = "isp",
> +		.sta_mask = BIT(5),
> +		.ctl_offs = 0x0238,
> +		.sram_pdn_bits = GENMASK(11, 8),
> +		.sram_pdn_ack_bits = GENMASK(13, 12),
> +		.clk_id = {CLK_MM},
> +	},
> +	[MT8173_POWER_DOMAIN_MM] = {
> +		.name = "mm",
> +		.sta_mask = BIT(3),
> +		.ctl_offs = 0x023c,
> +		.sram_pdn_bits = GENMASK(11, 8),
> +		.sram_pdn_ack_bits = GENMASK(12, 12),
> +		.clk_id = {CLK_MM},
> +		.bus_prot_mask = MT8173_TOP_AXI_PROT_EN_MM_M0 |
> +			MT8173_TOP_AXI_PROT_EN_MM_M1,
> +	},
> +	[MT8173_POWER_DOMAIN_VENC_LT] = {
> +		.name = "venc_lt",
> +		.sta_mask = BIT(20),
> +		.ctl_offs = 0x0298,
> +		.sram_pdn_bits = GENMASK(11, 8),
> +		.sram_pdn_ack_bits = GENMASK(15, 12),
> +		.clk_id = {CLK_MM, CLK_VENC_LT},
> +	},
> +	[MT8173_POWER_DOMAIN_AUDIO] = {
> +		.name = "audio",
> +		.sta_mask = BIT(24),
> +		.ctl_offs = 0x029c,
> +		.sram_pdn_bits = GENMASK(11, 8),
> +		.sram_pdn_ack_bits = GENMASK(15, 12),
> +		.clk_id = {CLK_NONE},
> +	},
> +	[MT8173_POWER_DOMAIN_USB] = {
> +		.name = "usb",
> +		.sta_mask = BIT(25),
> +		.ctl_offs = 0x02cc,
> +		.sram_pdn_bits = GENMASK(11, 8),
> +		.sram_pdn_ack_bits = GENMASK(15, 12),
> +		.clk_id = {CLK_NONE},
> +		.active_wakeup = true,
> +	},
> +	[MT8173_POWER_DOMAIN_MFG_ASYNC] = {
> +		.name = "mfg_async",
> +		.sta_mask = BIT(23),
> +		.ctl_offs = 0x02c4,
> +		.sram_pdn_bits = GENMASK(11, 8),
> +		.sram_pdn_ack_bits = 0,
> +		.clk_id = {CLK_MFG},
> +	},
> +	[MT8173_POWER_DOMAIN_MFG_2D] = {
> +		.name = "mfg_2d",
> +		.sta_mask = BIT(22),
> +		.ctl_offs = 0x02c0,
> +		.sram_pdn_bits = GENMASK(11, 8),
> +		.sram_pdn_ack_bits = GENMASK(13, 12),
> +		.clk_id = {CLK_NONE},
> +	},
> +	[MT8173_POWER_DOMAIN_MFG] = {
> +		.name = "mfg",
> +		.sta_mask = BIT(4),
> +		.ctl_offs = 0x0214,
> +		.sram_pdn_bits = GENMASK(13, 8),
> +		.sram_pdn_ack_bits = GENMASK(21, 16),
> +		.clk_id = {CLK_NONE},
> +		.bus_prot_mask = MT8173_TOP_AXI_PROT_EN_MFG_S |
> +			MT8173_TOP_AXI_PROT_EN_MFG_M0 |
> +			MT8173_TOP_AXI_PROT_EN_MFG_M1 |
> +			MT8173_TOP_AXI_PROT_EN_MFG_SNOOP_OUT,
> +	},
> +};
> +
> +#define NUM_DOMAINS_MT8173	ARRAY_SIZE(scp_domain_data_mt8173)
> +
> +static int __init scpsys_probe_mt8173(struct platform_device *pdev)
> +{
> +	struct scp *scp;
> +	struct genpd_onecell_data *pd_data;
> +	int ret;
> +
> +	scp = init_scp(pdev, scp_domain_data_mt8173, NUM_DOMAINS_MT8173);
> +	if (IS_ERR(scp))
> +		return PTR_ERR(scp);
> +
> +	mtk_register_power_domains(pdev, scp, NUM_DOMAINS_MT8173);
> +
> +	pd_data = &scp->pd_data;
> +
>   	ret = pm_genpd_add_subdomain(pd_data->domains[MT8173_POWER_DOMAIN_MFG_ASYNC],
>   		pd_data->domains[MT8173_POWER_DOMAIN_MFG_2D]);
>   	if (ret && IS_ENABLED(CONFIG_PM))
> @@ -526,21 +523,36 @@ static int __init scpsys_probe(struct platform_device *pdev)
>   	if (ret && IS_ENABLED(CONFIG_PM))
>   		dev_err(&pdev->dev, "Failed to add subdomain: %d\n", ret);
>
> -	ret = of_genpd_add_provider_onecell(pdev->dev.of_node, pd_data);
> -	if (ret)
> -		dev_err(&pdev->dev, "Failed to add OF provider: %d\n", ret);
> -
>   	return 0;
>   }
>
> +/*
> + * scpsys driver init
> + */
> +
>   static const struct of_device_id of_scpsys_match_tbl[] = {
>   	{
>   		.compatible = "mediatek,mt8173-scpsys",
> +		.data = scpsys_probe_mt8173,
>   	}, {
>   		/* sentinel */
>   	}
>   };
>
> +static int __init scpsys_probe(struct platform_device *pdev)
> +{
> +	int (*probe)(struct platform_device *);
> +	const struct of_device_id *of_id;
> +
> +	of_id = of_match_node(of_scpsys_match_tbl, pdev->dev.of_node);
> +	if (!of_id || !of_id->data)
> +		return -EINVAL;
> +
> +	probe = of_id->data;
> +
> +	return probe(pdev);
> +}
> +
>   static struct platform_driver scpsys_drv = {
>   	.driver = {
>   		.name = "mtk-scpsys",
> diff --git a/drivers/soc/mediatek/mtk-scpsys.h b/drivers/soc/mediatek/mtk-scpsys.h
> new file mode 100644
> index 0000000..e435bc3
> --- /dev/null
> +++ b/drivers/soc/mediatek/mtk-scpsys.h
> @@ -0,0 +1,55 @@
> +#ifndef __DRV_SOC_MTK_H
> +#define __DRV_SOC_MTK_H
> +
> +enum clk_id {
> +	CLK_NONE,
> +	CLK_MM,
> +	CLK_MFG,
> +	CLK_VENC,
> +	CLK_VENC_LT,
> +	CLK_MAX,
> +};
> +
> +#define MAX_CLKS	2
> +
> +struct scp_domain_data {
> +	const char *name;
> +	u32 sta_mask;
> +	int ctl_offs;
> +	u32 sram_pdn_bits;
> +	u32 sram_pdn_ack_bits;
> +	u32 bus_prot_mask;
> +	enum clk_id clk_id[MAX_CLKS];
> +	bool active_wakeup;
> +};
> +
> +struct scp;
> +
> +struct scp_domain {
> +	struct generic_pm_domain genpd;
> +	struct scp *scp;
> +	struct clk *clk[MAX_CLKS];
> +	u32 sta_mask;
> +	void __iomem *ctl_addr;
> +	u32 sram_pdn_bits;
> +	u32 sram_pdn_ack_bits;
> +	u32 bus_prot_mask;
> +	bool active_wakeup;
> +	struct regulator *supply;
> +};
> +
> +struct scp {
> +	struct scp_domain *domains;
> +	struct genpd_onecell_data pd_data;
> +	struct device *dev;
> +	void __iomem *base;
> +	struct regmap *infracfg;
> +};
> +
> +struct scp *init_scp(struct platform_device *pdev,
> +			const struct scp_domain_data *scp_domain_data, int num);
> +
> +void mtk_register_power_domains(struct platform_device *pdev,
> +				struct scp *scp, int num);
> +
> +#endif /* __DRV_SOC_MTK_H */
>
