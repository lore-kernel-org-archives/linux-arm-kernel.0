From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 7 Nov 2012 09:47:26 +0000
Subject: [PATCH] ARM: setup_mm_for_reboot(): use flush_cache_louis()
In-Reply-To: <509987BD.8090800@ti.com>
References: <alpine.LFD.2.02.1211061610070.21033@xanadu.home>
 <509987BD.8090800@ti.com>
Message-ID: <20121107094726.GB17831@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 06, 2012 at 09:57:17PM +0000, Santosh Shilimkar wrote:
> On Tuesday 06 November 2012 03:12 PM, Nicolas Pitre wrote:
> >
> > ... instead of flush_cache_all().  The later unconditionally flushes
> > the L2 cache on ARMv7 architectures such as Cortex A15 and A7 which
> > is costly and unnecessary in some scenarios where setup_mm_for_reboot()
> > is used.  If L2 has to be flushed as well, it should already be done
> > separately on other architectures anyway.
> >
> > Signed-off-by: Nicolas Pitre <nico@linaro.org>
> >
> > diff --git a/arch/arm/mm/idmap.c b/arch/arm/mm/idmap.c
> > index ab88ed4f8e..2c61085a10 100644
> > --- a/arch/arm/mm/idmap.c
> > +++ b/arch/arm/mm/idmap.c
> > @@ -104,7 +104,7 @@ early_initcall(init_static_idmap);
> >   void setup_mm_for_reboot(void)
> >   {
> >   	/* Clean and invalidate L1. */
> > -	flush_cache_all();
> > +	flush_cache_louis();
> >
> >   	/* Switch to the identity mapping. */
> >   	cpu_switch_mm(idmap_pgd, &init_mm);
> >
> Nice. Just one difference is that the I-cache invalidation won't
> happen with this change. Not that it is needed here but capturing
> that in change-log would be good.

Yes, it does happen. The LoUIS API mirrors the flush_cache_all() API in
this respect, and it has to. The only change is the data cache level at
which it operates.

Lorenzo
