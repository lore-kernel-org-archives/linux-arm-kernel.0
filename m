From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 18 Jun 2015 10:04:00 +0100
Subject: [PATCH v6 05/14] crypto: marvell/CESA: add TDMA support
In-Reply-To: <20150617095001.GA11538@gondor.apana.org.au>
References: <1434527142-3609-1-git-send-email-boris.brezillon@free-electrons.com>
 <1434527142-3609-6-git-send-email-boris.brezillon@free-electrons.com>
 <20150617095001.GA11538@gondor.apana.org.au>
Message-ID: <20150618090400.GG7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 17, 2015 at 05:50:01PM +0800, Herbert Xu wrote:
> On Wed, Jun 17, 2015 at 09:45:33AM +0200, Boris Brezillon wrote:
> >
> > +	ret = dma_map_sg(cesa_dev->dev, req->src, creq->src_nents,
> > +			 DMA_TO_DEVICE);
> > +	if (!ret)
> > +		return -ENOMEM;
> > +
> > +	creq->src_nents = ret;
> 
> DMA-API-HOWTO says that you must retain the original nents and
> use it when you call dma_unmap_sg.  So I'm afraid one more repost
> is needed :)

It's worse than that...  You're right on that point, but there's an
additional point.

If dma_map_sg() coalesces scatterlist entries, then ret will be smaller
than src_nents, and ret indicates how many scatterlist entries to be
walked during DMA - you should not use src_nents for that.  I couldn't
see where the driver used that information.  In fact, the driver seems
to be capable of walking more than src_nents/ret numbers of scatterlist
entries: it just keeps going with sg_next() until it hits the end of
the allocated scatterlist.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
