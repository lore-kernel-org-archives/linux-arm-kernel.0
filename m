From: stern@rowland.harvard.edu (Alan Stern)
Date: Mon, 28 Jan 2013 10:40:24 -0500 (EST)
Subject: [PATCH v2 10/30] USB: ehci-omap: Use PHY APIs to get the PHY
 device and put it out of suspend
In-Reply-To: <1359372631-8180-11-git-send-email-rogerq@ti.com>
Message-ID: <Pine.LNX.4.44L0.1301281034060.1997-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 28 Jan 2013, Roger Quadros wrote:

> For each port that is in PHY mode we obtain a PHY device using the USB PHY
> library and put it out of suspend.
> 
> It is upto platform code to associate the PHY to the controller's
> port and it is upto the PHY driver to manage the PHY's resources.

"up to" is two words, not one.

> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  drivers/usb/host/ehci-omap.c |   54 ++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 54 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
> index fd2f5450..a35e44e 100644
> --- a/drivers/usb/host/ehci-omap.c
> +++ b/drivers/usb/host/ehci-omap.c
> @@ -70,6 +70,11 @@ static const char hcd_name[] = "ehci-omap";
>  
>  /*-------------------------------------------------------------------------*/
>  
> +struct omap_hcd {
> +	struct usb_hcd *hcd;

This pointer is not needed any more.

> +	struct usb_phy **phy;	/* one PHY for each port */
> +	int nports;

Is there a reasonable upper limit on the number of ports?  If there is 
you could just put a fixed-size array here.

> @@ -233,6 +240,39 @@ static int ehci_hcd_omap_probe(struct platform_device *pdev)
>  	hcd->rsrc_len = resource_size(res);
>  	hcd->regs = regs;
>  
> +	omap = (struct omap_hcd *)hcd_to_ehci(hcd)->priv;
> +	omap->nports = pdata->nports;
> +	i = sizeof(struct usb_phy *) * omap->nports;
> +	omap->phy = devm_kzalloc(&pdev->dev, i, GFP_KERNEL);
> +	if (!omap->phy) {
> +		dev_err(dev, "Memory allocation failed\n");
> +		return -ENOMEM;

You have to put a "goto" here, not a "return".  The hcd must be cleaned 
up properly.

> @@ -295,11 +342,18 @@ static int ehci_hcd_omap_remove(struct platform_device *pdev)
>  {
>  	struct device *dev				= &pdev->dev;
>  	struct usb_hcd *hcd				= dev_get_drvdata(dev);
> +	struct omap_hcd *omap = (struct omap_hcd *)hcd_to_ehci(hcd)->priv;

What's with the weird spacing in the first two declarations?  This 
isn't a typeset document where the paragraphs need to be fully 
justified.  :-)

> +	int i;
>  
>  	usb_remove_hcd(hcd);
>  	disable_put_regulator(dev->platform_data);
>  	usb_put_hcd(hcd);

This line must be moved down.  When the hcd is deallocated, the
omap_hcd structure goes with it.

> +	for (i = 0; i < omap->nports; i++) {
> +		if (omap->phy[i])
> +			usb_phy_shutdown(omap->phy[i]);
> +	}
> +

Alan Stern
