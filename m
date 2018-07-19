From: vkoul@kernel.org (Vinod)
Date: Thu, 19 Jul 2018 14:52:24 +0530
Subject: [RFC] dmaengine: Add metadat_ops for dma_async_tx_descriptor
In-Reply-To: <052ebdd9-7e68-5b78-52c3-304376f48777@ti.com>
References: <32208a9c-2b15-d345-1432-f1e387531f9b@ti.com>
 <20180601102429.16429-1-peter.ujfalusi@ti.com>
 <20180710055230.GB3219@vkoul-mobl>
 <052ebdd9-7e68-5b78-52c3-304376f48777@ti.com>
Message-ID: <20180719092224.GK3219@vkoul-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On 18-07-18, 13:06, Peter Ujfalusi wrote:

> >> +struct dma_async_tx_descriptor;
> >> +
> >> +struct dma_descriptor_metadata_ops {
> >> +	int (*attach)(struct dma_async_tx_descriptor *desc, void *data,
> >> +		      size_t len);
> > 
> > How does one detach?
> 
> I have not thought about detach, but clients can just attach NULL I guess.

So what are the implication of attach and detach here, should the data
be deref by dmaengine driver and drop the ref.

Should anyone do refcounting?

> 
> > When should the client free up the memory, IOW when
> > does dma driver drop ref to data.
> 
> The metadata is for the descriptor so the DMA driver might want to
> access to it while the descriptor is valid.
> 
> Typically clients can free up their metadata storage after the dma
> completion callback. On DEV_TO_MEM the metadata is going to be placed in
> the provided buffer when the transfer is completed.

That sounds okay to me

> >> +	void *(*get_ptr)(struct dma_async_tx_descriptor *desc,
> >> +			 size_t *payload_len, size_t *max_len);
> > 
> > so what is this supposed to do..?
> 
> My issue with the attach in general is that it will need additional
> memcpy to move the metadata from/to the client buffer to it's place.
> 
> With get_ptr the client can get the pointer to the actual place where
> the metadata resides and modify/read it in place w/o memcpy.
> 
> I know, I know... We need to trust the clients, but with high throughput
> peripherals the memcpy is taxing.

Okay I am not sure I have understood fully, so with attach you set
a pointer (containing metdata?) so why do you need additional one..

> 
> > 
> >> +	int (*set_len)(struct dma_async_tx_descriptor *desc,
> >> +		       size_t payload_len);
> > 
> > attach already has length, so how does this help?
> 
> So, DMA drivers can implement either or both:
> 1. attach()
> 2. get_ptr() / set_len()

Ah okay, what are the reasons for providing two methods and not a single
one

> 
> Clients must not mix the two way of handling the metadata.
> The set_len() is intended to tell the DMA driver the client provided
> metadata size (in MEM_TO_DEV case mostly).
> 
> MEM_TO_DEV flow on client side:
> get_ptr()
> fill in the metadata to the pointer (not exceeding max_len)
> set_len() to tell the DMA driver the amount of valid bytes written
> 
> DEV_TO_MEM flow on client side:
> In the completion callback, get_ptr()
> the metadata is payload_len bytes and can be accessed in the return pointer.

I would think to unify this..

> BTW: The driver which is going to need this is now accessible in public:
> https://git.ti.com/ti-linux-kernel/ti-linux-kernel/trees/ti-linux-4.14.y/drivers/dma/ti
> 
> or in my wip tree:
> https://github.com/omap-audio/linux-audio/tree/peter/ti-linux-4.14.y/wip/drivers/dma/ti
> 
> prefixed with k3-*
> 
-- 
~Vinod
