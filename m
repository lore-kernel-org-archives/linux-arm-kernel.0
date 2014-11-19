From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Nov 2014 13:48:58 +0100
Subject: For the problem when using swiotlb
In-Reply-To: <20141119112910.GD7156@e104818-lin.cambridge.arm.com>
References: <5469E26B.2010905@huawei.com> <1535751.CcvIi3DN4F@wuerfel>
 <20141119112910.GD7156@e104818-lin.cambridge.arm.com>
Message-ID: <1497289.TPKf3qDiKk@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 19 November 2014 11:29:10 Catalin Marinas wrote:
> > The driver should call 'dma_set_mask_and_coherent()' with the appropriate
> > dma mask, and check whether that succeeded. However, the code implementing
> > dma_set_mask_and_coherent on arm64 also needs to be changed to look up
> > the dma-ranges property (see of_dma_configure()), and check if the mask
> > is possible.
> 
> dma_set_mask_and_coherent() is a generic function. I think the
> of_dma_configure() should start with a coherent_dma_mask based on
> dma-ranges if given rather than defaulting to DMA_BIT_MASK(32). The
> comment in of_dma_configure() says that devices should set up the
> supported mask but it's not always up to them but the bus they are
> connected to.
> 
> Something like below, untested:
> 
> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> index 3b64d0bf5bba..dff34883db45 100644
> --- a/drivers/of/platform.c
> +++ b/drivers/of/platform.c
> @@ -200,6 +200,10 @@ static void of_dma_configure(struct device *dev)
>         /* DMA ranges found. Calculate and set dma_pfn_offset */
>         dev->dma_pfn_offset = PFN_DOWN(paddr - dma_addr);
>         dev_dbg(dev, "dma_pfn_offset(%#08lx)\n", dev->dma_pfn_offset);
> +
> +       /* Set the coherent_dma_mask based on the dma-ranges property */
> +       if (size)
> +               dev->coherent_dma_mask = DMA_BIT_MASK(ilog2(size));
>  }
>  
> 

We have discussed this in the past, and the problem with this is
that the actual mask depends both on the capabilities of the
device and the bus. In particular, if the device can only do
32-bit DMA, we must not set the mask to something higher.

The normal rule here is that a driver that wants to do 64-bit
DMA must call dma_set_mask_and_coherent() with the higher mask,
while a device that can not access all of the 32-bit address space
must call dma_set_mask_and_coherent() with the smaller mask
before doing calling any of the other DMA interfaces.

However, if the bus is not capable of addressing the entire
32-bit range (as on some modern shmobile machines, or some of the
really old machines), we need to limit the mask here already.

	Arnd
