From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Sun, 20 Dec 2009 17:45:16 +0100 (CET)
Subject: [PATCH] mx3fb: some debug and initialisation fixes.
In-Reply-To: <1261152262.3356.69.camel@climbing-alby>
References: <1261152262.3356.69.camel@climbing-alby>
Message-ID: <Pine.LNX.4.64.0912201744490.14323@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 18 Dec 2009, Alberto Panizzo wrote:

> Fix the kernel oops when dev_dbg is called with mx3_fbi->txd == NULL
> 
> Fix the late initialisation of mx3fb->backlight_level.
> If not, in the chain of function started by init_fb_chan(), in __blank() call 
> sdc_set_brightness(mx3fb, mx3fb->backlight_level) that will shut down
> the CONTRAST PWM output. 
> 
> 
> Signed-off-by: Alberto Panizzo <maramaopercheseimorto@gmail.com>

Acked-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Thanks
Guennadi

> ---
>  drivers/video/mx3fb.c |   12 ++++++++----
>  1 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/video/mx3fb.c b/drivers/video/mx3fb.c
> index 054ef29..772ba3f 100644
> --- a/drivers/video/mx3fb.c
> +++ b/drivers/video/mx3fb.c
> @@ -324,8 +324,11 @@ static void sdc_enable_channel(struct mx3fb_info *mx3_fbi)
>  	unsigned long flags;
>  	dma_cookie_t cookie;
>  
> -	dev_dbg(mx3fb->dev, "mx3fbi %p, desc %p, sg %p\n", mx3_fbi,
> -		to_tx_desc(mx3_fbi->txd), to_tx_desc(mx3_fbi->txd)->sg);
> +	if (mx3_fbi->txd)
> +		dev_dbg(mx3fb->dev, "mx3fbi %p, desc %p, sg %p\n", mx3_fbi,
> +			to_tx_desc(mx3_fbi->txd), to_tx_desc(mx3_fbi->txd)->sg);
> +	else
> +		dev_dbg(mx3fb->dev, "mx3fbi %p, txd = NULL\n", mx3_fbi);
>  
>  	/* This enables the channel */
>  	if (mx3_fbi->cookie < 0) {
> @@ -646,6 +649,7 @@ static int sdc_set_global_alpha(struct mx3fb_data *mx3fb, bool enable, uint8_t a
>  
>  static void sdc_set_brightness(struct mx3fb_data *mx3fb, uint8_t value)
>  {
> +	dev_dbg(mx3fb->dev, "%s: value = %d\n", __func__, value);
>  	/* This might be board-specific */
>  	mx3fb_write_reg(mx3fb, 0x03000000UL | value << 16, SDC_PWM_CTRL);
>  	return;
> @@ -1486,12 +1490,12 @@ static int mx3fb_probe(struct platform_device *pdev)
>  		goto ersdc0;
>  	}
>  
> +	mx3fb->backlight_level = 255;
> +
>  	ret = init_fb_chan(mx3fb, to_idmac_chan(chan));
>  	if (ret < 0)
>  		goto eisdc0;
>  
> -	mx3fb->backlight_level = 255;
> -
>  	return 0;
>  
>  eisdc0:
> -- 
> 1.6.3.3
> 
> 
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
