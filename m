From: gklkml16@gmail.com (Ganapatrao Kulkarni)
Date: Thu, 11 Oct 2018 21:36:46 +0530
Subject: [PATCH v6 2/2] ThunderX2: Add Cavium ThunderX2 SoC UNCORE PMU
 driver
In-Reply-To: <3e9ab774-71db-d81d-5f0a-15fe942dfdb0@arm.com>
References: <20180621063338.20093-1-ganapatrao.kulkarni@cavium.com>
 <20180621063338.20093-3-ganapatrao.kulkarni@cavium.com>
 <c77e9601-71ca-ff09-f21d-b2493ca7c40b@arm.com>
 <CAKTKpr41udk9dGyLVZjO5pj_J7sf_sU_Td3t2R60UMxJatDDXA@mail.gmail.com>
 <3e9ab774-71db-d81d-5f0a-15fe942dfdb0@arm.com>
Message-ID: <CAKTKpr5iFHVbfOq1d1E=bcwxK4=UdExXh=QyyyJ_zE4s_5bz=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 11, 2018 at 2:43 PM Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> Hi Ganapatrao,
>
> On 11/10/18 07:39, Ganapatrao Kulkarni wrote:
> >>> +
> >>> +/*
> >>> + * We must NOT create groups containing events from multiple hardware PMUs,
> >>> + * although mixing different software and hardware PMUs is allowed.
> >>> + */
> >>> +static bool thunderx2_uncore_validate_event_group(struct perf_event *event)
> >>> +{
> >>> +     struct pmu *pmu = event->pmu;
> >>> +     struct perf_event *leader = event->group_leader;
> >>> +     struct perf_event *sibling;
> >>> +     int counters = 0;
> >>> +
> >>> +     if (leader->pmu != event->pmu && !is_software_event(leader))
> >>> +             return false;
> >>> +
> >>> +     for_each_sibling_event(sibling, event->group_leader) {
> >>> +             if (is_software_event(sibling))
> >>> +                     continue;
> >>> +             if (sibling->pmu != pmu)
> >>> +                     return false;
> >>> +             counters++;
> >>> +     }
> >>
> >> The above loop will not account for :
> >> 1) The leader event
> >> 2) The event that we are about to add.
> >>
> >> So you need to allocate counters for both the above to make sure we can
> >> accommodate the events.
> >
> > Is leader also part of sibling list?
>
> No.

not sure, what you are expecting here, this function is inline with
other perf driver code added in driver/perf

