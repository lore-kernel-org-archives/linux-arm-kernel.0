From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 25 Jul 2014 11:36:18 +0100
Subject: Kexec on arm64
In-Reply-To: <1406247468.4062.59.camel@smoke>
References: <CAFdej006OSyhgDcJ2iZdbjt+PtysN=i_+9Dr4GTmr=+t5yg4Kw@mail.gmail.com>
 <1405443898.22585.7.camel@smoke>
 <CAL85gmC9LLcN_uxMY1bM5kLx=N7rZGdGO3bmGHeUVo=Rqgk8uw@mail.gmail.com>
 <1405551861.7262.26.camel@smoke>
 <CAFdej03nixSU=3h+HYk2E3Onb2P3--Di0GM+wCwLS6ZNH7UjEQ@mail.gmail.com>
 <CAFdej00J2mJwcg2Cy6CHVuuQZ4uQ2zZg8oErGPi0uPejievB+Q@mail.gmail.com>
 <1406162287.4062.39.camel@smoke>
 <20140724093603.GC4079@leverpostej>
 <1406247468.4062.59.camel@smoke>
Message-ID: <20140725103618.GB18920@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 25, 2014 at 01:17:48AM +0100, Geoff Levand wrote:
> Hi,
> 
> On Thu, 2014-07-24 at 10:36 +0100, Mark Rutland wrote:
> > On Thu, Jul 24, 2014 at 01:38:07AM +0100, Geoff Levand wrote:
>  
> > > All memory management for the main cpu is done by the arch code.  Kexec
> > > and cpu hot plug only work with the secondary cpus, so the problem would
> > > be in the arch memory code, either in setup_restart() for shutdown, or
> > > in the startup code.
> > 
> > It's possible that soft_restart and setup_restart are a little dodgy, as
> > they also rely on the compiler being smart and not touching the stack
> > after setup_restart().
> > 
> > However, they provide absolutely no guarantee that any data has been
> > flushed out to the PoC [1]. If you require any data to be flushed out to the
> > PoC so as to be visible to noncacheable accesses, you will need to
> > ensure that this is flushed by VA before soft_restart is called. Data
> > may have migrated to another cache (e.g. another CPU, or the L3) where
> > it is not visible.
> 
> OK, kexec's reset routine relocate_new_kernel does use a few global
> variables that are set by the main kexec routines.  I added a call to
> __flush_dcache_area(), which uses 'dc civac' for those.
> 
> I had thought the call to __flush_dcache_all, which uses 'dc cisw', in
> flush_cache_all() would be enough.

Unfortunately Set/Way ops don't provide the guarantee you require. While
they may happen to force prior writes out to the PoC on some
implementations, this guarantee is not provided by the architecture. The
only way to guarantee data is out at the PoC per the architecture is to
use cache maintenance by VA (unless you are unlucky enough to be on a
32-bit system with an outer cache that requires MMIO maintenance).

Almost every use of Set/Way operations is dodgy. They only make sense
for IMPLEMENTATION DEFINED power-on / power-off sequences (which the
arm64 kernel won't be dealing with), and some edge cases where you need
to guarantee that the local d-caches are empty (to avoid unexpectedly
hitting in the cache).

The naming of __flush_dcache_all is certainly misleading and I intend to
address that shortly.

Thanks,
Mark.
