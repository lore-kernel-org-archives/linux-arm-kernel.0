From: marex@denx.de (Marek Vasut)
Date: Sat, 12 Oct 2013 11:42:06 +0200
Subject: [PATCH 05/12] usb: phy-mxs: Add implementation of nofity_suspend
 and notify_resume
In-Reply-To: <1381568986-19802-6-git-send-email-peter.chen@freescale.com>
References: <1381568986-19802-1-git-send-email-peter.chen@freescale.com>
 <1381568986-19802-6-git-send-email-peter.chen@freescale.com>
Message-ID: <201310121142.07174.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Peter Chen,

> Add notify_suspend and notify_resume according to different SoCs.
> 
> Signed-off-by: Peter Chen <peter.chen@freescale.com>
> ---
>  drivers/usb/phy/phy-mxs-usb.c |   73
> +++++++++++++++++++++++++++++++++++++++++ 1 files changed, 73
> insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/usb/phy/phy-mxs-usb.c b/drivers/usb/phy/phy-mxs-usb.c
> index e0b0de0..8661dae 100644
> --- a/drivers/usb/phy/phy-mxs-usb.c
> +++ b/drivers/usb/phy/phy-mxs-usb.c
> @@ -197,6 +197,78 @@ static int mxs_phy_on_disconnect(struct usb_phy *phy,
>  	return 0;
>  }
> 
> +static int mxs_phy_on_suspend_workaround(struct usb_phy *phy,
> +		enum usb_device_speed speed)
> +{
> +	dev_dbg(phy->dev, "%s speed device has suspended\n",
> +		(speed == USB_SPEED_HIGH) ? "high" : "non-high");

HS : FS/LS you mean?

> +
> +	/* delay 4ms to wait bus entering idle */
> +	usleep_range(4000, 5000);
> +
> +	/*
> +	 * Workaround for wakeup signal between portsc.suspendM
> +	 * and PHY enters low power mode.
> +	 */
> +	writel_relaxed(0xffffffff, phy->io_priv + HW_USBPHY_PWD);
> +	writel_relaxed(0, phy->io_priv + HW_USBPHY_PWD);
> +
> +	if (speed == USB_SPEED_HIGH)
> +		writel_relaxed(BM_USBPHY_CTRL_ENHOSTDISCONDETECT,
> +				phy->io_priv + HW_USBPHY_CTRL_CLR);
> +
> +	return 0;
> +}

[...]

> +/*
> + * For mxs PHY, there are two PHY issues related to suspend/resume.
> + * For mx23 and mx28, both of two issues are existed.
> + * For mx6q and mx6dl, only one issue is existed.
> + * For mx6 sololite, none issue is existed.
> + */
> +static void mxs_phy_workaround(struct mxs_phy *mxs_phy)
> +{
> +	if (is_mx23_phy(mxs_phy)) {

This is_mx23_phy() returns 1 for mx28 too? It's not too clear, not even from the 
comment above, a short comment here would help for sure.

> +		mxs_phy->phy.notify_suspend = mxs_phy_on_suspend_workaround;
> +		mxs_phy->phy.notify_resume = mxs_phy_on_resume;
> +	} else if (is_mx6q_phy(mxs_phy)) {
> +		mxs_phy->phy.notify_suspend = mxs_phy_on_suspend;
> +		mxs_phy->phy.notify_resume = mxs_phy_on_resume;
> +	}
> +}
> +
>  static int mxs_phy_probe(struct platform_device *pdev)
>  {
>  	struct resource *res;
> @@ -257,6 +329,7 @@ static int mxs_phy_probe(struct platform_device *pdev)
> 
>  	mxs_phy->clk = clk;
>  	mxs_phy->devtype = pdev->id_entry->driver_data;
> +	mxs_phy_workaround(mxs_phy);
> 
>  	platform_set_drvdata(pdev, &mxs_phy->phy);
