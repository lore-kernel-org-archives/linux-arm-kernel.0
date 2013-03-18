From: stern@rowland.harvard.edu (Alan Stern)
Date: Mon, 18 Mar 2013 12:03:35 -0400 (EDT)
Subject: [RFC] USB: EHCI: hot-fix OMAP and Orion multiplatform config
In-Reply-To: <201303152011.26414.arnd@arndb.de>
Message-ID: <Pine.LNX.4.44L0.1303181156150.1922-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 15 Mar 2013, Arnd Bergmann wrote:

> > Instead of adding these tests for non-NULL pdata all over the place, 
> > you could define a static structure with default settings and store a 
> > pointer to it if pdata wasn't set initially.
> 
> Yes, good idea. Here is a new version. Maybe Alexey or Tony can verify if
> that works for them on wm8850. That should be independent of the decision
> into which kernel to merge this patch.

On the whole this looks good (and a lot nicer than the first version).  
However there is one bug...

> +static struct usb_ehci_pdata ehci_platform_defaults;
> +
>  static int ehci_platform_probe(struct platform_device *dev)
>  {
>  	struct usb_hcd *hcd;
>  	struct resource *res_mem;
> -	struct usb_ehci_pdata *pdata = dev->dev.platform_data;
> +	struct usb_ehci_pdata *pdata;
>  	int irq;
>  	int err = -ENOMEM;
>  
> -	if (!pdata) {
> -		WARN_ON(1);
> -		return -ENODEV;
> -	}
> -
>  	if (usb_disabled())
>  		return -ENODEV;
>  
> +	if (!dev->dev.platform_data) {
> +		dev->dev.platform_data = &ehci_platform_defaults;

If the ehci-platform module is unloaded and then reloaded at a
different address, the stale pointer will cause an invalid memory
reference.  ehci_platform_remove() needs to set dev->dev.platform_data
back to NULL if it is equal to &ehci_platform_defaults.

Once that is fixed, you can add

Acked-by: Alan Stern <stern@rowland.harvard.edu>

Alan Stern
