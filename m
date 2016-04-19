From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 19 Apr 2016 16:43:40 +0100
Subject: [PATCH v2 2/5] arm64/perf: Cavium ThunderX L2C TAD uncore support
In-Reply-To: <c821d052ffc795b74b520e3cfc393929f0dcbb1e.1457539622.git.jglauber@cavium.com>
References: <cover.1457539621.git.jglauber@cavium.com>
 <c821d052ffc795b74b520e3cfc393929f0dcbb1e.1457539622.git.jglauber@cavium.com>
Message-ID: <20160419154340.GC20991@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 09, 2016 at 05:21:04PM +0100, Jan Glauber wrote:
> Support counters of the L2 Cache tag and data units.
> 
> Also support pass2 added/modified counters by checking MIDR.
> 
> Signed-off-by: Jan Glauber <jglauber@cavium.com>
> ---
>  drivers/perf/uncore/Makefile                |   3 +-
>  drivers/perf/uncore/uncore_cavium.c         |   6 +-
>  drivers/perf/uncore/uncore_cavium.h         |   7 +-
>  drivers/perf/uncore/uncore_cavium_l2c_tad.c | 600 ++++++++++++++++++++++++++++
>  4 files changed, 613 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/perf/uncore/uncore_cavium_l2c_tad.c
> 
> diff --git a/drivers/perf/uncore/Makefile b/drivers/perf/uncore/Makefile
> index b9c72c2..6a16caf 100644
> --- a/drivers/perf/uncore/Makefile
> +++ b/drivers/perf/uncore/Makefile
> @@ -1 +1,2 @@
> -obj-$(CONFIG_ARCH_THUNDER) += uncore_cavium.o
> +obj-$(CONFIG_ARCH_THUNDER) += uncore_cavium.o		\
> +			      uncore_cavium_l2c_tad.o
> diff --git a/drivers/perf/uncore/uncore_cavium.c b/drivers/perf/uncore/uncore_cavium.c
> index 4fd5e45..b92b2ae 100644
> --- a/drivers/perf/uncore/uncore_cavium.c
> +++ b/drivers/perf/uncore/uncore_cavium.c
> @@ -15,7 +15,10 @@ int thunder_uncore_version;
>  
>  struct thunder_uncore *event_to_thunder_uncore(struct perf_event *event)
>  {
> -	return NULL;
> +	if (event->pmu->type == thunder_l2c_tad_pmu.type)
> +		return thunder_uncore_l2c_tad;
> +	else
> +		return NULL;
>  }

If thunder_uncore contained the relevant struct pmu, you wouldn't need
this function.

You could take event->pmu, and use container_of to get the relevant
thunder_uncore.

So please do that and get rid of this function.

