From: will.deacon@arm.com (Will Deacon)
Date: Thu, 28 Apr 2011 18:25:26 +0100
Subject: [PATCH] ARM: perf: remove erroneous check on active_events
In-Reply-To: <20110428161242.GE3052@pulham.picochip.com>
References: <1303898236-14263-1-git-send-email-mark.rutland@arm.com>
	<20110428154108.GV17290@n2100.arm.linux.org.uk>
	<20110428161242.GE3052@pulham.picochip.com>
Message-ID: <1304011526.4680.15.camel@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi guys [adding Peter Z],

On Thu, 2011-04-28 at 17:12 +0100, Jamie Iles wrote:
> On Thu, Apr 28, 2011 at 04:41:08PM +0100, Russell King - ARM Linux wrote:
> > On Wed, Apr 27, 2011 at 10:57:16AM +0100, Mark Rutland wrote:
> > > diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
> > > index fd6403c..29a0cf8 100644
> > > --- a/arch/arm/kernel/perf_event.c
> > > +++ b/arch/arm/kernel/perf_event.c
> > > @@ -560,11 +560,6 @@ static int armpmu_event_init(struct perf_event *event)
> > >     event->destroy = hw_perf_event_destroy;
> > > 
> > >     if (!atomic_inc_not_zero(&active_events)) {
> > > -           if (atomic_read(&active_events) > armpmu->num_events) {
> > > -                   atomic_dec(&active_events);
> >
> > Yuck.  This is a good example of atomic_* abuse.  The above does nothing
> > to deal with the situation where two threads are running thusly:
> > CPU0                                  CPU1
> > atomic_inc_not_zero(&active_events)
> >                                       atomic_inc_not_zero(&active_events)

Agreed. Mark's patch is deleting the offending code though, so that's a
plus.

> Yup, I messed up there.  How about the patch below that eliminates the
> atomic_t's entirely?  This means that we always lock the mutex in event
> destruction rather than just for the last one but that seems acceptable
> to me.
> 
> The MIPS perf events code is based on this so could do with the same
> change.

Does the x86 code also need updating to address Ashwin's comments about
the standard deviation? AFAICT the original patch would simply make ARM
in line with x86 anyway, where -ENOSPC is returned at the add() level
for individual events.

One argument for leaving the policy like it is, is that the user should
be grouping the events, so that the deviation is at least consistent and
the group will not be scheduled unless the whole thing can go on at
once.

Will
