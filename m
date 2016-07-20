From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 20 Jul 2016 11:41:58 +0200
Subject: [PATCH 3/4] drm/mediatek: fix the wrong pixel clock when
 resolution is 4K
In-Reply-To: <1468987385-37353-4-git-send-email-bibby.hsieh@mediatek.com>
References: <1468987385-37353-1-git-send-email-bibby.hsieh@mediatek.com>
 <1468987385-37353-4-git-send-email-bibby.hsieh@mediatek.com>
Message-ID: <1469007718.5809.32.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, den 20.07.2016, 12:03 +0800 schrieb Bibby Hsieh:
> From: Junzhi Zhao <junzhi.zhao@mediatek.com>
> 
> Pixel clock should be 297MHz when resolution is 4K.
> 
> Signed-off-by: Junzhi Zhao <junzhi.zhao@mediatek.com>
> Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dpi.c |  184 +++++++++++++++++++++++++-----------
>  1 file changed, 131 insertions(+), 53 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
> index d05ca79..c0f04d2 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> @@ -60,14 +60,35 @@ enum mtk_dpi_out_color_format {
>  	MTK_DPI_COLOR_FORMAT_YCBCR_422_FULL
>  };
>  
> +enum mtk_dpi_clk_id {
> +	MTK_DPI_CLK_DPI_ENGINE,
> +	MTK_DPI_CLK_DPI_PIXEL,
> +	MTK_DPI_CLK_TVD_PLL,
> +	MTK_DPI_CLK_TVDPLL_MUX,
> +	MTK_DPI_CLK_TVDPLL_D2,
> +	MTK_DPI_CLK_TVDPLL_D4,
> +	MTK_DPI_CLK_TVDPLL_D8,
> +	MTK_DPI_CLK_TVDPLL_D16,
> +	MTK_DPI_CLK_COUNT,
> +};

I think this is going in the wrong direction. If the pixel clock output
isn't correct after a clk_set_rate(dpi->pixel_clk, rate), the clock
drivers should be fixed, not worked around in the dpi driver.

The TVDPLL_* mux and dividers are not direct inputs to the DPI module:

   tvdpll ("pll")
     |               ..|\
     v               ..| | mm_sel ----> mm_dpi_engine ("engine")
   tvdpll_594m(1/3)  ..|/
     |
     |`-> tvdpll_d2 -->|\
     |`-> tvdpll_d4 -->| | dpi0_sel --> mm_dpi_pixel ("pixel")
     |`-> tvdpll_d8 -->| |
     `--> tvdpll_d16 ->|/

Currently the code first sets the "pll" to the desired multiple of the
pixel clock manually (*3*4, *3*8) and than calls clk_set_rate on the
"pixel" clock which gets propagated by the clock framework up to
dpi0_sel. Since dpi0_sel doesn't have the CLK_SET_RATE_PARENT flag set,
it should just choose the tvdpll_d* input divider. I'd like not to give
the dpi driver direct access to all the intermediate clocks.

regards
Philipp
