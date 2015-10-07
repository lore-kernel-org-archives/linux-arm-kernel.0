From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 7 Oct 2015 18:33:17 +0100
Subject: [PATCH 1/2] dmaengine: hdmac: factorise memset descriptor
 allocation
In-Reply-To: <20151007135412.GB3320@vkoul-mobl.iind.intel.com>
References: <1443711158-18495-1-git-send-email-maxime.ripard@free-electrons.com>
 <1443711158-18495-2-git-send-email-maxime.ripard@free-electrons.com>
 <20151007135412.GB3320@vkoul-mobl.iind.intel.com>
Message-ID: <20151007173317.GG2278@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

On Wed, Oct 07, 2015 at 02:54:13PM +0100, Vinod Koul wrote:
> On Thu, Oct 01, 2015 at 04:52:37PM +0200, Maxime Ripard wrote:
> 
> > +static struct at_desc *atc_create_memset_desc(struct dma_chan *chan,
> > +					      dma_addr_t psrc,
> > +					      dma_addr_t pdst,
> > +					      size_t len)
> > +{
> > +	struct at_dma_chan *atchan = to_at_dma_chan(chan);
> > +	struct at_desc *desc;
> > +	size_t xfer_count;
> > +
> > +	u32 ctrla = ATC_SRC_WIDTH(2) |
> > +		ATC_DST_WIDTH(2);
> 
> why is this over two lines :)
> 
> > +	u32 ctrlb = ATC_DEFAULT_CTRLB | ATC_IEN |
> > +		ATC_SRC_ADDR_MODE_FIXED |
> > +		ATC_DST_ADDR_MODE_INCR |
> > +		ATC_FC_MEM2MEM;
> > +
> > +	xfer_count = len >> 2;
> > +	if (xfer_count > ATC_BTSIZE_MAX) {
> > +		dev_err(chan2dev(chan), "%s: buffer is too big\n",
> > +			__func__);
> > +		return NULL;
> > +	}
> 
> This is fine, but this is driver limitation. We should really split the
> txn to multiple descriptors here..

Both these things are actually just copy from the previous code.

I can probably fix the first style issue in this patch, but splitting
the memset descriptors should go in a separate patch.

> 
> > @@ -914,46 +953,26 @@ atc_prep_dma_memset(struct dma_chan *chan, dma_addr_t dest, int value,
> >  		return NULL;
> >  	}
> >  
> > -	xfer_count = len >> 2;
> > -	if (xfer_count > ATC_BTSIZE_MAX) {
> > -		dev_err(chan2dev(chan), "%s: buffer is too big\n",
> > +	vaddr = dma_pool_alloc(atdma->memset_pool, GFP_ATOMIC, &paddr);
> 
> Mostly people use _zalloc variant, any reason why you don't want that

Not necessarily, but I don't need zeroed memory either, since I
overwrite the content right after the allocation.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151007/77353878/attachment.sig>
