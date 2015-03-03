From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 03 Mar 2015 10:23:06 +0100
Subject: EDAC on arm64
In-Reply-To: <20150302222502.GA13277@MBP.local>
References: <54F11133.70909@redhat.com> <2937202.iu6lrkO1gm@wuerfel>
 <20150302222502.GA13277@MBP.local>
Message-ID: <2550695.nbkPi0RDF3@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 02 March 2015 22:25:16 Catalin Marinas wrote:
> On Mon, Mar 02, 2015 at 08:40:16PM +0100, Arnd Bergmann wrote:
> > On Monday 02 March 2015 14:58:41 Catalin Marinas wrote:
> > > On Mon, Mar 02, 2015 at 10:59:32AM +0000, Will Deacon wrote:
> > > > On Sat, Feb 28, 2015 at 12:52:03AM +0000, Jon Masters wrote:
> > > > > Have you considered reviving the patch you posted previously for EDAC
> > > > > support (the atomic_scrub read/write test piece dependency)?
> > > > > 
> > > > > http://lists.infradead.org/pipermail/linux-arm-kernel/2014-April/249039.html
> > > > 
> > > > Well, we'd need a way to handle the non-coherent DMA case and it's really
> > > > not clear how to fix that.
> > > 
> > > I agree, that's where the discussions stopped. Basically the EDAC memory
> > > writing is racy with any non-cacheable memory accesses (by CPU or
> > > device). The only way we could safely use this is only if all the
> > > devices are coherent *and* KVM is disabled. With KVM, guests may access
> > > the memory uncached, so we hit the same problem.
> > 
> > Is this a setting of the host, or does the guest always have this capability?
> 
> The guest can always make it stricter than what the host set in stage 2
> (i.e. from Normal Cacheable -> NonCacheable -> Device) but never in the
> other direction.

Do you have an idea what the purpose of this is? Why would a guest
even want to mark pages as noncachable that are mapped into the
host as cachable and that might have dirty cache lines?

> > If a guest can influence the caching of a page it has access to, I can
> > imagine all sorts of security problems with malicious guests regardless
> > of EDAC.
> 
> Not as long as the host is aware of this. Basically it needs to flush
> the cache on a page when it is mapped into the guest address space (IPA)
> and flush it again when reading a page from guest.

You have to flush and invalidate the cache line, but of course nobody
wants to do that because it totally destroys performance.

	Arnd
