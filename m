From: gklkml16@gmail.com (Ganapatrao Kulkarni)
Date: Tue, 17 Jul 2018 10:51:19 +0530
Subject: [PATCH v6 2/2] ThunderX2: Add Cavium ThunderX2 SoC UNCORE PMU
 driver
In-Reply-To: <CAKTKpr5d0f6Hjj5_j4OFh609SrMOEYg+Zgm3O7UiJx7bw5A_XA@mail.gmail.com>
References: <20180621063338.20093-1-ganapatrao.kulkarni@cavium.com>
 <20180621063338.20093-3-ganapatrao.kulkarni@cavium.com>
 <20180712165606.3vqx4ysnvdlfzmtp@lakrids.cambridge.arm.com>
 <CAKTKpr5d0f6Hjj5_j4OFh609SrMOEYg+Zgm3O7UiJx7bw5A_XA@mail.gmail.com>
Message-ID: <CAKTKpr67DTvD8R5kS0OA53UH2d_cc_1vAbR3_NAo_-wfDMGO-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,


On Fri, Jul 13, 2018 at 6:28 PM, Ganapatrao Kulkarni <gklkml16@gmail.com> wrote:
> thanks Mark for the comments.
>
> On Thu, Jul 12, 2018 at 10:26 PM, Mark Rutland <mark.rutland@arm.com> wrote:
>> Hi Ganapat,
>>
>> On Thu, Jun 21, 2018 at 12:03:38PM +0530, Ganapatrao Kulkarni wrote:
>>> This patch adds a perf driver for the PMU UNCORE devices DDR4 Memory
>>> Controller(DMC) and Level 3 Cache(L3C).
>>>
>>> ThunderX2 has 8 independent DMC PMUs to capture performance events
>>> corresponding to 8 channels of DDR4 Memory Controller and 16 independent
>>> L3C PMUs to capture events corresponding to 16 tiles of L3 cache.
>>> Each PMU supports up to 4 counters. All counters lack overflow interrupt
>>> and are sampled periodically.
>>>
>>> Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
>>> ---
>>>  drivers/perf/Kconfig         |   8 +
>>>  drivers/perf/Makefile        |   1 +
>>>  drivers/perf/thunderx2_pmu.c | 949 +++++++++++++++++++++++++++++++++++++++++++
>>>  include/linux/cpuhotplug.h   |   1 +
>>>  4 files changed, 959 insertions(+)
>>>  create mode 100644 drivers/perf/thunderx2_pmu.c
>>>
>>> diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
>>> index 08ebaf7..ecedb9e 100644
>>> --- a/drivers/perf/Kconfig
>>> +++ b/drivers/perf/Kconfig
>>> @@ -87,6 +87,14 @@ config QCOM_L3_PMU
>>>          Adds the L3 cache PMU into the perf events subsystem for
>>>          monitoring L3 cache events.
>>>
>>> +config THUNDERX2_PMU
>>> +        bool "Cavium ThunderX2 SoC PMU UNCORE"
>>> +     depends on ARCH_THUNDER2 && ARM64 && ACPI
>>
>> Surely this depends on NUMA for the node id?
>  it is, i will update.
>
>>
>> [...]
>>
>>> +/*
>>> + * pmu on each socket has 2 uncore devices(dmc and l3),
>>> + * each uncore device has up to 16 channels, each channel can sample
>>> + * events independently with counters up to 4.
>>> + */
>>> +struct thunderx2_pmu_uncore_channel {
>>> +     struct pmu pmu;
>>> +     struct hlist_node       node;
>>> +     struct thunderx2_pmu_uncore_dev *uncore_dev;
>>> +     int channel;
>>> +     int cpu;
>>> +     DECLARE_BITMAP(active_counters, UNCORE_MAX_COUNTERS);
>>> +     struct perf_event *events[UNCORE_MAX_COUNTERS];
>>> +     struct hrtimer hrtimer;
>>> +     /* to sync counter alloc/release */
>>> +     raw_spinlock_t lock;
>>> +};
>>
>> This lock should not be necessary. The pmu::{add,del} callbacks are
>> strictly serialised w.r.t. one another per CPU because the core perf
>> code holds ctx->lock whenever it calls either.
>>
>> Previously, you mentioned you'd seen scheduling while atomic when this
>> lock was removed. Could you please provide a backtrace?
>
> yes, i have seen,  if i try to kick in simulatneously more events than
> h/w counters available(4 here).
> i will try with v6 and send the trace asap.

i dont have the setup on which i have seen this issue. I have tried to
recreate on my current setup and not able to see it as before. I will
remove these locks, if i dont see any issue while sending next
version. Sorry for the noise!

