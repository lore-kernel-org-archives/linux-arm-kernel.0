From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 9 Apr 2015 15:40:29 +0100
Subject: [PATCH] drivers: CCI: fix used_mask init in validate_group()
In-Reply-To: <1428589600.20354.27.camel@deneb.redhat.com>
References: <1428517284-7951-1-git-send-email-msalter@redhat.com>
 <20150409135124.GA9648@leverpostej>
 <1428588703.20354.23.camel@deneb.redhat.com>
 <20150409142047.GC9648@leverpostej>
 <1428589600.20354.27.camel@deneb.redhat.com>
Message-ID: <20150409144029.GE9648@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > > > >  validate_group(struct perf_event *event)
> > > > >  {
> > > > >  	struct perf_event *sibling, *leader = event->group_leader;
> > > > > -	struct cci_pmu_hw_events fake_pmu = {
> > > > > -		/*
> > > > > -		 * Initialise the fake PMU. We only need to populate the
> > > > > -		 * used_mask for the purposes of validation.
> > > > > -		 */
> > > > > -		.used_mask = CPU_BITS_NONE,
> > > > 
> > > > Can we not simply change this to:
> > > > 
> > > > 		.used_mask = { 0 },
> > > > 
> > > > That should result in the entire array being zeroed.
> > > 
> > > It does, but it also causes the whole struct to be cleared.
> > 
> > Sure, but it's also the minimal diff, and it's easier to read. This was
> > what the code was intended to be initially.
> > 
> > > With the memset, only used_mask gets cleared.
> > 
> > Is there an appreciable difference between the two performance-wise?
> 
> I dunno. It is 3 strp insns vs 1 str.
> If you want the static init, I'll send another patch.

I'd prefer the designated initializer to the memset.

Thanks,
Mark.
