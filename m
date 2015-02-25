From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 25 Feb 2015 14:42:08 +0000
Subject: [PATCH] ARM: dma-mapping: support non-consistent DMA attribute
In-Reply-To: <CAD8Lp46de18aC+6cQUyn3hZV3HhLHNMsOuxSoQVg+5hU7vPMdA@mail.gmail.com>
References: <1424810703-20382-1-git-send-email-drake@endlessm.com>
 <16874142.jSTJ8OZePS@wuerfel>
 <CAD8Lp46KOQZMJqiqudE_0nvpaHgYxpD0qCeM2r8ZOgfzJUo6dA@mail.gmail.com>
 <20150225141846.GZ8656@n2100.arm.linux.org.uk>
 <CAD8Lp46de18aC+6cQUyn3hZV3HhLHNMsOuxSoQVg+5hU7vPMdA@mail.gmail.com>
Message-ID: <20150225144208.GA8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 25, 2015 at 08:30:38AM -0600, Daniel Drake wrote:
> Fair enough, what you're describing does sound like a better model.
> Thanks for explaining.
> 
> I'm still a little unclear on how DRM solves this particular problem
> though. At the point when the buffer is CPU-owned, it can be mapped
> into userspace with CPU caches enabled, right?

Whether a buffer is mapped or not is an entirely separate issue.
We have many cases where the kernel has the buffer mapped into its
lowmem region while the device is doing DMA.  Having a buffer mapped
into userspace is no different.

What DRM can do is track the state of the buffer: the DRM model is that
you talk to the GPU through DRM, which means that you submit a command
stream, along with identifiers for the buffers you want the command
stream to operate on.

DRM can then scan the state of those buffers, and perform the appropriate
DMA API operation on the buffers to flip them over to device ownership.

When userspace wants to access the buffer later, it needs to ask DRM
whether the buffer is safe to access - this causes DRM to check whether
the buffer is still being used for a render operation, and can then
flip the buffer back to CPU ownership.

The idea that a buffer needs to be constantly mapped and unmapped in
userspace would create its own problems: there is a cost to setting up
and tearing down the mappings.

As with anything performance related, the less work you can do, the faster
you will appear to be: that applies very much here.  If you can avoid
having to setup and tear down mappings, if you can avoid having to do
cache maintanence all the time, you will gain extra performance quite
simply because you're not wasting CPU cycles doing stuff which is not
absolutely necessary.

I would put some of this into practice with etnaviv-drm, but I've decided
to walk away from that project and just look after the work which I once
did on it as a fork.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
