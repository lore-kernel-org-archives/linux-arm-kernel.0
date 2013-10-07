From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Mon, 7 Oct 2013 22:55:56 +0200 (CEST)
Subject: [PATCH] DMA: extend documentation to provide more API details
In-Reply-To: <20131007155229.GN2954@intel.com>
References: <20131005233137.GA12758@n2100.arm.linux.org.uk>
 <20131006052029.GE2954@intel.com>
 <Pine.LNX.4.64.1310071233340.20796@axis700.grange>
 <20131007111728.GM12758@n2100.arm.linux.org.uk>
 <20131007103936.GH2954@intel.com>
 <Pine.LNX.4.64.1310071409080.20796@axis700.grange>
 <20131007142511.GJ2954@intel.com>
 <Pine.LNX.4.64.1310071725300.20796@axis700.grange>
 <20131007144335.GL2954@intel.com>
 <Pine.LNX.4.64.1310071739590.20796@axis700.grange>
 <20131007155229.GN2954@intel.com>
Message-ID: <Pine.LNX.4.64.1310072244030.27047@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 7 Oct 2013, Vinod Koul wrote:

> On Mon, Oct 07, 2013 at 05:45:22PM +0200, Guennadi Liakhovetski wrote:
> > On Mon, 7 Oct 2013, Vinod Koul wrote:
> > 
> > > On Mon, Oct 07, 2013 at 05:28:37PM +0200, Guennadi Liakhovetski wrote:
> > > > > > > > > No, not something in the middle. I was thinking about
> > > > > > > > > 
> > > > > > > > > (1) cookie 1-3 are submitted
> > > > > > > > > (2) cookie 1 succeeds
> > > > > > > > > (3) a DMA error occurs, cookies 2-3 are discarded
> > > > > > > discarded using terminate_all right?
> > > > > > 
> > > > > > No, by the dmaengine driver as a part of the error processing.
> > > > > And how will that be done...?
> > > > 
> > > > Sorry, I meant - DMA descriptors with cookies #2 and #3 will be cancelled 
> > > > and recycled by the dmaengine driver. That's what you have to do, when 
> > > > processing DMA error IRQ.
> > > Well how do you that?
> > 
> > Mmmh, maybe I'm missing something, but isn't it a part of the common DMA 
> > processing? You get an error IRQ; on some DMAC types this means, that you 
> > have to reset the hardware, so, you perform whatever actions you have to 
> > do to reset the controller; you remove any descriptors from the pending 
> > queue; reinsert them into the free queue and let any clients run on a 
> > timeout. I don't think it would be a good idea to do anything more smart 
> > like trying to restart the current transfer or drop it and continue with 
> > the queue, because we don't know in what state the client hardware is, so, 
> > we can only let the client driver try to recover.
> No that would be very wrong thing to do behind clients back. Suppose you got a
> trasaction which returned error irq and it was generated one half of the
> requested transfer was done. Redoing the entrie transaction wont be right!
> 
> So I think you need to let client know the error status.
> 
> But again, is this usage fiarly common?

Hm, I think, the question is different: is this possible and realistic? If 
there's just one DMAC and one platform, I think, there should be a way to 
support it? There are controllers, that actually have separate error IRQ 
outputs and special status bits for them. Actually, see commit

commit 47a4dc26eeb89a3746f9b1e2092602b40469640a
Author: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date:   Thu Feb 11 16:50:05 2010 +0000

    dmaengine: shdma: fix DMA error handling.

Which means, there are indeed real life situations when such error IRQs 
trigger.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
