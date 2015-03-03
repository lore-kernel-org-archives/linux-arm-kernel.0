From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 3 Mar 2015 10:57:05 +0000
Subject: EDAC on arm64
In-Reply-To: <2550695.nbkPi0RDF3@wuerfel>
References: <54F11133.70909@redhat.com> <2937202.iu6lrkO1gm@wuerfel>
 <20150302222502.GA13277@MBP.local> <2550695.nbkPi0RDF3@wuerfel>
Message-ID: <20150303105705.GF28951@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 03, 2015 at 10:23:06AM +0100, Arnd Bergmann wrote:
> On Monday 02 March 2015 22:25:16 Catalin Marinas wrote:
> > On Mon, Mar 02, 2015 at 08:40:16PM +0100, Arnd Bergmann wrote:
> > > On Monday 02 March 2015 14:58:41 Catalin Marinas wrote:
> > > > On Mon, Mar 02, 2015 at 10:59:32AM +0000, Will Deacon wrote:
> > > > > On Sat, Feb 28, 2015 at 12:52:03AM +0000, Jon Masters wrote:
> > > > > > Have you considered reviving the patch you posted previously for EDAC
> > > > > > support (the atomic_scrub read/write test piece dependency)?
> > > > > > 
> > > > > > http://lists.infradead.org/pipermail/linux-arm-kernel/2014-April/249039.html
> > > > > 
> > > > > Well, we'd need a way to handle the non-coherent DMA case and it's really
> > > > > not clear how to fix that.
> > > > 
> > > > I agree, that's where the discussions stopped. Basically the EDAC memory
> > > > writing is racy with any non-cacheable memory accesses (by CPU or
> > > > device). The only way we could safely use this is only if all the
> > > > devices are coherent *and* KVM is disabled. With KVM, guests may access
> > > > the memory uncached, so we hit the same problem.
> > > 
> > > Is this a setting of the host, or does the guest always have this capability?
> > 
> > The guest can always make it stricter than what the host set in stage 2
> > (i.e. from Normal Cacheable -> NonCacheable -> Device) but never in the
> > other direction.
> 
> Do you have an idea what the purpose of this is? Why would a guest
> even want to mark pages as noncachable that are mapped into the
> host as cachable and that might have dirty cache lines?

The stage 1 / stage 2 attributes combination works such that the
hypervisor can impose more stricter attributes or none at all (in which
case it is up to the guest to decide what it needs). So for example
devices mapped into the guest address space (e.g. the GIC) are marked as
Device memory in stage 2 so that the guest could never map them as
Normal Cacheable memory (with some bad consequences).

The other direction is that the guest may want to create a stricter
mapping than what the host wants. A possible reason is some frame
buffer or anything else where the guest assumes that by creating a
non-cacheable mapping it won't need to do cache maintenance. That's why
when KVM maps a page into the guest address space, it flushes the cache
so there are no dirty lines. Since the host would not write to such page
again, it won't dirty the cache (and if the guest does, it needs to deal
with it itself).

There are some scenarios where this does not work well: a virtual frame
buffer emulated by Qemu where the guest thinks it is non-cacheable and
Qemu maps it as cacheable. The only sane solution here is to tell the
guest that the (virtual) frame buffer device is DMA coherent and that it
should use a cacheable mapping. But I don't think the host should
somehow (transparently) upgrade the cacheability that the guest thinks
it has.

> > > If a guest can influence the caching of a page it has access to, I can
> > > imagine all sorts of security problems with malicious guests regardless
> > > of EDAC.
> > 
> > Not as long as the host is aware of this. Basically it needs to flush
> > the cache on a page when it is mapped into the guest address space (IPA)
> > and flush it again when reading a page from guest.
> 
> You have to flush and invalidate the cache line, but of course nobody
> wants to do that because it totally destroys performance.

There are two cases when the cache needs flushing: (1) when a page is
mapped into the guest address space (done lazily via the page faulting
mechanism) and (2) when the host reads a page already mapped in the
guest address space (e.g. swapping out). They indeed take some time but
none of them are on a critical path.

(and maybe at some point we'll get fully transparent caches on ARM as
well, so we don't have to worry about cache maintenance)

-- 
Catalin
