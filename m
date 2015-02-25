From: drake@endlessm.com (Daniel Drake)
Date: Wed, 25 Feb 2015 09:21:13 -0600
Subject: [PATCH] ARM: dma-mapping: support non-consistent DMA attribute
In-Reply-To: <20150225144208.GA8656@n2100.arm.linux.org.uk>
References: <1424810703-20382-1-git-send-email-drake@endlessm.com>
 <16874142.jSTJ8OZePS@wuerfel>
 <CAD8Lp46KOQZMJqiqudE_0nvpaHgYxpD0qCeM2r8ZOgfzJUo6dA@mail.gmail.com>
 <20150225141846.GZ8656@n2100.arm.linux.org.uk>
 <CAD8Lp46de18aC+6cQUyn3hZV3HhLHNMsOuxSoQVg+5hU7vPMdA@mail.gmail.com>
 <20150225144208.GA8656@n2100.arm.linux.org.uk>
Message-ID: <CAD8Lp46cy3f+h9ytwwcwaFnZzNPcNTAhCVQOOLL7h9Hxadf7Hg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 25, 2015 at 8:42 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> When userspace wants to access the buffer later, it needs to ask DRM
> whether the buffer is safe to access - this causes DRM to check whether
> the buffer is still being used for a render operation, and can then
> flip the buffer back to CPU ownership.
>
> The idea that a buffer needs to be constantly mapped and unmapped in
> userspace would create its own problems: there is a cost to setting up
> and tearing down the mappings.

OK, so lets say the userspace mapping is created just once, and there
is a DRM-based access control mechanism as you describe, mandating
when it can/can't be accessed. To ask the question a different way
then: How is the one-time userspace mapping created?

As far as I can see, the if the dma_mmap_* API is used to do that, the
mapping will always be uncached or writecombine. There's no way that
it could currently be mapped with CPU caches enabled, unless
dma_mmap_* is avoided.

Daniel
