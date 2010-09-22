From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Wed, 22 Sep 2010 18:15:06 +0200 (CEST)
Subject: [PATCH v3] Separate display's pixel configuration from video mode
In-Reply-To: <1285166622-20986-1-git-send-email-m.grzeschik@pengutronix.de>
References: <Pine.LNX.4.64.1009221307550.32562@axis700.grange>
	<1285166622-20986-1-git-send-email-m.grzeschik@pengutronix.de>
Message-ID: <Pine.LNX.4.64.1009221814350.32562@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 22 Sep 2010, Michael Grzeschik wrote:

> From: Juergen Beisert <jbe@pengutronix.de>
> 
> Currently the pixel mapping to the display depends on the video mode. This
> seems not true as the IPU transfers the data read from the video memory in an
> internal 32 bit bus to the DI unit. The DI mapping only depends on the settings
> the IPU should read the data from video memory. If all these settings do it in
> the same byte order, only one DI mapping per display is required.
> 
> There are three locations where we can mix the colour components:
>  - in the video mode description, colour offsets
>  - in the IPU while reading pixel data from memory
>  - in the DI unit while mapping it to the connected display
> 
> If one of these settings are incorrect, the displayed colours are broken.
> 
> With this patch the platform describes the display connection and the driver
> uses this information independently from the selected video mode.
> 
> Signed-off-by: Juergen Beisert <jbe@pengutronix.de>
> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>

Tested-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