>
> >>> +static void thunderx2_uncore_start(struct perf_event *event, int flags)
> >>> +{
> >>> +     struct hw_perf_event *hwc = &event->hw;
> >>> +     struct thunderx2_pmu_uncore_channel *pmu_uncore;
> >>> +     struct thunderx2_pmu_uncore_dev *uncore_dev;
> >>> +     unsigned long irqflags;
> >>> +
> >>> +     hwc->state = 0;
> >>> +     pmu_uncore = pmu_to_thunderx2_pmu_uncore(event->pmu);
> >>> +     uncore_dev = pmu_uncore->uncore_dev;
> >>> +
> >>> +     raw_spin_lock_irqsave(&uncore_dev->lock, irqflags);
> >>> +     uncore_dev->select_channel(event);
> >>> +     uncore_dev->start_event(event, flags);
> >>> +     raw_spin_unlock_irqrestore(&uncore_dev->lock, irqflags);
> >>> +
> >>> +     perf_event_update_userpage(event);
> >>> +
> >>> +     if (!find_last_bit(pmu_uncore->active_counters,
> >>> +                             pmu_uncore->uncore_dev->max_counters)) {
> >>
> >> Are we guaranteed that the counter0 is always allocated ? What if the
> >> event is deleted and there are other events active ? A better check

timer will be active/restarted, till last bit is cleared( till last
counter is released).

> >> would be :
> >>          if (find_last_bit(...) != pmu_uncore->uncore_dev->max_counters)
> >>
> > IIUC, find_last_bit will return  zero if none of the counters are
> > active and we want to start timer for first active counter.
> >
>
> Well, if that was the case, how do you know if the bit zero is the only
> bit set ?
>
> AFAICS, lib/find_bit.c has :
>
> unsigned long find_last_bit(const unsigned long *addr, unsigned long size)
> {
>          if (size) {
>                  unsigned long val = BITMAP_LAST_WORD_MASK(size);
>                  unsigned long idx = (size-1) / BITS_PER_LONG;
>
>                  do {
>                          val &= addr[idx];
>                          if (val)
>                                  return idx * BITS_PER_LONG + __fls(val);
>
>                          val = ~0ul;
>                  } while (idx--);
>          }
>          return size;
> }
>
>
> It returns "size" when it can't find a set bit.

before start, alloc_counter is called to set, it seems we never hit
case where at-least one bit is not set.
timer will be started for first bit set and will continue till all
bits are cleared.
>
>
> >>> +             thunderx2_uncore_update(event);
> >>> +             hwc->state |= PERF_HES_UPTODATE;
> >>> +     }
> >>> +     raw_spin_unlock_irqrestore(&uncore_dev->lock, irqflags);
> >>> +}
> >>> +
> >>> +static int thunderx2_uncore_add(struct perf_event *event, int flags)
> >>> +{
> >>> +     struct hw_perf_event *hwc = &event->hw;
> >>> +     struct thunderx2_pmu_uncore_channel *pmu_uncore;
> >>> +     struct thunderx2_pmu_uncore_dev *uncore_dev;
> >>> +
> >>> +     pmu_uncore = pmu_to_thunderx2_pmu_uncore(event->pmu);
> >>> +     uncore_dev = pmu_uncore->uncore_dev;
> >>> +
> >>> +     /* Allocate a free counter */
> >>> +     hwc->idx  = alloc_counter(pmu_uncore);
> >>> +     if (hwc->idx < 0)
> >>> +             return -EAGAIN;
> >>> +
> >>> +     pmu_uncore->events[hwc->idx] = event;
> >>> +     /* set counter control and data registers base address */
> >>> +     uncore_dev->init_cntr_base(event, uncore_dev);
> >>> +
> >>> +     hwc->state = PERF_HES_UPTODATE | PERF_HES_STOPPED;
> >>> +     if (flags & PERF_EF_START)
> >>> +             thunderx2_uncore_start(event, flags);
> >>> +
> >>> +     return 0;
> >>> +}
> >>> +
> >>> +static void thunderx2_uncore_del(struct perf_event *event, int flags)
> >>> +{
> >>> +     struct thunderx2_pmu_uncore_channel *pmu_uncore =
> >>> +                     pmu_to_thunderx2_pmu_uncore(event->pmu);
> >>> +     struct hw_perf_event *hwc = &event->hw;
> >>> +
> >>> +     thunderx2_uncore_stop(event, PERF_EF_UPDATE);
> >>> +
> >>> +     /* clear the assigned counter */
> >>> +     free_counter(pmu_uncore, GET_COUNTERID(event));
> >>> +
> >>> +     perf_event_update_userpage(event);
> >>> +     pmu_uncore->events[hwc->idx] = NULL;
> >>> +     hwc->idx = -1;
> >>> +}
> >>> +
> >>> +static void thunderx2_uncore_read(struct perf_event *event)
> >>> +{
> >>> +     unsigned long irqflags;
> >>> +     struct thunderx2_pmu_uncore_channel *pmu_uncore =
> >>> +                     pmu_to_thunderx2_pmu_uncore(event->pmu);
> >>> +
> >>> +     raw_spin_lock_irqsave(&pmu_uncore->uncore_dev->lock, irqflags);
> >>> +     thunderx2_uncore_update(event);
> >>> +     raw_spin_unlock_irqrestore(&pmu_uncore->uncore_dev->lock, irqflags);
> >>> +}
> >>> +
> >>> +static enum hrtimer_restart thunderx2_uncore_hrtimer_callback(
> >>> +             struct hrtimer *hrt)
> >>> +{
> >>> +     struct thunderx2_pmu_uncore_channel *pmu_uncore;
> >>> +     unsigned long irqflags;
> >>> +     int idx;
> >>> +     bool restart_timer = false;
> >>> +
> >>> +     pmu_uncore = container_of(hrt, struct thunderx2_pmu_uncore_channel,
> >>> +                     hrtimer);
> >>> +
> >>> +     raw_spin_lock_irqsave(&pmu_uncore->uncore_dev->lock, irqflags);
> >>> +     for_each_set_bit(idx, pmu_uncore->active_counters,
> >>> +                     pmu_uncore->uncore_dev->max_counters) {
> >>> +             struct perf_event *event = pmu_uncore->events[idx];
> >>
> >> Do we need to check if the "event" is not NULL ? Couldn't this race with
> >> an event_del() operation ?
> >
> > i dont think so, i have not come across any such race condition during
> > my testing.
>
> Thinking about it further, we may not hit it, as the PMU is "disable"d,
> before "add/del", which implies that the IRQ won't be triggered.
>
> Btw, in general, not hitting a race condition doesn't prove there cannot
> be a race ;)

want to avoid, unnecessary defensive programming.
>
> >>> +static int thunderx2_pmu_uncore_register(
> >>> +             struct thunderx2_pmu_uncore_channel *pmu_uncore)
> >>> +{
> >>> +     struct device *dev = pmu_uncore->uncore_dev->dev;
> >>> +     char *name = pmu_uncore->uncore_dev->name;
> >>> +     int channel = pmu_uncore->channel;
> >>> +
> >>> +     /* Perf event registration */
> >>> +     pmu_uncore->pmu = (struct pmu) {
> >>> +             .attr_groups    = pmu_uncore->uncore_dev->attr_groups,
> >>> +             .task_ctx_nr    = perf_invalid_context,
> >>> +             .event_init     = thunderx2_uncore_event_init,
> >>> +             .add            = thunderx2_uncore_add,
> >>> +             .del            = thunderx2_uncore_del,
> >>> +             .start          = thunderx2_uncore_start,
> >>> +             .stop           = thunderx2_uncore_stop,
> >>> +             .read           = thunderx2_uncore_read,
> >>
> >> You must fill in the module field of the PMU to prevent this module from
> >> being unloaded while it is in use.
> >
> > thanks, i will add it.
> >>
> >>> +     };
> >>> +
> >>> +     pmu_uncore->pmu.name = devm_kasprintf(dev, GFP_KERNEL,
> >>> +                     "%s_%d", name, channel);
> >>> +
> >>> +     return perf_pmu_register(&pmu_uncore->pmu, pmu_uncore->pmu.name, -1);
> >>> +}
> >>> +
> >>> +static int thunderx2_pmu_uncore_add(struct thunderx2_pmu_uncore_dev *uncore_dev,
> >>> +             int channel)
> >>> +{
> >>> +     struct thunderx2_pmu_uncore_channel *pmu_uncore;
> >>> +     int ret, cpu;
> >>> +
> >>> +     pmu_uncore = devm_kzalloc(uncore_dev->dev, sizeof(*pmu_uncore),
> >>> +                     GFP_KERNEL);
> >>> +     if (!pmu_uncore)
> >>> +             return -ENOMEM;
> >>> +
> >>> +     cpu = cpumask_any_and(cpumask_of_node(uncore_dev->node),
> >>> +                     cpu_online_mask);
> >>> +     if (cpu >= nr_cpu_ids)
> >>> +             return -EINVAL;
> >>
> >> Do we need to fail this here ? We could always add this back when a CPU
> >> comes online (e.g, maxcpus=n). We do have cpu-hotplug call backs anyway.
> >
> > we want to fail, since we dont have any cpu to serve.
> >
>
> I understand that. We can bring up CPUs later from userspace. e.g, on a
> system like ThunderX, to speed up the booting, one could add "maxcpus=8"
> which forces the kernel to only bring up the first 8 CPUs and the rest
> are brought up by the userspace. So, one of the DMC/L3 doesn't have a
> supported CPU booted up during the driver probe, you will not bring
> the PMU up and hence won't be able to use them even after the CPUs are
> brought up later. You can take a look at the arm_dsu_pmu, where we
> handle a similar situation via dsu_pmu_cpu_online().

ok got it thanks, this check was added when hotplug was not implemented.

>
>
> >>> +static struct platform_driver thunderx2_uncore_driver = {
> >>> +     .probe = thunderx2_uncore_probe,
> >>> +     .driver = {
> >>> +             .name           = "thunderx2-uncore-pmu",
> >>> +             .acpi_match_table = ACPI_PTR(thunderx2_uncore_acpi_match),
> >>> +     },
> >>> +};
> >>
> >> Don't we need to unregister the pmu's when we remove the module ?
> >
> > it is built in module at present, no unload is supported.
> > Anyway i am adding in next version , since i am going for loadable module.
>
> Ok
>
>
> Suzuki

thanks
Ganapat
