From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 28 Apr 2010 14:47:02 +0800
Subject: CONSISTENT_DMA_SIZE limitations
In-Reply-To: <v2taec7e5c31004272325x9e5958ddp34d7db1ff3477f4d@mail.gmail.com>
References: <v2taec7e5c31004272325x9e5958ddp34d7db1ff3477f4d@mail.gmail.com>
Message-ID: <n2rf17812d71004272347m63c1f3f3k71005f720110822e@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 28, 2010 at 2:25 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
> Hi everyone,
>
> Are there any special CONSISTENT_DMA_SIZE limitiations in the latest
> upstrem ARM kernel?
>
> On SH-Mobile ARM a single 256 MB I/O window is mapped virt:phys 1:1 at
> 0xe6000000 -> 0xf5ffffff at ->map_io() time.
>
> The virtual area on top of the I/O window at 0xf6000000 -> 0xffdfffff
> seems suitable for consistent dma mappings. Extending
> CONSISTENT_DMA_SIZE from the default 2MB to 158 MB makes efficient use
> of the entire range. Empty 2MB space is left at the top as usual.
>
> Extending CONSISTENT_DMA_SIZE seems like a good idea to me, but I'm
> not sure if doing so will break something else. Perhaps I need to
> rework some code in arch/arm/mm/dma-mapping.c?
>

Hi Magnus,

For a hackish way of enabling something, I don't think that's a bad idea
to extend CONSISTENT_DMA_SIZE. And it's often seen by framebuffer
and video/graphics related drivers, which is normally hungry for large
amount of consistent memory. However, I'm a little bit concerned about
such usage, (esp. I'm not sure how this is done in ARMv7), my preference
would be:

1) either use the dma API
2) or reserve a large chunk of memory during boot and get it remapped later

> I'm asking because most platforms only export up to 14 MB, and
> Documentation/arm/memory.txt mentions 0xff000000 -> 0xffbfffff as
> reserved.
>
> Thanks!
>
> / magnus
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
