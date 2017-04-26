From: peter.chen@nxp.com (Peter Chen)
Date: Wed, 26 Apr 2017 16:34:28 +0800
Subject: [PATCH] usb: chipidea: properly handle host or gadget
 initialization failure
In-Reply-To: <20170425094311.361-1-jszhang@marvell.com>
References: <20170425094311.361-1-jszhang@marvell.com>
Message-ID: <20170426083428.GA4375@b29397-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 25, 2017 at 05:43:11PM +0800, Jisheng Zhang wrote:
> If ci_hdrc_host_init() or ci_hdrc_gadget_init() returns error and the
> error != -ENXIO, as Peter pointed out, "it stands for initialization
> for host or gadget has failed", so we'd better return failure rather
> continue.
> 
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> ---
>  drivers/usb/chipidea/core.c | 25 +++++++++++++++++++------
>  1 file changed, 19 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
> index 79ad8e91632e..047afdbb7049 100644
> --- a/drivers/usb/chipidea/core.c
> +++ b/drivers/usb/chipidea/core.c
> @@ -930,20 +930,28 @@ static int ci_hdrc_probe(struct platform_device *pdev)
>  	/* initialize role(s) before the interrupt is requested */
>  	if (dr_mode == USB_DR_MODE_OTG || dr_mode == USB_DR_MODE_HOST) {
>  		ret = ci_hdrc_host_init(ci);
> -		if (ret)
> -			dev_info(dev, "doesn't support host\n");
> +		if (ret) {
> +			if (ret == -ENXIO)
> +				dev_info(dev, "doesn't support host\n");
> +			else
> +				goto deinit_phy;
> +		}
>  	}
>  
>  	if (dr_mode == USB_DR_MODE_OTG || dr_mode == USB_DR_MODE_PERIPHERAL) {
>  		ret = ci_hdrc_gadget_init(ci);
> -		if (ret)
> -			dev_info(dev, "doesn't support gadget\n");
> +		if (ret) {
> +			if (ret == -ENXIO)
> +				dev_info(dev, "doesn't support gadget\n");
> +			else
> +				goto deinit_host;
> +		}
>  	}
>  
>  	if (!ci->roles[CI_ROLE_HOST] && !ci->roles[CI_ROLE_GADGET]) {
>  		dev_err(dev, "no supported roles\n");
>  		ret = -ENODEV;
> -		goto deinit_phy;
> +		goto deinit_gadget;
>  	}
>  
>  	if (ci->is_otg && ci->roles[CI_ROLE_GADGET]) {
> @@ -1013,7 +1021,12 @@ static int ci_hdrc_probe(struct platform_device *pdev)
>  		return 0;
>  
>  stop:
> -	ci_role_destroy(ci);
> +	if (ci->is_otg)
> +		ci_hdrc_otg_destroy(ci);
> +deinit_gadget:
> +	ci_hdrc_gadget_destroy(ci);
> +deinit_host:
> +	ci_hdrc_host_destroy(ci);
>  deinit_phy:
>  	ci_usb_phy_exit(ci);
>  ulpi_exit:
> -- 
> 2.11.0
> 

You change is ok, there are more things need to change for this issue,
would you mind adding below changes to your patch, and send v2. Below
changes are based on your changes.

diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index c55bcdd..4cad8a9 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -818,7 +818,7 @@ static inline void ci_role_destroy(struct ci_hdrc *ci)
 {
 	ci_hdrc_gadget_destroy(ci);
 	ci_hdrc_host_destroy(ci);
-	if (ci->is_otg)
+	if (ci->is_otg && ci->roles[CI_ROLE_GADGET])
 		ci_hdrc_otg_destroy(ci);
 }
 
@@ -1005,7 +1005,7 @@ static int ci_hdrc_probe(struct platform_device *pdev)
 		ret = ci_hdrc_otg_init(ci);
 		if (ret) {
 			dev_err(dev, "init otg fails, ret = %d\n", ret);
-			goto stop;
+			goto deinit_gadget;
 		}
 	}
 
@@ -1075,7 +1075,7 @@ static int ci_hdrc_probe(struct platform_device *pdev)
 remove_debug:
 	dbg_remove_files(ci);
 stop:
-	if (ci->is_otg)
+	if (ci->is_otg && ci->roles[CI_ROLE_GADGET])
 		ci_hdrc_otg_destroy(ci);
 deinit_gadget:
 	ci_hdrc_gadget_destroy(ci);

-- 

Best Regards,
Peter Chen
