From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Fri, 01 Feb 2013 22:54:49 +0100
Subject: [PATCH v2 2/6] usb: otg: utils: add facilities in phy lib to
 support multiple PHYs of same type
In-Reply-To: <1359081206-5602-3-git-send-email-kishon@ti.com>
References: <1359081206-5602-1-git-send-email-kishon@ti.com>
 <1359081206-5602-3-git-send-email-kishon@ti.com>
Message-ID: <510C39A9.70202@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/25/2013 03:33 AM, Kishon Vijay Abraham I wrote:
> In order to add support for multipe PHY's of the same type, new API's
> for adding PHY and getting PHY has been added. Now the binding
> information for the PHY and controller should be done in platform file
> using usb_bind_phy API. And for getting a PHY, the device pointer of the
> USB controller and an index should be passed. Based on the binding
> information that is added in the platform file, usb_get_phy_dev will return the
> appropriate PHY.
> Already existing API's to add and get phy by type is not removed. These
> API's are deprecated and will be removed once all the platforms start to
> use the new API.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/usb/otg/otg.c   |  118 ++++++++++++++++++++++++++++++++++++++++++++++-
>  include/linux/usb/phy.h |   13 ++++++
>  2 files changed, 130 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/otg/otg.c b/drivers/usb/otg/otg.c
> index 8e756d9..4bb4333 100644
> --- a/drivers/usb/otg/otg.c
> +++ b/drivers/usb/otg/otg.c
> @@ -36,6 +36,24 @@ static struct usb_phy *__usb_find_phy(struct list_head *list,
>  	return ERR_PTR(-ENODEV);
>  }
>  
> +static struct usb_phy *__usb_find_phy_dev(struct device *dev,
> +	struct list_head *list, u8 index)
> +{
> +	struct usb_phy_bind *phy_bind = NULL;
> +
> +	list_for_each_entry(phy_bind, list, list) {
> +		if (!(strcmp(phy_bind->dev_name, dev_name(dev))) &&
> +				phy_bind->index == index) {
> +			if (phy_bind->phy)
> +				return phy_bind->phy;
> +			else
> +				return ERR_PTR(-EPROBE_DEFER);
> +		}
> +	}
> +
> +	return ERR_PTR(-ENODEV);
> +}
> +
>  static void devm_usb_phy_release(struct device *dev, void *res)
>  {
>  	struct usb_phy *phy = *(struct usb_phy **)res;
> @@ -112,6 +130,69 @@ err0:
>  EXPORT_SYMBOL(usb_get_phy);
>  
>  /**
> + * usb_get_phy_dev - find the USB PHY
> + * @dev - device that requests this phy
> + * @index - the index of the phy
> + *
> + * Returns the phy driver, after getting a refcount to it; or
> + * -ENODEV if there is no such phy.  The caller is responsible for
> + * calling usb_put_phy() to release that count.
> + *
> + * For use by USB host and peripheral drivers.
> + */
> +struct usb_phy *usb_get_phy_dev(struct device *dev, u8 index)
> +{
> +	struct usb_phy	*phy = NULL;
> +	unsigned long	flags;
> +
> +	spin_lock_irqsave(&phy_lock, flags);
> +
> +	phy = __usb_find_phy_dev(dev, &phy_bind_list, index);
> +	if (IS_ERR(phy)) {

You should probably lock the phy module in memory. See my patch "usb:
otg: use try_module_get in all usb_get_phy functions and add missing
module_put".

Marc



-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130201/c716d5f4/attachment-0001.sig>
