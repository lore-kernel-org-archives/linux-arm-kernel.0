From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 14 Aug 2015 23:19:46 +0200
Subject: [PATCH 2/3] Display a DMA error message
In-Reply-To: <1439416290-21228-3-git-send-email-jeremy.linton@arm.com>
References: <1439416290-21228-1-git-send-email-jeremy.linton@arm.com>
 <1439416290-21228-3-git-send-email-jeremy.linton@arm.com>
Message-ID: <2099290.n6l88bWDgg@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 12 August 2015 16:51:29 Jeremy Linton wrote:
> diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
> index 2593def..82e396f 100644
> --- a/drivers/usb/host/ehci-platform.c
> +++ b/drivers/usb/host/ehci-platform.c
> @@ -162,8 +162,10 @@ static int ehci_platform_probe(struct platform_device *dev)
>  
>         err = dma_coerce_mask_and_coherent(&dev->dev,
>                 pdata->dma_mask_64 ? DMA_BIT_MASK(64) : DMA_BIT_MASK(32));
> -       if (err)
> +       if (err) {
> +               dev_err(&dev->dev, "Error: DMA setup failed\n");
>                 return err;
> +       }

We should really stop doing this: the platform should provide the
correct dma mask when creating the device, instead of setting a
bogus pdata field. Do not duplicate this bug for ACPI.

	Arnd
