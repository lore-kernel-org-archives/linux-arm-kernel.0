From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 26 Mar 2015 16:15:05 +0000
Subject: RPmsg, DMA and ARM64
In-Reply-To: <20150326160136.GC30197@toto>
References: <20150324043749.GJ23658@toto>
 <20150326152607.GM8656@n2100.arm.linux.org.uk>
 <20150326160136.GC30197@toto>
Message-ID: <20150326161505.GR8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 27, 2015 at 02:01:36AM +1000, Edgar E. Iglesias wrote:
> On Thu, Mar 26, 2015 at 03:26:07PM +0000, Russell King - ARM Linux wrote:
> > The only way to pass such memory using scatterlists is by doing:
> > 
> > 	sg_init_table(sg, 1);
> > 	sg_dma_address(sg) = addr;
> > 	sg_dma_length(sg) = length;
> > 
> > Such a scatterlist must _never_ have the dma_(map|unmap|sync)_sg*()
> > functions called on it - the only operations which would be permissible
> > is to walk the scatterlist, and access it using the standard DMA
> > accessors sg_dma_address() and sg_dma_length().
> 
> I'll have a closer look and see if I can change rpmsg to deal with
> this.

Thanks - I should point out too that when accessing the scatterlist for
DMA purposes, using the accessors I mentioned above is a must - especially
as we're now getting IOMMUs on ARM.

This is because of a subtlety of the DMA streaming API.

The reason is that sg_dma_length(sg) may not be equal to sg->length -
IOMMUs (as part of dma_map_sg()) are permitted to coalesce entries
together by using their remapping abilities, which can result in fewer
scatterlist entries being needed.

It's also important to realise that dma_map_sg() returns the number of
scatterlist entries to be walked for DMA purposes, rather than the nents
passed into dma_map_sg() should _not_ be used.  It's the same reason -
if coalescing has occurred, the return value will be smaller, telling
you how many scatterlist entries are to be walked.

Finally, it's important to realise that when such coalescing occurs,
the values you have in sg_dma_address() and sg_dma_length() may _not_
correspond with the struct page in the entry.  In other words, you
can't expect to be able to switch between DMA and PIO and use the
same scatterlist entry, and expect to hit the same memory.

I suspect a lot of ARM driver authors are not aware of these finer
points.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