>
>>
>> [...]
>>
>> It would be worth a comment here explaining which resources the channel
>> PMUs share, and why we need this thunderx2_pmu_uncore_dev. IIUC, it's
>> just that they share a register windows switched by FW?
>>
>>> +struct thunderx2_pmu_uncore_dev {
>>> +     char *name;
>>> +     struct device *dev;
>>> +     enum thunderx2_uncore_type type;
>>> +     void __iomem *base;
>>> +     int node;
>>> +     u32    max_counters;
>>> +     u32    max_channels;
>>> +     u32    max_events;
>>> +     u64 hrtimer_interval;
>>> +     /* this lock synchronizes across channels */
>>> +     raw_spinlock_t lock;
>>> +     const struct attribute_group **attr_groups;
>>> +     void    (*init_cntr_base)(struct perf_event *event,
>>> +                     struct thunderx2_pmu_uncore_dev *uncore_dev);
>>> +     void    (*select_channel)(struct perf_event *event);
>>> +     void    (*stop_event)(struct perf_event *event);
>>> +     void    (*start_event)(struct perf_event *event, int flags);
>>> +};
>>
>> As a general thing, the really long structure/enum/macro names make
>> things really hard to read.
>>
>> Could we s/THUNDERX2/TX2/ and s/thunderx2/tx2/ for identifiers please?
>
> thanks, will do.
>>
>> Similarly:
>>
>> * s/thunderx2_pmu_uncore_channel/tx2_pmu/
>>
>> * s/thunderx2_pmu_uncore_dev/tx2_pmu_group/
>>
>> ... and consistently name those "pmu" and "pmu_group" respectively --
>> that mekas the relationship between the two much clearer for someone who
>> is not intimately familiar with the hardware.
>
> These PMUs(UNCORE) counters makes only sense to someone who is
> familiar with the hardware.
> IMHO,  the current names aligned to hardware design like channels ,
> tiles, counter etc,
> which is explained in PATCH1/2.
>
> I will try to simplify long names.
>
>>
>> That makes things far more legible, e.g.
>>
>>> +static inline struct thunderx2_pmu_uncore_channel *
>>> +pmu_to_thunderx2_pmu_uncore(struct pmu *pmu)
>>> +{
>>> +     return container_of(pmu, struct thunderx2_pmu_uncore_channel, pmu);
>>> +}
>>
>> ... becomes:
>>
>> static struct tx2_pmu *pmu_to_tx2_pmu(struct pmu *pmu)
>> {
>>         return container_of(pmu, struct tx2_pmu, pmu);
>> }
>>
>> [...]
>>
>>> +/*
>>> + * sysfs cpumask attributes
>>> + */
>>> +static ssize_t cpumask_show(struct device *dev,
>>> +                             struct device_attribute *attr, char *buf)
>>> +{
>>> +     struct cpumask cpu_mask;
>>> +     struct thunderx2_pmu_uncore_channel *pmu_uncore =
>>> +             pmu_to_thunderx2_pmu_uncore(dev_get_drvdata(dev));
>>> +
>>> +     cpumask_clear(&cpu_mask);
>>> +     cpumask_set_cpu(pmu_uncore->cpu, &cpu_mask);
>>> +     return cpumap_print_to_pagebuf(true, buf, &cpu_mask);
>>> +}
>>> +static DEVICE_ATTR_RO(cpumask);
>>
>> This can be simplified to:
>>
>> static ssize_t cpumask_show(struct device *dev, struct device_attribute
>>                             *attr, char *buf)
>> {
>>         struct thunderx2_pmu_uncore_channel *pmu_uncore;
>>         pmu_uncore = pmu_to_thunderx2_pmu_uncore(dev_get_drvdata(dev));
>>
>>         return cpumap_print_to_pagebuf(true, buf, cpumask_of(pmu_uncore->cpu));
>> }
>
> thanks, will do
>>
>> [...]
>>
>>> +static int alloc_counter(struct thunderx2_pmu_uncore_channel *pmu_uncore)
>>> +{
>>> +     int counter;
>>> +
>>> +     raw_spin_lock(&pmu_uncore->lock);
>>> +     counter = find_first_zero_bit(pmu_uncore->active_counters,
>>> +                             pmu_uncore->uncore_dev->max_counters);
>>> +     if (counter == pmu_uncore->uncore_dev->max_counters) {
>>> +             raw_spin_unlock(&pmu_uncore->lock);
>>> +             return -ENOSPC;
>>> +     }
>>> +     set_bit(counter, pmu_uncore->active_counters);
>>> +     raw_spin_unlock(&pmu_uncore->lock);
>>> +     return counter;
>>> +}
>>> +
>>> +static void free_counter(
>>> +             struct thunderx2_pmu_uncore_channel *pmu_uncore, int counter)
>>> +{
>>> +     raw_spin_lock(&pmu_uncore->lock);
>>> +     clear_bit(counter, pmu_uncore->active_counters);
>>> +     raw_spin_unlock(&pmu_uncore->lock);
>>> +}
>>
>> As above, I still don't believe that these locks are necessary, unless
>> we have a bug elsewhere.
>
> i will try to debug and provide you more info.
>
>>
>> [...]
>>
>>> +/*
>>> + * DMC and L3 counter interface is muxed across all channels.
>>> + * hence we need to select the channel before accessing counter
>>> + * data/control registers.
>>> + *
>>> + *  L3 Tile and DMC channel selection is through SMC call
>>> + *  SMC call arguments,
>>> + *   x0 = THUNDERX2_SMC_CALL_ID      (Vendor SMC call Id)
>>> + *   x1 = THUNDERX2_SMC_SET_CHANNEL  (Id to set DMC/L3C channel)
>>> + *   x2 = Node id
>>> + *   x3 = DMC(1)/L3C(0)
>>> + *   x4 = channel Id
>>> + */
>>
>> Please document which ID space the node id is in, e.g.
>>
>>         x2 = FW Node ID (matching SRAT/SLIT IDs)
>>
>> ... so that it's clear that this isn't a Linux logical node id, even if
>> those happen to be the same today.
>
> sure.
>>
>> [...]
>>
>>> +static void thunderx2_uncore_start(struct perf_event *event, int flags)
>>> +{
>>> +     struct hw_perf_event *hwc = &event->hw;
>>> +     struct thunderx2_pmu_uncore_channel *pmu_uncore;
>>> +     struct thunderx2_pmu_uncore_dev *uncore_dev;
>>> +     unsigned long irqflags;
>>> +
>>> +     hwc->state = 0;
>>> +     pmu_uncore = pmu_to_thunderx2_pmu_uncore(event->pmu);
>>> +     uncore_dev = pmu_uncore->uncore_dev;
>>> +
>>> +     raw_spin_lock_irqsave(&uncore_dev->lock, irqflags);
>>> +     uncore_dev->select_channel(event);
>>> +     uncore_dev->start_event(event, flags);
>>> +     raw_spin_unlock_irqrestore(&uncore_dev->lock, irqflags);
>>> +     perf_event_update_userpage(event);
>>> +
>>> +     if (!find_last_bit(pmu_uncore->active_counters,
>>> +                             pmu_uncore->uncore_dev->max_counters)) {
>>
>> This would be clearer using !bitmap_empty().
>
> thanks.
>>
>>> +             hrtimer_start(&pmu_uncore->hrtimer,
>>> +                     ns_to_ktime(uncore_dev->hrtimer_interval),
>>> +                     HRTIMER_MODE_REL_PINNED);
>>> +     }
>>> +}
>>
>> [...]
>>
>>> +static enum hrtimer_restart thunderx2_uncore_hrtimer_callback(
>>> +             struct hrtimer *hrt)
>>
>> s/hrt/timer/ please
>
> sure, thanks.
>>
>>> +{
>>> +     struct thunderx2_pmu_uncore_channel *pmu_uncore;
>>> +     unsigned long irqflags;
>>> +     int idx;
>>> +     bool restart_timer = false;
>>> +
>>> +     pmu_uncore = container_of(hrt, struct thunderx2_pmu_uncore_channel,
>>> +                     hrtimer);
>>> +
>>> +     raw_spin_lock_irqsave(&pmu_uncore->uncore_dev->lock, irqflags);
>>> +     for_each_set_bit(idx, pmu_uncore->active_counters,
>>> +                     pmu_uncore->uncore_dev->max_counters) {
>>> +             struct perf_event *event = pmu_uncore->events[idx];
>>> +
>>> +             thunderx2_uncore_update(event);
>>> +             restart_timer = true;
>>> +     }
>>> +     raw_spin_unlock_irqrestore(&pmu_uncore->uncore_dev->lock, irqflags);
>>> +
>>> +     if (restart_timer)
>>> +             hrtimer_forward_now(hrt,
>>> +                     ns_to_ktime(
>>> +                             pmu_uncore->uncore_dev->hrtimer_interval));
>>> +
>>> +     return restart_timer ? HRTIMER_RESTART : HRTIMER_NORESTART;
>>> +}
>>
>> You don't need to take the lock at all if there are no active events,
>> and we can avoid all the conditional logic that way. e.g. assuming the
>> renames I requested above:
>>
>> static enum hrtimer_restart tx2_hrtimer_callback(struct hrtimer *timer)
>>
>> {
>>         struct tx2_pmu *pmu;
>>         struct tx2_pmu_group *pmu_group;
>>         unsigned long irqflags;
>>         int max_counters;
>>         int idx;
>>
>>         pmu = container_of(timer, struct tx2_pmu, hrtimer);
>>         pmu_group = pmu->pmu_group;
>>         max_counters = pmu_group->max_counters;
>>
>>         if (cpumask_empty(pmu->active_counters, max_counters))
>>                 return HRTIMER_NORESTART;
>>
>>         raw_spin_lock_irqsave(&pmu_group->lock, irqflags);
>>         for_each_set_bit(idx, pmu->active_counters, max_counters) {
>>                 struct perf_event *event = pmu->events[idx];
>>
>>                 tx2_uncore_update(event);
>>                 restart_timer = true;
>>         }
>>         raw_spin_unlock_irqrestore(&pmu_group->lock, irqflags);
>>
>>         hrtimer_forward_now(hrt, ns_to_ktime(pmu_group->hrtimer_interval));
>>
>>         return HRTIMER_RESTART;
>> }
>
> thanks, i will adopt this function.
>>
>> [...]
>>
>>> +     switch (uncore_dev->type) {
>>> +     case PMU_TYPE_L3C:
>>> +             uncore_dev->max_counters = UNCORE_MAX_COUNTERS;
>>> +             uncore_dev->max_channels = UNCORE_L3_MAX_TILES;
>>> +             uncore_dev->max_events = L3_EVENT_MAX;
>>> +             uncore_dev->hrtimer_interval = UNCORE_HRTIMER_INTERVAL;
>>> +             uncore_dev->attr_groups = l3c_pmu_attr_groups;
>>> +             uncore_dev->name = devm_kasprintf(dev, GFP_KERNEL,
>>> +                             "uncore_l3c_%d", uncore_dev->node);
>>> +             uncore_dev->init_cntr_base = init_cntr_base_l3c;
>>> +             uncore_dev->start_event = uncore_start_event_l3c;
>>> +             uncore_dev->stop_event = uncore_stop_event_l3c;
>>> +             uncore_dev->select_channel = uncore_select_channel;
>>> +             break;
>>> +     case PMU_TYPE_DMC:
>>> +             uncore_dev->max_counters = UNCORE_MAX_COUNTERS;
>>> +             uncore_dev->max_channels = UNCORE_DMC_MAX_CHANNELS;
>>> +             uncore_dev->max_events = DMC_EVENT_MAX;
>>> +             uncore_dev->hrtimer_interval = UNCORE_HRTIMER_INTERVAL;
>>> +             uncore_dev->attr_groups = dmc_pmu_attr_groups;
>>> +             uncore_dev->name = devm_kasprintf(dev, GFP_KERNEL,
>>> +                             "uncore_dmc_%d", uncore_dev->node);
>>> +             uncore_dev->init_cntr_base = init_cntr_base_dmc;
>>> +             uncore_dev->start_event = uncore_start_event_dmc;
>>> +             uncore_dev->stop_event = uncore_stop_event_dmc;
>>> +             uncore_dev->select_channel = uncore_select_channel;
>>> +             break;
>>
>> We should probably s/uncore/tx2/, or s/uncore/thunderx2/ to namespace
>> this.
>
> ok, i would preffer tx2.
>>
>>> +static int thunderx2_uncore_pmu_offline_cpu(unsigned int cpu,
>>> +             struct hlist_node *node)
>>> +{
>>> +     int new_cpu;
>>> +     struct thunderx2_pmu_uncore_channel *pmu_uncore;
>>> +
>>> +     pmu_uncore = hlist_entry_safe(node,
>>> +                     struct thunderx2_pmu_uncore_channel, node);
>>> +     if (cpu != pmu_uncore->cpu)
>>> +             return 0;
>>> +
>>> +     new_cpu = cpumask_any_and(
>>> +                     cpumask_of_node(pmu_uncore->uncore_dev->node),
>>> +                     cpu_online_mask);
>>> +     if (new_cpu >= nr_cpu_ids)
>>> +             return 0;
>>> +
>>> +     pmu_uncore->cpu = new_cpu;
>>> +     perf_pmu_migrate_context(&pmu_uncore->pmu, cpu, new_cpu);
>>> +     return 0;
>>> +}
>>
>> We'll also need a onlining callback. Consider if all CPUs in a NUMA node
>> were offlined, then we tried to online an arbitrary CPU from that node.
>
> sure, will add.
>>
>> Thanks,
>> Mark.
>
> thanks
> Ganapat

thanks
Ganapat