> ---
>  v2 - v3:
> 	changed to multiline comment
> 	added a generic set_di_bus_mapping function
> 
>  v1 - v2:
>         added default fallback ipu fb_bitfield values
>         for the case the platform doesn't define these.
> 
>  arch/arm/plat-mxc/include/mach/mx3fb.h |    5 ++
>  drivers/video/mx3fb.c                  |   81 ++++++++++++++++----------------
>  2 files changed, 45 insertions(+), 41 deletions(-)
> 
> diff --git a/arch/arm/plat-mxc/include/mach/mx3fb.h b/arch/arm/plat-mxc/include/mach/mx3fb.h
> index ac24c5c..93bd032 100644
> --- a/arch/arm/plat-mxc/include/mach/mx3fb.h
> +++ b/arch/arm/plat-mxc/include/mach/mx3fb.h
> @@ -33,6 +33,11 @@ struct mx3fb_platform_data {
>  	const char			*name;
>  	const struct fb_videomode	*mode;
>  	int				num_modes;
> +
> +	/* display's mapping description */
> +	struct fb_bitfield red;
> +	struct fb_bitfield green;
> +	struct fb_bitfield blue;
>  };
>  
>  #endif
> diff --git a/drivers/video/mx3fb.c b/drivers/video/mx3fb.c
> index 658f10a..ca20da8 100644
> --- a/drivers/video/mx3fb.c
> +++ b/drivers/video/mx3fb.c
> @@ -286,13 +286,6 @@ static void mx3fb_write_reg(struct mx3fb_data *mx3fb, u32 value, unsigned long r
>  	__raw_writel(value, mx3fb->reg_base + reg);
>  }
>  
> -static const uint32_t di_mappings[] = {
> -	0x1600AAAA, 0x00E05555, 0x00070000, 3,	/* RGB888 */
> -	0x0005000F, 0x000B000F, 0x0011000F, 1,	/* RGB666 */
> -	0x0011000F, 0x000B000F, 0x0005000F, 1,	/* BGR666 */
> -	0x0004003F, 0x000A000F, 0x000F003F, 1	/* RGB565 */
> -};
> -
>  static void sdc_fb_init(struct mx3fb_info *fbi)
>  {
>  	struct mx3fb_data *mx3fb = fbi->mx3fb;
> @@ -414,6 +407,17 @@ static int sdc_set_window_pos(struct mx3fb_data *mx3fb, enum ipu_channel channel
>  	return 0;
>  }
>  
> +static void set_di_bus_mapping(struct mx3fb_data *mx3fb, struct fb_bitfield *bf,
> +			      unsigned long reg)
> +{
> +	u32 val = 0xffff;
> +
> +	val &= ~(((1 << (bf->length * 2)) - 1) << (16 - (bf->length * 2)));
> +	val |= ((bf->offset + bf->length - 1)) << 16;
> +	pr_debug("b: %d %d 0x%08x\n", bf->offset, bf->length, val);
> +	mx3fb_write_reg(mx3fb, val, reg);
> +}
> +
>  /**
>   * sdc_init_panel() - initialize a synchronous LCD panel.
>   * @mx3fb:		mx3fb context.
> @@ -421,7 +425,6 @@ static int sdc_set_window_pos(struct mx3fb_data *mx3fb, enum ipu_channel channel
>   * @pixel_clk:		desired pixel clock frequency in Hz.
>   * @width:		width of panel in pixels.
>   * @height:		height of panel in pixels.
> - * @pixel_fmt:		pixel format of buffer as FOURCC ASCII code.
>   * @h_start_width:	number of pixel clocks between the HSYNC signal pulse
>   *			and the start of valid data.
>   * @h_sync_width:	width of the HSYNC signal in units of pixel clocks.
> @@ -438,7 +441,6 @@ static int sdc_set_window_pos(struct mx3fb_data *mx3fb, enum ipu_channel channel
>  static int sdc_init_panel(struct mx3fb_data *mx3fb, enum ipu_panel panel,
>  			  uint32_t pixel_clk,
>  			  uint16_t width, uint16_t height,
> -			  enum pixel_fmt pixel_fmt,
>  			  uint16_t h_start_width, uint16_t h_sync_width,
>  			  uint16_t h_end_width, uint16_t v_start_width,
>  			  uint16_t v_sync_width, uint16_t v_end_width,
> @@ -450,6 +452,9 @@ static int sdc_init_panel(struct mx3fb_data *mx3fb, enum ipu_panel panel,
>  	uint32_t div;
>  	struct clk *ipu_clk;
>  
> +	struct device *dev = mx3fb->dev;
> +	struct mx3fb_platform_data *mx3fb_pdata = dev->platform_data;
> +
>  	dev_dbg(mx3fb->dev, "panel size = %d x %d", width, height);
>  
>  	if (v_sync_width == 0 || h_sync_width == 0)
> @@ -536,36 +541,18 @@ static int sdc_init_panel(struct mx3fb_data *mx3fb, enum ipu_panel panel,
>  		sig.Vsync_pol << DI_D3_VSYNC_POL_SHIFT;
>  	mx3fb_write_reg(mx3fb, old_conf, DI_DISP_SIG_POL);
>  
> -	switch (pixel_fmt) {
> -	case IPU_PIX_FMT_RGB24:
> -		mx3fb_write_reg(mx3fb, di_mappings[0], DI_DISP3_B0_MAP);
> -		mx3fb_write_reg(mx3fb, di_mappings[1], DI_DISP3_B1_MAP);
> -		mx3fb_write_reg(mx3fb, di_mappings[2], DI_DISP3_B2_MAP);
> -		mx3fb_write_reg(mx3fb, mx3fb_read_reg(mx3fb, DI_DISP_ACC_CC) |
> -			     ((di_mappings[3] - 1) << 12), DI_DISP_ACC_CC);
> -		break;
> -	case IPU_PIX_FMT_RGB666:
> -		mx3fb_write_reg(mx3fb, di_mappings[4], DI_DISP3_B0_MAP);
> -		mx3fb_write_reg(mx3fb, di_mappings[5], DI_DISP3_B1_MAP);
> -		mx3fb_write_reg(mx3fb, di_mappings[6], DI_DISP3_B2_MAP);
> -		mx3fb_write_reg(mx3fb, mx3fb_read_reg(mx3fb, DI_DISP_ACC_CC) |
> -			     ((di_mappings[7] - 1) << 12), DI_DISP_ACC_CC);
> -		break;
> -	case IPU_PIX_FMT_BGR666:
> -		mx3fb_write_reg(mx3fb, di_mappings[8], DI_DISP3_B0_MAP);
> -		mx3fb_write_reg(mx3fb, di_mappings[9], DI_DISP3_B1_MAP);
> -		mx3fb_write_reg(mx3fb, di_mappings[10], DI_DISP3_B2_MAP);
> -		mx3fb_write_reg(mx3fb, mx3fb_read_reg(mx3fb, DI_DISP_ACC_CC) |
> -			     ((di_mappings[11] - 1) << 12), DI_DISP_ACC_CC);
> -		break;
> -	default:
> -		mx3fb_write_reg(mx3fb, di_mappings[12], DI_DISP3_B0_MAP);
> -		mx3fb_write_reg(mx3fb, di_mappings[13], DI_DISP3_B1_MAP);
> -		mx3fb_write_reg(mx3fb, di_mappings[14], DI_DISP3_B2_MAP);
> -		mx3fb_write_reg(mx3fb, mx3fb_read_reg(mx3fb, DI_DISP_ACC_CC) |
> -			     ((di_mappings[15] - 1) << 12), DI_DISP_ACC_CC);
> -		break;
> -	}
> +	/*
> +	 * setup the pixel mapping to the display. This seems independent
> +	 * from the internal video mode in use
> +	 */
> +	set_di_bus_mapping(mx3fb, &mx3fb_pdata->blue, DI_DISP3_B0_MAP);
> +	set_di_bus_mapping(mx3fb, &mx3fb_pdata->green, DI_DISP3_B1_MAP);
> +	set_di_bus_mapping(mx3fb, &mx3fb_pdata->red, DI_DISP3_B2_MAP);
> +
> +	/* the TFT displays expecting one pixel per clock */
> +	reg = mx3fb_read_reg(mx3fb, DI_DISP_ACC_CC) & ~(3 << 12);
> +	reg |= 0 << 12;	/* 0 means one clock */
> +	mx3fb_write_reg(mx3fb, reg, DI_DISP_ACC_CC);
>  
>  	spin_unlock_irqrestore(&mx3fb->lock, lock_flags);
>  
> @@ -776,8 +763,6 @@ static int __set_par(struct fb_info *fbi, bool lock)
>  		if (sdc_init_panel(mx3fb, mode,
>  				   (PICOS2KHZ(fbi->var.pixclock)) * 1000UL,
>  				   fbi->var.xres, fbi->var.yres,
> -				   (fbi->var.sync & FB_SYNC_SWAP_RGB) ?
> -				   IPU_PIX_FMT_BGR666 : IPU_PIX_FMT_RGB666,
>  				   fbi->var.left_margin,
>  				   fbi->var.hsync_len,
>  				   fbi->var.right_margin +
> @@ -1367,6 +1352,20 @@ static int init_fb_chan(struct mx3fb_data *mx3fb, struct idmac_channel *ichan)
>  		goto emode;
>  	}
>  
> +	if (mx3fb_pdata->red.length == 0 &&
> +	    mx3fb_pdata->green.length == 0 &&
> +	    mx3fb_pdata->blue.length == 0) {
> +
> +		mx3fb_pdata->red.length = 6;
> +		mx3fb_pdata->red.offset = 12;
> +
> +		mx3fb_pdata->green.length = 6;
> +		mx3fb_pdata->green.offset = 6;
> +
> +		mx3fb_pdata->blue.length = 6;
> +		mx3fb_pdata->blue.offset = 0;
> +	}
> +
>  	fb_videomode_to_modelist(mode, num_modes, &fbi->modelist);
>  
>  	/* Default Y virtual size is 2x panel size */
> -- 
> 1.7.2.3
> 
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
