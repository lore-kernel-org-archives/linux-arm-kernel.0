From: julian.calaby@gmail.com (Julian Calaby)
Date: Fri, 9 Jun 2017 00:22:48 +1000
Subject: [PATCH 28/44] sparc: remove arch specific dma_supported
 implementations
In-Reply-To: <20170608132609.32662-29-hch@lst.de>
References: <20170608132609.32662-1-hch@lst.de>
 <20170608132609.32662-29-hch@lst.de>
Message-ID: <CAGRGNgUJ3J_LEwhJ1rFHuzZ_J4OnTV9-DekcuT=N5z1pBKcb3A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christoph,

On Thu, Jun 8, 2017 at 11:25 PM, Christoph Hellwig <hch@lst.de> wrote:
> Usually dma_supported decisions are done by the dma_map_ops instance.
> Switch sparc to that model by providing a ->dma_supported instance for
> sbus that always returns false, and implementations tailored to the sun4u
> and sun4v cases for sparc64, and leave it unimplemented for PCI on
> sparc32, which means always supported.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/sparc/include/asm/dma-mapping.h |  3 ---
>  arch/sparc/kernel/iommu.c            | 40 +++++++++++++++---------------------
>  arch/sparc/kernel/ioport.c           | 22 ++++++--------------
>  arch/sparc/kernel/pci_sun4v.c        | 17 +++++++++++++++
>  4 files changed, 39 insertions(+), 43 deletions(-)
>
> diff --git a/arch/sparc/kernel/ioport.c b/arch/sparc/kernel/ioport.c
> index dd081d557609..12894f259bea 100644
> --- a/arch/sparc/kernel/ioport.c
> +++ b/arch/sparc/kernel/ioport.c
> @@ -401,6 +401,11 @@ static void sbus_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
>         BUG();
>  }
>
> +static int sbus_dma_supported(struct device *dev, u64 mask)
> +{
> +       return 0;
> +}
> +

I'm guessing there's a few places that have DMA ops but DMA isn't
actually supported. Why not have a common method for this, maybe
"dma_not_supported"?

>  static const struct dma_map_ops sbus_dma_ops = {
>         .alloc                  = sbus_alloc_coherent,
>         .free                   = sbus_free_coherent,
> @@ -410,6 +415,7 @@ static const struct dma_map_ops sbus_dma_ops = {
>         .unmap_sg               = sbus_unmap_sg,
>         .sync_sg_for_cpu        = sbus_sync_sg_for_cpu,
>         .sync_sg_for_device     = sbus_sync_sg_for_device,
> +       .dma_supported          = sbus_dma_supported,
>  };
>
>  static int __init sparc_register_ioport(void)

Thanks,

-- 
Julian Calaby

Email: julian.calaby at gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
