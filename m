From: balbi@ti.com (Felipe Balbi)
Date: Wed, 3 Apr 2013 16:48:27 +0300
Subject: [PATCH v5 2/6] usb: phy: omap-usb2: use the new generic PHY
 framework
In-Reply-To: <1364993634-6378-3-git-send-email-kishon@ti.com>
References: <1364993634-6378-1-git-send-email-kishon@ti.com>
 <1364993634-6378-3-git-send-email-kishon@ti.com>
Message-ID: <20130403134827.GF14680@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 03, 2013 at 06:23:50PM +0530, Kishon Vijay Abraham I wrote:
> Used the generic PHY framework API to create the PHY. omap_usb2_suspend
> is split into omap_usb_suspend and omap_usb_resume in order to align
> with the new framework.
> 
> However using the old USB PHY library cannot be completely removed
> because OTG is intertwined with PHY and moving to the new framework
> will break OTG. Once we have a separate OTG state machine, we
> can get rid of the USB PHY library.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/usb/phy/omap-usb2.c |   48 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
> 
> diff --git a/drivers/usb/phy/omap-usb2.c b/drivers/usb/phy/omap-usb2.c
> index 844ab68..4e48db4 100644
> --- a/drivers/usb/phy/omap-usb2.c
> +++ b/drivers/usb/phy/omap-usb2.c
> @@ -28,6 +28,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/delay.h>
>  #include <linux/usb/omap_control_usb.h>
> +#include <linux/phy/phy.h>
>  
>  /**
>   * omap_usb2_set_comparator - links the comparator present in the sytem with
> @@ -119,9 +120,49 @@ static int omap_usb2_suspend(struct usb_phy *x, int suspend)
>  	return 0;
>  }
>  
> +static int omap_usb_suspend(struct phy *x)
> +{
> +	struct omap_usb *phy = dev_get_drvdata(&x->dev);
> +
> +	if (!phy->is_suspended) {
> +		omap_control_usb_phy_power(phy->control_dev, 0);
> +		pm_runtime_put_sync(phy->dev);
> +		phy->is_suspended = 1;
> +	}
> +
> +	return 0;
> +}
> +
> +static int omap_usb_resume(struct phy *x)
> +{
> +	u32 ret;
> +	struct omap_usb *phy = dev_get_drvdata(&x->dev);
> +
> +	if (phy->is_suspended) {
> +		ret = pm_runtime_get_sync(phy->dev);
> +		if (ret < 0) {
> +			dev_err(phy->dev, "get_sync failed with err %d\n",
> +									ret);
> +			return ret;
> +		}
> +		omap_control_usb_phy_power(phy->control_dev, 1);
> +		phy->is_suspended = 0;
> +	}
> +
> +	return 0;
> +}
> +
> +static struct phy_ops ops = {

const ? Maybe provide a:

#define DEFINE_PHY_OPS(name)	\
const struct phy_ops #name_phy_ops = {

macro ? This will force people to add the const keyword :-)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130403/c783de21/attachment.sig>
