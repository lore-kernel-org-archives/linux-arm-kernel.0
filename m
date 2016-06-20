From: ttnguyen@apm.com (Tai Tri Nguyen)
Date: Mon, 20 Jun 2016 14:09:53 -0700
Subject: [PATCH v3 3/4] perf: xgene: Add APM X-Gene SoC Performance
 Monitoring Unit driver
In-Reply-To: <20160616153946.GB31477@leverpostej>
References: <1465521892-31420-1-git-send-email-ttnguyen@apm.com>
 <1465521892-31420-4-git-send-email-ttnguyen@apm.com>
 <20160616153946.GB31477@leverpostej>
Message-ID: <CACgAJHxjdUckLy4RdiaOQC3Ls-Z0K8joMQoMX2am078JwQK5dQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

Thanks for the comments.

On Thu, Jun 16, 2016 at 8:39 AM, Mark Rutland <mark.rutland@arm.com> wrote:
>
> Hi,
>
> On Thu, Jun 09, 2016 at 06:24:51PM -0700, Tai Nguyen wrote:
> > +#include <linux/acpi.h>
> > +#include <linux/efi.h>
> > +#include <linux/module.h>
> > +#include <linux/io.h>
> > +#include <linux/clk.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/of_address.h>
> > +#include <linux/of_fdt.h>
> > +#include <linux/of_irq.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/perf_event.h>
> > +#include <linux/module.h>
> > +#include <linux/cpumask.h>
> > +#include <linux/slab.h>
> > +#include <linux/mfd/syscon.h>
> > +#include <linux/regmap.h>
>
> Minor nit: please sort these alphabetically (it makes scanning them
> by-eye easier and can help when there are conflicts).

Okay, will fix it.

>
>
> [...]
>
> > +static struct dev_ext_attribute l3c_pmu_format_attrs[] = {
> > +     PMU_FORMAT_EXT_ATTR(l3c_eventid, "config:0-7"),
> > +     PMU_FORMAT_EXT_ATTR(l3c_agentid, "config1:0-9"),
> > +};
> > +
> > +static struct dev_ext_attribute iob_pmu_format_attrs[] = {
> > +     PMU_FORMAT_EXT_ATTR(iob_eventid, "config:0-7"),
> > +     PMU_FORMAT_EXT_ATTR(iob_agentid, "config1:0-63"),
> > +};
> > +
> > +static struct dev_ext_attribute mcb_pmu_format_attrs[] = {
> > +     PMU_FORMAT_EXT_ATTR(mcb_eventid, "config:0-5"),
> > +     PMU_FORMAT_EXT_ATTR(mcb_agentid, "config1:0-9"),
> > +};
> > +
> > +static struct dev_ext_attribute mc_pmu_format_attrs[] = {
> > +     PMU_FORMAT_EXT_ATTR(mc_eventid, "config:0-28"),
> > +};
>
> Please make these structures const.

Okay

>
>
> > +static struct attribute_group pmu_format_attr_group = {
> > +     .name = "format",
> > +     .attrs = NULL,          /* Filled in xgene_pmu_alloc_attrs */
> > +};
>
> I think you should just have a (static const) format_attr_group for each
> class, which you reuse and share across instances, rather than bothering
> with dynamic allocation (which I think is broken -- more on that below).
>
> To save some pain, I think you can use a compound literal to initialise
> each of those in one go:
>
> static const struct attribute_group l3c_pmu_format_attr_group = {
>         .name = "format",
>         .attrs = (const dev_ext_attribute[]) {
>                 PMU_FORMAT_EXT_ATTR(l3c_eventid, "config:0-7"),
>                 PMU_FORMAT_EXT_ATTR(l3c_agentid, "config1:0-9"),
>         },
> };
>
> You'll need a full pmu attr group for each class also, but you don't
> lose much by doing so.

This compound literal approach doesn't work because they aren't the
same structure.
But yes I'll create a format_attr_group per class.

