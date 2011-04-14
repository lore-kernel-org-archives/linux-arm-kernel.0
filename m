From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 14 Apr 2011 10:49:51 +0200
Subject: [PATCH 3/7] Add i.MX5 framebuffer driver
In-Reply-To: <1302710016-3569-3-git-send-email-weitway@gmail.com>
References: <1302710016-3569-1-git-send-email-weitway@gmail.com>
	<1302710016-3569-3-git-send-email-weitway@gmail.com>
Message-ID: <20110414084951.GX7285@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason,

On Wed, Apr 13, 2011 at 11:53:32PM +0800, weitway at gmail.com wrote:
> 
> +
> +static int imx_ipu_fb_map_video_memory(struct fb_info *fbi)
> +{
> +	int size;
> +
> +	size = fbi->var.yres_virtual * fbi->fix.line_length;
> +
> +	if (fbi->screen_base) {
> +		if (fbi->fix.smem_len >= size)
> +			return 0;
> +
> +		dma_free_writecombine(fbi->device, fbi->fix.smem_len,
> +			      fbi->screen_base, fbi->fix.smem_start);
> +	}
> +
> +	fbi->screen_base = dma_alloc_writecombine(fbi->device,
> +				size,
> +				(dma_addr_t *)&fbi->fix.smem_start,
> +				GFP_DMA);
> +	if (fbi->screen_base == 0) {
> +		dev_err(fbi->device, "Unable to allocate framebuffer memory (%d)\n",
> +				fbi->fix.smem_len);
> +		fbi->fix.smem_len = 0;
> +		fbi->fix.smem_start = 0;
> +		return -ENOMEM;
> +	}

On which version of the driver I posted did you base this on? At least
in the last version removed this remapping feature.

You don't know whether the framebuffer is still mapped somewhere, so
you can't reallocate the framebuffer memory without corrupting your
memory. Simple test: run fbtest on one console, switch to a higher
resolution on another console and see your board go down...

IMO the only sane solution is to allocate memory for the largest
possible resolution at probe time.


> +
> +	INIT_LIST_HEAD(&fbi->modelist);
> +	for (i = 0; i < plat_data->num_modes; i++)
> +		fb_add_videomode(&plat_data->modes[i], &fbi->modelist);
> +
> +	/*if (plat_data->flags & IMX_IPU_FB_USE_MODEDB) {
> +		for (i = 0; i < num_fb_modes; i++)
> +			fb_add_videomode(&fb_modes[i], &fbi->modelist);
> +	}*/
> +

You should remove this.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
