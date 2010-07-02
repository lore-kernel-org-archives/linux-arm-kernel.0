From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Fri, 2 Jul 2010 22:18:08 +0530
Subject: [patch 2/2] arm: Implement l2x0 cache disable function
In-Reply-To: <alpine.LFD.2.00.1007021658300.2525@localhost.localdomain>
References: <20100701160206.539545857@linutronix.de>
	<20100701160352.249208135@linutronix.de>
	<1278071240.10162.59.camel@e102109-lin.cambridge.arm.com>
	<alpine.LFD.2.00.1007021658300.2525@localhost.localdomain>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C5ECEEDB@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-
> kernel-bounces at lists.infradead.org] On Behalf Of Thomas Gleixner
> Sent: Friday, July 02, 2010 9:00 PM
> To: Catalin Marinas
> Cc: Tony Lindgren; LAK
> Subject: Re: [patch 2/2] arm: Implement l2x0 cache disable function
> 
> On Fri, 2 Jul 2010, Catalin Marinas wrote:
> 
> > On Thu, 2010-07-01 at 17:05 +0100, Thomas Gleixner wrote:
> > > This function is called from kexec code before the inner caches are
> > > disabled to prevent random crashes in the new kernel.
> > >
> > > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > > Index: linux-2.6/arch/arm/mm/cache-l2x0.c
> > > ===================================================================
> > > --- linux-2.6.orig/arch/arm/mm/cache-l2x0.c
> > > +++ linux-2.6/arch/arm/mm/cache-l2x0.c
> > > @@ -206,6 +206,12 @@ static void l2x0_flush_range(unsigned lo
> > >         spin_unlock_irqrestore(&l2x0_lock, flags);
> > >  }
> > >
> > > +static void l2x0_cache_disable(void)
> > > +{
> > > +       l2x0_inv_all();
> > > +       writel(0, l2x0_base + L2X0_CTRL);
> > > +}
> >
> > Even if we go this route, we need an l2x0_flush_all() rather than
> > invalidate here as the latter removes dirty cache lines without evicting
> > them first.
> 
> True, but that's an implementation detail. What's more important is to
> make a decision how to solve the problem as kexec is completely
> unusable for all L2 systems right now.
> 
> I think the correct way to deal with this is disabling L2 and let the
> OMAP3 folks deal with it. As Tony said there is some SMI magic to do
> that, so we can do the following:
> 
Just to be clear OMAP3 don't have external(outer) L2 so the below point is actually applicable to OMAP4.
If " omap_smi_magic_l2_enable" such a generic "secure_l2x_enable" hook which
can be populated by the archs should take care of OMAP problem

> In l2x0_init()
> 
>    if (!l2_enabled()) {
>       if (non_secure()) {
>       	 omap_smi_magic_l2_enable();
> 	 outer_cache.disable = omap_smi_magic_l2_disable;
>       } else {
>          sane_l2_enable();
> 	 outer_cache.disable = sane_l2_disable;
>       }
>    }
> 
> Russells patch has its own merits nevertheless as a cleanup and
> simplification, but that's a separate issue.
> 
> Thoughts ?
> 
> 	 tglx
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
