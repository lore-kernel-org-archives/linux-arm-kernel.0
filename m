From: stern@rowland.harvard.edu (Alan Stern)
Date: Mon, 23 Sep 2013 14:27:39 -0400 (EDT)
Subject: [PATCH 36/51] DMA-API: usb: use dma_set_coherent_mask()
In-Reply-To: <E1VMmHX-0007jq-Cj@rmk-PC.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44L0.1309231418030.1348-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 19 Sep 2013, Russell King wrote:

> The correct way for a driver to specify the coherent DMA mask is
> not to directly access the field in the struct device, but to use
> dma_set_coherent_mask().  Only arch and bus code should access this
> member directly.
> 
> Convert all direct write accesses to using the correct API.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

> diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
> index f6b790c..5b0cd2d 100644
> --- a/drivers/usb/host/ehci-platform.c
> +++ b/drivers/usb/host/ehci-platform.c

> @@ -91,8 +91,9 @@ static int ehci_platform_probe(struct platform_device *dev)
>  		dev->dev.platform_data = &ehci_platform_defaults;
>  	if (!dev->dev.dma_mask)
>  		dev->dev.dma_mask = &dev->dev.coherent_dma_mask;
> -	if (!dev->dev.coherent_dma_mask)
> -		dev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
> +	err = dma_set_coherent_mask(&dev->dev, DMA_BIT_MASK(32));
> +	if (err)
> +		return err;
>  
>  	pdata = dev_get_platdata(&dev->dev);

ehci-platform.c is a generic file, intended for use by multiple
platforms.  Is it not possible that on some platforms, the arch or bus
code may already have initialized the DMA masks?  Isn't something like 
this (i.e., DMA bindings) planned for Device Tree?

By eliminating the tests above and calling dma_set_coherent_mask or
dma_coerce_mask_and_coherent unconditionally, this patch (and the next)
would overwrite those initial settings.

I don't know to what extent the same may be true for the other,
platform-specific, drivers changed by this patch.  But it's something 
to be aware of.

Alan Stern
