From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Sun, 27 Sep 2015 15:19:00 +0200
Subject: [PATCH v3] soc: mediatek: add scpsys support active_wakeup
In-Reply-To: <1440573281-28952-1-git-send-email-eddie.huang@mediatek.com>
References: <1440573281-28952-1-git-send-email-eddie.huang@mediatek.com>
Message-ID: <5607ECC4.3030902@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 26/08/15 09:14, Eddie Huang wrote:
> Register gpd_dev_ops.active_wakeup function to support keep power
> during suspend state. And add flag to each power domain to
> decide whether keep power during suspend or not.
>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
> Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
> Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
>

Applied, thanks.

> ---
> Change in v3:
> Remove check dev->power_domain NULL or ERR. This will not happen
> when call scpsys_active_wakeup function
>
> Change in v2:
> Drop .active_wakeup = false lines in scp_domain_data[] array
> ---
>   drivers/soc/mediatek/mtk-scpsys.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
>
> diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
> index 43a79ed..3a00975 100644
> --- a/drivers/soc/mediatek/mtk-scpsys.c
> +++ b/drivers/soc/mediatek/mtk-scpsys.c
> @@ -67,6 +67,7 @@ struct scp_domain_data {
>   	u32 sram_pdn_ack_bits;
>   	u32 bus_prot_mask;
>   	enum clk_id clk_id;
> +	bool active_wakeup;
>   };
>
>   static const struct scp_domain_data scp_domain_data[] __initconst = {
> @@ -127,6 +128,7 @@ static const struct scp_domain_data scp_domain_data[] __initconst = {
>   		.sram_pdn_bits = GENMASK(11, 8),
>   		.sram_pdn_ack_bits = GENMASK(15, 12),
>   		.clk_id = MT8173_CLK_NONE,
> +		.active_wakeup = true,
>   	},
>   	[MT8173_POWER_DOMAIN_MFG_ASYNC] = {
>   		.name = "mfg_async",
> @@ -171,6 +173,7 @@ struct scp_domain {
>   	u32 sram_pdn_bits;
>   	u32 sram_pdn_ack_bits;
>   	u32 bus_prot_mask;
> +	bool active_wakeup;
>   };
>
>   struct scp {
> @@ -370,6 +373,17 @@ out:
>   	return ret;
>   }
>
> +static bool scpsys_active_wakeup(struct device *dev)
> +{
> +	struct generic_pm_domain *genpd;
> +	struct scp_domain *scpd;
> +
> +	genpd = pd_to_genpd(dev->pm_domain);
> +	scpd = container_of(genpd, struct scp_domain, genpd);
> +
> +	return scpd->active_wakeup;
> +}
> +
>   static int __init scpsys_probe(struct platform_device *pdev)
>   {
>   	struct genpd_onecell_data *pd_data;
> @@ -427,12 +441,14 @@ static int __init scpsys_probe(struct platform_device *pdev)
>   		scpd->sram_pdn_bits = data->sram_pdn_bits;
>   		scpd->sram_pdn_ack_bits = data->sram_pdn_ack_bits;
>   		scpd->bus_prot_mask = data->bus_prot_mask;
> +		scpd->active_wakeup = data->active_wakeup;
>   		if (data->clk_id != MT8173_CLK_NONE)
>   			scpd->clk = clk[data->clk_id];
>
>   		genpd->name = data->name;
>   		genpd->power_off = scpsys_power_off;
>   		genpd->power_on = scpsys_power_on;
> +		genpd->dev_ops.active_wakeup = scpsys_active_wakeup;
>
>   		/*
>   		 * Initially turn on all domains to make the domains usable
>
