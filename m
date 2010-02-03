From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 3 Feb 2010 10:20:31 +0000
Subject: [PATCH 13/16] ARM: LPC32XX: Various fixes with readl/writel types
In-Reply-To: <1265155168-28909-14-git-send-email-wellsk40@gmail.com>
References: <1265155168-28909-14-git-send-email-wellsk40@gmail.com>
Message-ID: <20100203102031.GE22275@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 02, 2010 at 03:59:25PM -0800, wellsk40 at gmail.com wrote:
>  	if (fb->fb.screen_base == NULL) {
> -		fb->fb.screen_base = dma_alloc_writecombine(&fb->dev->dev,
> -			PANEL_SIZE, &dma, GFP_KERNEL);
> +		fb->fb.screen_base = (__force char __iomem *)
> +			dma_alloc_writecombine(&fb->dev->dev, PANEL_SIZE,
> +			&dma, GFP_KERNEL);

There are times when putting up with sparse complaints is the right thing
to do, and this is one situation where that is true.

>  		fb->fb.fix.smem_start = dma;
>  	}
>  
> @@ -130,7 +131,7 @@ static int lpc32xx_clcd_mmap(struct clcd_fb *fb, struct vm_area_struct *vma)
>  #endif
>  
>  	return dma_mmap_writecombine(&fb->dev->dev, vma,
> -				     fb->fb.screen_base,
> +				     (__force void *) fb->fb.screen_base,

Same here.

>  				     fb->fb.fix.smem_start,
>  				     fb->fb.fix.smem_len);
>  }
> @@ -140,11 +141,12 @@ static void lpc32xx_clcd_remove(struct clcd_fb *fb)
>  #ifdef CONFIG_MACH_LPC32XX_IRAM_FOR_CLCD
>  	if (PANEL_SIZE > CONFIG_ARCH_LPC32XX_IRAM_SIZE)
>  		dma_free_writecombine(&fb->dev->dev, fb->fb.fix.smem_len,
> -			fb->fb.screen_base, fb->fb.fix.smem_start);
> +			(__force void *) fb->fb.screen_base,
> +			fb->fb.fix.smem_start);

and here.

>  
>  #else
>  	dma_free_writecombine(&fb->dev->dev, fb->fb.fix.smem_len,
> -		fb->fb.screen_base, fb->fb.fix.smem_start);
> +		(__force void *) fb->fb.screen_base, fb->fb.fix.smem_start);

and here.
