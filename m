From: ttnguyen@apm.com (Tai Tri Nguyen)
Date: Mon, 4 Apr 2016 16:42:11 -0700
Subject: [PATCH 3/4] perf: xgene: Add APM X-Gene SoC Performance
 Monitoring Unit driver
In-Reply-To: <20160401121820.GB29876@leverpostej>
References: <1459467472-31561-1-git-send-email-ttnguyen@apm.com>
 <1459467472-31561-4-git-send-email-ttnguyen@apm.com>
 <20160401121820.GB29876@leverpostej>
Message-ID: <CACgAJHwZ0MwjBDa65P7tYAkF4-m+TCj-65OGpYYQD2tO6hkFqQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

First of all, thanks for your comments.

On Fri, Apr 1, 2016 at 5:18 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> Hi,
>
> I haven't reviewed this in great detail, but I spotted a few issues.
>
>> +static int get_next_avail_cntr(struct xgene_pmu_dev *pmu_dev)
>> +{
>> +     int shift, cntr, retval;
>> +     unsigned long flags;
>> +
>> +     raw_spin_lock_irqsave(&pmu_dev->lock, flags);
>> +
>> +     for (cntr = 0; cntr < pmu_dev->max_counters; cntr++) {
>> +             shift = cntr;
>> +             if (!(pmu_dev->cntr_assign_mask & (1ULL << shift))) {
>> +                     pmu_dev->cntr_assign_mask |= (1ULL << shift);
>> +                     retval = cntr;
>> +                     goto out;
>> +             }
>> +     }
>> +     retval = -ENOSPC;
>
> Please use a bitmask. Then you can do something like:
>
>         cntr = find_first_zero_bit(pmu_dev->cntr_assign_mask,
>                                    pmu_dev->max_counters);
>         if (cntr == pmu_dev->max_counters)
>                 return -ENOSPC;
>         set_bit(cntr, pmu_dev->cntr_assign_mask);
>         return cntr;
>

Yes, it's better. I will use bitmask instead.

> Are the spinlocks necessary?
>
> I thought add and del couldn't be called in parallel for the same
> context, and those are the only users of this mask.
>

I'm trying to avoid the case where multiple events may claim the same
available counter.
There's a race condition here.

>> +
>> +out:
>> +     raw_spin_unlock_irqrestore(&pmu_dev->lock, flags);
>> +
>> +     return retval;
>> +}
>> +
>> +static int clear_avail_cntr(struct xgene_pmu_dev *pmu_dev, u8 cntr)
>> +{
>> +     unsigned long flags;
>> +     int shift;
>> +
>> +     if (cntr > pmu_dev->max_counters)
>> +             return -EINVAL;
>
> This implies we have an event we tried to del, which didn't have a
> counter. Surely we should never have added the event in that case, and
> this should never happen?
>

You're right. This should never happen. I'll remove it.

>> +
>> +     shift = cntr;
>> +
>> +     raw_spin_lock_irqsave(&pmu_dev->lock, flags);
>> +     pmu_dev->cntr_assign_mask &= ~(1ULL << shift);
>
> clear_bit(cntr, pmu_dev->cntr_assign_mask);

Sure, I'll change it along with bitmap use.

>
>> +     raw_spin_unlock_irqrestore(&pmu_dev->lock, flags);
>> +
>> +     return 0;
>> +}
>
> [...]
>
>> +static int xgene_perf_event_init(struct perf_event *event)
>> +{
>> +     struct xgene_pmu_dev *pmu_dev = to_pmu_dev(event->pmu);
>> +     struct hw_perf_event *hwc = &event->hw;
>> +     u64 config, config1;
>> +
>> +     /* test the event attr type check for PMU enumeration */
>> +     if (event->attr.type != event->pmu->type)
>> +             return -ENOENT;
>> +
>> +     /*
>> +      * SOC PMU counters are shared across all cores.
>> +      * Therefore, it does not support per-process mode.
>> +      * Also, it does not support event sampling mode.
>> +      */
>> +     if (is_sampling_event(event) || event->attach_state & PERF_ATTACH_TASK)
>> +             return -EINVAL;
>> +
>> +     /* SOC counters do not have usr/os/guest/host bits */
>> +     if (event->attr.exclude_user || event->attr.exclude_kernel ||
>> +         event->attr.exclude_host || event->attr.exclude_guest)
>> +             return -EINVAL;
>> +
>> +     if (event->cpu < 0)
>> +             return -EINVAL;
>
> We should really have this made common for system PMUs (e.g. librify
> it). Every driver does something subtly different, and isn't kept in
> sync with new core feature addition.
>
> Even if you're happy to accept a request made with any event->cpu,
> you'll need to forcefully override that and ensure that all events are
> in the same percpu context.
>
> See what we do in drivers/bus/arm-ccn.c.

Okay, I'll refer to arm-ccn.c to enforce CPU assignment to the first core.

>
>> +
>> +     if (event->pmu != &pmu_dev->pmu)
>> +             return -ENOENT;
>
> If this does need to be checked, we should so so when checking the type
> above.
>
> However, the PMU should have a unique type anyway, so the type being the
> same should imply this is true anyway.
>

Yes, this is over checking. I'll remove it.

>> +
>> +     if (pmu_dev) {
>> +             config = event->attr.config;
>> +             config1 = event->attr.config1;
>> +     } else {
>> +             return -EINVAL;
>> +     }
>> +
>
> How can the else case ever occur? All other PMUs have been filtered away
> by this point.

Right. It's not necessary. Will get rid of it.

>
>> +     if (pmu_dev->max_counters == 0)
>> +             return -EINVAL;
>
> Why bother registering the PMU device at all in this case?

Yes, will remove this check.

>
>> +
>> +     hwc->config = config;
>> +     if (config1)
>> +             hwc->extra_reg.config = config1;
>> +     else
>> +             /* Enable all Agents */
>> +             hwc->extra_reg.config = 0xFFFFFFFFFFFFFFFFULL;
>
> I'm not sure I follow what's going on here.
>
> It would be good to document precisely what this means.

These are X-Gene PMU specific for monitoring performance of a specific
data path.
X-Gene PMUs have 2 registers capable of masking the Agents from which
the request come from. If the bit with the bit number corresponding to
the AgentID
is set, the event will be counted only if it is caused by a request
from that agent.
Each PMU has different set of Agents. By default, the event will be counted for
all agent requests.

I'll have it commented better for next revision of the patch.

>
> [...]
>
>> +static int xgene_init_events_attrs(struct xgene_pmu_dev *pmu_dev,
>> +                                struct xgene_pmu_dev_event_desc *event_desc)
>> +{
>> +     struct attribute_group *attr_group;
>> +     struct attribute **attrs;
>> +     int i = 0, j;
>> +
>> +     while (event_desc[i].attr.attr.name)
>> +             i++;
>> +
>> +     attr_group = devm_kzalloc(pmu_dev->parent->dev,
>> +                     sizeof(struct attribute *) * (i + 1)
>> +                     + sizeof(*attr_group), GFP_KERNEL);
>> +     if (!attr_group)
>> +             return -ENOMEM;
>> +
>> +     attrs = (struct attribute **)(attr_group + 1);
>> +     for (j = 0; j < i; j++)
>> +             attrs[j] = &event_desc[j].attr.attr;
>> +
>> +     attr_group->name = "events";
>> +     attr_group->attrs = attrs;
>> +     pmu_dev->events_group = attr_group;
>> +
>> +     return 0;
>> +}
>
> I don't think this needs to be dynamic. See what we do in
> drivers/bus/arm-cci.c with CCI_EXT_ATTR_ENTRY for a simple way of
> initialising the attribute pointer array at compile time.
>
> With that, you don't need any dynamic allocation or initialisation here.
>

Okay.

>> +static void xgene_perf_pmu_init(struct xgene_pmu_dev *pmu_dev)
>> +{
>> +     pmu_dev->pmu.event_init = xgene_perf_event_init;
>> +     pmu_dev->pmu.add        = xgene_perf_add;
>> +     pmu_dev->pmu.del        = xgene_perf_del;
>> +     pmu_dev->pmu.start      = xgene_perf_start;
>> +     pmu_dev->pmu.stop       = xgene_perf_stop;
>> +     pmu_dev->pmu.read       = xgene_perf_read;
>> +}
>
> You'll also need to set the task_ctx_nr to perf_invalid_context, as this
> is a system PMU rather than something that can profile tasks or
> individual CPUs.
>

Okay, thanks

>> +static irqreturn_t _xgene_pmu_isr(int irq, struct xgene_pmu_dev *pmu_dev)
>> +{
>> +     struct perf_event *event = NULL;
>> +     struct perf_sample_data data;
>> +     struct xgene_pmu *xgene_pmu;
>> +     struct hw_perf_event *hwc;
>> +     struct pt_regs *regs;
>
> This is _not_ a CPU PMU. There are no relevant pt_rregs.

Yes, got it.

>
>> +     int idx;
>> +     u32 val;
>> +
>> +     /* Get interrupt counter source */
>> +     val = readl(pmu_dev->inf->csr + PMU_PMOVSR);
>> +     idx = ffs(val) - 1;
>> +     if (!(val & PMU_OVERFLOW_MASK))
>> +             goto out;
>> +     event = pmu_dev->pmu_counter_event[idx];
>> +
>> +     /*
>> +      * Handle the counter(s) overflow(s)
>> +      */
>> +     regs = get_irq_regs();
>
> As above, this is irrelevant.

Got it

>
>> +
>> +     /* Ignore if we don't have an event. */
>> +     if (!event)
>> +             goto out;
>> +
>> +     hwc = &event->hw;
>> +
>> +     xgene_perf_event_update(event, hwc, idx);
>> +     perf_sample_data_init(&data, 0, hwc->last_period);
>> +     if (!xgene_perf_event_set_period(event, hwc, idx))
>> +             goto out;
>> +
>> +     if (perf_event_overflow(event, &data, regs))
>> +             xgene_perf_disable_event(event);
>
> perf_event_overflow skips non-sampling events (i.e. all events this PMU
> is capable of), and always returns 0, so the regs aren't even used at
> all...
>
> This can/should go.
>

I will remove it.

> [...]
>
>> +static int xgene_pmu_probe_active_mcb_mcu(struct xgene_pmu *xgene_pmu,
>> +                                       struct platform_device *pdev)
>> +{
>> +     if (efi_enabled(EFI_BOOT))
>> +             return acpi_pmu_probe_active_mcb_mcu(xgene_pmu, pdev);
>> +     else
>> +             return fdt_pmu_probe_active_mcb_mcu(xgene_pmu, pdev);
>> +}
>
> EFI has _nothing_ to do with ACPI here.
>
> EFI != ACPI; ECI && !ACPI is possible.
>
> Check whether you have an of_node or an acpi companion device.

Okay, thanks

>
>> +static int xgene_pmu_probe_pmu_dev(struct xgene_pmu *xgene_pmu,
>> +                                struct platform_device *pdev)
>> +{
>> +     if (efi_enabled(EFI_BOOT))
>> +             return acpi_pmu_probe_pmu_dev(xgene_pmu, pdev);
>> +     else
>> +             return fdt_pmu_probe_pmu_dev(xgene_pmu, pdev);
>> +}
>
> Likewise.

Okay

>
> Thanks,
> Mark.

Thanks,
-- 
Tai
