From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 17 Jun 2015 13:33:24 +0200
Subject: [PATCH v6 05/14] crypto: marvell/CESA: add TDMA support
In-Reply-To: <20150617095001.GA11538@gondor.apana.org.au>
References: <1434527142-3609-1-git-send-email-boris.brezillon@free-electrons.com>
 <1434527142-3609-6-git-send-email-boris.brezillon@free-electrons.com>
 <20150617095001.GA11538@gondor.apana.org.au>
Message-ID: <20150617133324.1ee6ad55@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 17 Jun 2015 17:50:01 +0800
Herbert Xu <herbert@gondor.apana.org.au> wrote:

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

My bad (again :-/).
Actually, I think I don't need to save the dma_map_sg return val, since
I'm using the sg_next function to iterate over the scatterlist. Am I
right ?
IOW, is the ->map_sg() function (in dma_map_ops) supposed to merge the
contiguous entries and then flag the unused entries with the is_chain
flag ?
If that's not the case, and the ->map_sg() just marks the merged entries
as empty (length = 0), then I'll have to rework my iterator algorithm.

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
