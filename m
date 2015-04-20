From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 20 Apr 2015 08:52:29 +0200
Subject: [PATCH v2 3/5] mmc: mediatek: Add PM support for MMC driver
In-Reply-To: <1426562035-16709-4-git-send-email-chaotian.jing@mediatek.com>
References: <1426562035-16709-1-git-send-email-chaotian.jing@mediatek.com>
 <1426562035-16709-4-git-send-email-chaotian.jing@mediatek.com>
Message-ID: <20150420065229.GP4946@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 17, 2015 at 11:13:53AM +0800, Chaotian Jing wrote:
> Add PM support for Mediatek MMC driver
> 
> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
> ---
>  drivers/mmc/host/mtk-sd.c | 94 ++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 93 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 86c999b..e02f6a6 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -1186,6 +1232,8 @@ static void msdc_ops_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  	int ret;
>  	u32 ddr = 0;
>  
> +	pm_runtime_get_sync(host->dev);
> +
>  	if (ios->timing == MMC_TIMING_UHS_DDR50)
>  		ddr = 1;
>  
> @@ -1230,6 +1278,9 @@ static void msdc_ops_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  
>  	if (host->mclk != ios->clock || host->ddr != ddr)
>  		msdc_set_mclk(host, ddr, ios->clock);
> +
> +	pm_runtime_mark_last_busy(host->dev);
> +	pm_runtime_put_autosuspend(host->dev);

This may also be imbalanced. This function can return between
pm_runtime_get_sync() and pm_runtime_put_autosuspend().

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
