From: stern@rowland.harvard.edu (Alan Stern)
Date: Wed, 7 Sep 2016 12:08:20 -0400 (EDT)
Subject: [PATCH] usb: dwc3: host: inherit dma configuration from parent dev
In-Reply-To: <3189648.KnWLgq0lTY@wuerfel>
Message-ID: <Pine.LNX.4.44L0.1609071158160.2115-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 7 Sep 2016, Arnd Bergmann wrote:

> However, to summarize the discussion so far, I agree that
> of_dma_configure() is not the solution to these problems, and I think
> we can do much better:
> 
> Splitting the usb_bus->controller field into the Linux-internal device
> (used for the sysfs hierarchy, for printks and for power management)
> and a new pointer (used for DMA, DT enumeration and phy lookup) probably
> covers all that we really need.
> 
> I've prototyped it below, with the dwc3, xhci and chipidea changes
> together with the core changes. I've surely made mistakes there and
> don't expect it to work out of the box, but this should give an
> idea of how I think this can all be solved in the least invasive
> way.
> 
> I noticed that the gadget interface already has a way to handle the
> DMA allocation by device, so I added that in as well.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
>  drivers/usb/chipidea/core.c    |  4 ----
>  drivers/usb/chipidea/host.c    |  3 ++-
>  drivers/usb/chipidea/udc.c     |  8 ++++----
>  drivers/usb/core/buffer.c      | 12 ++++++------
>  drivers/usb/core/hcd.c         | 48 +++++++++++++++++++++++++++++-------------------
>  drivers/usb/core/usb.c         | 16 ++++++++--------
>  drivers/usb/dwc3/core.c        | 28 +++++++++++++++-------------
>  drivers/usb/dwc3/core.h        |  1 +
>  drivers/usb/dwc3/dwc3-exynos.c | 10 ----------
>  drivers/usb/dwc3/dwc3-st.c     |  1 -
>  drivers/usb/dwc3/ep0.c         |  8 ++++----
>  drivers/usb/dwc3/gadget.c      | 34 +++++++++++++++++-----------------
>  drivers/usb/dwc3/host.c        | 13 ++++---------
>  drivers/usb/host/ehci-fsl.c    |  4 ++--

How did this driver end up in the patch?

>  drivers/usb/host/xhci-plat.c   | 32 +++++++++++++++++++++++++-------
>  include/linux/usb.h            |  1 +
>  include/linux/usb/hcd.h        |  3 +++

> diff --git a/drivers/usb/host/ehci-fsl.c b/drivers/usb/host/ehci-fsl.c
> index 9f5ffb629973..b2419950221f 100644
> --- a/drivers/usb/host/ehci-fsl.c
> +++ b/drivers/usb/host/ehci-fsl.c
> @@ -96,8 +96,8 @@ static int fsl_ehci_drv_probe(struct platform_device *pdev)
>  	}
>  	irq = res->start;
>  
> -	hcd = usb_create_hcd(&fsl_ehci_hc_driver, &pdev->dev,
> -				dev_name(&pdev->dev));
> +	hcd = __usb_create_hcd(&fsl_ehci_hc_driver, &pdev->dev.parent,
> +				&pdev->dev, dev_name(&pdev->dev), NULL);

Based on the

	if (of_device_is_compatible(dev->parent->of_node,
				    "fsl,mpc5121-usb2-dr")) {

lines in the driver?

>  	if (!hcd) {
>  		retval = -ENOMEM;
>  		goto err1;

Alan Stern
