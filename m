From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Wed, 12 Dec 2012 16:04:18 +0100
Subject: [PATCH 4/4] DMA: PL330: add device tree property for DMA_MEMCPY
 capability
In-Reply-To: <CABb+yY0FxsZyBy=scTF31+QMWgHzKf7bNz8vsPowtiMkve7igg@mail.gmail.com>
References: <1351504796-24788-1-git-send-email-b.zolnierkie@samsung.com>
 <201211301156.08060.b.zolnierkie@samsung.com>
 <CABb+yY0FxsZyBy=scTF31+QMWgHzKf7bNz8vsPowtiMkve7igg@mail.gmail.com>
Message-ID: <201212121604.19112.b.zolnierkie@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

On Wednesday 12 December 2012 08:36:14 Jassi Brar wrote:
> On Fri, Nov 30, 2012 at 4:26 PM, Bartlomiej Zolnierkiewicz
> <b.zolnierkie@samsung.com> wrote:
> 
> > Thank you for explaining it.  Here is a patch implementing the idea:
> >
> > From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > Subject: [PATCH] DMA: PL330: add peripherals map to the device tree
> >
> > Add device tree (DT) property ("peri-map") for storing indices
> > of peripherals connected to DMAC and fix DT nodes of client
> > drivers to use 'dma peripheral id' instead of 'dma request id'.
> > Also instead of setting DMA_MEMCPY capability unconditionally in
> > pl330_probe() do it only when "peri-map" DT property is present
> > (idea from Jassi Brar).  It fixes the issue on ARM EXYNOS
> > platforms using DT where pdma controller erroneously was used
> > for DMA_MEMCPY operations instead of mdma one (it seems to work
> > correctly but at the cost of worse performance).
> >
> Sorry, we need to change it as per new generic dma DT bindings
>   http://git.infradead.org/users/vkoul/slave-dma.git/blob/refs/heads/next:/Documentation/devicetree/bindings/dma/dma.txt

>From looking at the new generic DMA DT bindings code it seems that:

- There is no way to specify different mappings of DMA request signals
  for different DMA controllers using the same driver (cause different
  of_dma_xlate translation functions would be needed in place of
  "peri-map" DT properties).

- There is no way to distinguish DMA capabilities for different DMA
  controllers using the same driver (i.e. differentiate between
  DMA_MEMCPY and DMA_SLAVE controllers, which is what I really wanted
  to fix in the first place; now it seems that in order to add this
  relatively trivial change I would have to do a major rewrite of
  the whole DT support for PL330, hmmm...).

Could you please describe how I should proceed with implementing 
needed functionality in the PL330 driver or/and generic DMA DT layer?

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung Poland R&D Center
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121212/01eb2dcb/attachment-0001.html>
