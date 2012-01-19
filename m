From: Ian.Campbell@citrix.com (Ian Campbell)
Date: Thu, 19 Jan 2012 17:35:10 +0000
Subject: Oops in guest after ioremap() on ARMv7
In-Reply-To: <20120103165027.GD22876@arm.com>
References: <4EF31DA7.9030407@citrix.com> <20111222144937.GE20635@arm.com>
 <4EF35CFF.3050200@citrix.com> <20111222181356.GI20635@arm.com>
 <4EF37802.30300@citrix.com>
 <1324641625.7877.161.camel@zakaz.uk.xensource.com>
 <20120103165027.GD22876@arm.com>
Message-ID: <1326994510.17599.97.camel@zakaz.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-01-03 at 16:50 +0000, Catalin Marinas wrote:
> On Fri, Dec 23, 2011 at 12:00:25PM +0000, Ian Campbell wrote:
> > On Thu, 2011-12-22 at 18:33 +0000, David Vrabel wrote:
> > > On 22/12/11 18:13, Catalin Marinas wrote:
> > > > On Thu, Dec 22, 2011 at 04:38:23PM +0000, David Vrabel wrote:
> > > >> On 22/12/11 14:49, Catalin Marinas wrote:
> > > >>> What's the value of the VTCR register for this guest? Are the
> > > >>> translation table walks marked as cacheable? Also, are the page table
> > > >>> attributes Normal Cacheable in the stage 2 translation? The processor
> > > >>> chooses the more restrictive attribute between stage 1 and stage 2.
> > > >>
> > > >> VTCR = 0x80002558 which is: Outer Shareable; Normal memory, outer
> > > >> write-back write-allocate cacheable; Normal memory, inner write-back,
> > > >> write-allocate cacheable.
> 
> BTW, it would be better to mark the stage 2 table walks as inner
> shareable, i.e. VTCR = 0x80003558. That's because in case of SMP you
> would want page table accesses to snoop the caches of the other CPUs.

I did this. It didn't make any difference to the problem (I don't think
you were suggesting it would).

> > > >> L3 TT entries for stage 2 have the following attributes:
> > > >> Outer-Shareable; Normal, inner write-back cachable; Normal, outer
> > > >> write-back cacheable.
> > > >>
> > > >> These look sensible to me.
> > > > 
> > > > They look fine (UP system). BTW, I assume that the hypervisor also
> > > > flushes the caches and TLBs for the stage 2 translation tables.
> > > 
> > > I think so. Cc'ing Ian Campbell who knows the hypervisor side better
> > > than me.
> > 
> > At the moment we build the entire p2m before we ever load the VTTBR or
> > enable stage-2 translations in the HCR. Is that sufficient or do we also
> > need to flush something?
> 
> If the model does not correctly implement cacheable page table walks for
> either stage 1 or stage 2 translation (though ID_MMFR3[23:20] indicate
> that it should), the hypervisor would need to clean the D-cache to the
> point of unification (not necessary to go to the point of coherency)
> before any of the state 2 translation tables are used.

I added a copy of Linux's v7_flush_dcache_all after building the p2m but
just before loading the VTTBR and it didn't help.

I turned off cacheability in VTCR and that didn't help either.

Then I turned off cacheability in the Linux TTBR{0,1} (by frobbing both
TTB_FLAGS_UP and TTB_FLAGS_SMP to use FOO_NC everywhere) and this _did_
make a difference -- the kernel now boots.

I then tested just that change by itself and it seems to have done the
trick.

Does that indicate a model bug?

FWIW ID_MMFR3 is 0x02102111 on the model I've got so you are right that
it should to cacheable walks.

Cheers,
Ian.

> > Obviously we will need to make sure we do appropriate flushes when we
> > start needing to change the p2m of a running guest etc. Currently our
> > write_pte does a flush with DCCMVAC and in general our global flushes
> > are at the more aggressive end of the scale (correctness before
> > optimisation ;-)).
> 
> You can use DCCMVAU but could also check the coherent walk bits in
> ID_MMFR3 (assuming that the model works correctly).
> 
