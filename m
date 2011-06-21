From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 21 Jun 2011 13:47:03 +0200
Subject: [Linaro-mm-sig] [PATCH 3/8] ARM: dma-mapping: use
	asm-generic/dma-mapping-common.h
In-Reply-To: <BANLkTimHE2jzQAav465WaG3iWVeHPyNRNQ@mail.gmail.com>
References: <1308556213-24970-1-git-send-email-m.szyprowski@samsung.com>
	<1308556213-24970-4-git-send-email-m.szyprowski@samsung.com>
	<BANLkTimHE2jzQAav465WaG3iWVeHPyNRNQ@mail.gmail.com>
Message-ID: <002501cc3008$f000d600$d0028200$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Monday, June 20, 2011 4:33 PM KyongHo Cho wrote:

> On Mon, Jun 20, 2011 at 4:50 PM, Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
> > +static inline void set_dma_ops(struct device *dev, struct dma_map_ops
> *ops)
> > +{
> > + ? ? ? dev->archdata.dma_ops = ops;
> > +}
> > +
> 
> Who calls set_dma_ops()?
> In the mach. initialization part?

Yes, some board, machine or device bus initialization code is supposed to
call this function. Just 'git grep dma_set_ops' and you will see. In my
patch series one of the clients of set_dma_ops function is dmabounce 
framework (it is called in dmabounce_register_dev() function).

> What if a device driver does not want to use arch's dma_map_ops
> when machine init procedure set a dma_map_ops?

Could you elaborate on this case? The whole point of dma-mapping framework
is to hide the implementation of DMA mapping operation from the driver. 
The driver should never fiddle with dma map ops directly.

> Even though, may arch defiens their dma_map_ops in archdata of device
> structure,
> I think it is not a good idea that is device structure contains a
> pointer to dma_map_ops
> that may not be common to all devices in a board.

It is up to the board/bus startup code to set dma ops correctly.

> I also think that it is better to attach and to detach dma_map_ops
> dynamically.

What's the point of such operations? Why do you want to change dma
mapping methods in runtime?

> Moreover, a mapping is not permanent in our Exynos platform
> because a System MMU may be turned off while runtime.

This is theoretically possible. The System MMU (Samsung IOMMU
controller) driver can change dma_map_ops back to NULL on remove moving
back the client device to generic ARM dma mapping implementation.

> DMA API must come with IOMMU API to initialize IOMMU in runtime.

I don't understand what's the problem here. 

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
