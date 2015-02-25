From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 25 Feb 2015 14:18:46 +0000
Subject: [PATCH] ARM: dma-mapping: support non-consistent DMA attribute
In-Reply-To: <CAD8Lp46KOQZMJqiqudE_0nvpaHgYxpD0qCeM2r8ZOgfzJUo6dA@mail.gmail.com>
References: <1424810703-20382-1-git-send-email-drake@endlessm.com>
 <16874142.jSTJ8OZePS@wuerfel>
 <CAD8Lp46KOQZMJqiqudE_0nvpaHgYxpD0qCeM2r8ZOgfzJUo6dA@mail.gmail.com>
Message-ID: <20150225141846.GZ8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 25, 2015 at 07:58:00AM -0600, Daniel Drake wrote:
> UMP's not going upstream, but I was wondering if this patch had any
> value in the more general case. Thinking more, perhaps not, at least
> until dma-buf grows some form of userspace cache control API.

Which I would oppose.

The DMA API itself provides a very simple model:

 sg = cpu owned buffer(s)
 /* cpu owns sg buffers and can read/write it */
 dma_addr = dma_map_sg(dev, sg, ...);
 /* dev owns sg buffers, it is invalid for the CPU to write to the buffer
  * CPU writes to the buffer may very well be lost */
 dma_sync_sg_for_cpu(dev, sg, ...);
 /* cpu owns sg buffers, CPU can read/write buffer */
 dma_sync_sg_for_device(dev, sg, ...);
 /* dev owns sg buffers, it is invalid for the CPU to write to the buffer
  * CPU writes to the buffer may very well be lost */
 dma_unmap_sg(dev, sg, ...);
 /* cpu owns sg buffers again */

If we're wanting to do something like this in userspace, there's too much
chance userspace will get this ownership business wrong (we know this,
userspace programmers basically suck - they abuse anything we give them.)

It's far better to have a proper infrastructure present for things like
GPUs.  The good news is that we have such an infrastructure.  It's called
DRM, and with DRM, we track things like buffers associated with the GPU,
and we know which buffers the GPU should be accessing, and when the GPU
has finished with them.

There are even implementations on x86 which (such as the Intel drivers)
which track which domain each buffer is in, whether it's in the GPUs
domain or the CPUs domain, and the buffer has to be in the correct domain
for it to be operated upon.

So, we already have everything necessary.

Except for MALI, we don't, because of course we're better off having a
closed source, inherently insecure GPU driver which needs loads of crap
exported to userspace to work efficiently.  No, sorry, we're not going
to make this easy by providing interfaces for userspace to crap on:
GPU drivers need to be implemented properly.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
