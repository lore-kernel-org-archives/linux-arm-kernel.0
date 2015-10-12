From: will.deacon@arm.com (Will Deacon)
Date: Mon, 12 Oct 2015 15:30:25 +0100
Subject: [PATCHv2] arm: perf: Add event descriptions
In-Reply-To: <20151009165330.GA22415@dreric01-gentoo.localdomain>
References: <20151007182735.GA18706@dreric01-gentoo.localdomain>
 <20151009101338.GH26278@arm.com>
 <20151009165330.GA22415@dreric01-gentoo.localdomain>
Message-ID: <20151012143025.GG16124@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 09, 2015 at 09:53:32AM -0700, Drew Richardson wrote:
> On Fri, Oct 09, 2015 at 11:13:38AM +0100, Will Deacon wrote:
> > On Wed, Oct 07, 2015 at 11:28:18AM -0700, Drew Richardson wrote:
> > > diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
> > > index 126dc679b230..6623bd0d8a1d 100644
> > > --- a/arch/arm/kernel/perf_event_v7.c
> > > +++ b/arch/arm/kernel/perf_event_v7.c
> > > @@ -547,6 +547,95 @@ static const unsigned scorpion_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
> > >  	[C(BPU)][C(OP_WRITE)][C(RESULT_MISS)] = ARMV7_PERFCTR_PC_BRANCH_MIS_PRED,
> > >  };
> > >  
> > > +static ssize_t armv7_event_sysfs_show(struct device *dev,
> > > +				      struct device_attribute *attr, char *page)
> > > +{
> > > +	struct perf_pmu_events_attr *pmu_attr;
> > > +
> > > +	pmu_attr = container_of(attr, struct perf_pmu_events_attr, attr);
> > > +
> > > +	return sprintf(page, "event=0x%02llx\n", pmu_attr->id);
> > > +}
> > 
> > Can we not do this with a couple of macros, stringification of the event
> > code and PMU_EVENT_ATTR_STRING, therefore avoiding this function entirely?
> 
> I assumed that doing it this way would be smaller, but using
> PMU_EVENT_ATTR_STRING is a few hundred bytes smaller, see
> below. (Please let me know if you'd prefer I send it out in a separate
> email or even a new thread)

I think this looks much better, thanks. The only thing left to do is
re-use some of the existing event descriptions from the enum
armv7_perf_types that we have at the top of the file, rather than
duplicate the event -> ID mapping. Feel free to extend the enumeration
if you need to (it's intended to cover all of the architected events).

Thanks,

Will
