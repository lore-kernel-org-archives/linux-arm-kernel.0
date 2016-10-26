From: ck.hu@mediatek.com (CK Hu)
Date: Wed, 26 Oct 2016 14:41:21 +0800
Subject: [PATCH v2] drm/mediatek: fixed the calc method of data rate per
 lane
In-Reply-To: <1477374045-2837-1-git-send-email-jitao.shi@mediatek.com>
References: <1477374045-2837-1-git-send-email-jitao.shi@mediatek.com>
Message-ID: <1477464081.17405.2.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Jitao:

On Tue, 2016-10-25 at 13:40 +0800, Jitao Shi wrote:
> Tune dsi frame rate by pixel clock, dsi add some extra signal (i.e. Tlpx,
> Ths-prepare, Ths-zero, Ths-trail,Ths-exit) when enter and exit LP mode, this
> signal will cause h-time larger than normal and reduce FPS.
> Need to multiply a coefficient to offset the extra signal's effect.
> coefficient = ((htotal*bpp/lane_number)+Tlpx+Ths_prep+Ths_zero+Ths_trail+
>                 Ths_exit)/(htotal*bpp/lane_number))
> 
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
> Change since v1:
>  - phy_timing2 and phy_timing3 refer clock cycle time.
>  - define values of LPX HS_PRPR HS_ZERO HS_TRAIL TA_GO TA_SURE TA_GET DA_HS_EXIT
> ---
>  drivers/gpu/drm/mediatek/mtk_dsi.c |  103 +++++++++++++++++++++++-------------
>  1 file changed, 67 insertions(+), 36 deletions(-)
> 

[snip...]

