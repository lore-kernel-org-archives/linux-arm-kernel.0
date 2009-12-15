From: jamie@jamieiles.com (Jamie Iles)
Date: Tue, 15 Dec 2009 15:02:05 +0000
Subject: [PATCH 5/5] arm/perfevents: implement perf event support for ARMv6
In-Reply-To: <000101ca7d92$fe903000$fbb09000$@deacon@arm.com>
References: <1260875712-29712-1-git-send-email-jamie.iles@picochip.com>
	<1260875712-29712-2-git-send-email-jamie.iles@picochip.com>
	<1260875712-29712-3-git-send-email-jamie.iles@picochip.com>
	<1260875712-29712-4-git-send-email-jamie.iles@picochip.com>
	<1260875712-29712-5-git-send-email-jamie.iles@picochip.com>
	<1260875712-29712-6-git-send-email-jamie.iles@picochip.com>
	<000101ca7d92$fe903000$fbb09000$@deacon@arm.com>
Message-ID: <20091215150205.GO4141@wear.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On Tue, Dec 15, 2009 at 02:29:21PM -0000, Will Deacon wrote:
> > +static struct arm_pmu armv6pmu = {
> > +	.name			= "v6",
> > +	.handle_irq		= armv6pmu_handle_irq,
> > +	.enable			= armv6pmu_enable_event,
> > +	.disable		= armv6pmu_disable_event,
> > +	.event_map		= armv6pmu_event_map,
> > +	.raw_event		= armv6pmu_raw_event,
> > +        .read_counter           = armv6pmu_read_counter,
> > +        .write_counter          = armv6pmu_write_counter,
> > +	.get_event_idx		= armv6pmu_get_event_idx,
> > +        .start                  = armv6pmu_start,
> > +	.stop		        = armv6pmu_stop,
> > +	.num_events		= 3,
> > +	.max_period		= (1LLU << 32) - 1,
> > +};
> 
> Your indentation seems to have gone awry here, I think I saw it somewhere
> else in the file too.
Indeed. That needs fixing.

> Watch out for the 11MPCore CPU. The event numbers are defined *slightly*
> differently (1136,1156 and 1176 don't have any conflicts with each other,
> but the 11MPCore does). If you look at the TRM the first 6 events are the
> same as for other v6 cores, but then event 0x06 becomes a new event: `branch
> not predicted' which offsets the others by one. Other than that, the PMUs
> are accessed the same way on each core, so you just need to make sure you
> select the correct event mappings.
Ok, is it a safe assumption that for ARMv6 if num_possible_cpus() returns >1
we are mpcore and need to use different ID's or is there a better way to test
for mpcore?

Thanks,

Jamie
