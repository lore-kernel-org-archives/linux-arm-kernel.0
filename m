From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 18 Dec 2012 16:29:44 +0000
Subject: [PATCH 5/7] arm64: ARMv8 RTSM model (SoC) support
In-Reply-To: <20121211163932.GC16071@arm.com>
References: <1354914392-9634-1-git-send-email-catalin.marinas@arm.com>
 <1354914392-9634-6-git-send-email-catalin.marinas@arm.com>
 <201212111541.16479.arnd@arndb.de> <20121211163932.GC16071@arm.com>
Message-ID: <20121218162944.GA594@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 11, 2012 at 04:39:32PM +0000, Catalin Marinas wrote:
> On Tue, Dec 11, 2012 at 03:41:15PM +0000, Arnd Bergmann wrote:
> > On Friday 07 December 2012, Catalin Marinas wrote:
> > > diff --git a/arch/arm6
> > > +static const char *vexpress_dt_match[] __initdata = {
> > > +       "arm,vexpress",
> > > +       NULL,
> > > +};
> > > +
> > > +static int __init vexpress_init(void)
> > > +{
> > > +       if (!of_flat_dt_match(of_get_flat_dt_root(), vexpress_dt_match))
> > > +               return 0;
> > > +
> > > +       vexpress_sysreg_of_early_init();
> > > +       vexpress_clk_of_init();
> > > +
> > > +       return 0;
> > > +}
> > > +arch_initcall(vexpress_init);
> > 
> > I think it would be more appropriate for these two to check the presence of
> > the individual devices, and move the caller into the actual device driver,
> > rather than checking for the root node of the device tree.
> > 
> > There may be cases where we want to check the root node, but both the clock
> > setup and the sysreg should both be detectable.
> 
> I cc'ed Pawel as well since it's touching his code. We've been through
> several versions internally and didn't find a clear winner. Currently,
> vexpress_clk_of_init() requires vexpress_sysreg_of_early_init() to be
> called first. Pawel has a patch to allow sysreg self-initialisation when
> called from vexpress_clk_of_init().
> 
> This leaves us with a way to call vexpress_clk_of_init() directly from
> clk-vexpress.c. There are two ways:
> 
> 1. arch_initcall() in clk-vexpress.c, checking for the DT match.
> 2. driver registration (arch_initcall) and later probing when
>    of_platform_populate() is called from the arch/arm64 code.

After some more thinking, none of these would work for arch/arm since
vexpress_clk_of_init() is called very early via the time_init() ...
v2m_dt_timer_init(). On arm64 we rely on the architected timers to be
always present but this assumption is not valid on arm where clocks
would need to be initialised early.

While I'd really like to get rid of the SoC code in arch/arm64, the best
place I see for the vexpress_clk_of_init() call is still the arch code
(unless we add #ifdefs in the clk-vexpress.c code).

-- 
Catalin
