From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 8 Oct 2013 09:22:43 +0530
Subject: [PATCH] DMA: extend documentation to provide more API details
In-Reply-To: <Pine.LNX.4.64.1310072244030.27047@axis700.grange>
References: <Pine.LNX.4.64.1310071233340.20796@axis700.grange>
 <20131007111728.GM12758@n2100.arm.linux.org.uk>
 <20131007103936.GH2954@intel.com>
 <Pine.LNX.4.64.1310071409080.20796@axis700.grange>
 <20131007142511.GJ2954@intel.com>
 <Pine.LNX.4.64.1310071725300.20796@axis700.grange>
 <20131007144335.GL2954@intel.com>
 <Pine.LNX.4.64.1310071739590.20796@axis700.grange>
 <20131007155229.GN2954@intel.com>
 <Pine.LNX.4.64.1310072244030.27047@axis700.grange>
Message-ID: <20131008035243.GO2954@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 07, 2013 at 10:55:56PM +0200, Guennadi Liakhovetski wrote:
> > > > > > > > > > No, not something in the middle. I was thinking about
> > > > > > > > > > 
> > > > > > > > > > (1) cookie 1-3 are submitted
> > > > > > > > > > (2) cookie 1 succeeds
> > > > > > > > > > (3) a DMA error occurs, cookies 2-3 are discarded
> > > > > > > > discarded using terminate_all right?
> > > > > > > 
> > > > > > > No, by the dmaengine driver as a part of the error processing.
> > > > > > And how will that be done...?
> > > > > 
> > > > > Sorry, I meant - DMA descriptors with cookies #2 and #3 will be cancelled 
> > > > > and recycled by the dmaengine driver. That's what you have to do, when 
> > > > > processing DMA error IRQ.
> > > > Well how do you that?
> > > 
> > > Mmmh, maybe I'm missing something, but isn't it a part of the common DMA 
> > > processing? You get an error IRQ; on some DMAC types this means, that you 
> > > have to reset the hardware, so, you perform whatever actions you have to 
> > > do to reset the controller; you remove any descriptors from the pending 
> > > queue; reinsert them into the free queue and let any clients run on a 
> > > timeout. I don't think it would be a good idea to do anything more smart 
> > > like trying to restart the current transfer or drop it and continue with 
> > > the queue, because we don't know in what state the client hardware is, so, 
> > > we can only let the client driver try to recover.
> > No that would be very wrong thing to do behind clients back. Suppose you got a
> > trasaction which returned error irq and it was generated one half of the
> > requested transfer was done. Redoing the entrie transaction wont be right!
> > 
> > So I think you need to let client know the error status.
> > 
> > But again, is this usage fiarly common?
> 
> Hm, I think, the question is different: is this possible and realistic? If 
> there's just one DMAC and one platform, I think, there should be a way to 
> support it? There are controllers, that actually have separate error IRQ 
> outputs and special status bits for them. Actually, see commit
Fair enough, if this is something you commonly need to deal with then lets add a
new callback for error reporting. I think this would be simpler and then client
will know about the failure

On failure reporting the client should query the status to know what is pending
for this transaction then recover accordingly

Will send patch for this and moving to DMA_COMPLETE as status

--
~Vinod