>
> > +
> > +/*
> > + * sysfs event attributes
> > + */
> > +static ssize_t _xgene_pmu_event_show(struct device *dev,
> > +                             struct device_attribute *attr, char *buf)
> > +{
> > +     struct dev_ext_attribute *eattr;
> > +
> > +     eattr = container_of(attr, struct dev_ext_attribute, attr);
> > +     return sprintf(buf, "config=0x%lx\n", (unsigned long)eattr->var);
> > +}
> > +
> > +#define PMU_EVENT_EXT_ATTR(_name, _config) \
> > +     PMU_EXT_ATTR(_name, _xgene_pmu_event_show, (unsigned long)_config)
> > +
> > +static struct dev_ext_attribute l3c_pmu_events_attrs[] = {
> > +     PMU_EVENT_EXT_ATTR(cycle-count,                         0x00),
> > +     PMU_EVENT_EXT_ATTR(cycle-count-div-64,                  0x01),
> > +     PMU_EVENT_EXT_ATTR(read-hit,                            0x02),
> > +     PMU_EVENT_EXT_ATTR(read-miss,                           0x03),
> > +     PMU_EVENT_EXT_ATTR(write-need-replacement,              0x06),
> > +     PMU_EVENT_EXT_ATTR(write-not-need-replacement,          0x07),
> > +     PMU_EVENT_EXT_ATTR(tq-full,                             0x08),
> > +     PMU_EVENT_EXT_ATTR(ackq-full,                           0x09),
> > +     PMU_EVENT_EXT_ATTR(wdb-full,                            0x0a),
> > +     PMU_EVENT_EXT_ATTR(bank-fifo-full,                      0x0b),
> > +     PMU_EVENT_EXT_ATTR(odb-full,                            0x0c),
> > +     PMU_EVENT_EXT_ATTR(wbq-full,                            0x0d),
> > +     PMU_EVENT_EXT_ATTR(bank-conflict-fifo-issue,            0x0e),
> > +     PMU_EVENT_EXT_ATTR(bank-fifo-issue,                     0x0f),
> > +};
> > +
> > +static struct dev_ext_attribute iob_pmu_events_attrs[] = {
> > +     PMU_EVENT_EXT_ATTR(cycle-count,                         0x00),
> > +     PMU_EVENT_EXT_ATTR(cycle-count-div-64,                  0x01),
> > +     PMU_EVENT_EXT_ATTR(axi0-read,                           0x02),
> > +     PMU_EVENT_EXT_ATTR(axi0-read-partial,                   0x03),
> > +     PMU_EVENT_EXT_ATTR(axi1-read,                           0x04),
> > +     PMU_EVENT_EXT_ATTR(axi1-read-partial,                   0x05),
> > +     PMU_EVENT_EXT_ATTR(csw-read-block,                      0x06),
> > +     PMU_EVENT_EXT_ATTR(csw-read-partial,                    0x07),
> > +     PMU_EVENT_EXT_ATTR(axi0-write,                          0x10),
> > +     PMU_EVENT_EXT_ATTR(axi0-write-partial,                  0x11),
> > +     PMU_EVENT_EXT_ATTR(axi1-write,                          0x13),
> > +     PMU_EVENT_EXT_ATTR(axi1-write-partial,                  0x14),
> > +     PMU_EVENT_EXT_ATTR(csw-inbound-dirty,                   0x16),
> > +};
> > +
> > +static struct dev_ext_attribute mcb_pmu_events_attrs[] = {
> > +     PMU_EVENT_EXT_ATTR(cycle-count,                         0x00),
> > +     PMU_EVENT_EXT_ATTR(cycle-count-div-64,                  0x01),
> > +     PMU_EVENT_EXT_ATTR(csw-read,                            0x02),
> > +     PMU_EVENT_EXT_ATTR(csw-write-request,                   0x03),
> > +     PMU_EVENT_EXT_ATTR(mcb-csw-stall,                       0x04),
> > +     PMU_EVENT_EXT_ATTR(cancel-read-gack,                    0x05),
> > +};
> > +
> > +static struct dev_ext_attribute mc_pmu_events_attrs[] = {
> > +     PMU_EVENT_EXT_ATTR(cycle-count,                         0x00),
> > +     PMU_EVENT_EXT_ATTR(cycle-count-div-64,                  0x01),
> > +     PMU_EVENT_EXT_ATTR(act-cmd-sent,                        0x02),
> > +     PMU_EVENT_EXT_ATTR(pre-cmd-sent,                        0x03),
> > +     PMU_EVENT_EXT_ATTR(rd-cmd-sent,                         0x04),
> > +     PMU_EVENT_EXT_ATTR(rda-cmd-sent,                        0x05),
> > +     PMU_EVENT_EXT_ATTR(wr-cmd-sent,                         0x06),
> > +     PMU_EVENT_EXT_ATTR(wra-cmd-sent,                        0x07),
> > +     PMU_EVENT_EXT_ATTR(pde-cmd-sent,                        0x08),
> > +     PMU_EVENT_EXT_ATTR(sre-cmd-sent,                        0x09),
> > +     PMU_EVENT_EXT_ATTR(prea-cmd-sent,                       0x0a),
> > +     PMU_EVENT_EXT_ATTR(ref-cmd-sent,                        0x0b),
> > +     PMU_EVENT_EXT_ATTR(rd-rda-cmd-sent,                     0x0c),
> > +     PMU_EVENT_EXT_ATTR(wr-wra-cmd-sent,                     0x0d),
> > +     PMU_EVENT_EXT_ATTR(in-rd-collision,                     0x0e),
> > +     PMU_EVENT_EXT_ATTR(in-wr-collision,                     0x0f),
> > +     PMU_EVENT_EXT_ATTR(collision-queue-not-empty,           0x10),
> > +     PMU_EVENT_EXT_ATTR(collision-queue-full,                0x11),
> > +     PMU_EVENT_EXT_ATTR(mcu-request,                         0x12),
> > +     PMU_EVENT_EXT_ATTR(mcu-rd-request,                      0x13),
> > +     PMU_EVENT_EXT_ATTR(mcu-hp-rd-request,                   0x14),
> > +     PMU_EVENT_EXT_ATTR(mcu-wr-request,                      0x15),
> > +     PMU_EVENT_EXT_ATTR(mcu-rd-proceed-all,                  0x16),
> > +     PMU_EVENT_EXT_ATTR(mcu-rd-proceed-cancel,               0x17),
> > +     PMU_EVENT_EXT_ATTR(mcu-rd-response,                     0x18),
> > +     PMU_EVENT_EXT_ATTR(mcu-rd-proceed-speculative-all,      0x19),
> > +     PMU_EVENT_EXT_ATTR(mcu-rd-proceed-speculative-cancel,   0x1a),
> > +     PMU_EVENT_EXT_ATTR(mcu-wr-proceed-all,                  0x1b),
> > +     PMU_EVENT_EXT_ATTR(mcu-wr-proceed-cancel,               0x1c),
> > +};
> > +
> > +static struct attribute_group pmu_events_attr_group = {
> > +     .name = "events",
> > +     .attrs = NULL,          /* Filled in xgene_pmu_alloc_attrs */
> > +};
>
> My comments for the format groups apply here too.

