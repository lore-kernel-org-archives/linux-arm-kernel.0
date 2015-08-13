From: stern@rowland.harvard.edu (Alan Stern)
Date: Thu, 13 Aug 2015 10:52:56 -0400 (EDT)
Subject: [PATCH 2/3] Display a DMA error message
In-Reply-To: <1439416290-21228-3-git-send-email-jeremy.linton@arm.com>
Message-ID: <Pine.LNX.4.44L0.1508131051500.1277-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 12 Aug 2015, Jeremy Linton wrote:

> If the ehci driver fails to configure the dma settings then display
> a dev error instead of simply failing. This is triggered in an
> ACPI world if the user fails to set the _CCA on the device.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  drivers/usb/host/ehci-platform.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
> index 2593def..82e396f 100644
> --- a/drivers/usb/host/ehci-platform.c
> +++ b/drivers/usb/host/ehci-platform.c
> @@ -162,8 +162,10 @@ static int ehci_platform_probe(struct platform_device *dev)
>  
>  	err = dma_coerce_mask_and_coherent(&dev->dev,
>  		pdata->dma_mask_64 ? DMA_BIT_MASK(64) : DMA_BIT_MASK(32));
> -	if (err)
> +	if (err) {
> +		dev_err(&dev->dev, "Error: DMA setup failed\n");
>  		return err;
> +	}
>  
>  	irq = platform_get_irq(dev, 0);
>  	if (irq < 0) {
> 

Too bad the ohci-platform driver doesn't get the same update, but 
it clearly wouldn't belong in this patch set.  Anyway,

Acked-by: Alan Stern <stern@rowland.harvard.edu>

Alan Stern
