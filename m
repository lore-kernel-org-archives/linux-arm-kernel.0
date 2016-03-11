From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 11 Mar 2016 13:26:23 +0200
Subject: [PATCH 3/3] video: fbdev: imxfb: add some error handling
In-Reply-To: <1457380425-20244-4-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1457380425-20244-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1457380425-20244-4-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <56E2AB5F.1020806@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 07/03/16 21:53, Uwe Kleine-K?nig wrote:
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Always have a description in a patch. In trivial cases it can be more or
less the same as the subject.

> ---
>  drivers/video/fbdev/imxfb.c | 33 ++++++++++++++++++++++++++-------
>  1 file changed, 26 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/video/fbdev/imxfb.c b/drivers/video/fbdev/imxfb.c
> index 3dd2824e6773..671b3719db56 100644
> --- a/drivers/video/fbdev/imxfb.c
> +++ b/drivers/video/fbdev/imxfb.c
> @@ -473,8 +473,9 @@ static int imxfb_set_par(struct fb_info *info)
>  	return 0;
>  }
>  
> -static void imxfb_enable_controller(struct imxfb_info *fbi)
> +static int imxfb_enable_controller(struct imxfb_info *fbi)
>  {
> +	int ret;
>  
>  	if (fbi->enabled)
>  		return;
> @@ -496,10 +497,27 @@ static void imxfb_enable_controller(struct imxfb_info *fbi)
>  	 */
>  	writel(RMCR_LCDC_EN_MX1, fbi->regs + LCDC_RMCR);
>  
> -	clk_prepare_enable(fbi->clk_ipg);
> -	clk_prepare_enable(fbi->clk_ahb);
> -	clk_prepare_enable(fbi->clk_per);
> +	ret = clk_prepare_enable(fbi->clk_ipg);
> +	if (ret)
> +		goto err_enable_ipg;
> +
> +	ret = clk_prepare_enable(fbi->clk_ahb);
> +	if (ret)
> +		goto err_enable_ahb;
> +
> +	ret = clk_prepare_enable(fbi->clk_per);
> +	if (ret) {
> +		clk_disable_unprepare(fbi->clk_ahb);
> +err_enable_ahb:
> +		clk_disable_unprepare(fbi->clk_ipg);
> +err_enable_ipg:
> +		writel(0, fbi->regs + LCDC_RMCR);

Please don't do that =). If you use goto, have the labels at the end of
the function, not in the middle inside a if() block...

> +
> +		return ret;
> +	}
> +
>  	fbi->enabled = true;
> +	return 0;
>  }
>  
>  static void imxfb_disable_controller(struct imxfb_info *fbi)
> @@ -510,8 +528,8 @@ static void imxfb_disable_controller(struct imxfb_info *fbi)
>  	pr_debug("Disabling LCD controller\n");
>  
>  	clk_disable_unprepare(fbi->clk_per);
> -	clk_disable_unprepare(fbi->clk_ipg);
>  	clk_disable_unprepare(fbi->clk_ahb);
> +	clk_disable_unprepare(fbi->clk_ipg);

This is not error handling. I don't mind it being in the same patch, but
this change is something to mention in the description.

>  	fbi->enabled = false;
>  
>  	writel(0, fbi->regs + LCDC_RMCR);
> @@ -520,6 +538,7 @@ static void imxfb_disable_controller(struct imxfb_info *fbi)
>  static int imxfb_blank(int blank, struct fb_info *info)
>  {
>  	struct imxfb_info *fbi = info->par;
> +	int ret = 0;;

Extra ;.

>  
>  	pr_debug("imxfb_blank: blank=%d\n", blank);
>  
> @@ -532,10 +551,10 @@ static int imxfb_blank(int blank, struct fb_info *info)
>  		break;
>  
>  	case FB_BLANK_UNBLANK:
> -		imxfb_enable_controller(fbi);
> +		ret = imxfb_enable_controller(fbi);
>  		break;
>  	}
> -	return 0;
> +	return ret;
>  }
>  
>  static struct fb_ops imxfb_ops = {
> 

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160311/982398a6/attachment-0001.sig>