Okay, I will do the same.

>
> > +
> > +/*
> > + * sysfs cpumask attributes
> > + */
> > +static ssize_t xgene_pmu_cpumask_show(struct device *dev,
> > +                                   struct device_attribute *attr, char *buf)
> > +{
> > +     struct xgene_pmu_dev *pmu_dev = to_pmu_dev(dev_get_drvdata(dev));
> > +
> > +     return cpumap_print_to_pagebuf(true, buf, &pmu_dev->parent->cpu);
> > +}
> > +static DEVICE_ATTR(cpumask, S_IRUGO, xgene_pmu_cpumask_show, NULL);
> > +
> > +static struct attribute *xgene_pmu_cpumask_attrs[] = {
> > +     &dev_attr_cpumask.attr,
> > +     NULL,
> > +};
> > +
> > +static struct attribute_group pmu_cpumask_attr_group = {
> > +     .attrs = xgene_pmu_cpumask_attrs,
> > +};
>
> Please make these const.

Okay

>
> > +
> > +static const struct attribute_group *pmu_attr_groups[] = {
> > +     &pmu_format_attr_group,
> > +     &pmu_cpumask_attr_group,
> > +     &pmu_events_attr_group,
> > +     NULL
> > +};
>
> As mentioned earlier, you'll need one of these per class.

