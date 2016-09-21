From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Wed, 21 Sep 2016 12:25:50 +0200
Subject: [PATCH v8 1/4] soc: mediatek: Refine scpsys to support multiple
 platform
In-Reply-To: <1468911883-41882-2-git-send-email-jamesjj.liao@mediatek.com>
References: <1468911883-41882-1-git-send-email-jamesjj.liao@mediatek.com>
 <1468911883-41882-2-git-send-email-jamesjj.liao@mediatek.com>
Message-ID: <92a5bc68-0c4c-b9e1-17d7-34c83020aa37@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 19/07/16 09:04, James Liao wrote:
> Refine scpsys driver common code to support multiple SoC / platform.
>
> Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
> Reviewed-by: Kevin Hilman <khilman@baylibre.com>
> ---
>  drivers/soc/mediatek/mtk-scpsys.c | 363 +++++++++++++++++++++++---------------
>  1 file changed, 220 insertions(+), 143 deletions(-)
>
> diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
> index 837effe..1f3555a 100644
> --- a/drivers/soc/mediatek/mtk-scpsys.c
> +++ b/drivers/soc/mediatek/mtk-scpsys.c
> @@ -11,17 +11,15 @@
>   * GNU General Public License for more details.
>   */
>  #include <linux/clk.h>
> -#include <linux/delay.h>
> +#include <linux/init.h>
>  #include <linux/io.h>
> -#include <linux/kernel.h>
>  #include <linux/mfd/syscon.h>
> -#include <linux/init.h>
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_domain.h>
> -#include <linux/regmap.h>
> -#include <linux/soc/mediatek/infracfg.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/soc/mediatek/infracfg.h>
> +
>  #include <dt-bindings/power/mt8173-power.h>
>
>  #define SPM_VDE_PWR_CON			0x0210
> @@ -34,6 +32,7 @@
>  #define SPM_MFG_2D_PWR_CON		0x02c0
>  #define SPM_MFG_ASYNC_PWR_CON		0x02c4
>  #define SPM_USB_PWR_CON			0x02cc
> +
>  #define SPM_PWR_STATUS			0x060c
>  #define SPM_PWR_STATUS_2ND		0x0610
>
> @@ -55,12 +54,12 @@
>  #define PWR_STATUS_USB			BIT(25)
>
>  enum clk_id {
> -	MT8173_CLK_NONE,
> -	MT8173_CLK_MM,
> -	MT8173_CLK_MFG,
> -	MT8173_CLK_VENC,
> -	MT8173_CLK_VENC_LT,
> -	MT8173_CLK_MAX,
> +	CLK_NONE,
> +	CLK_MM,
> +	CLK_MFG,
> +	CLK_VENC,
> +	CLK_VENC_LT,
> +	CLK_MAX,
>  };
>
>  #define MAX_CLKS	2
> @@ -76,98 +75,6 @@ struct scp_domain_data {
>  	bool active_wakeup;
>  };
>
> -static const struct scp_domain_data scp_domain_data[] = {
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
>  struct scp;
>
>  struct scp_domain {
> @@ -179,7 +86,7 @@ struct scp_domain {
>  };
>
>  struct scp {
> -	struct scp_domain domains[NUM_DOMAINS];
> +	struct scp_domain *domains;
>  	struct genpd_onecell_data pd_data;
>  	struct device *dev;
>  	void __iomem *base;
> @@ -408,57 +315,69 @@ static bool scpsys_active_wakeup(struct device *dev)
>  	return scpd->data->active_wakeup;
>  }
>
> -static int scpsys_probe(struct platform_device *pdev)
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

Should be:
for (i = CLK_NONE + 1; i < CLK_MAX; i++)

then we can get rid of clk_ids[].

> +}
> +
> +static struct scp *init_scp(struct platform_device *pdev,
> +			const struct scp_domain_data *scp_domain_data, int num)
>  {
>  	struct genpd_onecell_data *pd_data;
>  	struct resource *res;
> -	int i, j, ret;
> +	int i, j;
>  	struct scp *scp;
> -	struct clk *clk[MT8173_CLK_MAX];
> +	struct clk *clk[CLK_MAX];
>
>  	scp = devm_kzalloc(&pdev->dev, sizeof(*scp), GFP_KERNEL);
>  	if (!scp)
> -		return -ENOMEM;
> +		return ERR_PTR(-ENOMEM);
>
>  	scp->dev = &pdev->dev;
>
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	scp->base = devm_ioremap_resource(&pdev->dev, res);
>  	if (IS_ERR(scp->base))
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
>  	scp->infracfg = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
>  			"infracfg");
>  	if (IS_ERR(scp->infracfg)) {
>  		dev_err(&pdev->dev, "Cannot find infracfg controller: %ld\n",
>  				PTR_ERR(scp->infracfg));
> -		return PTR_ERR(scp->infracfg);
> +		return ERR_CAST(scp->infracfg);
>  	}
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

While at it, please leave this block of code between
devm_ioremap_resource(...) and syscon_regmap_lookup_by_phandle(...)

Thanks,
Matthias
