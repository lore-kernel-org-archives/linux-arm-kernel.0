From: tony@atomide.com (Tony Lindgren)
Date: Wed, 10 Mar 2010 13:55:33 -0800
Subject: [PATCH 1/2] arm: disable L2 cache in the v7 finish function
In-Reply-To: <1268152984.1000.12.camel@e102109-lin.cambridge.arm.com>
References: <1268143623-22361-2-git-send-email-saeed@marvell.com>
	<1268152984.1000.12.camel@e102109-lin.cambridge.arm.com>
Message-ID: <20100310215533.GQ2900@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Catalin Marinas <catalin.marinas@arm.com> [100309 09:05]:
> On Tue, 2010-03-09 at 14:07 +0000, Saeed Bishara wrote:
> > Signed-off-by: Saeed Bishara <saeed@marvell.com>
> > ---
> >  arch/arm/mm/proc-v7.S |    5 +++++
> >  1 files changed, 5 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
> > index 7aaf88a..06cc36c 100644
> > --- a/arch/arm/mm/proc-v7.S
> > +++ b/arch/arm/mm/proc-v7.S
> > @@ -52,6 +52,11 @@ ENTRY(cpu_v7_proc_fin)
> >         bic     r0, r0, #0x1000                 @ ...i............
> >         bic     r0, r0, #0x0006                 @ .............ca.
> >         mcr     p15, 0, r0, c1, c0, 0           @ disable caches
> > +#ifdef CONFIG_OUTER_CACHE
> > +       mrc     p15, 0, r0, c1, c0, 1
> > +       bic     r0, r0, #0x2
> > +       mcr     p15, 0, r0, c1, c0, 1           @ disable L2 cache
> > +#endif
> >         ldmfd   sp!, {pc}
> >  ENDPROC(cpu_v7_proc_fin)
> 
> NACK.
> 
> I'm not sure why kexec doesn't work but bit 1 in this register has
> different meanings on Cortex-A8 and A9.
> 
> Also, on Cortex-A8, it means L2EN but this refers to the inner L2 rather
> than the outer cache (that's configurable via the L2 Auxiliary Cache
> Control Register but the Linux meaning of outer cache is a separate
> device outside the CPU acting as a cache controller).

Plus there are two other ways to disable the inner L2 and then
L2EN won't work like I replied earlier.

Regards,

Tony
