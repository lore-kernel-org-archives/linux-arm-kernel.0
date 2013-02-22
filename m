From: peter.chen@freescale.com (Peter Chen)
Date: Fri, 22 Feb 2013 10:09:41 +0800
Subject: [PATCH 6/9] USB chipidea: introduce dual role mode pdata flags
In-Reply-To: <1359984275-24646-7-git-send-email-s.hauer@pengutronix.de>
References: <1359984275-24646-1-git-send-email-s.hauer@pengutronix.de>
 <1359984275-24646-7-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20130222020940.GB1026@nchen-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 04, 2013 at 02:24:32PM +0100, Sascha Hauer wrote:
> Even if a chipidea core is otg capable the board may not. This allows
> to explicitly set the core to host/peripheral mode. Without these
> flags the driver falls back to the old behaviour.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/usb/chipidea/core.c  |   21 +++++++++++++++------
>  include/linux/usb/chipidea.h |    2 +-
>  2 files changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
> index 04d68cb..c89f2aa 100644
> --- a/drivers/usb/chipidea/core.c
> +++ b/drivers/usb/chipidea/core.c
> @@ -435,6 +435,7 @@ static int ci_hdrc_probe(struct platform_device *pdev)
>  	struct resource	*res;
>  	void __iomem	*base;
>  	int		ret;
> +	enum usb_dr_mode dr_mode;
>  
>  	if (!dev->platform_data) {
>  		dev_err(dev, "platform data missing\n");
> @@ -487,14 +488,22 @@ static int ci_hdrc_probe(struct platform_device *pdev)
>  		return -ENODEV;
>  	}
>  
> -	ret = ci_hdrc_gadget_init(ci);
> -	if (ret)
> -		dev_info(dev, "doesn't support gadget\n");
> +	if (dr_mode == USB_DR_MODE_OTG || dr_mode == USB_DR_MODE_PERIPHERAL) {

Can we change "USB_DR_MODE_PERIPHERAL" to "USB_DR_MODE_GADGET", since we always
use gadget to stands for device or peripheral mode at code (like below
CI_ROLE_GADGET), it may make code uniform.

> +		ret = ci_hdrc_gadget_init(ci);
> +		if (ret)
> +			dev_info(dev, "doesn't support gadget\n");
> +	}
>  
>  	if (!ci->roles[CI_ROLE_HOST] && !ci->roles[CI_ROLE_GADGET]) {
>  		dev_err(dev, "no supported roles\n");

-- 

Best Regards,
Peter Chen
