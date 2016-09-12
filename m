From: ck.hu@mediatek.com (CK Hu)
Date: Mon, 12 Sep 2016 11:15:42 +0800
Subject: [PATCH v4 3/3] drm/mediatek: fix the wrong pixel clock when
 resolution is 4K
In-Reply-To: <1471417088-2993-4-git-send-email-bibby.hsieh@mediatek.com>
References: <1471417088-2993-1-git-send-email-bibby.hsieh@mediatek.com>
 <1471417088-2993-4-git-send-email-bibby.hsieh@mediatek.com>
Message-ID: <1473650142.28437.5.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Bibby:

Sorry for the late reply.

On Wed, 2016-08-17 at 14:58 +0800, Bibby Hsieh wrote:
> From: Junzhi Zhao <junzhi.zhao@mediatek.com>
> 
> Pixel clock should be 297MHz when resolution is 4K.
> 

>From the code you modified, I think title should be: "Enlarge pll_rate
range from (<original lower bound>, <original upper bound>) to (<new
lower bound>, <new upper bound>)"

In description, you can explain the pll_rate for 4K and this enlargement
could support more resolution include 4K (Not only 4K).

> Signed-off-by: Junzhi Zhao <junzhi.zhao@mediatek.com>
> Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dpi.c |    9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
> index 0186e50..90fb831 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> @@ -432,11 +432,16 @@ static int mtk_dpi_set_display_mode(struct mtk_dpi *dpi,
>  	unsigned long pll_rate;
>  	unsigned int factor;
>  
> +	/* let pll_rate can fix the valid range of tvdpll (1G~2GHz) */
>  	pix_rate = 1000UL * mode->clock;
> -	if (mode->clock <= 74000)
> +	if (mode->clock <= 27000)
> +		factor = 16 * 3;
> +	else if (mode->clock <= 84000)
>  		factor = 8 * 3;
> -	else
> +	else if (mode->clock <= 167000)
>  		factor = 4 * 3;
> +	else
> +		factor = 2 * 3;
>  	pll_rate = pix_rate * factor;
>  
>  	dev_dbg(dpi->dev, "Want PLL %lu Hz, pixel clock %lu Hz\n",

Regards,
CK
