From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 25 Feb 2015 17:25:51 +0000
Subject: [PATCH] ARM: dma-mapping: support non-consistent DMA attribute
In-Reply-To: <CABqkSC+Pgc2tZm8X+wuk4zL7=QebqL9yzX3LNZec0WfaGNr-bw@mail.gmail.com>
References: <1424810703-20382-1-git-send-email-drake@endlessm.com>
 <16874142.jSTJ8OZePS@wuerfel>
 <CAD8Lp46KOQZMJqiqudE_0nvpaHgYxpD0qCeM2r8ZOgfzJUo6dA@mail.gmail.com>
 <20150225141846.GZ8656@n2100.arm.linux.org.uk>
 <CAD8Lp46de18aC+6cQUyn3hZV3HhLHNMsOuxSoQVg+5hU7vPMdA@mail.gmail.com>
 <20150225144208.GA8656@n2100.arm.linux.org.uk>
 <CABqkSC+Pgc2tZm8X+wuk4zL7=QebqL9yzX3LNZec0WfaGNr-bw@mail.gmail.com>
Message-ID: <20150225172551.GG8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 25, 2015 at 08:31:30AM -0800, Jasper St. Pierre wrote:
> On Wed, Feb 25, 2015 at 6:42 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Wed, Feb 25, 2015 at 08:30:38AM -0600, Daniel Drake wrote:
> >> Fair enough, what you're describing does sound like a better model.
> >> Thanks for explaining.
> >>
> >> I'm still a little unclear on how DRM solves this particular problem
> >> though. At the point when the buffer is CPU-owned, it can be mapped
> >> into userspace with CPU caches enabled, right?
> >
> > Whether a buffer is mapped or not is an entirely separate issue.
> > We have many cases where the kernel has the buffer mapped into its
> > lowmem region while the device is doing DMA.  Having a buffer mapped
> > into userspace is no different.
> >
> > What DRM can do is track the state of the buffer: the DRM model is that
> > you talk to the GPU through DRM, which means that you submit a command
> > stream, along with identifiers for the buffers you want the command
> > stream to operate on.
> >
> > DRM can then scan the state of those buffers, and perform the appropriate
> > DMA API operation on the buffers to flip them over to device ownership.
> >
> > When userspace wants to access the buffer later, it needs to ask DRM
> > whether the buffer is safe to access - this causes DRM to check whether
> > the buffer is still being used for a render operation, and can then
> > flip the buffer back to CPU ownership.
> >
> > The idea that a buffer needs to be constantly mapped and unmapped in
> > userspace would create its own problems: there is a cost to setting up
> > and tearing down the mappings.
> >
> > As with anything performance related, the less work you can do, the faster
> > you will appear to be: that applies very much here.  If you can avoid
> > having to setup and tear down mappings, if you can avoid having to do
> > cache maintanence all the time, you will gain extra performance quite
> > simply because you're not wasting CPU cycles doing stuff which is not
> > absolutely necessary.
> >
> > I would put some of this into practice with etnaviv-drm, but I've decided
> > to walk away from that project and just look after the work which I once
> > did on it as a fork.
> 
> We are using DRM. The DRM CMA helpers use the DMA APIs to allocate
> memory from the CMA region, and we wanted to speed it up by using
> cached buffers.
> 
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/gpu/drm/drm_gem_cma_helper.c#n85
> 
> We tried dma_alloc_attrs, but found that setting
> DMA_ATTR_NON_CONSISTENT didn't work correctly. Hence, this patch.
> 
> Should the DRM CMA helpers not be using the DMA APIs to allocate
> memory from the CMA region?

It seems to be a reasonable thing to do.

However, what I would raise is whether you /really/ want to be using
CMA for this.

CMA gets you contiguous memory.  Great, but that means you must be able
to defragment the CMA memory region enough to get your large buffer.
Like any memory allocator, it will suffer from fragmentation, and
eventually it won't be able to allocate large buffers.  That will then
cause you to have to fall back to CPU rendering instead of GPU rendering.

There's another problem though - you have to have enough VM space for
all your pixmaps, since you can't swap them out once allocated (they
aren't treated as page cache pages.)

If your GPU has a MMU, you really ough to look at the possibility of
using shmem buffers, which are page-based allocations, using the page
cache.  This means they are swappable as well, and don't suffer from
the fragmentation issue.

dma-buf doesn't work particularly well with that though; the assumption
is that once imported, the buffer doesn't change (and hence can't be
swapped out) so the pages end up being pinned.  That really needs fixing...
there's a lot which needs fixing in this area because it's been designed
around people's particular use cases instead of a more high-level
approach.

CMA is useful for cases where you need a contiguous buffer, but where
you don't have a requirement for it, it's best to avoid it.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
