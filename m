From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 20 Feb 2012 17:57:23 +0000
Subject: Query: Multiple Mappings to Mem and ARMV6+
In-Reply-To: <CAOh2x=nqancNQ1sHpcPFMm+rcPGYEPZ5-YvKeOo6N_TE+fOjTw@mail.gmail.com>
References: <CAOh2x=nT365ixeHKsV7-313ZbKMoVLj0bEr9BvKB7jdGSnMV8w@mail.gmail.com>
 <20120216171520.GA9151@arm.com>
 <CAOh2x=nUPb-CcyJBmZ2wv=tsNzi=r3F16NynsbChXD=q5hSGiw@mail.gmail.com>
 <20120216174813.GE9151@arm.com>
 <CAOh2x=m_XWmHzm+KZX-E+P9b26=Bz9Ou76vCaSrHaTz-7xqHxA@mail.gmail.com>
 <CAHkRjk7sv6iHwhpOm1ZEH3eXppG75d8r2Y=D70SrtikyrjySwQ@mail.gmail.com>
 <CAOh2x=nqancNQ1sHpcPFMm+rcPGYEPZ5-YvKeOo6N_TE+fOjTw@mail.gmail.com>
Message-ID: <20120220175723.GJ26840@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 20, 2012 at 09:48:56AM -0800, viresh kumar wrote:
> On Feb 20, 2012 4:31 PM, "Catalin Marinas" <catalin.marinas@arm.com> wrote:
> >
> > On 16 February 2012 18:14, viresh kumar <viresh.linux@gmail.com> wrote:
> > > On Thu, Feb 16, 2012 at 9:48 AM, Catalin Marinas
> > > <catalin.marinas@arm.com> wrote:
> > >> The DMA API implementation on ARM takes care of the cache cleaning and
> > >> invalidating.
> > >
> > > I believe that this is the reason why we have cache re-invalidation
> > > (we invalidated
> > > it in dma_map_*() earlier) in dma_unmap_*() calls for ARMv6+ for
> > > DMA_FROM_DEVICE.
> > > Am i Correct?
> >
> > Yes.
> >
> 
> But why isn't keeping only the second one sufficient? Why don't we remove
> it from dma_map_* routines?

Please don't think for a moment that anyone likes the idea of having to
walk over the cache twice for every DMA operation.  We don't.  But I can
assure you that it's very very necessary.

The first run through the affected cache lines on dma_map_*() is there
to get rid of any cache lines for the buffer which may be marked 'dirty'.
A dirty cache line can be evicted (written back) to memory at _any_ time.
If this occurs while the DMA controller is reading data from a device,
the results depend on the order which the particular cache line is written
by the DMA controller, and by the cache line eviction.

If the cache line eviction happens after the DMA controller has written,
the DMA'd data will be overwritten by old stale data.

So, we must get rid of these dirty cache lines.  We can do that either
by cleaning the cache lines or invalidating them.  We chose to invalidate
them because it makes very little difference.

For the case where the DMA controller needs to read from memory, we
obviously have to ensure that all data is pushed out of the cache for it
to be visible to the DMA controller.  For this case, merely cleaning the
cache is sufficient.

The second run through the affected cache lines is to prevent speculative
prefetches occuring while the DMA controller is on operation, which could
result in old data (before the DMA controller has written its data) being
read by the CPU, resulting again in old stale data.

I hope it's now clear why we need to run over the buffer twice.
