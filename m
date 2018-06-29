From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 29 Jun 2018 15:29:52 +0100
Subject: [PATCH v3 4/7] arm_pmu: Tidy up clear_event_idx call backs
In-Reply-To: <109b2082-f4ae-9095-7d6f-9daf78b38144@arm.com>
References: <1529403342-17899-1-git-send-email-suzuki.poulose@arm.com>
 <1529403342-17899-5-git-send-email-suzuki.poulose@arm.com>
 <20180629134049.b6sppasr7j32h37g@lakrids.cambridge.arm.com>
 <109b2082-f4ae-9095-7d6f-9daf78b38144@arm.com>
Message-ID: <20180629142951.lzuzvw6oisrnjjgn@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 29, 2018 at 03:18:23PM +0100, Suzuki K Poulose wrote:
> 
> Hi Mark,
> 
> On 29/06/18 14:40, Mark Rutland wrote:
> > On Tue, Jun 19, 2018 at 11:15:39AM +0100, Suzuki K Poulose wrote:
> > > The armpmu uses get_event_idx callback to allocate an event
> > > counter for a given event, which marks the selected counter
> > > as "used". Now, when we delete the counter, the arm_pmu goes
> > > ahead and clears the "used" bit and then invokes the "clear_event_idx"
> > > call back, which kind of splits the job between the core code
> > > and the backend. Tidy this up by relying on the clear_event_idx
> > > to do the book keeping, if available. Otherwise, let the core
> > > driver do the default "clear" bit operation. This will be useful
> > > for adding the chained event support, where we leave the event
> > > idx maintenance to the backend.
> > > 
> > > Also, when an event is removed from the PMU, reset the hw.idx
> > > to indicate that a counter is not allocated for this event,
> > > to help the backends do better checks. This will be also used
> > > for the chain counter support.
> > > 
> > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > Cc: Will Deacon <will.deacon@arm.com>
> > > Reviewed-by: Julien Thierry <julien.thierry@arm.com>
> > > Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> > > ---
> > > Changes since v2:
> > >   - Reset the event counter after an event is removed.
> > > ---
> > >   arch/arm/kernel/perf_event_v7.c |  2 ++
> > >   drivers/perf/arm_pmu.c          | 17 +++++++++++++----
> > >   2 files changed, 15 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
> > > index fd7ce01..765d265 100644
> > > --- a/arch/arm/kernel/perf_event_v7.c
> > > +++ b/arch/arm/kernel/perf_event_v7.c
> > > @@ -1637,6 +1637,7 @@ static void krait_pmu_clear_event_idx(struct pmu_hw_events *cpuc,
> > >   	bool venum_event = EVENT_VENUM(hwc->config_base);
> > >   	bool krait_event = EVENT_CPU(hwc->config_base);
> > > +	clear_bit(hwc->idx, cpuc->used_mask);
> > >   	if (venum_event || krait_event) {
> > >   		bit = krait_event_to_bit(event, region, group);
> > >   		clear_bit(bit, cpuc->used_mask);
> > > @@ -1966,6 +1967,7 @@ static void scorpion_pmu_clear_event_idx(struct pmu_hw_events *cpuc,
> > >   	bool venum_event = EVENT_VENUM(hwc->config_base);
> > >   	bool scorpion_event = EVENT_CPU(hwc->config_base);
> > > +	clear_bit(hwc->idx, cpuc->used_mask);
> > >   	if (venum_event || scorpion_event) {
> > >   		bit = scorpion_event_to_bit(event, region, group);
> > >   		clear_bit(bit, cpuc->used_mask);
> > 
> > As an aside, I think there's an existing problem with krait and
> > cpu_pm_pmu_setup(), and we'll end up with the same issue when chained
> > counters use multiple counters for one event.
> > 
> > The krait code sets multiple bits in the PMU's pmu_hw_events::used_mask,
> > but only one of these will have a corresponding (non-NULL) entry in
> > pmu_hw_events::events[].
> 
> The Krait pmu allocates the "krait" specific event bit beyond the armpmu->num_events.
> See krait_event_to_bit(). And we don't go beyond armpmu->num_events for the "events"
> check. So we should be safe. And it passes on the idx within the num_events back
> to armpmu. So whatever krait pmu does is invisible to the generic driver.

Ah; I had missed that, sorry for the noise.

> > I guess the best thing to do would be to avoid the test_bit(), and just
> > skip an idx if hw_events->events[idx] is NULL.
> > 
> > Would you mind spinning a patch to that effect?
> 
> Eitherway, I could split that change to a new one.

No need -- sorry for the noise.

Thanks,
Mark.
