From: robert.richter@amd.com (Robert Richter)
Date: Mon, 30 Aug 2010 14:41:58 +0200
Subject: [PATCH 2/4] sh: Accessor functions for the sh_pmu state
In-Reply-To: <20100827191745.GA7258@console-pimps.org>
References: <cover.1282848651.git.matt@console-pimps.org>
	<f259830dbccb084d27d127676b979d9cb502e36f.1282848651.git.matt@console-pimps.org>
	<20100827134301.GL22783@erda.amd.com>
	<20100827191745.GA7258@console-pimps.org>
Message-ID: <20100830124158.GY22783@erda.amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27.08.10 15:17:45, Matt Fleming wrote:

> > > --- a/arch/sh/kernel/perf_event.c
> > > +++ b/arch/sh/kernel/perf_event.c
> > > @@ -60,6 +60,19 @@ static inline int sh_pmu_initialized(void)
> > >  }
> > >  
> > >  /*
> > > + * Return the number of events for the current sh_pmu.
> > > + */
> > > +int sh_pmu_num_events(void)
> > > +{
> > > +	return sh_pmu->num_events;
> > > +}
> > > +
> > > +const char *sh_pmu_name(void)
> > > +{
> > > +	return sh_pmu->name;
> > > +}

> > This accessor functions should be generic for all architectures.
> 
> This isn't going to work. ARM uses an integer ID whereas SH uses a
> string name. This is specific to an architecture and making it generic
> would probably involve some abstraction layer.

Perf should provide the interface to detect the number of counters
(btw. *num_events is wrong) and the name of the pmu. The information
is part of perf and thus the functions accessing it should be part of
perf too, not oprofile.

We also need generic functions, because we want to have a generic
oprofile-perf driver.

I don't see that this is hard to implement. We could add function
stubs returning an error or invalid value using the __weak attribute
and implement it for those architectures where we need it.

-Robert

-- 
Advanced Micro Devices, Inc.
Operating System Research Center
