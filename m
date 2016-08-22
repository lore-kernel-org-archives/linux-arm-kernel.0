From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 22 Aug 2016 15:09:04 +0100
Subject: [PATCHv2] arm: l2x0: add PMU support
In-Reply-To: <20160822133720.GI14680@arm.com>
References: <1471602346-26466-1-git-send-email-mark.rutland@arm.com>
 <20160822133720.GI14680@arm.com>
Message-ID: <20160822140904.GC30850@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 22, 2016 at 02:37:20PM +0100, Will Deacon wrote:
> On Fri, Aug 19, 2016 at 11:25:46AM +0100, Mark Rutland wrote:
> > +/* How many counters are allocated? */
> > +static bool l2x0_pmu_num_active_counters(void)
> > +{
> 
> I know you only have two counters, but using a bool here is perverse!
> 
> > +	int i, cnt = 0;
> > +
> > +	for (i = 0; i < PMU_NR_COUNTERS; i++) {
> > +		if (events[i])
> > +			cnt++;
> > +	}
> > +
> > +	return cnt;
> > +}

Whoops. That's a hold-over from development when this was called
something like l2x0_pmu_has_active_counters().

I've fixed this to return an int.

Luckily the callsites all compare against zero, so there shouldn't be a
functional problem.

> > +static __init int l2x0_pmu_register(void)
> > +{
> > +	int ret;
> > +	const char *name;
> > +
> > +	if (!l2x0_base)
> > +		return 0;
> > +
> > +	/* Only L220 and PL310 have a PMU */
> > +	if (strcmp("L2C-220", l2x0_data->type) == 0)
> > +		name = "l2c_220";
> > +	if (strcmp("L2C-310", l2x0_data->type) == 0)
> > +		name = "l2c_310";
> > +	else
> > +		return 0;
> 
> Turns out that the L210 *does* have a PMU, but it's quite different and
> I don't think we should bother supporting it for now. Worth updating the
> comment, though.

Indeed. I've rewritten the above to mention how the name is used by the
sysfs code, mentioning that we do not support the L210 PMU.

Thanks,
Mark.
