From: will.deacon@arm.com (Will Deacon)
Date: Tue, 4 Sep 2012 18:26:23 +0100
Subject: [PATCH V2 3/6] arm: cache-l2x0: add support for Aurora L2 cache
 ctrl
In-Reply-To: <5046152A.1050601@free-electrons.com>
References: <1346755232-26006-1-git-send-email-gregory.clement@free-electrons.com>
 <1346755232-26006-4-git-send-email-gregory.clement@free-electrons.com>
 <20120904112247.GF2458@mudshark.cambridge.arm.com>
 <5046152A.1050601@free-electrons.com>
Message-ID: <20120904172623.GP2458@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 04, 2012 at 03:50:18PM +0100, Gregory CLEMENT wrote:
> >> +       /*
> >> +        * Clean and invalidate partial last cache line.
> >> +        */
> >> +       if (start < end && end & (CACHE_LINE_SIZE - 1)) {
> >> +               writel((end & ~(CACHE_LINE_SIZE - 1)) & ~0x1f,
> >> +                       l2x0_base + AURORA_FLUSH_PHY_ADDR_REG);
> >> +               cache_sync();
> >> +               end &= ~(CACHE_LINE_SIZE - 1);
> >> +       }
> >> +
> >> +       /*
> >> +        * Invalidate all full cache lines between 'start' and 'end'.
> >> +        */
> >> +       while (start < end) {
> >> +               unsigned long range_end = calc_range_end(start, end);
> >> +               aurora_pa_range(start, range_end - CACHE_LINE_SIZE,
> >> +                               AURORA_INVAL_RANGE_REG);
> >> +               start = range_end;
> >> +       }
> >> +
> >> +       dsb();
> >
> > Why? (same for the other dsbs following writels/cache_syncs).
> 
> I will ask if it is really needed.

I just think you'll get the dsb() via aurora_pa_range, so you shouldn't need
the extra one after the loop.

> >> +static void aurora_resume(void)
> >> +{
> >> +       u32 u;
> >> +
> >> +       u = readl(l2x0_base + L2X0_CTRL);
> >> +       if (!(u & 1)) {
> >
> > We should probably add a L2X0_CTRL_EN define and use that (also update the
> > enabling code to use it as well).
> >
> 
> Should it be a separate patch or can I include it with this one?

I think you can just include it here (it's trivial to implement).

> >> +static void __init aurora_of_setup(const struct device_node *np,
> >> +                               u32 *aux_val, u32 *aux_mask)
> >> +{
> >> +       u32 val = AURORA_ACR_REPLACEMENT_TYPE_SEMIPLRU;
> >> +       u32 mask =  AURORA_ACR_REPLACEMENT_MASK;
> >> +
> >> +       of_property_read_u32(np, "cache-id-part",
> >> +                       &cache_id_part_number_from_dt);
> >> +
> >> +       /* Determine and save the write policy */
> >> +       l2_wt_override = of_property_read_bool(np, "wt-override");
> >> +
> >> +       if (l2_wt_override) {
> >> +               val |= AURORA_ACR_FORCE_WRITE_THRO_POLICY;
> >> +               mask |= AURORA_ACR_FORCE_WRITE_POLICY_MASK;
> >> +       }
> >
> > smp_mb() after the assignment to l2_wt_override?
> 
> Sorry I don't get your point, why do you think we need this?

In case you get an outer_cache operation from a different core before the
assignment to l2_wt_override has become visible, in which case you might
accidentally skip the operation (e.g. if it's clean). This may well be
overkill, since we probably have the same problem for stuff like the base
address already.

Will
