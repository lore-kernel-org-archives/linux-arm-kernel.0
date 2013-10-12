From: marex@denx.de (Marek Vasut)
Date: Sat, 12 Oct 2013 11:44:59 +0200
Subject: [PATCH 07/12] usb: phy-mxs: Add implementation of set_wakeup
In-Reply-To: <1381568986-19802-8-git-send-email-peter.chen@freescale.com>
References: <1381568986-19802-1-git-send-email-peter.chen@freescale.com>
 <1381568986-19802-8-git-send-email-peter.chen@freescale.com>
Message-ID: <201310121144.59501.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Peter Chen,

> When we need the PHY can be waken up by external signals,
> we can call this API. Besides, we call mxs_phy_disconnect_line
> at this API to close the connection between USB PHY and
> controller, after that, the line state from controller is SE0.
> Once the PHY is out of power, without calling mxs_phy_disconnect_line,
> there are unknown wakeups due to dp/dm floating at device mode.
> 
> Signed-off-by: Peter Chen <peter.chen@freescale.com>
> ---
>  drivers/usb/phy/phy-mxs-usb.c |   82
> ++++++++++++++++++++++++++++++++++++++++- 1 files changed, 81
> insertions(+), 1 deletions(-)

[...]

> +static int mxs_phy_set_wakeup(struct usb_phy *x, bool enabled)
> +{
> +	struct mxs_phy *mxs_phy = to_mxs_phy(x);
> +	u32 value = BM_USBPHY_CTRL_ENVBUSCHG_WKUP |
> +			BM_USBPHY_CTRL_ENDPDMCHG_WKUP |
> +				BM_USBPHY_CTRL_ENIDCHG_WKUP;

Does this stuff pass checkpatch at all? I mean, this alignment seems a bit 
strange.

> +	if (enabled) {
> +		mxs_phy_disconnect_line(mxs_phy, true);
> +		writel_relaxed(value, x->io_priv + HW_USBPHY_CTRL_SET);
> +	} else {
> +		writel_relaxed(value, x->io_priv + HW_USBPHY_CTRL_CLR);
> +		mxs_phy_disconnect_line(mxs_phy, false);
> +	}
> +
> +	return 0;
> +}
> +
>  static int mxs_phy_on_connect(struct usb_phy *phy,
>  		enum usb_device_speed speed)
>  {
> @@ -315,6 +390,10 @@ static int mxs_phy_probe(struct platform_device *pdev)
>  		}
>  	}
> 
> +	if (of_find_property(np, "disconnect_line_without_vbus", NULL) &&
> +			mxs_phy->regmap_anatop)

You might want to introduce a variable here to make the condition shorter:

var = of_find....
if (var && mxs_phy->...)

> +		mxs_phy->disconnect_line_without_vbus_is_needed = true;
> +
>  	mxs_phy->phy.io_priv		= base;
>  	mxs_phy->phy.dev		= &pdev->dev;
>  	mxs_phy->phy.label		= DRIVER_NAME;
> @@ -324,6 +403,7 @@ static int mxs_phy_probe(struct platform_device *pdev)
>  	mxs_phy->phy.notify_connect	= mxs_phy_on_connect;
>  	mxs_phy->phy.notify_disconnect	= mxs_phy_on_disconnect;
>  	mxs_phy->phy.type		= USB_PHY_TYPE_USB2;
> +	mxs_phy->phy.set_wakeup		= mxs_phy_set_wakeup;
> 
>  	ATOMIC_INIT_NOTIFIER_HEAD(&mxs_phy->phy.notifier);
