From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 31 Jul 2012 21:08:55 +0100
Subject: About dma_sync_single_for_{cpu,device}
In-Reply-To: <CACYmx9MnEn_XOosBn2-YJ=ny9FiLPADMNa6okwG08xrSpCUSpA@mail.gmail.com>
References: <20120730202401.GA4947@gobelin> <20120731064557.GA4676@gobelin>
 <20120731090931.GP6802@n2100.arm.linux.org.uk>
 <CACYmx9MnEn_XOosBn2-YJ=ny9FiLPADMNa6okwG08xrSpCUSpA@mail.gmail.com>
Message-ID: <20120731200855.GC10335@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 31, 2012 at 09:31:13PM +0200, Karl Beldan wrote:
> On 7/31/12, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> > On Tue, Jul 31, 2012 at 08:45:57AM +0200, Karl Beldan wrote:
> >> I was expecting the following to work:
> >> 	addr = dma_map_single(dev, buffer, size, DMA_TO_DEVICE);
> >> 	dma_sync_single_for_device(dev, buffer, pattern_size, DMA_FROM_DEVICE);
> >> 	dev_send(buffer);
> >> 	// wait for irq (don't peek in the buffer) ... got irq
> >> 	dma_sync_single_for_cpu(dev, buffer, pattern_size, DMA_FROM_DEVICE);
> >> 	if (!xfer_done(buffer)) // not RAM value
> >> 		dma_sync_single_for_device(dev, buffer, pattern_size, DMA_FROM_DEVICE);
> >> 	[...]
> >
> 
> Hi Russell,
> 
> 
> > First point is that you clearly do not understand the DMA API at all.  The
> > DMA API has the idea of buffer ownership.  Only the owner may access the
> > buffer:
> >
> Are you saying that this scenario does not work ?
> We are taking some liberties with the DMA API, we're more using some
> of its funcs rather than _using_ it ;).
> The question was not whether this was a proper usage of the API, but
> why that scenario would not lead to the expected results .. and now
> I've found the culprit peek I am happy.

If you abuse the API don't expect your stuff to work in future kernel
versions.

It seems that the overall tone of your reply is "what we have now works,
we don't care if it's correct, sod you."

Fine, I won't spend any more time on this.  Just don't ever think about
merging it into mainline, thanks.
