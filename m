From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 30 Oct 2013 20:34:02 +0100
Subject: [PATCHv8][ 1/6] video: imxfb: Introduce regulator support.
In-Reply-To: <1383061860-25035-1-git-send-email-denis@eukrea.com>
References: <1383061860-25035-1-git-send-email-denis@eukrea.com>
Message-ID: <20131030193402.GX18477@ns203013.ovh.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16:50 Tue 29 Oct     , Denis Carikli wrote:
> This commit is based on the following commit by Fabio Estevam:
>   4344429 video: mxsfb: Introduce regulator support
> 
> Cc: Fabio Estevam <fabio.estevam@freescale.com>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: linux-fbdev at vger.kernel.org
> Cc: Eric B?nard <eric@eukrea.com>
> Signed-off-by: Denis Carikli <denis@eukrea.com>
> ---
>  drivers/video/imxfb.c |   29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/video/imxfb.c b/drivers/video/imxfb.c
> index 44ee678..4bf3837 100644
> --- a/drivers/video/imxfb.c
> +++ b/drivers/video/imxfb.c
> @@ -28,6 +28,7 @@
>  #include <linux/cpufreq.h>
>  #include <linux/clk.h>
>  #include <linux/platform_device.h>
> +#include <linux/regulator/consumer.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/io.h>
>  #include <linux/math64.h>
> @@ -145,6 +146,7 @@ struct imxfb_info {
>  	struct clk		*clk_ipg;
>  	struct clk		*clk_ahb;
>  	struct clk		*clk_per;
> +	struct regulator	*reg_lcd;
>  	enum imxfb_type		devtype;
>  	bool			enabled;
>  
> @@ -563,12 +565,23 @@ static void imxfb_exit_backlight(struct imxfb_info *fbi)
>  
>  static void imxfb_enable_controller(struct imxfb_info *fbi)
>  {
> +	int ret;

	return the error so you can return it in imxfb_blank
>  
>  	if (fbi->enabled)
>  		return;
>  
>  	pr_debug("Enabling LCD controller\n");
>  
> +	if (fbi->reg_lcd) {
> +		ret = regulator_enable(fbi->reg_lcd);
> +		if (ret) {
> +			dev_err(&fbi->pdev->dev,
> +				"lcd regulator enable failed with error: %d\n",
> +				ret);
> +			return;
> +		}
> +	}
> +
>  	writel(fbi->screen_dma, fbi->regs + LCDC_SSA);
>  
>  	/* panning offset 0 (0 pixel offset)        */
> @@ -597,6 +610,8 @@ static void imxfb_enable_controller(struct imxfb_info *fbi)
>  
>  static void imxfb_disable_controller(struct imxfb_info *fbi)
>  {
> +	int ret;
> +
>  	if (!fbi->enabled)
>  		return;
>  
> @@ -613,6 +628,14 @@ static void imxfb_disable_controller(struct imxfb_info *fbi)
>  	fbi->enabled = false;
>  
>  	writel(0, fbi->regs + LCDC_RMCR);
> +
> +	if (fbi->reg_lcd) {
> +		ret = regulator_disable(fbi->reg_lcd);
> +		if (ret)
> +			dev_err(&fbi->pdev->dev,
> +				"lcd regulator disable failed with error: %d\n",
> +				ret);
> +	}
	ditto here
>  }
>  
>  static int imxfb_blank(int blank, struct fb_info *info)
> @@ -1020,6 +1043,12 @@ static int imxfb_probe(struct platform_device *pdev)
>  		goto failed_register;
>  	}
>  
> +	fbi->reg_lcd = devm_regulator_get(&pdev->dev, "lcd");
> +	if (IS_ERR(fbi->reg_lcd)) {
> +		dev_info(&pdev->dev, "No lcd regulator used.\n");
> +		fbi->reg_lcd = NULL;
> +	}
> +
>  	imxfb_enable_controller(fbi);
>  	fbi->pdev = pdev;
>  #ifdef PWMR_BACKLIGHT_AVAILABLE
> -- 
> 1.7.9.5
> 
