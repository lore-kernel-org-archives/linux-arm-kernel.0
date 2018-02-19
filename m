From: robin.murphy@arm.com (Robin Murphy)
Date: Mon, 19 Feb 2018 11:43:11 +0000
Subject: [PATCH v2 4/8] drm/rockchip: dw_hdmi: Allow outputs that don't
 need output switching
In-Reply-To: <20180216204158.29839-5-heiko@sntech.de>
References: <20180216204158.29839-1-heiko@sntech.de>
 <20180216204158.29839-5-heiko@sntech.de>
Message-ID: <f1104948-5b95-968c-edc4-7a4d5212bae0@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

On 16/02/18 20:41, Heiko Stuebner wrote:
> So far we always encountered socs with 2 output crtcs needing the driver
> to tell the hdmi block which output to connect to. But there also exist
> socs with only one crtc like the rk3228, rk3328 and rk3368.
> 
> So adapt the register field to simply carry a negative value to signal
> that now output-switching is necessary.

Nit: s/now/no/ ? (Hooray for grammatically-correct typos which invert 
the entire meaning of the sentence!)

What are the necessary dependencies for these patches? I tried applying 
the series on 4.16-rc1 to test, but it failed at patch #6 with some 
missing context (I tried checking drm-next for where rockchip_hdmi::hdmi 
might have come from, but didn't see anything obvious)

Thanks,
Robin.

> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>   drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
> index 3574b0ae2ad1..6dc03f1a5709 100644
> --- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
> @@ -36,7 +36,7 @@
>    * @lcdsel_lit: reg value of selecting vop little for HDMI
>    */
>   struct rockchip_hdmi_chip_data {
> -	u32	lcdsel_grf_reg;
> +	int	lcdsel_grf_reg;
>   	u32	lcdsel_big;
>   	u32	lcdsel_lit;
>   };
> @@ -253,6 +253,9 @@ static void dw_hdmi_rockchip_encoder_enable(struct drm_encoder *encoder)
>   	u32 val;
>   	int ret;
>   
> +	if (hdmi->chip_data->lcdsel_grf_reg < 0)
> +		return;
> +
>   	ret = drm_of_encoder_active_endpoint_id(hdmi->dev->of_node, encoder);
>   	if (ret)
>   		val = hdmi->chip_data->lcdsel_lit;
> 
