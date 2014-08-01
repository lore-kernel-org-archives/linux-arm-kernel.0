From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Fri, 01 Aug 2014 19:01:08 +0200
Subject: [PATCH] dmaengine: Remove the context argument to the
 prep_dma_cyclic operation
In-Reply-To: <20140801164428.GB8181@intel.com>
References: <1406888410-14504-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <20140801164428.GB8181@intel.com>
Message-ID: <20109653.z2OVfR07am@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

On Friday 01 August 2014 22:14:28 Vinod Koul wrote:
> On Fri, Aug 01, 2014 at 12:20:10PM +0200, Laurent Pinchart wrote:
> > The argument is always set to NULL and never used. Remove it.
> 
> Thats not true.
> 
> It was introduced in commit:
> commit 185ecb5f4fd43911c35956d4cc7d94a1da30417f
> Author: Alexandre Bounine <alexandre.bounine@idt.com>
> Date:   Thu Mar 8 15:35:13 2012 -0500
> 
>     dmaengine: add context parameter to prep_slave_sg and prep_dma_cyclic
> 
>     Add context parameter to device_prep_slave_sg() and
> device_prep_dma_cyclic() interfaces to allow passing client/target specific
> information associated with the data transfer.
>     Modify all affected DMA engine drivers.
> 
>     Signed-off-by: Alexandre Bounine <alexandre.bounine@idt.com>
>     Acked-by: Linus Walleij <linus.walleij@linaro.org>
>     Acked-by: Felipe Balbi <balbi@ti.com>
>     Signed-off-by: Vinod Koul <vinod.koul@linux.intel.com>
> 
> This is still used by rapidio driver. This required some extra parameters
> passed in struct rio_dma_ext.

As far as I can see, rapidio uses the context argument for prep_slave_sg only, 
not for prep_dma_cyclic. This patch addresses prep_dma_cyclic only.

> I do agree this is not very elegant.

Indeed :-)

What would you think about a prep_rio_slave_sg operation ?

> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> > ---
> > 
> >  drivers/dma/amba-pl08x.c      | 2 +-
> >  drivers/dma/at_hdmac.c        | 3 +--
> >  drivers/dma/bcm2835-dma.c     | 2 +-
> >  drivers/dma/dma-jz4740.c      | 2 +-
> >  drivers/dma/edma.c            | 2 +-
> >  drivers/dma/ep93xx_dma.c      | 4 +---
> >  drivers/dma/fsl-edma.c        | 2 +-
> >  drivers/dma/imx-dma.c         | 2 +-
> >  drivers/dma/imx-sdma.c        | 2 +-
> >  drivers/dma/mmp_pdma.c        | 2 +-
> >  drivers/dma/mmp_tdma.c        | 2 +-
> >  drivers/dma/mxs-dma.c         | 2 +-
> >  drivers/dma/omap-dma.c        | 3 +--
> >  drivers/dma/pl330.c           | 2 +-
> >  drivers/dma/s3c24xx-dma.c     | 3 +--
> >  drivers/dma/sa11x0-dma.c      | 2 +-
> >  drivers/dma/sh/shdma-base.c   | 2 +-
> >  drivers/dma/sirf-dma.c        | 2 +-
> >  drivers/dma/ste_dma40.c       | 3 +--
> >  drivers/dma/tegra20-apb-dma.c | 2 +-
> >  include/linux/dmaengine.h     | 4 ++--
> >  21 files changed, 22 insertions(+), 28 deletions(-)

-- 
Regards,

Laurent Pinchart
