From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 15 Oct 2015 17:44:17 +0100
Subject: [PATCH v5 2/2] arm: perf: Add event descriptions
In-Reply-To: <20151015163144.GA19108@dreric01-gentoo.localdomain>
References: <20151009101338.GH26278@arm.com>
 <20151009165330.GA22415@dreric01-gentoo.localdomain>
 <20151012143025.GG16124@arm.com>
 <20151012181037.GA16013@dreric01-gentoo.localdomain>
 <20151013153644.GC18121@dreric01-gentoo.localdomain>
 <20151015132111.GD29301@arm.com>
 <20151015151506.GC18965@dreric01-gentoo.localdomain>
 <20151015152915.GH29301@arm.com>
 <20151015154126.GL8825@leverpostej>
 <20151015163144.GA19108@dreric01-gentoo.localdomain>
Message-ID: <20151015164416.GN8825@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 15, 2015 at 09:31:46AM -0700, Drew Richardson wrote:
> On Thu, Oct 15, 2015 at 04:41:26PM +0100, Mark Rutland wrote:
> > On Thu, Oct 15, 2015 at 04:29:15PM +0100, Will Deacon wrote:
> > > On Thu, Oct 15, 2015 at 08:15:06AM -0700, Drew Richardson wrote:
> > > > On Thu, Oct 15, 2015 at 02:21:12PM +0100, Will Deacon wrote:
> > > > > On Tue, Oct 13, 2015 at 08:36:45AM -0700, Drew Richardson wrote:
> > > > > > Add additional information about the ARM architected hardware events
> > > > > > to make counters self describing. This makes the hardware PMUs easier
> > > > > > to use as perf list contains possible events instead of users having
> > > > > > to refer to documentation like the ARM TRMs.
> > > > > > 
> > > > > > Signed-off-by: Drew Richardson <drew.richardson@arm.com>
> > > > > > ---
> > > > > >  arch/arm/kernel/perf_event_v7.c | 121 ++++++++++++++++++++++++++++++++++++++++
> > > > > >  drivers/perf/arm_pmu.c          |   1 +
> > > > > >  2 files changed, 122 insertions(+)
> > > > > 
> > > > > [...]
> > > > > 
> > > > > > diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
> > > > > > index 2365a32a595e..e933d2dd71c0 100644
> > > > > > --- a/drivers/perf/arm_pmu.c
> > > > > > +++ b/drivers/perf/arm_pmu.c
> > > > > > @@ -548,6 +548,7 @@ static void armpmu_init(struct arm_pmu *armpmu)
> > > > > >  		.stop		= armpmu_stop,
> > > > > >  		.read		= armpmu_read,
> > > > > >  		.filter_match	= armpmu_filter_match,
> > > > > > +		.attr_groups	= armpmu->pmu.attr_groups,
> > > > > 
> > > > > I don't understand this hunk. What's it doing?
> > > > 
> > > > I'm not 100% clear either on what it's doing. But without this line
> > > > the attr_groups don't get passed on and I don't see them on my TC2. I
> > > > debugged the issue down to this but it may not be the proper way to
> > > > solve the problem.
> > > 
> > > Oh yuck, it's because we call armpmu_init after cpu_pmu_init and the former
> > > uses struct initialisation and ends up zeroing anything set previously.
> > > 
> > > We should probably tidy all this up:
> > > 
> > >   * Remove armpmu_register and call perf_pmu_register directly from
> > >     arm_pmu_device_probe instead
> > > 
> > >   * Call armpmu_init immediately prior to arm_cpu_init
> > 
> > Assuming you mean cpu_pmu_init, how about the below?
> > 
> > Thanks,
> > Mark.
> > 
> > ---->8----
> > From f8a99a406f3dd7a272a6dee4a551436fea851f38 Mon Sep 17 00:00:00 2001
> > From: Mark Rutland <mark.rutland@arm.com>
> > Date: Thu, 15 Oct 2015 16:32:17 +0100
> > Subject: [PATCH] drivers/perf: kill armpmu_register
> > 
> > Nothing outside of drivers/perf/arm_pmu.c should call armpmu_register
> > any more, so it no longer needs to be in include/linux/perf/arm_pmu.h.
> > Additionally, by folding it in to arm_pmu_device_probe we can allow
> > drivers to override struct pmu fields without getting blatted by the
> > armpmu code.
> > 
> > This patch folds armpmu_register into arm_pmu_device_probe. The logging
> > to the console is moved to after the PMU is successfully registered with
> > the core perf code.
> > 
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Suggested-by: Will Deacon <will.deacon@arm.com>
> > Cc: Drew Richardson <drew.richardson@arm.com>
> > Cc: Pawel Moll <pawel.moll@arm.com>
> > ---
> >  drivers/perf/arm_pmu.c       | 14 +++++---------
> >  include/linux/perf/arm_pmu.h |  2 --
> >  2 files changed, 5 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
> > index f346960..15463cb 100644
> > --- a/drivers/perf/arm_pmu.c
> > +++ b/drivers/perf/arm_pmu.c
> > @@ -583,14 +583,6 @@ static void armpmu_init(struct arm_pmu *armpmu)
> >  	};
> >  }
> >  
> > -int armpmu_register(struct arm_pmu *armpmu, int type)
> > -{
> > -	armpmu_init(armpmu);
> > -	pr_info("enabled with %s PMU driver, %d counters available\n",
> > -			armpmu->name, armpmu->num_events);
> > -	return perf_pmu_register(&armpmu->pmu, armpmu->name, type);
> > -}
> > -
> >  /* Set at runtime when we know what CPU type we are. */
> >  static struct arm_pmu *__oprofile_cpu_pmu;
> >  
> > @@ -934,14 +926,18 @@ int arm_pmu_device_probe(struct platform_device *pdev,
> >  		goto out_free;
> >  	}
> >  
> > +	armpmu_init(pmu);
> >  	ret = cpu_pmu_init(pmu);
> >  	if (ret)
> >  		goto out_free;
> >  
> > -	ret = armpmu_register(pmu, -1);
> > +	ret = perf_pmu_register(&pmu->pmu, pmu->name, -1);
> >  	if (ret)
> >  		goto out_destroy;
> >  
> > +	pr_info("enabled with %s PMU driver, %d counters available\n",
> > +			pmu->name, pmu->num_events);
> > +
> >  	return 0;
> >  
> >  out_destroy:
> > diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
> > index bfa673b..83b5e34 100644
> > --- a/include/linux/perf/arm_pmu.h
> > +++ b/include/linux/perf/arm_pmu.h
> > @@ -111,8 +111,6 @@ struct arm_pmu {
> >  
> >  #define to_arm_pmu(p) (container_of(p, struct arm_pmu, pmu))
> >  
> > -int armpmu_register(struct arm_pmu *armpmu, int type);
> > -
> >  u64 armpmu_event_update(struct perf_event *event);
> >  
> >  int armpmu_event_set_period(struct perf_event *event);
> > -- 
> > 1.9.1
> > 
> 
> Unfortunately the copy of attr_groups in armpmu_init is still required
> even with this patch. The armv7_a*_pmu_init functions are obtained
> from the platform_device (assigned to init_fn) and called before
> armpmu_init.

Ah, whoops. Sorry about that.

It looks like I should be able to move armpmu_init immediately after it
gets allocated, before the init_fn gets called. I'll respin (and test)
the patch.

Thanks,
Mark.