>  
> -static void dsi_phy_timconfig(struct mtk_dsi *dsi)
> +static void dsi_phy_timconfig(struct mtk_dsi *dsi, u32 phy_timing0,
> +			      u32 phy_timing1, u32 phy_timing2,
> +			      u32 phy_timing3)
>  {
> -	u32 timcon0, timcon1, timcon2, timcon3;
> -	unsigned int ui, cycle_time;
> -	unsigned int lpx;
> -
> -	ui = 1000 / dsi->data_rate + 0x01;
> -	cycle_time = 8000 / dsi->data_rate + 0x01;
> -	lpx = 5;
> -
> -	timcon0 = (8 << 24) | (0xa << 16) | (0x6 << 8) | lpx;
> -	timcon1 = (7 << 24) | (5 * lpx << 16) | ((3 * lpx) / 2) << 8 |
> -		  (4 * lpx);
> -	timcon2 = ((NS_TO_CYCLE(0x64, cycle_time) + 0xa) << 24) |
> -		  (NS_TO_CYCLE(0x150, cycle_time) << 16);
> -	timcon3 = (2 * lpx) << 16 | NS_TO_CYCLE(80 + 52 * ui, cycle_time) << 8 |
> -		   NS_TO_CYCLE(0x40, cycle_time);
> -
> -	writel(timcon0, dsi->regs + DSI_PHY_TIMECON0);
> -	writel(timcon1, dsi->regs + DSI_PHY_TIMECON1);
> -	writel(timcon2, dsi->regs + DSI_PHY_TIMECON2);
> -	writel(timcon3, dsi->regs + DSI_PHY_TIMECON3);

Why do you move these calculation to mtk_dsi_poweron()? You can keep
calculation here and just do some modification.

Regards,
CK

> +	writel(phy_timing0, dsi->regs + DSI_PHY_TIMECON0);
> +	writel(phy_timing1, dsi->regs + DSI_PHY_TIMECON1);
> +	writel(phy_timing2, dsi->regs + DSI_PHY_TIMECON2);
> +	writel(phy_timing3, dsi->regs + DSI_PHY_TIMECON3);
>  }
>  
>  static void mtk_dsi_enable(struct mtk_dsi *dsi)
> @@ -202,19 +188,51 @@ static int mtk_dsi_poweron(struct mtk_dsi *dsi)
>  {
>  	struct device *dev = dsi->dev;
>  	int ret;
> +	u64 bit_clock, total_bits;
> +	u32 htotal, htotal_bits, bit_per_pixel, overhead_cycles, overhead_bits;
> +	u32 phy_timing0, phy_timing1, phy_timing2, phy_timing3;
> +	u32 ui, cycle_time;
>  
>  	if (++dsi->refcount != 1)
>  		return 0;
>  
> +	switch (dsi->format) {
> +	case MIPI_DSI_FMT_RGB565:
> +		bit_per_pixel = 16;
> +		break;
> +	case MIPI_DSI_FMT_RGB666_PACKED:
> +		bit_per_pixel = 18;
> +		break;
> +	case MIPI_DSI_FMT_RGB666:
> +	case MIPI_DSI_FMT_RGB888:
> +	default:
> +		bit_per_pixel = 24;
> +		break;
> +	}
> +	/**
> +	 * data_rate = (pixel_clock) * bit_per_pixel * mipi_ratio / lane_num;
> +	 * vm.pixelclock is Khz, data_rata unit is Hz, so need to multiply 1000
> +	 * mipi_ratio is (htotal * byte_per_pixel / lane_num + Tlpx + Ths_prep
> +	 *		  + Thstrail + Ths_exit + Ths_zero) /
> +	 *		 (htotal * byte_per_pixel /lane_number)
> +	 */
> +	bit_clock = dsi->vm.pixelclock * 1000 * bit_per_pixel;
> +	htotal = dsi->vm.hactive + dsi->vm.hback_porch + dsi->vm.hfront_porch +
> +		 dsi->vm.hsync_len;
> +	htotal_bits = htotal * bit_per_pixel;
> +
>  	/**
> -	 * data_rate = (pixel_clock / 1000) * pixel_dipth * mipi_ratio;
> -	 * pixel_clock unit is Khz, data_rata unit is MHz, so need divide 1000.
> -	 * mipi_ratio is mipi clk coefficient for balance the pixel clk in mipi.
> -	 * we set mipi_ratio is 1.05.
> +	 * overhead = lpx + hs_prepare + hs_zero + hs_trail + hs_exit
>  	 */
> -	dsi->data_rate = dsi->vm.pixelclock * 3 * 21 / (1 * 1000 * 10);
> +	overhead_cycles = LPX + (HS_PRPR >> 8) + (HS_ZERO >> 16) +
> +			  (HS_TRAIL >> 24) + (DA_HS_EXIT >> 24);
> +	overhead_bits = overhead_cycles * dsi->lanes * 8;
> +	total_bits = htotal_bits + overhead_bits;
>  
> -	ret = clk_set_rate(dsi->hs_clk, dsi->data_rate * 1000000);
> +	dsi->data_rate = DIV_ROUND_UP_ULL(bit_clock * total_bits,
> +					  htotal_bits * dsi->lanes);
> +
> +	ret = clk_set_rate(dsi->hs_clk, dsi->data_rate);
>  	if (ret < 0) {
>  		dev_err(dev, "Failed to set data rate: %d\n", ret);
>  		goto err_refcount;
> @@ -236,7 +254,20 @@ static int mtk_dsi_poweron(struct mtk_dsi *dsi)
>  
>  	mtk_dsi_enable(dsi);
>  	mtk_dsi_reset(dsi);
> -	dsi_phy_timconfig(dsi);
> +
> +	ui = 1000 / dsi->data_rate + 0x01;
> +	cycle_time = 8000 / dsi->data_rate + 0x01;
> +
> +	phy_timing0 = LPX | HS_PRPR | HS_ZERO | HS_TRAIL;
> +	phy_timing1 = TA_GO | TA_SURE | TA_GET | DA_HS_EXIT;
> +	phy_timing2 = ((NS_TO_CYCLE(0x64, cycle_time) + 0xa) << 24) |
> +		      (NS_TO_CYCLE(0x150, cycle_time) << 16);
> +	phy_timing3 = (2 * LPX) << 16 |
> +		      NS_TO_CYCLE(80 + 52 * ui, cycle_time) << 8 |
> +		      NS_TO_CYCLE(0x40, cycle_time);
> +
> +	dsi_phy_timconfig(dsi, phy_timing0, phy_timing1, phy_timing2,
> +			  phy_timing3);
>  
>  	return 0;
>  
