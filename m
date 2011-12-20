From: marek.vasut@gmail.com (Marek Vasut)
Date: Tue, 20 Dec 2011 14:49:26 +0100
Subject: [PATCH 09/12] video: mxsfb: convert to clk_prepare/clk_unprepare
In-Reply-To: <1324382443-4439-10-git-send-email-shawn.guo@linaro.org>
References: <1324382443-4439-1-git-send-email-shawn.guo@linaro.org>
 <1324382443-4439-10-git-send-email-shawn.guo@linaro.org>
Message-ID: <201112201449.26270.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> The patch converts mxsfb driver to clk_prepare/clk_unprepare by
> using helper functions clk_prepare_enable/clk_disable_unprepare.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
> ---
>  drivers/video/mxsfb.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/video/mxsfb.c b/drivers/video/mxsfb.c
> index d837d63..eb3c5ee 100644
> --- a/drivers/video/mxsfb.c
> +++ b/drivers/video/mxsfb.c
> @@ -328,7 +328,7 @@ static void mxsfb_enable_controller(struct fb_info
> *fb_info)
> 
>  	dev_dbg(&host->pdev->dev, "%s\n", __func__);
> 
> -	clk_enable(host->clk);
> +	clk_prepare_enable(host->clk);
>  	clk_set_rate(host->clk, PICOS2KHZ(fb_info->var.pixclock) * 1000U);
> 
>  	/* if it was disabled, re-enable the mode again */
> @@ -368,7 +368,7 @@ static void mxsfb_disable_controller(struct fb_info
> *fb_info)
> 
>  	writel(VDCTRL4_SYNC_SIGNALS_ON, host->base + LCDC_VDCTRL4 + REG_CLR);
> 
> -	clk_disable(host->clk);
> +	clk_disable_unprepare(host->clk);
> 
>  	host->enabled = 0;
>  }
> @@ -668,7 +668,7 @@ static int __devinit mxsfb_restore_mode(struct
> mxsfb_info *host) line_count = fb_info->fix.smem_len /
> fb_info->fix.line_length;
>  	fb_info->fix.ypanstep = 1;
> 
> -	clk_enable(host->clk);
> +	clk_prepare_enable(host->clk);
>  	host->enabled = 1;
> 
>  	return 0;
> @@ -841,7 +841,7 @@ static int __devinit mxsfb_probe(struct platform_device
> *pdev)
> 
>  error_register:
>  	if (host->enabled)
> -		clk_disable(host->clk);
> +		clk_disable_unprepare(host->clk);
>  	fb_destroy_modelist(&fb_info->modelist);
>  error_init_fb:
>  	kfree(fb_info->pseudo_palette);

Acked-by: Marek Vasut <marek.vasut@gmail.com>