Yes, I got it.

>
> [...]
>
> > +static int xgene_perf_event_init(struct perf_event *event)
> > +{
> > +     struct xgene_pmu_dev *pmu_dev = to_pmu_dev(event->pmu);
> > +     struct hw_perf_event *hwc = &event->hw;
> > +     u64 config, config1;
> > +
> > +     /* Test the event attr type check for PMU enumeration */
> > +     if (event->attr.type != event->pmu->type)
> > +             return -ENOENT;
> > +
> > +     /*
> > +      * SOC PMU counters are shared across all cores.
> > +      * Therefore, it does not support per-process mode.
> > +      * Also, it does not support event sampling mode.
> > +      */
> > +     if (is_sampling_event(event) || event->attach_state & PERF_ATTACH_TASK)
> > +             return -EINVAL;
> > +
> > +     /* SOC counters do not have usr/os/guest/host bits */
> > +     if (event->attr.exclude_user || event->attr.exclude_kernel ||
> > +         event->attr.exclude_host || event->attr.exclude_guest)
> > +             return -EINVAL;
> > +
> > +     if (event->cpu < 0)
> > +             return -EINVAL;
> > +     /*
> > +      * Many perf core operations (eg. events rotation) operate on a
> > +      * single CPU context. This is obvious for CPU PMUs, where one
> > +      * expects the same sets of events being observed on all CPUs,
> > +      * but can lead to issues for off-core PMUs, where each
> > +      * event could be theoretically assigned to a different CPU. To
> > +      * mitigate this, we enforce CPU assignment to one, selected
> > +      * processor (the one described in the "cpumask" attribute).
> > +      */
> > +     event->cpu = cpumask_first(&pmu_dev->parent->cpu);
>
> I didn't spot a perf_pmu_migrate_context call anywhere.
>
> Do you not plan to handle hotplug?

No, I don't plan to handle hotplug.

>
> > +
> > +     config = event->attr.config;
> > +     config1 = event->attr.config1;
> > +
> > +     hwc->config = config;
> > +     /*
> > +      * Each bit of the config1 field represents an agent from which the
> > +      * request of the event come. The event is counted only if it's caused
> > +      * by a request of an agent has the bit set.
> > +      * By default, the event is counted for all agents.
> > +      */
> > +     if (config1)
> > +             hwc->extra_reg.config = config1;
> > +     else
> > +             hwc->extra_reg.config = 0xFFFFFFFFFFFFFFFFULL;
> > +
>
> If you treated the bits as having the opposite meaning (i.e. a bit set
> means ignore an agent), then the zero default would not have to be
> special-cased here.
>
> Currently 0 and 0xFFFFFFFFFFFFFFFFULL mean the same thing, which is a
> little odd.
>
> You also need to verify the event grouping, e.g. avoiding cross-pmu
> groups. See what we do in the arm-ccn driver.
>

This is hardware configuration.
This config1 value will be programmed to the PMU CSR.
0 and 0xFFFFFFFFFFFFFFFFULL don't mean the same thing.
0: The event counter isn't counted at all because all the agent enable
bits are masked to disabled.
0xFFFFFFFFFFFFFFFFULL: The event counter will be counted by requests
from any available agents.

> [...]
>
> > +     if (local64_cmpxchg(&hwc->prev_count, prev_raw_count, count)
> > +             != prev_raw_count)
> > +             return;
>
> Please leave the '!=' dangling on the first line. It makes it clearer
> that there is more to the expression.

Okay, I will fix it.

>
> [...]
>
> > +static struct attribute **alloc_attrs(struct device *dev, u32 n,
> > +                             struct dev_ext_attribute *dev_attr)
> > +{
> > +     struct attribute **attrs;
> > +     int i;
> > +
> > +     /* Alloc n + 1 (for terminating NULL) */
> > +     attrs  = devm_kcalloc(dev, n + 1, sizeof(struct attribute *),
> > +                     GFP_KERNEL);
> > +     if (!attrs)
> > +             return attrs;
> > +
> > +     for (i = 0; i < n; i++)
> > +             attrs[i] = &dev_attr[i].attr.attr;
> > +     return attrs;
> > +}
> > +
> > +static int
> > +xgene_pmu_alloc_attrs(struct device *dev, struct xgene_pmu_dev *pmu_dev)
> > +{
> > +     struct attribute **attrs;
> > +
> > +     if (pmu_dev->nformat_attrs) {
> > +             attrs = alloc_attrs(dev, pmu_dev->nformat_attrs,
> > +                             pmu_dev->format_attr);
> > +             if (!attrs)
> > +                     return -ENOMEM;
> > +             pmu_format_attr_group.attrs = attrs;
> > +     }
> > +
> > +     if (pmu_dev->nevents_attrs) {
> > +             attrs = alloc_attrs(dev, pmu_dev->nevents_attrs,
> > +                             pmu_dev->events_attr);
> > +             if (!attrs)
> > +                     return -ENOMEM;
> > +             pmu_events_attr_group.attrs = attrs;
> > +     }
> > +
> > +     pmu_dev->attr_groups = pmu_attr_groups;
> > +
> > +     return 0;
> > +}
>
> I don't see why we need to dynamically allocate anything, given we make
> a full copy of each of the existing arrays without modification. We
> should just be able to use them as-is.
>
> As I mentioned above, please just statically allocate the structures you
> need and share them.

Yes, got it. The dynamic relocation will be all removed along with the
fixed attribute group per class.

>
> [...]
>
> > +static int
> > +xgene_pmu_dev_add(struct xgene_pmu *xgene_pmu, struct xgene_pmu_dev_ctx *ctx)
> > +{
> > +     struct device *dev = xgene_pmu->dev;
> > +     struct xgene_pmu_dev *pmu;
> > +     int rc;
> > +
> > +     pmu = devm_kzalloc(dev, sizeof(*pmu), GFP_KERNEL);
> > +     if (!pmu)
> > +             return -ENOMEM;
> > +     pmu->parent = xgene_pmu;
> > +     pmu->inf = &ctx->inf;
> > +     ctx->pmu_dev = pmu;
> > +
> > +     switch (pmu->inf->type) {
> > +     case PMU_TYPE_L3C:
> > +             pmu->format_attr = l3c_pmu_format_attrs;
> > +             pmu->nformat_attrs = ARRAY_SIZE(l3c_pmu_format_attrs);
> > +             pmu->events_attr = l3c_pmu_events_attrs;
> > +             pmu->nevents_attrs = ARRAY_SIZE(l3c_pmu_events_attrs);
> > +             break;
> > +     case PMU_TYPE_IOB:
> > +             pmu->format_attr = iob_pmu_format_attrs;
> > +             pmu->nformat_attrs = ARRAY_SIZE(iob_pmu_format_attrs);
> > +             pmu->events_attr = iob_pmu_events_attrs;
> > +             pmu->nevents_attrs = ARRAY_SIZE(iob_pmu_events_attrs);
> > +             break;
> > +     case PMU_TYPE_MCB:
> > +             if (!(xgene_pmu->mcb_active_mask & pmu->inf->enable_mask))
> > +                     goto dev_err;
> > +             pmu->format_attr = mcb_pmu_format_attrs;
> > +             pmu->nformat_attrs = ARRAY_SIZE(mcb_pmu_format_attrs);
> > +             pmu->events_attr = mcb_pmu_events_attrs;
> > +             pmu->nevents_attrs = ARRAY_SIZE(mcb_pmu_events_attrs);
> > +             break;
> > +     case PMU_TYPE_MC:
> > +             if (!(xgene_pmu->mc_active_mask & pmu->inf->enable_mask))
> > +                     goto dev_err;
> > +             pmu->format_attr = mc_pmu_format_attrs;
> > +             pmu->nformat_attrs = ARRAY_SIZE(mc_pmu_format_attrs);
> > +             pmu->events_attr = mc_pmu_events_attrs;
> > +             pmu->nevents_attrs = ARRAY_SIZE(mc_pmu_events_attrs);
> > +             break;
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +
> > +     rc = xgene_pmu_alloc_attrs(dev, pmu);
> > +     if (rc) {
> > +             dev_err(dev, "%s PMU: Failed to alloc attributes\n", ctx->name);
> > +             goto dev_err;
> > +     }
> > +
> > +     rc = xgene_init_perf(pmu, ctx->name);
> > +     if (rc) {
> > +             dev_err(dev, "%s PMU: Failed to init perf driver\n", ctx->name);
> > +             goto dev_err;
> > +     }
> > +
> > +     dev_info(dev, "%s PMU registered\n", ctx->name);
> > +
> > +     /* All attribute allocations can be free'd after perf_register_pmu */
> > +     deallocate_attrs(dev, pmu);
>
> As far as I can see, that is not true. The core perf code doesn't make a
> copy of the attrs, it just continues to use them as-is. So this looks to
> be broken and very unsafe.
>
> Please get rid of the dynamic allocation and copying.
>

This will be removed.

> [...]
>
> > +static irqreturn_t _xgene_pmu_isr(int irq, struct xgene_pmu_dev *pmu_dev)
> > +{
> > +     struct perf_event *event = NULL;
> > +     struct perf_sample_data data;
>
> You never sample, so don't need perf_sample_data.

Okay thanks.

>
> > +     struct xgene_pmu *xgene_pmu;
> > +     struct hw_perf_event *hwc;
> > +     int idx;
> > +     u32 val;
> > +
> > +     /* Get interrupt counter source */
> > +     val = readl(pmu_dev->inf->csr + PMU_PMOVSR);
> > +     idx = ffs(val) - 1;
>
> bit 0 is never set?

No, it's not that.
The ffs() return a value for bit position 1 to 32. Bit 0 (overflow
occurs on the counter 0) returns position 1.
The above is just to map the returned value to the according counter index.
Btw, This ffs() use will be removed in next patch version.

>
> What if multiple counters overflow? You should iterate over all the
> counters which have overflown (as we do in the arm-ccn driver).

This is right, thanks for catching it. I'll fix it.

>
> > +     if (!(val & PMU_OVERFLOW_MASK))
> > +             goto out;
> > +     event = pmu_dev->pmu_counter_event[idx];
> > +
> > +     /* Ignore if we don't have an event. */
> > +     if (!event)
> > +             goto out;
> > +
> > +     hwc = &event->hw;
> > +
> > +     xgene_perf_event_update(event, hwc, idx);
> > +     perf_sample_data_init(&data, 0, hwc->last_period);
>
> You aren't sampling, so don't need this.

Yes, thanks

>
> > +     if (!xgene_perf_event_set_period(event, hwc, idx))
> > +             goto out;
> > +
> > +out:
> > +     /* Clear interrupt flag */
> > +     xgene_pmu = pmu_dev->parent;
> > +     if (xgene_pmu->version == 1)
>
>
> It would be better to consistently use the PCP_PMU_V{1,2} defines.
>

Okay

> [...]
>
> > +     version = (dev_id == PCP_PMU_V1) ? 1 : 2;
>
> As above, why not set version to the dev_id, and use the PCP_PMU_V*
> defines consistently when comparing xgene_pmu::version?
>

Okay, I'll fix it

> > +     irq = platform_get_irq(pdev, 0);
> > +     if (irq < 0) {
> > +             dev_err(&pdev->dev, "No IRQ resource\n");
> > +             rc = -EINVAL;
> > +             goto err;
> > +     }
> > +     rc = devm_request_irq(&pdev->dev, irq, xgene_pmu_isr, IRQF_SHARED,
> > +                           dev_name(&pdev->dev), xgene_pmu);
> > +     if (rc) {
> > +             dev_err(&pdev->dev, "Could not request IRQ %d\n", irq);
> > +             goto err;
> > +     }
>
> > +     /* Pick one core to use for cpumask attributes */
> > +     cpumask_set_cpu(smp_processor_id(), &xgene_pmu->cpu);
>
> You also need to ensure that the IRQ occurs on this CPU.

Okay, I will set affinity to make sure the overflow interrupt is
handled by this CPU.
I will soon send out the patch version 4 to fix all the above comments.

Thanks,
-- 
Tai
