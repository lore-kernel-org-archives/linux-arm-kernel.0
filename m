From: ck.hu@mediatek.com (CK Hu)
Date: Wed, 5 Sep 2018 17:30:35 +0800
Subject: [PATCH v2 01/13] drm/mediatek: add refcount for DPI power on/off
In-Reply-To: <20180905083146.14727-2-bibby.hsieh@mediatek.com>
References: <20180905083146.14727-1-bibby.hsieh@mediatek.com>
 <20180905083146.14727-2-bibby.hsieh@mediatek.com>
Message-ID: <1536139835.11913.3.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Bibby:

This looks reasonable, but why MT8173 doesn't need this patch? So
describe more about why MT7623 need this patch. If this is caused by
latest DRM core flow change, I think we should treat this patch
independent with MT7623.

Regards,
CK

On Wed, 2018-09-05 at 16:31 +0800, Bibby Hsieh wrote:
> From: chunhui dai <chunhui.dai@mediatek.com>
> 
> add refcount for DPI power on/off to protect the flow
> 
> Signed-off-by: chunhui dai <chunhui.dai@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dpi.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
> index 6c0ea39d5739..d9373e67d328 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> @@ -77,6 +77,7 @@ struct mtk_dpi {
>  	enum mtk_dpi_out_bit_num bit_num;
>  	enum mtk_dpi_out_channel_swap channel_swap;
>  	bool power_sta;
> +	int refcount;
>  	u8 power_ctl;
>  };
>  
> @@ -369,6 +370,12 @@ static void mtk_dpi_config_color_format(struct mtk_dpi *dpi,
>  
>  static void mtk_dpi_power_off(struct mtk_dpi *dpi, enum mtk_dpi_power_ctl pctl)
>  {
> +	if (WARN_ON(dpi->refcount == 0))
> +		return;
> +
> +	if (--dpi->refcount != 0)
> +		return;
> +
>  	dpi->power_ctl &= ~pctl;
>  
>  	if ((dpi->power_ctl & DPI_POWER_START) ||
> @@ -388,14 +395,17 @@ static int mtk_dpi_power_on(struct mtk_dpi *dpi, enum mtk_dpi_power_ctl pctl)
>  {
>  	int ret;
>  
> +	if (++dpi->refcount != 1)
> +		return 0;
> +
>  	dpi->power_ctl |= pctl;
>  
>  	if (!(dpi->power_ctl & DPI_POWER_START) &&
>  	    !(dpi->power_ctl & DPI_POWER_ENABLE))
> -		return 0;
> +		goto err_refcount;
>  
>  	if (dpi->power_sta)
> -		return 0;
> +		goto err_refcount;
>  
>  	ret = clk_prepare_enable(dpi->engine_clk);
>  	if (ret) {
> @@ -417,6 +427,8 @@ static int mtk_dpi_power_on(struct mtk_dpi *dpi, enum mtk_dpi_power_ctl pctl)
>  	clk_disable_unprepare(dpi->engine_clk);
>  err_eng:
>  	dpi->power_ctl &= ~pctl;
> +err_refcount:
> +	dpi->refcount--;
>  	return ret;
>  }
>  
