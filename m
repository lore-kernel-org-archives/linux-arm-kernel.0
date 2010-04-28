From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Wed, 28 Apr 2010 12:37:05 +0530
Subject: CONSISTENT_DMA_SIZE limitations
In-Reply-To: <n2rf17812d71004272347m63c1f3f3k71005f720110822e@mail.gmail.com>
References: <v2taec7e5c31004272325x9e5958ddp34d7db1ff3477f4d@mail.gmail.com>
	<n2rf17812d71004272347m63c1f3f3k71005f720110822e@mail.gmail.com>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C5172F4B@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-kernel-
> bounces at lists.infradead.org] On Behalf Of Eric Miao
> Sent: Wednesday, April 28, 2010 12:17 PM
> To: Magnus Damm
> Cc: linux-arm-kernel at lists.infradead.org
> Subject: Re: CONSISTENT_DMA_SIZE limitations
> 
> On Wed, Apr 28, 2010 at 2:25 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
> > Hi everyone,
> >
> > Are there any special CONSISTENT_DMA_SIZE limitiations in the latest
> > upstrem ARM kernel?
> >
> > On SH-Mobile ARM a single 256 MB I/O window is mapped virt:phys 1:1 at
> > 0xe6000000 -> 0xf5ffffff at ->map_io() time.
> >
> > The virtual area on top of the I/O window at 0xf6000000 -> 0xffdfffff
> > seems suitable for consistent dma mappings. Extending
> > CONSISTENT_DMA_SIZE from the default 2MB to 158 MB makes efficient use
> > of the entire range. Empty 2MB space is left at the top as usual.
> >
> > Extending CONSISTENT_DMA_SIZE seems like a good idea to me, but I'm
> > not sure if doing so will break something else. Perhaps I need to
> > rework some code in arch/arm/mm/dma-mapping.c?
> >
> 
> Hi Magnus,
> 
> For a hackish way of enabling something, I don't think that's a bad idea
> to extend CONSISTENT_DMA_SIZE. And it's often seen by framebuffer
> and video/graphics related drivers, which is normally hungry for large
> amount of consistent memory. However, I'm a little bit concerned about
> such usage, (esp. I'm not sure how this is done in ARMv7), my preference
> would be:
> 
> 1) either use the dma API
> 2) or reserve a large chunk of memory during boot and get it remapped later
> 
> > I'm asking because most platforms only export up to 14 MB, and
> > Documentation/arm/memory.txt mentions 0xff000000 -> 0xffbfffff as
> > reserved.

Not the best way but works is :
You can override the default setting of 2MB to whatever memory you need and
then use the dma_alloc_coherent(), to allocate from this space.

Just ensure that you don't ioremap this memory with different cache-attribute
otherwise you will end up in the alias mapping of same memory which is not
allowed on newer ARMv7.

Regards,
Santosh
