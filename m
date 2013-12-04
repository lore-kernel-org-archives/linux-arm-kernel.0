From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Wed, 4 Dec 2013 10:51:10 +0200
Subject: [patch] video: vt8500: fix error handling in probe()
In-Reply-To: <20131202081118.GB3852@elgon.mountain>
References: <20131202081118.GB3852@elgon.mountain>
Message-ID: <529EECFE.1010607@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2013-12-02 10:11, Dan Carpenter wrote:
> We shouldn't kfree(fbi) because that was allocated with devm_kzalloc().
> There were several error paths which returned directly instead of
> releasing resources.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> diff --git a/drivers/video/vt8500lcdfb.c b/drivers/video/vt8500lcdfb.c
> index b30e5a439d1f..a8f2b280f796 100644
> --- a/drivers/video/vt8500lcdfb.c
> +++ b/drivers/video/vt8500lcdfb.c
> @@ -293,8 +293,7 @@ static int vt8500lcd_probe(struct platform_device *pdev)
>  			+ sizeof(u32) * 16, GFP_KERNEL);
>  	if (!fbi) {
>  		dev_err(&pdev->dev, "Failed to initialize framebuffer device\n");
> -		ret = -ENOMEM;
> -		goto failed;
> +		return -ENOMEM;
>  	}
>  
>  	strcpy(fbi->fb.fix.id, "VT8500 LCD");
> @@ -327,15 +326,13 @@ static int vt8500lcd_probe(struct platform_device *pdev)
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	if (res == NULL) {
>  		dev_err(&pdev->dev, "no I/O memory resource defined\n");
> -		ret = -ENODEV;
> -		goto failed_fbi;
> +		return -ENODEV;
>  	}
>  
>  	res = request_mem_region(res->start, resource_size(res), "vt8500lcd");
>  	if (res == NULL) {
>  		dev_err(&pdev->dev, "failed to request I/O memory\n");
> -		ret = -EBUSY;
> -		goto failed_fbi;
> +		return -EBUSY;
>  	}
>  
>  	fbi->regbase = ioremap(res->start, resource_size(res));
> @@ -346,17 +343,19 @@ static int vt8500lcd_probe(struct platform_device *pdev)
>  	}
>  
>  	disp_timing = of_get_display_timings(pdev->dev.of_node);
> -	if (!disp_timing)
> -		return -EINVAL;
> +	if (!disp_timing) {
> +		ret = -EINVAL;
> +		goto failed_free_io;
> +	}
>  
>  	ret = of_get_fb_videomode(pdev->dev.of_node, &of_mode,
>  							OF_USE_NATIVE_MODE);
>  	if (ret)
> -		return ret;
> +		goto failed_free_io;
>  
>  	ret = of_property_read_u32(pdev->dev.of_node, "bits-per-pixel", &bpp);
>  	if (ret)
> -		return ret;
> +		goto failed_free_io;
>  
>  	/* try allocating the framebuffer */
>  	fb_mem_len = of_mode.xres * of_mode.yres * 2 * (bpp / 8);
> @@ -364,7 +363,8 @@ static int vt8500lcd_probe(struct platform_device *pdev)
>  				GFP_KERNEL);
>  	if (!fb_mem_virt) {
>  		pr_err("%s: Failed to allocate framebuffer\n", __func__);
> -		return -ENOMEM;
> +		ret = -ENOMEM;
> +		goto failed_free_io;
>  	}
>  
>  	fbi->fb.fix.smem_start	= fb_mem_phys;
> @@ -447,9 +447,6 @@ failed_free_io:
>  	iounmap(fbi->regbase);
>  failed_free_res:
>  	release_mem_region(res->start, resource_size(res));
> -failed_fbi:
> -	kfree(fbi);
> -failed:
>  	return ret;
>  }

Thanks, queued for 3.13 fbdev fixes.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131204/64f89453/attachment.sig>
