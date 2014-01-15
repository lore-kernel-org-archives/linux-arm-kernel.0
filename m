From: stern@rowland.harvard.edu (Alan Stern)
Date: Wed, 15 Jan 2014 11:30:11 -0500 (EST)
Subject: [PATCH v6 1/2] ohci-platform: Add support for devicetree
 instantiation
In-Reply-To: <1389802104-17330-2-git-send-email-hdegoede@redhat.com>
Message-ID: <Pine.LNX.4.44L0.1401151123340.1587-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 15 Jan 2014, Hans de Goede wrote:

> +static int ohci_platform_power_on(struct platform_device *dev)
> +{
> +	struct usb_hcd *hcd = platform_get_drvdata(dev);
> +	struct ohci_platform_priv *priv = hcd_to_ohci_priv(hcd);
> +	int clk, ret;
> +
> +	for (clk = 0; clk < OHCI_MAX_CLKS && priv->clks[clk]; clk++) {

You fixed this one...

> @@ -125,13 +225,22 @@ static int ohci_platform_remove(struct platform_device *dev)
>  {
>  	struct usb_hcd *hcd = platform_get_drvdata(dev);
>  	struct usb_ohci_pdata *pdata = dev_get_platdata(&dev->dev);
> +	struct ohci_platform_priv *priv = hcd_to_ohci_priv(hcd);
> +	int clk;
>  
>  	usb_remove_hcd(hcd);
> -	usb_put_hcd(hcd);
>  
>  	if (pdata->power_off)
>  		pdata->power_off(dev);
>  
> +	for (clk = 0; priv->clks[clk] && clk < OHCI_MAX_CLKS; clk++)

but not this one.  :-(  Same for the ehci-platform patch.

In fact, it might be easier to make this loop go backward, like
you do in the *_platform_power_off routines.

Is there a devm-type routine that will take care of all this for you?

Alan Stern
