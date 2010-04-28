From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 28 Apr 2010 16:08:46 +0900
Subject: CONSISTENT_DMA_SIZE limitations
In-Reply-To: <n2rf17812d71004272347m63c1f3f3k71005f720110822e@mail.gmail.com>
References: <v2taec7e5c31004272325x9e5958ddp34d7db1ff3477f4d@mail.gmail.com>
	<n2rf17812d71004272347m63c1f3f3k71005f720110822e@mail.gmail.com>
Message-ID: <k2jaec7e5c31004280008o85dbf9ffpbb4b1c2fd0eb7077@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 28, 2010 at 3:47 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
> On Wed, Apr 28, 2010 at 2:25 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
>> Extending CONSISTENT_DMA_SIZE seems like a good idea to me, but I'm
>> not sure if doing so will break something else. Perhaps I need to
>> rework some code in arch/arm/mm/dma-mapping.c?
>>
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

Hi Eric,

So we already have a bunch of multimedia-related drivers upstream for
SH, and they often make use of dma_alloc_coherent() and friends.
Chunks of physically contiguous memory are allocated during boot and
passed on to the platform drivers as a struct resource. This is true
for the LCDC fbdev and the CEU v4l2 code, as well as all the uio
devices. To avoid fragmentation issues the v4l2 driver also creates a
memory pool from the struct resource using
dma_declare_coherent_memory().

Eventually I'd like to tie in the IOMMU, but first i'd like to enable
the existing drivers by extending CONSISTENT_DMA_SIZE.

Thanks for your comments!

/ magnus
