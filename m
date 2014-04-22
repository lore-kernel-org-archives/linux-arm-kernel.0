From: will.deacon@arm.com (Will Deacon)
Date: Tue, 22 Apr 2014 17:01:00 +0100
Subject: [PATCH v3] arm64: enable EDAC on arm64
In-Reply-To: <CAL_JsqJEwUu0ooEcL+hniD8vxjBW5571ea3u3JmPN3x1MfXW3w@mail.gmail.com>
References: <1398096556-26799-1-git-send-email-robherring2@gmail.com>
 <20140422102455.GD7484@arm.com>
 <CAL_JsqKS_NZbxq_nFBnsQvj51TtraEeFm0aY=j=N3DwJ+bTL6g@mail.gmail.com>
 <20140422132624.GC9820@arm.com>
 <CAL_JsqJEwUu0ooEcL+hniD8vxjBW5571ea3u3JmPN3x1MfXW3w@mail.gmail.com>
Message-ID: <20140422160100.GH9820@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 22, 2014 at 04:23:20PM +0100, Rob Herring wrote:
> On Tue, Apr 22, 2014 at 8:26 AM, Will Deacon <will.deacon@arm.com> wrote:
> > On Tue, Apr 22, 2014 at 01:54:12PM +0100, Rob Herring wrote:
> >> On Tue, Apr 22, 2014 at 5:24 AM, Will Deacon <will.deacon@arm.com> wrote:
> >> > On Mon, Apr 21, 2014 at 05:09:16PM +0100, Rob Herring wrote:
> >> >> +#ifndef ASM_EDAC_H
> >> >> +#define ASM_EDAC_H
> >> >> +/*
> >> >> + * ECC atomic, DMA, SMP and interrupt safe scrub function.
> >> >
> >> > What do you mean by `DMA safe'? For coherent (cacheable) DMA buffers, this
> >> > should work fine, but for non-coherent (and potentially non-cacheable)
> >> > buffers, I think we'll have problems both due to the lack of guaranteed
> >> > exclusive monitor support and also eviction of dirty lines.
> >>
> >> That's just copied from other implementations. I agree you could have
> >> a problem here although I don't see why dirty line eviction would be.
> >
> > I was thinking of the case where you have an ongoing, non-coherent DMA
> > transfer from a device and then the atomic_scrub routine runs in parallel
> > on the CPU, targetting the same buffer. In this case, the stxr could store
> > stale data back to the buffer, leading to corruption (since the monitor
> > won't help). This differs from the case where the monitor could always
> > report failure for non-cacheable regions, causing atomic_scrub to livelock.
> 
> It is only reads that will trigger an error and scrubbing. If the DMA
> is continuously reading (such as a framebuffer), then there would not
> be an issue. What would be the usecase where a DMA continously writes
> to the same location without any synchronization with the cpu? I
> suppose one core could re-trigger a DMA while another core is doing
> the scrubbing. You would have to read the DMA data and be finished
> with it quicker than the scrubbing could get handled. I just wonder
> whether this is really only a theoretical problem, but not one in
> practice.

I don't think it's all that complicated if you consider speculative reads
from the CPU triggering the error. However, discussion with Catalin raised
another question (see below).

> >> There's not really a solution other than not doing s/w scrubbing or
> >> doing it in h/w. So it is up to individual drivers to decide what to
> >> do, but we have to provide this function just to enable EDAC.
> >
> > I think we need to avoid s/w scrubbing of non-cacheable memory altogether.
> 
> There's not really a way to determine the memory attributes easily
> though. Whether it works depends on the h/w. Calxeda's memory
> controller did have an exclusive monitor so I think this would have
> worked even in the non-coherent case.
> 
> What exactly is your proposal to do here? I think we should assume the
> h/w is designed correctly until we have a case that it is not.

Looking at the edac_mc_scrub_block code, atomic_scrub is always called with
a normal, cacheable mapping (kmap_atomic) so that doesn't help us (although
it means the exclusives will at least succeed).

The problem of speculative reads by the CPU could be solved by unmapped the
DMA buffer when we transfer the ownership over to the device (instead of
invalidating it after the transfer). However, I'm now slightly confused as
to how atomic_scrub fixes errors reported at any cache level higher than
L1. Do we need cache-flushing to ensure that the exclusive-store propagates
to the point of failure?

Will
