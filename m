From: drake@endlessm.com (Daniel Drake)
Date: Wed, 25 Feb 2015 08:30:38 -0600
Subject: [PATCH] ARM: dma-mapping: support non-consistent DMA attribute
In-Reply-To: <20150225141846.GZ8656@n2100.arm.linux.org.uk>
References: <1424810703-20382-1-git-send-email-drake@endlessm.com>
 <16874142.jSTJ8OZePS@wuerfel>
 <CAD8Lp46KOQZMJqiqudE_0nvpaHgYxpD0qCeM2r8ZOgfzJUo6dA@mail.gmail.com>
 <20150225141846.GZ8656@n2100.arm.linux.org.uk>
Message-ID: <CAD8Lp46de18aC+6cQUyn3hZV3HhLHNMsOuxSoQVg+5hU7vPMdA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 25, 2015 at 8:18 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
>  sg = cpu owned buffer(s)
>  /* cpu owns sg buffers and can read/write it */
>  dma_addr = dma_map_sg(dev, sg, ...);
>  /* dev owns sg buffers, it is invalid for the CPU to write to the buffer
>   * CPU writes to the buffer may very well be lost */
>  dma_sync_sg_for_cpu(dev, sg, ...);
>  /* cpu owns sg buffers, CPU can read/write buffer */
>  dma_sync_sg_for_device(dev, sg, ...);
>  /* dev owns sg buffers, it is invalid for the CPU to write to the buffer
>   * CPU writes to the buffer may very well be lost */
>  dma_unmap_sg(dev, sg, ...);
>  /* cpu owns sg buffers again */
>
> If we're wanting to do something like this in userspace, there's too much
> chance userspace will get this ownership business wrong (we know this,
> userspace programmers basically suck - they abuse anything we give them.)
>
> It's far better to have a proper infrastructure present for things like
> GPUs.  The good news is that we have such an infrastructure.  It's called
> DRM, and with DRM, we track things like buffers associated with the GPU,
> and we know which buffers the GPU should be accessing, and when the GPU
> has finished with them.

Fair enough, what you're describing does sound like a better model.
Thanks for explaining.

I'm still a little unclear on how DRM solves this particular problem
though. At the point when the buffer is CPU-owned, it can be mapped
into userspace with CPU caches enabled, right?
But how can DRM do that if the dma_mmap_* API is always going to map
it as writecombine or uncached?
Or should DRM drivers avoid that API and use remap_pfn_range()
directly, retaining full control of pgprot flags?

Thanks
Daniel
