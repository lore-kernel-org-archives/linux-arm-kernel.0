From: matt@console-pimps.org (Matt Fleming)
Date: Fri, 27 Aug 2010 20:17:45 +0100
Subject: [PATCH 2/4] sh: Accessor functions for the sh_pmu state
In-Reply-To: <20100827134301.GL22783@erda.amd.com>
References: <cover.1282848651.git.matt@console-pimps.org>
	<f259830dbccb084d27d127676b979d9cb502e36f.1282848651.git.matt@console-pimps.org>
	<20100827134301.GL22783@erda.amd.com>
Message-ID: <20100827191745.GA7258@console-pimps.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 27, 2010 at 03:43:01PM +0200, Robert Richter wrote:
> On 26.08.10 15:09:17, Matt Fleming wrote:
> > Introduce some accessor functions for getting at the name and number of
> > counters of the current sh_pmu instance.
> > 
> > Signed-off-by: Matt Fleming <matt@console-pimps.org>
> > ---
> >  arch/sh/include/asm/perf_event.h |    2 ++
> >  arch/sh/kernel/perf_event.c      |   13 +++++++++++++
> >  2 files changed, 15 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/sh/include/asm/perf_event.h b/arch/sh/include/asm/perf_event.h
> > index 3d0c9f3..5b7fa84 100644
> > --- a/arch/sh/include/asm/perf_event.h
> > +++ b/arch/sh/include/asm/perf_event.h
> > @@ -25,6 +25,8 @@ struct sh_pmu {
> >  extern int register_sh_pmu(struct sh_pmu *);
> >  extern int reserve_pmc_hardware(void);
> >  extern void release_pmc_hardware(void);
> > +extern int sh_pmu_num_events(void);
> > +extern const char *sh_pmu_name(void);
> >  
> >  static inline void set_perf_event_pending(void)
> >  {
> > diff --git a/arch/sh/kernel/perf_event.c b/arch/sh/kernel/perf_event.c
> > index 7a3dc35..086f788 100644
> > --- a/arch/sh/kernel/perf_event.c
> > +++ b/arch/sh/kernel/perf_event.c
> > @@ -60,6 +60,19 @@ static inline int sh_pmu_initialized(void)
> >  }
> >  
> >  /*
> > + * Return the number of events for the current sh_pmu.
> > + */
> > +int sh_pmu_num_events(void)
> > +{
> > +	return sh_pmu->num_events;
> > +}
> > +
> > +const char *sh_pmu_name(void)
> > +{
> > +	return sh_pmu->name;
> > +}
> > +
> > +/*
> 
> This probably needs EXPORT_SYMBOLS*(), but not really sure. Have you
> compiled oprofile as module?

Ah, no, I haven't compiled this as a module. I'll add some
EXPORT_SYMBOL()'s in the next version.

> This accessor functions should be generic for all architectures.

This isn't going to work. ARM uses an integer ID whereas SH uses a
string name. This is specific to an architecture and making it generic
would probably involve some abstraction layer.
