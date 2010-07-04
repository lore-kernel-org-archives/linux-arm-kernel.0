From: catalin.marinas@arm.com (Catalin Marinas)
Date: Sun, 04 Jul 2010 15:07:24 +0100
Subject: [patch 2/2] arm: Implement l2x0 cache disable function
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C5ECEF1D@dbde02.ent.ti.com>
References: <alpine.LFD.2.00.1007021658300.2525@localhost.localdomain>
	<1278087010.10162.271.camel@e102109-lin.cambridge.arm.com>
	<alpine.LFD.2.00.1007021835512.2525@localhost.localdomain>
	<1278089680.10162.279.camel@e102109-lin.cambridge.arm.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C5ECEF1D@dbde02.ent.ti.com>
Message-ID: <1278252444.22408.9.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2010-07-03 at 08:01 +0100, Shilimkar, Santosh wrote:
> > From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-
> > kernel-bounces at lists.infradead.org] On Behalf Of Catalin Marinas
> > On Fri, 2010-07-02 at 17:39 +0100, Thomas Gleixner wrote:
> > > On Fri, 2 Jul 2010, Catalin Marinas wrote:
> > > > My view is that we should try to find why cache flushing doesn't work
> > > > but unfortunately I don't have any spare time to look into this (would
> > > > need to use tools like ICE debugging/tracing).
> > >
> > > Simply because you need to flush the cache in the decompressor of the
> > > new kernel before jumping into it and I doubt that Russell will be
> > > happy about adding an utter L2 mess to the decompressor.
> >
> > The decompressor can create mappings as inner cacheable outer
> > non-cacheable and it would not pollute the L2 cache.
> >
> > I wonder how the OMAP guys deal with an already enabled L2 cache during
> > decompressing.
> 
> $L2 isn't enabled during the decompression. It's done " __v7_setup" on OMAP3
> and just before " l2x0_init" on OMAP4

Another approach would have been to mark the page tables as outer
non-cacheable in the decompressor.

Anyway, if you already handle L2 cache initialisation during __v7_setup
(and we could go back to a thread where I asked for per-platform CPU
initialisation support), you could handle L2 cache disabling as well.

As per Thomas' patches, the outer_cache_fns structure has a .disable()
function and this can be overridden by the OMAP code after l2x0_init().

The only additional comment I have to Thomas' second patch is that the
l2x0_cache_disable() implementation has to flush (clean+inv) the L2
cache (rather than just invalidate) and then disable by writing the L2
control register. The L2 flushing function doesn't need to be exported
via outer_cache_fns since it's only the disabling that would handle it.

-- 
Catalin
