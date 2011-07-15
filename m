From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 15 Jul 2011 13:50:03 -0600
Subject: [PATCH v3] pxa2xx_spi: fix memory corruption
In-Reply-To: <20110715081242.GM23270@n2100.arm.linux.org.uk>
References: <201107101609.31405.anarsoul@gmail.com>
	<1310311099-24638-1-git-send-email-anarsoul@gmail.com>
	<20110715025331.GL2927@ponder.secretlab.ca>
	<20110715081242.GM23270@n2100.arm.linux.org.uk>
Message-ID: <20110715195003.GG2833@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 15, 2011 at 09:12:42AM +0100, Russell King - ARM Linux wrote:
> On Thu, Jul 14, 2011 at 08:53:31PM -0600, Grant Likely wrote:
> > > +	u8 null_dma_buf_unaligned[16];
> > 
> > Don't dma buffers need to be cache-line aligned?  How large is the
> > actual transfer?  Using the __aligned() or __cacheline_aligned
> > attribute is the correct way to make sure you've got a data buffer
> > that can be used for DMA mixed with other stuff.  Then you don't need
> > to fool around with PTR_ALIGN or anything.
> 
> Err, did you not read the whole patch?
> 
> > > +	drv_data->null_dma_buf =
> > > +		(u32 *)PTR_ALIGN(&drv_data->null_dma_buf_unaligned, 8);

I read a lot of patches yesterday.  I may very well have missed
something.  I still don't see what you're referring to though.  If
the __aligned() was used inside the structure definition, then there
would be no need to have both the null_dma_buf pointer and the
null_dma_buf_unaligned buffer.  It would just be a correctly aligned
null_dma_buf.

Plus, I was asking about whether it was valid to use the structure as
allocated in DMA operations since it may very well end up in the same
cache line as the allocated structure.  Firstly, that could mean DMA
and the cache referencing the same memory which could cause
corruption, and secondly on ARM isn't it a problem to have DMA buffers
in memory that is also cache mapped?

That said, I've not read the entire driver, so I haven't checked
null_dma_buffer is used in a real dma operation.

g.
