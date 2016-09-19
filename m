From: oss@buserror.net (Scott Wood)
Date: Sun, 18 Sep 2016 23:41:25 -0500
Subject: [PATCH v5 3/5] arm64: arch_timer: Work around QorIQ Erratum
 A-008585
In-Reply-To: <20160912113615.GA20804@leverpostej>
References: <1473469413-11019-1-git-send-email-oss@buserror.net>
 <1473469413-11019-3-git-send-email-oss@buserror.net>
 <20160912113615.GA20804@leverpostej>
Message-ID: <1474260085.15220.17.camel@buserror.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2016-09-12 at 12:36 +0100, Mark Rutland wrote:

> On Fri, Sep 09, 2016 at 08:03:31PM -0500, Scott Wood wrote:
> > +static __always_inline void arch_timer_cval_write_cp15(int access, u64
> > val)
> > +{
> > +	if (access == ARCH_TIMER_PHYS_ACCESS)
> > +		asm volatile("msr cntp_cval_el0, %0" : : "r" (val));
> > +	else if (access == ARCH_TIMER_VIRT_ACCESS)
> > +		asm volatile("msr cntv_cval_el0, %0" : : "r" (val));
> > +
> > +	isb();
> > +}
> Please add ARCH_TIMER_REG_CVAL to enum arch_timer_reg, and move these
> accesses into arch_timer_reg_write_cp15().

Adding ARCH_TIMER_REG_CVAL to the enum means we get warnings from bunch of
switch statements that don't actually need a CVAL implementation -- or else we
have to add untested CVAL accessors for arm32 and mmio. ?The arm32 part would
add another dependency on getting an ack from RMK, that can't be postponed as
easily as the archdata/vdso patch.

Since this is specific to an erratum rather than general cval support, I can
move the accesses into fsl_a008585_set_next_event (and convert to
write_sysreg).

> > 
> > +
> > +	do {
> > +		isb();
> What's the ISB for?
> 
> The core should order accesses to the same counter, and any ISB required
> for ordering against other counters should already be present. So I
> don't follow what this is trying to achieve.
> 
> If this is necessary, please add a comment explaining what it is
> intended to ensure.

I think it may have been a leftover from early patch versions when this
function was entirely replacing arch_counter_get_cntvct(). ?I'm not sure why I
put it in the loop, though.

> > @@ -271,6 +346,19 @@ static int
> > arch_timer_set_next_event_phys_mem(unsigned long evt,
> > ?	return 0;
> > ?}
> > ?
> > +static void fsl_a008585_set_sne(struct clock_event_device *clk)
> > +{
> > +#ifdef CONFIG_FSL_ERRATUM_A008585
> > +	if (!static_branch_unlikely(&arch_timer_read_ool_enabled))
> > +		return;
> > +
> > +	if (arch_timer_uses_ppi == VIRT_PPI)
> > +		clk->set_next_event = fsl_a008585_set_next_event_virt;
> > +	else
> > +		clk->set_next_event = fsl_a008585_set_next_event_phys;
> > +#endif
> > +}
> > +
> I'm not keen on the magic hook to reset the function pointers, and the
> additional phys/virt stubs seem pointless. Instead, can we fold this
> into the existing set_next_event? e.g. have that do:
> 
> 	if (needs_fsl_a008585_workaround() {
> 		fsl_a008585_set_next_event(access, evt, clk);
> 		return;
> 	}

OK. ?I had been trying to avoid messing with the standard set_next_event, but
it doesn't matter as much now that static branches are being used. ?In that
case we can avoid duplicating the ctrl code, and only replace the tval write.

-Scott
