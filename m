From: kevin.wells@nxp.com (Kevin Wells)
Date: Fri, 6 Aug 2010 01:02:46 +0200
Subject: RFC ARM LPC32xx AMBA apb_pclk changes
In-Reply-To: <20100731132630.GB27064@n2100.arm.linux.org.uk>
References: <AANLkTi=eqwRMYLAUoXkuBgTrPWHsj_XbfQF4FgNOxiXd@mail.gmail.com>
	<20100731094442.GF23886@n2100.arm.linux.org.uk>
	<20100731132630.GB27064@n2100.arm.linux.org.uk>
Message-ID: <083DF309106F364B939360100EC290F80AC3A54D64@eu1rdcrdc1wx030.exi.nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> 
> diff --git a/drivers/video/amba-clcd.c b/drivers/video/amba-clcd.c
> index afe21e6..1c2c683 100644
> --- a/drivers/video/amba-clcd.c
> +++ b/drivers/video/amba-clcd.c
> @@ -80,7 +80,10 @@ static void clcdfb_disable(struct clcd_fb *fb)
>  	/*
>  	 * Disable CLCD clock source.
>  	 */
> -	clk_disable(fb->clk);
> +	if (fb->clk_enabled) {
> +		fb->clk_enabled = false;
> +		clk_disable(fb->clk);
> +	}
>  }
> 
>  static void clcdfb_enable(struct clcd_fb *fb, u32 cntl)
> @@ -88,7 +91,10 @@ static void clcdfb_enable(struct clcd_fb *fb, u32
> cntl)
>  	/*
>  	 * Enable the CLCD clock source.
>  	 */
> -	clk_enable(fb->clk);
> +	if (!fb->clk_enabled) {
> +		fb->clk_enabled = true;
> +		clk_enable(fb->clk);
> +	}
> 
>  	/*
>  	 * Bring up by first enabling..
> diff --git a/include/linux/amba/clcd.h b/include/linux/amba/clcd.h
> index ca16c38..be33b3a 100644
> --- a/include/linux/amba/clcd.h
> +++ b/include/linux/amba/clcd.h
> @@ -150,6 +150,7 @@ struct clcd_fb {
>  	u16			off_cntl;
>  	u32			clcd_cntl;
>  	u32			cmap[16];
> +	bool			clk_enabled;
>  };
> 
>  static inline void clcdfb_decode(struct clcd_fb *fb, struct clcd_regs
> *regs)
> 

This should fix the unbalanced clock calls to the arch clock driver. Do
you want to submit this patch or want me to include it in with the
pl11x amba pclk register access patch?