>  
>  void thunder_uncore_read(struct perf_event *event)
> @@ -296,6 +299,7 @@ static int __init thunder_uncore_init(void)
>  		thunder_uncore_version = 1;
>  	pr_info("PMU version: %d\n", thunder_uncore_version);
>  
> +	thunder_uncore_l2c_tad_setup();
>  	return 0;
>  }
>  late_initcall(thunder_uncore_init);
> diff --git a/drivers/perf/uncore/uncore_cavium.h b/drivers/perf/uncore/uncore_cavium.h
> index c799709..7a9c367 100644
> --- a/drivers/perf/uncore/uncore_cavium.h
> +++ b/drivers/perf/uncore/uncore_cavium.h
> @@ -7,7 +7,7 @@
>  #define pr_fmt(fmt)     "thunderx_uncore: " fmt
>  
>  enum uncore_type {
> -	NOP_TYPE,
> +	L2C_TAD_TYPE,
>  };
>  
>  extern int thunder_uncore_version;
> @@ -65,6 +65,9 @@ static inline struct thunder_uncore_node *get_node(u64 config,
>  extern struct attribute_group thunder_uncore_attr_group;
>  extern struct device_attribute format_attr_node;
>  
> +extern struct thunder_uncore *thunder_uncore_l2c_tad;
> +extern struct pmu thunder_l2c_tad_pmu;

The above hopefully means you can get rid of these.

>  /* Prototypes */
>  struct thunder_uncore *event_to_thunder_uncore(struct perf_event *event);
>  void thunder_uncore_del(struct perf_event *event, int flags);
> @@ -76,3 +79,5 @@ int thunder_uncore_setup(struct thunder_uncore *uncore, int id,
>  ssize_t thunder_events_sysfs_show(struct device *dev,
>  				  struct device_attribute *attr,
>  				  char *page);
> +
> +int thunder_uncore_l2c_tad_setup(void);
> diff --git a/drivers/perf/uncore/uncore_cavium_l2c_tad.c b/drivers/perf/uncore/uncore_cavium_l2c_tad.c
> new file mode 100644
> index 0000000..c8dc305
> --- /dev/null
> +++ b/drivers/perf/uncore/uncore_cavium_l2c_tad.c
> @@ -0,0 +1,600 @@
> +/*
> + * Cavium Thunder uncore PMU support, L2C TAD counters.

It would be good to put an explaination of the TAD unit here, even if
just expanding that to Tag And Data.

> + *
> + * Copyright 2016 Cavium Inc.
> + * Author: Jan Glauber <jan.glauber@cavium.com>
> + */
> +
> +#include <linux/slab.h>
> +#include <linux/perf_event.h>

Minor nit, but as a general note I'd recommend alphabetically sorting
your includes now. 

That way any subsequent additions/removals are less likely to cause
painful conflicts (so long as they retain that order).

> +static void thunder_uncore_start(struct perf_event *event, int flags)
> +{
> +	struct thunder_uncore *uncore = event_to_thunder_uncore(event);
> +	struct hw_perf_event *hwc = &event->hw;
> +	struct thunder_uncore_node *node;
> +	struct thunder_uncore_unit *unit;
> +	u64 prev;
> +	int id;
> +
> +	node = get_node(hwc->config, uncore);
> +	id = get_id(hwc->config);
> +
> +	/* restore counter value divided by units into all counters */
> +	if (flags & PERF_EF_RELOAD) {
> +		prev = local64_read(&hwc->prev_count);
> +		prev = prev / node->nr_units;
> +
> +		list_for_each_entry(unit, &node->unit_list, entry)
> +			writeq(prev, hwc->event_base + unit->map);
> +	}

It would be vastly simpler to always restore zero into all counters, and
to update prev_count to account for this.

That will also save you any rounding loss from the division.

> +
> +	hwc->state = 0;
> +
> +	/* write byte in control registers for all units on the node */
> +	list_for_each_entry(unit, &node->unit_list, entry)
> +		writeb(id, hwc->config_base + unit->map);

That comment isn't very helpful. What is the intent and effect of this
write?

> +
> +	perf_event_update_userpage(event);
> +}
> +
> +static void thunder_uncore_stop(struct perf_event *event, int flags)
> +{
> +	struct thunder_uncore *uncore = event_to_thunder_uncore(event);
> +	struct hw_perf_event *hwc = &event->hw;
> +	struct thunder_uncore_node *node;
> +	struct thunder_uncore_unit *unit;
> +
> +	/* reset selection value for all units on the node */
> +	node = get_node(hwc->config, uncore);
> +
> +	list_for_each_entry(unit, &node->unit_list, entry)
> +		writeb(L2C_TAD_EVENTS_DISABLED, hwc->config_base + unit->map);
> +	hwc->state |= PERF_HES_STOPPED;
> +
> +	if ((flags & PERF_EF_UPDATE) && !(hwc->state & PERF_HES_UPTODATE)) {
> +		thunder_uncore_read(event);
> +		hwc->state |= PERF_HES_UPTODATE;
> +	}
> +}
> +
> +static int thunder_uncore_add(struct perf_event *event, int flags)
> +{
> +	struct thunder_uncore *uncore = event_to_thunder_uncore(event);
> +	struct hw_perf_event *hwc = &event->hw;
> +	struct thunder_uncore_node *node;
> +	int i;
> +
> +	WARN_ON_ONCE(!uncore);

This is trivially never possible if uncore contains the pmu (or we
couldn't have initialised the event in the first place).

> +	node = get_node(hwc->config, uncore);
> +
> +	/* are we already assigned? */
> +	if (hwc->idx != -1 && node->events[hwc->idx] == event)
> +		goto out;

Why would the event already be assigned a particular counter?

Which other piece of code might do that?

As far as I can see, nothing else can.

> +
> +	for (i = 0; i < node->num_counters; i++) {
> +		if (node->events[i] == event) {
> +			hwc->idx = i;
> +			goto out;
> +		}
> +	}

This should never happen, in the absence of a programming error. An
event should not be added multiple times, and adds and dels should be
balanced.

> +
> +	/* if not take the first available counter */
> +	hwc->idx = -1;
> +	for (i = 0; i < node->num_counters; i++) {
> +		if (cmpxchg(&node->events[i], NULL, event) == NULL) {
> +			hwc->idx = i;
> +			break;
> +		}
> +	}
> +out:
> +	if (hwc->idx == -1)
> +		return -EBUSY;
> +
> +	hwc->config_base = hwc->idx;
> +	hwc->event_base = L2C_TAD_COUNTER_OFFSET +
> +			  hwc->idx * sizeof(unsigned long long);

What's going on here?

I see that we write use hwc->event_base as an offset into registers in
the HW, so a sizeof unsigned long long is unusual.

I'm guessing that you're figuring out the address of a 64 bit register.
A comment, and sizeof(u64) would be better.

> +EVENT_ATTR(l2t_hit,	L2C_TAD_EVENT_L2T_HIT);
> +EVENT_ATTR(l2t_miss,	L2C_TAD_EVENT_L2T_MISS);
> +EVENT_ATTR(l2t_noalloc,	L2C_TAD_EVENT_L2T_NOALLOC);
> +EVENT_ATTR(l2_vic,	L2C_TAD_EVENT_L2_VIC);
> +EVENT_ATTR(sc_fail,	L2C_TAD_EVENT_SC_FAIL);
> +EVENT_ATTR(sc_pass,	L2C_TAD_EVENT_SC_PASS);
> +EVENT_ATTR(lfb_occ,	L2C_TAD_EVENT_LFB_OCC);
> +EVENT_ATTR(wait_lfb,	L2C_TAD_EVENT_WAIT_LFB);
> +EVENT_ATTR(wait_vab,	L2C_TAD_EVENT_WAIT_VAB);
> +EVENT_ATTR(rtg_hit,	L2C_TAD_EVENT_RTG_HIT);
> +EVENT_ATTR(rtg_miss,	L2C_TAD_EVENT_RTG_MISS);
> +EVENT_ATTR(l2_rtg_vic,	L2C_TAD_EVENT_L2_RTG_VIC);
> +EVENT_ATTR(l2_open_oci,	L2C_TAD_EVENT_L2_OPEN_OCI);

> +static struct attribute *thunder_l2c_tad_events_attr[] = {
> +	EVENT_PTR(l2t_hit),
> +	EVENT_PTR(l2t_miss),
> +	EVENT_PTR(l2t_noalloc),
> +	EVENT_PTR(l2_vic),
> +	EVENT_PTR(sc_fail),
> +	EVENT_PTR(sc_pass),
> +	EVENT_PTR(lfb_occ),
> +	EVENT_PTR(wait_lfb),
> +	EVENT_PTR(wait_vab),
> +	EVENT_PTR(rtg_hit),
> +	EVENT_PTR(rtg_miss),
> +	EVENT_PTR(l2_rtg_vic),
> +	EVENT_PTR(l2_open_oci),

This duplication is tedious.

Please do something like we did for CCI in commit 5e442eba342e567e
("arm-cci: simplify sysfs attr handling") so you only need to define
each attribute once to create it and place it in the relevant attribute
pointer list.

Likewise for the other PMUs.

> +static struct attribute_group thunder_l2c_tad_events_group = {
> +	.name = "events",
> +	.attrs = NULL,
> +};
> +
> +static const struct attribute_group *thunder_l2c_tad_attr_groups[] = {
> +	&thunder_uncore_attr_group,
> +	&thunder_l2c_tad_format_group,
> +	&thunder_l2c_tad_events_group,
> +	NULL,
> +};
> +
> +struct pmu thunder_l2c_tad_pmu = {
> +	.attr_groups	= thunder_l2c_tad_attr_groups,
> +	.name		= "thunder_l2c_tad",
> +	.event_init	= thunder_uncore_event_init,
> +	.add		= thunder_uncore_add,
> +	.del		= thunder_uncore_del,
> +	.start		= thunder_uncore_start,
> +	.stop		= thunder_uncore_stop,
> +	.read		= thunder_uncore_read,
> +};
> +
> +static int event_valid(u64 config)

A bool would be clearer.

> +{
> +	if ((config > 0 && config <= L2C_TAD_EVENT_WAIT_VAB) ||
> +	    config == L2C_TAD_EVENT_RTG_HIT ||
> +	    config == L2C_TAD_EVENT_RTG_MISS ||
> +	    config == L2C_TAD_EVENT_L2_RTG_VIC ||
> +	    config == L2C_TAD_EVENT_L2_OPEN_OCI ||
> +	    ((config & 0x80) && ((config & 0xf) <= 3)))

What are these last cases?

> +		return 1;
> +
> +	if (thunder_uncore_version == 1)
> +		if (config == L2C_TAD_EVENT_OPEN_CCPI ||
> +		    (config >= L2C_TAD_EVENT_LOOKUP &&
> +		     config <= L2C_TAD_EVENT_LOOKUP_ALL) ||
> +		    (config >= L2C_TAD_EVENT_TAG_ALC_HIT &&
> +		     config <= L2C_TAD_EVENT_OCI_RTG_ALC_VIC &&
> +		     config != 0x4d &&
> +		     config != 0x66 &&
> +		     config != 0x67))

Likewise, what are these last cases?

Why not rule these out explicitly first?

> +			return 1;
> +
> +	return 0;
> +}
> +
> +int __init thunder_uncore_l2c_tad_setup(void)
> +{
> +	int ret = -ENOMEM;
> +
> +	thunder_uncore_l2c_tad = kzalloc(sizeof(struct thunder_uncore),
> +					 GFP_KERNEL);

As previously, sizeof(*ptr) is preferred to sizeof(type), though it
doesn't save you anything here.

> +	if (!thunder_uncore_l2c_tad)
> +		goto fail_nomem;
> +
> +	if (thunder_uncore_version == 0)
> +		thunder_l2c_tad_events_group.attrs = thunder_l2c_tad_events_attr;
> +	else /* default */
> +		thunder_l2c_tad_events_group.attrs = thunder_l2c_tad_pass2_events_attr;
> +
> +	ret = thunder_uncore_setup(thunder_uncore_l2c_tad,
> +			   PCI_DEVICE_ID_THUNDER_L2C_TAD,
> +			   L2C_TAD_CONTROL_OFFSET,
> +			   L2C_TAD_COUNTER_OFFSET + L2C_TAD_NR_COUNTERS
> +				* sizeof(unsigned long long),

It would be nicer to calculate the size earlier (with sizeof(u64) as
previously mentioned).

> +			   &thunder_l2c_tad_pmu,
> +			   L2C_TAD_NR_COUNTERS);
> +	if (ret)
> +		goto fail;
> +
> +	thunder_uncore_l2c_tad->type = L2C_TAD_TYPE;

I believe this can go, with thunder_uncore containing a pmu.

Thanks,
Mark.
