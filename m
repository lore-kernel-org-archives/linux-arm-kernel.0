From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 2 Mar 2015 22:25:16 +0000
Subject: EDAC on arm64
In-Reply-To: <2937202.iu6lrkO1gm@wuerfel>
References: <54F11133.70909@redhat.com> <20150302105919.GA4434@arm.com>
 <20150302145840.GQ22541@e104818-lin.cambridge.arm.com>
 <2937202.iu6lrkO1gm@wuerfel>
Message-ID: <20150302222502.GA13277@MBP.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 02, 2015 at 08:40:16PM +0100, Arnd Bergmann wrote:
> On Monday 02 March 2015 14:58:41 Catalin Marinas wrote:
> > On Mon, Mar 02, 2015 at 10:59:32AM +0000, Will Deacon wrote:
> > > On Sat, Feb 28, 2015 at 12:52:03AM +0000, Jon Masters wrote:
> > > > Have you considered reviving the patch you posted previously for EDAC
> > > > support (the atomic_scrub read/write test piece dependency)?
> > > > 
> > > > http://lists.infradead.org/pipermail/linux-arm-kernel/2014-April/249039.html
> > > 
> > > Well, we'd need a way to handle the non-coherent DMA case and it's really
> > > not clear how to fix that.
> > 
> > I agree, that's where the discussions stopped. Basically the EDAC memory
> > writing is racy with any non-cacheable memory accesses (by CPU or
> > device). The only way we could safely use this is only if all the
> > devices are coherent *and* KVM is disabled. With KVM, guests may access
> > the memory uncached, so we hit the same problem.
> 
> Is this a setting of the host, or does the guest always have this capability?

The guest can always make it stricter than what the host set in stage 2
(i.e. from Normal Cacheable -> NonCacheable -> Device) but never in the
other direction.

> If a guest can influence the caching of a page it has access to, I can
> imagine all sorts of security problems with malicious guests regardless
> of EDAC.

Not as long as the host is aware of this. Basically it needs to flush
the cache on a page when it is mapped into the guest address space (IPA)
and flush it again when reading a page from guest.

-- 
Catalin
