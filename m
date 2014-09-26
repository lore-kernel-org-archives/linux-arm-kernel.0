From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 26 Sep 2014 09:01:49 +0200
Subject: [PATCH v6 07/12] usb: chipidea: add a usb2 driver for ci13xxx
In-Reply-To: <20140926002339.GB3026@peterchendt>
References: <1411468088-5702-1-git-send-email-antoine.tenart@free-electrons.com>
 <3696520.MDUrkdjfGZ@wuerfel> <20140926002339.GB3026@peterchendt>
Message-ID: <202048167.dt5r3yRThs@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 26 September 2014 08:23:40 Peter Chen wrote:
> In current chipidea structure, the parent (glue layer) driver will not be
> used for dma, udc/host driver uses dma mask from child (core layer), at core
> layer we will do:
> 
> 
>         pdev->dev.dma_mask = dev->dma_mask; /* this device is parent */
>         dma_set_coherent_mask(&pdev->dev, dev->coherent_dma_mask);
> 
> Would you suggestion us a suitable way? Or it is ok we use just Antoine's way that
> call dma_coerce_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32)) at parent
> driver no matter dt or non-dt? Thanks.

dma_coerce_mask_and_coherent is not ok, it will force a dma mask that is
unrelated to the actual requirements of the hardware.

I think the best way would be to never use the child device pointer for
DMA operations, just use a pointer to the parent device and make the
child dev->dma_mask pointer NULL to ensure all DMA operations fail.

	Arnd
