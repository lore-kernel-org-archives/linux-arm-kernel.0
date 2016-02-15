From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 15 Feb 2016 14:46:52 +0000
Subject: [RFC PATCH 1/7] arm64/perf: Basic uncore counter support for
 Cavium ThunderX
In-Reply-To: <20160215142726.GD9732@leverpostej>
References: <cover.1455295032.git.jglauber@cavium.com>
 <8bd93a25e069ed6428bc6c21fc53270962ccafcc.1455295032.git.jglauber@cavium.com>
 <20160212173658.GD20262@leverpostej>
 <20160215140720.GA4053@hardcore>
 <20160215142726.GD9732@leverpostej>
Message-ID: <20160215144652.GF9732@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 15, 2016 at 02:27:27PM +0000, Mark Rutland wrote:
> > > > +	uncore = event_to_thunder_uncore(event);
> > > > +	if (!uncore)
> > > > +		return -ENODEV;
> > > > +	if (!uncore->event_valid(event->attr.config))
> > > > +		return -EINVAL;
> > > > +
> > > > +	hwc->config = event->attr.config;
> > > > +	hwc->idx = -1;
> > > > +
> > > > +	/* and we don't care about CPU */
> > > 
> > > Actually, you do. You want the perf core to serialize accesses via the
> > > same CPU, so all events _must_ be targetted at the same CPU. Otherwise
> > > there are a tonne of problems you don't even want to think about.
> > 
> > I found that perf added the events on every CPU in the system. Because
> > the uncore events are not CPU related I wanted to avoid this. Setting
> > cpumask to -1 did not work. Therefore I added a single CPU in the
> > cpumask, see thunder_uncore_attr_show_cpumask().
> 
> I understand that, which is why I wrote:
> 
> > > You _must_ ensure this kernel-side, regardless of what the perf tool
> > > happens to do.
> > > 
> > > See the arm-cci and arm-ccn drivers for an example.
> 
> Take a look at drivers/bus/arm-cci.c; specifically, what we do in
> cci_pmu_event_init and cci_pmu_cpu_notifier.
> 
> This is the same thing that's done for x86 system PMUs. Take a look at
> uncore_pmu_event_init in arch/x86/kernel/cpu/perf_event_intel_uncore.c.

I note that we still have an open TODO rather than a call to
perf_pmu_migrate_context.

The better example is arm_ccn_pmu_cpu_notifier in drivers/bus/arm-ccn.c.

Mark.
