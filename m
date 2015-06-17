From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 17 Jun 2015 09:15:03 +0200
Subject: [PATCH v5 05/14] crypto: marvell/CESA: add TDMA support
In-Reply-To: <20150617055633.GA9123@gondor.apana.org.au>
References: <1434448748-10828-1-git-send-email-boris.brezillon@free-electrons.com>
 <1434448748-10828-6-git-send-email-boris.brezillon@free-electrons.com>
 <20150617050527.GA8807@gondor.apana.org.au>
 <20150617055633.GA9123@gondor.apana.org.au>
Message-ID: <20150617091503.5f74b6e5@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 17 Jun 2015 13:56:33 +0800
Herbert Xu <herbert@gondor.apana.org.au> wrote:

> On Wed, Jun 17, 2015 at 01:05:27PM +0800, Herbert Xu wrote:
> > On Tue, Jun 16, 2015 at 11:58:59AM +0200, Boris Brezillon wrote:
> > >
> > > +	ret = dma_map_sg(cesa_dev->dev, req->src, creq->src_nents,
> > > +			 DMA_TO_DEVICE);
> > > +	if (ret != creq->src_nents)
> > > +		return -ENOMEM;
> > 
> > Hmm it doesn't quite work like that.  It returns zero on error,
> > otherwise it returns the number (n) of mapped entries which may be
> > less than what you gave it due to merging.  You're then supposed
> > to use only the first n entries which should contain everything.
> 
> Please take a look at Documentation/DMA-API-HOWTO.txt, it has
> everything you need to know about the dma_map_sg interface.

Yep, I read it, but apparently not carefully enough ;-).
I'll fix that.

Note that I did not ignore your previous comment on purpose (checking
for !ret to verify if the sg entries were successfully mapped), but I
have a specific case in the hash code where the requested len is 0
(final request) and thus the src_nents is 0 too. Which means I'm
expecting the dma_sg_map to return 0.

Anyway, now I'm doing the following test:

if (creq->src_nents && !ret)
	return -ENOMEM;

Best Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
