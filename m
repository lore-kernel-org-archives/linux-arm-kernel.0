From: balbi@ti.com (Felipe Balbi)
Date: Tue, 19 Feb 2013 10:11:57 +0200
Subject: [PATCH v2 2/5] usb: phy: omap-usb2: use the new generic PHY
 framework
In-Reply-To: <1361253198-7401-3-git-send-email-kishon@ti.com>
References: <1361253198-7401-1-git-send-email-kishon@ti.com>
 <1361253198-7401-3-git-send-email-kishon@ti.com>
Message-ID: <20130219081157.GE23197@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Feb 19, 2013 at 11:23:15AM +0530, Kishon Vijay Abraham I wrote:
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
>  drivers/usb/phy/omap-usb2.c  |   49 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/usb/omap_usb.h |    3 +++
>  2 files changed, 52 insertions(+)
> 
> diff --git a/drivers/usb/phy/omap-usb2.c b/drivers/usb/phy/omap-usb2.c
> index 844ab68..924ae59 100644
> --- a/drivers/usb/phy/omap-usb2.c
> +++ b/drivers/usb/phy/omap-usb2.c
> @@ -119,9 +119,48 @@ static int omap_usb2_suspend(struct usb_phy *x, int suspend)
>  	return 0;
>  }
>  
> +static int omap_usb_suspend(struct phy_descriptor *desc)
> +{
> +	struct omap_usb *phy = desc_to_omapusb(desc);
> +
> +	if (!phy->is_suspended) {

I wonder if it wouldn't be better to have some refcounting done by phy
framework itself so that this only gets called when phy->refcount == 0

> +		omap_control_usb_phy_power(phy->control_dev, 0);

coudln't you move this to ->runtime_suspend() ?

> +		pm_runtime_put_sync(phy->dev);
> +		phy->is_suspended = 1;
> +	}
> +
> +	return 0;
> +}
> +
> +static int omap_usb_resume(struct phy_descriptor *desc)
> +{
> +	u32 ret;
> +	struct omap_usb *phy = desc_to_omapusb(desc);
> +
> +	if (phy->is_suspended) {
> +		ret = pm_runtime_get_sync(phy->dev);
> +		if (ret < 0) {
> +			dev_err(phy->dev, "get_sync failed with err %d\n",
> +									ret);
> +			return ret;
> +		}
> +		omap_control_usb_phy_power(phy->control_dev, 1);

likewise, this could go to ->runtime_resume().

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130219/cac57595/attachment.sig>
