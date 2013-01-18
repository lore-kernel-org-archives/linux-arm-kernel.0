From: lkundrak@v3.sk (Lubomir Rintel)
Date: Fri, 18 Jan 2013 08:45:54 +0100
Subject: [PATCH 2/2] dma: mv_xor: do not sync the DMA buffer after
 being deallocated
In-Reply-To: <1358083137.13136.1.camel@hobbes>
References: <1356636228-23096-1-git-send-email-lkundrak@v3.sk>
 <1356636228-23096-2-git-send-email-lkundrak@v3.sk>
 <20130104171033.4a244c3d@skate>  <1358083137.13136.1.camel@hobbes>
Message-ID: <1358495154.28503.5.camel@unicorn>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2013-01-13 at 14:18 +0100, Lubomir Rintel wrote:
> On Fri, 2013-01-04 at 17:10 +0100, Thomas Petazzoni wrote:
> > Dear Lubomir Rintel,
> > 
> > On Thu, 27 Dec 2012 20:23:48 +0100, Lubomir Rintel wrote:
> > 
> > >  	dma_sync_single_for_cpu(dma_chan->device->dev, dest_dma,
> > >  				MV_XOR_TEST_SIZE, DMA_FROM_DEVICE);
> > > +	dma_unmap_single(dma_chan->device->dev, dest_dma, MV_XOR_TEST_SIZE,
> > > +			 DMA_FROM_DEVICE);
> > 
> > I would assume that dma_unmap_single() implies a
> > dma_sync_single_for_cpu() since you're unmapping the DMA buffer. So if
> > you use dma_unmap_single(), I think you can remove the call to
> > dma_sync_single_for_cpu().
> 
> Yes, it indeed seems to be the case (comment for arm_dma_unmap_page():
> "After this call, reads by the CPU to the buffer are guaranteed to see
> whatever the device wrote there.".
> 
> > >  	dma_sync_single_for_cpu(dma_chan->device->dev, dest_dma,
> > >  				PAGE_SIZE, DMA_FROM_DEVICE);
> > > +	dma_unmap_page(dma_chan->device->dev, dest_dma, PAGE_SIZE,
> > > +		       DMA_FROM_DEVICE);
> > 
> > Ditto.
> > 
> > Also, the mv_xor_memcpy_self_test() function not only dma_map_single()
> > the destination buffer, but also the source buffer. So presumably, the
> > source buffer should also be dma_unmap_single()'d.
> > 
> > And for the mv_xor_xor_self_test() function, multiple source buffers
> > are dma_map_page()'d, so they should all be dma_unmap_page()'d I guess,
> > not only the destination buffer.
> 
> Those get released by the mv_xor_run_tx_complete_actions() callback.
> 
> I will follow up with an updated patch.

Actually, after cleaning up the sync a couple more selfcheck warnings
popped up. I'd be very thankful if you could take a look (patches
chained to this message).
