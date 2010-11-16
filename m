From: will.deacon@arm.com (Will Deacon)
Date: Tue, 16 Nov 2010 09:47:04 -0000
Subject: [PATCH 1/5] ARM: perf: consolidate common PMU behaviour
In-Reply-To: <AANLkTi=mu6iG9Yhhtp31g0aDH7+X0i6G8vZiW5FGmV-C@mail.gmail.com>
References: <1289842263-21241-1-git-send-email-will.deacon@arm.com>	<1289842263-21241-2-git-send-email-will.deacon@arm.com>
	<AANLkTi=mu6iG9Yhhtp31g0aDH7+X0i6G8vZiW5FGmV-C@mail.gmail.com>
Message-ID: <005601cb8573$39cab3f0$ad601bd0$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jean,

> > diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
> > index 07a5035..c49e170 100644
> > --- a/arch/arm/kernel/perf_event.c
> > +++ b/arch/arm/kernel/perf_event.c
> ...
> 
> > @@ -166,6 +165,19 @@ armpmu_map_cache_event(u64 config)
> >  }
> >
> >  static int
> > +armpmu_map_event(u64 config)
> > +{
> > +       int mapping = (*armpmu->event_map)[config];
> > +       return mapping == HW_OP_UNSUPPORTED ? -EOPNOTSUPP : mapping;
> > +}
> > +
> > +static int
> > +armpmu_map_raw_event(u64 config)
> > +{
> > +       return (int)(config & armpmu->raw_event_mask);
> > +}
> > +
> > +static int
> >  armpmu_event_set_period(struct perf_event *event,
> >                        struct hw_perf_event *hwc,
> >                        int idx)
> 
> Those functions could be inlined for performance reason.

Since these are static functions with no side effects, any half-decent
compiler should do the inlining for us. I checked the disassembly to be
sure (GCC based on 4.5.1) and, not only are the above functions inlined,
but __hw_perf_event_init is inlined into armpmu_event_init too.

> Other than that minor remark, I am OK
> Acked-by: Jean Pihet <j-pihet@ti.com>

Thanks,

Will
