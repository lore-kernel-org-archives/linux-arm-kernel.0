From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 9 Apr 2015 15:20:48 +0100
Subject: [PATCH] drivers: CCI: fix used_mask init in validate_group()
In-Reply-To: <1428588703.20354.23.camel@deneb.redhat.com>
References: <1428517284-7951-1-git-send-email-msalter@redhat.com>
 <20150409135124.GA9648@leverpostej>
 <1428588703.20354.23.camel@deneb.redhat.com>
Message-ID: <20150409142047.GC9648@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 09, 2015 at 03:11:43PM +0100, Mark Salter wrote:
> On Thu, 2015-04-09 at 14:51 +0100, Mark Rutland wrote:
> > On Wed, Apr 08, 2015 at 07:21:24PM +0100, Mark Salter wrote:
> > > Currently in validate_group(), there is a static initializer
> > > for fake_pmu.used_mask which is based on CPU_BITS_NONE but
> > > the used_mask array size is based on CCI_PMU_MAX_HW_EVENTS.
> > > CCI_PMU_MAX_HW_EVENTS is not based on NR_CPUS, so CPU_BITS_NONE
> > > is not correct and will cause a build failure if NR_CPUS
> > > is set high enough to make CPU_BITS_NONE larger than used_mask.
> > 
> > Whoops. My bad.
> > 
> > > This patch changes the used_mask initialization to be runtime
> > > based on the actual size of the array.
> > > 
> > > Signed-off-by: Mark Salter <msalter@redhat.com>
> > > ---
> > >  drivers/bus/arm-cci.c | 14 +++++++-------
> > >  1 file changed, 7 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
> > > index 84fd660..1d83072 100644
> > > --- a/drivers/bus/arm-cci.c
> > > +++ b/drivers/bus/arm-cci.c
> > > @@ -679,13 +679,13 @@ static int
> > >  validate_group(struct perf_event *event)
> > >  {
> > >  	struct perf_event *sibling, *leader = event->group_leader;
> > > -	struct cci_pmu_hw_events fake_pmu = {
> > > -		/*
> > > -		 * Initialise the fake PMU. We only need to populate the
> > > -		 * used_mask for the purposes of validation.
> > > -		 */
> > > -		.used_mask = CPU_BITS_NONE,
> > 
> > Can we not simply change this to:
> > 
> > 		.used_mask = { 0 },
> > 
> > That should result in the entire array being zeroed.
> 
> It does, but it also causes the whole struct to be cleared.

Sure, but it's also the minimal diff, and it's easier to read. This was
what the code was intended to be initially.

> With the memset, only used_mask gets cleared.

Is there an appreciable difference between the two performance-wise?

Mark.
