From: tgih.jun@samsung.com (Seungwon Jeon)
Date: Wed, 12 Jun 2013 10:22:00 +0900
Subject: [PATCH v3 4/7] mmc: dw_mmc-pltfm: add Rockchip variant
In-Reply-To: <201306111330.56901.heiko@sntech.de>
References: <201306111328.52679.heiko@sntech.de>
 <201306111330.56901.heiko@sntech.de>
Message-ID: <000a01ce670b$3cf651c0$b6e2f540$%jun@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Looks good to me.
But this patch has a dependency on '[PATCH 2/2] mmc: dw_mmc: Add support DW SD/MMC driver on SOCFPGA'
After that, it can be applied.(SDMMC_CMD_USE_HOLD_REG should be moved in dw_mmc.h)

Acked-by: Seungwon Jeon <tgih.jun@samsung.com>

Thanks,
Seungwon Jeon

On 06/11/13 2013 8:31 PM Heiko St?bner wrote:
> Cortex-A9 SoCs from Rockchip use a slightly modified variant of dw_mmc
> controllers that seems to require the SDMMC_CMD_USE_HOLD_REG bit to
> always be set.
> 
> There also seem to be no other modifications (additional register etc)
> present, so to keep the footprint low, add this small variant to the
> pltfm driver.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  drivers/mmc/host/dw_mmc-pltfm.c |   21 ++++++++++++++++++++-
>  1 files changed, 20 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pltfm.c
> index 9b05381..cbbbcf3 100644
> --- a/drivers/mmc/host/dw_mmc-pltfm.c
> +++ b/drivers/mmc/host/dw_mmc-pltfm.c
> @@ -24,6 +24,15 @@
> 
>  #include "dw_mmc.h"
> 
> +static void dw_mci_rockchip_prepare_command(struct dw_mci *host, u32 *cmdr)
> +{
> +	*cmdr |= SDMMC_CMD_USE_HOLD_REG;
> +}
> +
> +static const struct dw_mci_drv_data rockchip_drv_data = {
> +	.prepare_command	= dw_mci_rockchip_prepare_command,
> +};
> +
>  int dw_mci_pltfm_register(struct platform_device *pdev,
>  				const struct dw_mci_drv_data *drv_data)
>  {
> @@ -100,13 +109,23 @@ EXPORT_SYMBOL_GPL(dw_mci_pltfm_pmops);
> 
>  static const struct of_device_id dw_mci_pltfm_match[] = {
>  	{ .compatible = "snps,dw-mshc", },
> +	{ .compatible = "rockchip,cortex-a9-dw-mshc",
> +		.data = &rockchip_drv_data },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, dw_mci_pltfm_match);
> 
>  static int dw_mci_pltfm_probe(struct platform_device *pdev)
>  {
> -	return dw_mci_pltfm_register(pdev, NULL);
> +	const struct dw_mci_drv_data *drv_data = NULL;
> +	const struct of_device_id *match;
> +
> +	if (pdev->dev.of_node) {
> +		match = of_match_node(dw_mci_pltfm_match, pdev->dev.of_node);
> +		drv_data = match->data;
> +	}
> +
> +	return dw_mci_pltfm_register(pdev, drv_data);
>  }
> 
>  int dw_mci_pltfm_remove(struct platform_device *pdev)
> --
> 1.7.2.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
