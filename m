From: ck.hu@mediatek.com (CK Hu)
Date: Wed, 26 Oct 2016 17:37:50 +0800
Subject: [PATCH v3] drm/mediatek: fixed the calc method of data rate per
 lane
In-Reply-To: <1477472395-6451-1-git-send-email-jitao.shi@mediatek.com>
References: <1477472395-6451-1-git-send-email-jitao.shi@mediatek.com>
Message-ID: <1477474670.5215.5.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Jitao:

On Wed, 2016-10-26 at 16:59 +0800, Jitao Shi wrote:
> Tune dsi frame rate by pixel clock, dsi add some extra signal (i.e. Tlpx,
> Ths-prepare, Ths-zero, Ths-trail,Ths-exit) when enter and exit LP mode, this
> signal will cause h-time larger than normal and reduce FPS.
> Need to multiply a coefficient to offset the extra signal's effect.
> coefficient = ((htotal*bpp/lane_number)+Tlpx+Ths_prep+Ths_zero+Ths_trail+
>                 Ths_exit)/(htotal*bpp/lane_number))
> 

One check-patch warning in commit message:

WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description
(prefer a maximum 75 chars per line)
#7:
    Tune dsi frame rate by pixel clock, dsi add some extra signal (i.e.
Tlpx,

> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
> Change since v2:
>  - move phy timing back to dsi_phy_timconfig.
> 
> Change since v1:
>  - phy_timing2 and phy_timing3 refer clock cycle time.
>  - define values of LPX HS_PRPR HS_ZERO HS_TRAIL TA_GO TA_SURE TA_GET DA_HS_EXIT
> ---
>  drivers/gpu/drm/mediatek/mtk_dsi.c |   74 +++++++++++++++++++++++++-----------
>  1 file changed, 51 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
> index 28b2044..8b3b38a 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -85,16 +85,16 @@
>  #define LD0_WAKEUP_EN			BIT(2)
>  
>  #define DSI_PHY_TIMECON0	0x110
> -#define LPX				(0xff << 0)
> -#define HS_PRPR				(0xff << 8)
> -#define HS_ZERO				(0xff << 16)
> -#define HS_TRAIL			(0xff << 24)
> +#define LPX				(5 << 0)
> +#define HS_PRPR				(6 << 8)
> +#define HS_ZERO				(10 << 16)
> +#define HS_TRAIL			(8 << 24)
>  
>  #define DSI_PHY_TIMECON1	0x114
> -#define TA_GO				(0xff << 0)
> -#define TA_SURE				(0xff << 8)
> -#define TA_GET				(0xff << 16)
> -#define DA_HS_EXIT			(0xff << 24)
> +#define TA_GO				(20 << 0)
> +#define TA_SURE				(7 << 8)
> +#define TA_GET				(25 << 16)
> +#define DA_HS_EXIT			(7 << 24)
>  
>  #define DSI_PHY_TIMECON2	0x118
>  #define CONT_DET			(0xff << 0)
> @@ -161,20 +161,18 @@ static void mtk_dsi_mask(struct mtk_dsi *dsi, u32 offset, u32 mask, u32 data)
>  static void dsi_phy_timconfig(struct mtk_dsi *dsi)
>  {
>  	u32 timcon0, timcon1, timcon2, timcon3;
> -	unsigned int ui, cycle_time;
> -	unsigned int lpx;
> +	u32 ui, cycle_time;
>  
>  	ui = 1000 / dsi->data_rate + 0x01;
>  	cycle_time = 8000 / dsi->data_rate + 0x01;
> -	lpx = 5;
>  
> -	timcon0 = (8 << 24) | (0xa << 16) | (0x6 << 8) | lpx;
> -	timcon1 = (7 << 24) | (5 * lpx << 16) | ((3 * lpx) / 2) << 8 |
> -		  (4 * lpx);
> +	timcon0 = LPX | HS_PRPR | HS_ZERO | HS_TRAIL;
> +	timcon1 = 4 * LPX | (3 * LPX / 2) << 8 | 5 * LPX << 16 | DA_HS_EXIT;
>  	timcon2 = ((NS_TO_CYCLE(0x64, cycle_time) + 0xa) << 24) |
> -		  (NS_TO_CYCLE(0x150, cycle_time) << 16);
> -	timcon3 = (2 * lpx) << 16 | NS_TO_CYCLE(80 + 52 * ui, cycle_time) << 8 |
> -		   NS_TO_CYCLE(0x40, cycle_time);
> +		      (NS_TO_CYCLE(0x150, cycle_time) << 16);

I think this line may align to '(' in the right of '='.

> +	timcon3 = (2 * LPX) << 16 |
> +		      NS_TO_CYCLE(80 + 52 * ui, cycle_time) << 8 |
> +		      NS_TO_CYCLE(0x40, cycle_time);

I think these two lines may align to '(' in the right of '='.

Regards,
CK
     I. 
>  
>  	writel(timcon0, dsi->regs + DSI_PHY_TIMECON0);
>  	writel(timcon1, dsi->regs + DSI_PHY_TIMECON1);
> @@ -202,19 +200,49 @@ static int mtk_dsi_poweron(struct mtk_dsi *dsi)
>  {
>  	struct device *dev = dsi->dev;
>  	int ret;
> +	u64 bit_clock, total_bits;
> +	u32 htotal, htotal_bits, bit_per_pixel, overhead_cycles, overhead_bits;
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
>  	/**
> -	 * data_rate = (pixel_clock / 1000) * pixel_dipth * mipi_ratio;
> -	 * pixel_clock unit is Khz, data_rata unit is MHz, so need divide 1000.
> -	 * mipi_ratio is mipi clk coefficient for balance the pixel clk in mipi.
> -	 * we set mipi_ratio is 1.05.
> +	 * data_rate = (pixel_clock) * bit_per_pixel * mipi_ratio / lane_num;
> +	 * vm.pixelclock is Khz, data_rata unit is Hz, so need to multiply 1000
> +	 * mipi_ratio is (htotal * byte_per_pixel / lane_num + Tlpx + Ths_prep
> +	 *		  + Thstrail + Ths_exit + Ths_zero) /
> +	 *		 (htotal * byte_per_pixel /lane_number)
>  	 */
> -	dsi->data_rate = dsi->vm.pixelclock * 3 * 21 / (1 * 1000 * 10);
> +	bit_clock = dsi->vm.pixelclock * 1000 * bit_per_pixel;
> +	htotal = dsi->vm.hactive + dsi->vm.hback_porch + dsi->vm.hfront_porch +
> +		 dsi->vm.hsync_len;
> +	htotal_bits = htotal * bit_per_pixel;
> +
> +	/**
> +	 * overhead = lpx + hs_prepare + hs_zero + hs_trail + hs_exit
> +	 */
> +	overhead_cycles = LPX + (HS_PRPR >> 8) + (HS_ZERO >> 16) +
> +			  (HS_TRAIL >> 24) + (DA_HS_EXIT >> 24);
> +	overhead_bits = overhead_cycles * dsi->lanes * 8;
> +	total_bits = htotal_bits + overhead_bits;
> +
> +	dsi->data_rate = DIV_ROUND_UP_ULL(bit_clock * total_bits,
> +					  htotal_bits * dsi->lanes);
>  
> -	ret = clk_set_rate(dsi->hs_clk, dsi->data_rate * 1000000);
> +	ret = clk_set_rate(dsi->hs_clk, dsi->data_rate);
>  	if (ret < 0) {
>  		dev_err(dev, "Failed to set data rate: %d\n", ret);
>  		goto err_refcount;
