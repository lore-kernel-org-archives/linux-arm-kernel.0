From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 18 Jun 2015 10:48:03 +0100
Subject: [PATCH v6 05/14] crypto: marvell/CESA: add TDMA support
In-Reply-To: <20150618113324.2d469103@bbrezillon>
References: <1434527142-3609-1-git-send-email-boris.brezillon@free-electrons.com>
 <1434527142-3609-6-git-send-email-boris.brezillon@free-electrons.com>
 <20150617095001.GA11538@gondor.apana.org.au>
 <20150618090400.GG7557@n2100.arm.linux.org.uk>
 <20150618113324.2d469103@bbrezillon>
Message-ID: <20150618094803.GH7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 18, 2015 at 11:33:24AM +0200, Boris Brezillon wrote:
> Hi Russel,
> 
> On Thu, 18 Jun 2015 10:04:00 +0100
> Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> 
> > On Wed, Jun 17, 2015 at 05:50:01PM +0800, Herbert Xu wrote:
> > > On Wed, Jun 17, 2015 at 09:45:33AM +0200, Boris Brezillon wrote:
> > > >
> > > > +	ret = dma_map_sg(cesa_dev->dev, req->src, creq->src_nents,
> > > > +			 DMA_TO_DEVICE);
> > > > +	if (!ret)
> > > > +		return -ENOMEM;
> > > > +
> > > > +	creq->src_nents = ret;
> > > 
> > > DMA-API-HOWTO says that you must retain the original nents and
> > > use it when you call dma_unmap_sg.  So I'm afraid one more repost
> > > is needed :)
> > 
> > It's worse than that...  You're right on that point, but there's an
> > additional point.
> > 
> > If dma_map_sg() coalesces scatterlist entries, then ret will be smaller
> > than src_nents, and ret indicates how many scatterlist entries to be
> > walked during DMA - you should not use src_nents for that.  I couldn't
> > see where the driver used that information.  In fact, the driver seems
> > to be capable of walking more than src_nents/ret numbers of scatterlist
> > entries: it just keeps going with sg_next() until it hits the end of
> > the allocated scatterlist.
> 
> Yes, I realized that, and I never used the value returned by
> dma_map_sg() to walk the scatterlist anyway: I was using the sg_next()
> and sg->length value (which I replaced by sg_dma_len() in v7 as
> suggested by Herbert).
> So the ->src_nents assignment to dma_map_sg() return value was just a
> silly mistake caused by an uncareful read of the DMA-API-HOWTO.
> 
> Am I missing something else ?

Yes.  'ret' should be used to indicate the number of scatterlist entries
to walk for DMA purposes after the scatterlist has been mapped.  For PIO
purposes, using src_nents is still acceptable.

As Herbert points out, you're stopping after the sum of transferred bytes
matches, so I suppose that's fine.

One other point though: you should use sg_dma_address() rather than
dereferencing sg->dma_address directly.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
