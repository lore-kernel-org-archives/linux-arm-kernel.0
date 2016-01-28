From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 28 Jan 2016 11:49:25 +0000
Subject: Speeding up dma_unmap
In-Reply-To: <24650183.WoXLVmr0Vj@wuerfel>
References: <CAJFSRaCRvx=+_fEYAr8OeWGHnnz+rOWjLzLcm+wZiEstbHwxAw@mail.gmail.com>
 <20160127180944.GZ10826@n2100.arm.linux.org.uk>
 <20160128103105.GR14823@e104818-lin.cambridge.arm.com>
 <24650183.WoXLVmr0Vj@wuerfel>
Message-ID: <20160128114925.GU14823@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 28, 2016 at 12:20:55PM +0100, Arnd Bergmann wrote:
> On Thursday 28 January 2016 10:31:06 Catalin Marinas wrote:
> > On Wed, Jan 27, 2016 at 06:09:45PM +0000, Russell King - ARM Linux wrote:
> > > On Wed, Jan 27, 2016 at 04:06:30PM +0000, Catalin Marinas wrote:
> > > > On Wed, Jan 27, 2016 at 01:23:27PM +0100, Arnd Bergmann wrote:
> > > > > up reading cache lines back in randomly on a speculative prefetch,
> > > > > but as far as I can tell, the Cortex-A8 (or A5/A7) won't do that.
> > > > 
> > > > Are you sure about A5 and A7? I'm not even sure about the A8 but there
> > > > are good chances that A7 and A5 do speculative prefetches.
> > > 
> > > I thought when I was re-implementing the DMA API on ARM (which was
> > > around early v7 times) that there were CPUs that did speculative
> > > prefetching, which included the A8.  I seem to remember it was pretty
> > > urgent to have the DMA API fixed for _any_ ARMv7 CPU because of the
> > > speculative prefetching.
> > 
> > Indeed, it's a safe assumption to say that any ARMv7 CPU perform
> > speculative accesses. Even if some of them may only do I-cache
> > prefetching (just guessing), in the presence of a unified L2 this
> > distinction no longer matters.
[...]
> This means that there are still some cores on which one could try
> if disabling the prefetching and the flushes in DMA unmap provides
> any serious performance boost.

I think we need to look at the original use-case. There seems to be a
4MB buffer, how often is this mapped/unmapped? Would it be better off
with the coherent API than the streaming one?

-- 
Catalin
