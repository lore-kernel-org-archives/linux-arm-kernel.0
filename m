From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 19 Sep 2016 17:52:58 +0100
Subject: [PATCH v5 3/5] arm64: arch_timer: Work around QorIQ Erratum
 A-008585
In-Reply-To: <1474260085.15220.17.camel@buserror.net>
References: <1473469413-11019-1-git-send-email-oss@buserror.net>
 <1473469413-11019-3-git-send-email-oss@buserror.net>
 <20160912113615.GA20804@leverpostej>
 <1474260085.15220.17.camel@buserror.net>
Message-ID: <20160919165258.GA30584@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 18, 2016 at 11:41:25PM -0500, Scott Wood wrote:
> On Mon, 2016-09-12 at 12:36 +0100, Mark Rutland wrote:
> > On Fri, Sep 09, 2016 at 08:03:31PM -0500, Scott Wood wrote:
> > > +static __always_inline void arch_timer_cval_write_cp15(int access, u64
> > > val)
> > > +{
> > > +	if (access == ARCH_TIMER_PHYS_ACCESS)
> > > +		asm volatile("msr cntp_cval_el0, %0" : : "r" (val));
> > > +	else if (access == ARCH_TIMER_VIRT_ACCESS)
> > > +		asm volatile("msr cntv_cval_el0, %0" : : "r" (val));
> > > +
> > > +	isb();
> > > +}
> > Please add ARCH_TIMER_REG_CVAL to enum arch_timer_reg, and move these
> > accesses into arch_timer_reg_write_cp15().
> 
> Adding ARCH_TIMER_REG_CVAL to the enum means we get warnings from bunch of
> switch statements that don't actually need a CVAL implementation -- or else we
> have to add untested CVAL accessors for arm32 and mmio. ?The arm32 part would
> add another dependency on getting an ack from RMK, that can't be postponed as
> easily as the archdata/vdso patch.

That's annoying. Never mind, then.

> Since this is specific to an erratum rather than general cval support, I can
> move the accesses into fsl_a008585_set_next_event (and convert to
> write_sysreg).

Ok. I think that's preferable given we have no other users.

> > > +static void fsl_a008585_set_sne(struct clock_event_device *clk)
> > > +{
> > > +#ifdef CONFIG_FSL_ERRATUM_A008585
> > > +	if (!static_branch_unlikely(&arch_timer_read_ool_enabled))
> > > +		return;
> > > +
> > > +	if (arch_timer_uses_ppi == VIRT_PPI)
> > > +		clk->set_next_event = fsl_a008585_set_next_event_virt;
> > > +	else
> > > +		clk->set_next_event = fsl_a008585_set_next_event_phys;
> > > +#endif
> > > +}
> > > +
> > I'm not keen on the magic hook to reset the function pointers, and the
> > additional phys/virt stubs seem pointless. Instead, can we fold this
> > into the existing set_next_event? e.g. have that do:
> > 
> > 	if (needs_fsl_a008585_workaround() {
> > 		fsl_a008585_set_next_event(access, evt, clk);
> > 		return;
> > 	}
> 
> OK. ?I had been trying to avoid messing with the standard set_next_event, but
> it doesn't matter as much now that static branches are being used. ?In that
> case we can avoid duplicating the ctrl code, and only replace the tval write.

Reconsidering my suggestion, I realise this will also affect the MMIO
timers, so that doesn't work.

So for the moment, I guess we have to keep fsl_a008585_set_next_event().

Thanks,
Mark.
