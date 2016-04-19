From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 19 Apr 2016 16:56:12 +0100
Subject: [PATCH v2 3/5] arm64/perf: Cavium ThunderX L2C CBC uncore support
In-Reply-To: <256cecaca63266beedb57c344f10260915cc0a01.1457539622.git.jglauber@cavium.com>
References: <cover.1457539621.git.jglauber@cavium.com>
 <256cecaca63266beedb57c344f10260915cc0a01.1457539622.git.jglauber@cavium.com>
Message-ID: <20160419155612.GD20991@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 09, 2016 at 05:21:05PM +0100, Jan Glauber wrote:
> @@ -300,6 +302,7 @@ static int __init thunder_uncore_init(void)
>  	pr_info("PMU version: %d\n", thunder_uncore_version);
>  
>  	thunder_uncore_l2c_tad_setup();
> +	thunder_uncore_l2c_cbc_setup();
>  	return 0;
>  }
>  late_initcall(thunder_uncore_init);

Why aren't these just probed independently, as separate PCI devices,
rather than using a shared initcall?

You'd have to read the MIDR a few times, but that's a tiny fraction of
the rest of the cost of probing, and you can keep the common portion as
a stateless library.

> +int l2c_cbc_events[L2C_CBC_NR_COUNTERS] = {
> +	0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06,
> +	0x08, 0x09, 0x0a, 0x0b, 0x0c,
> +	0x10, 0x11, 0x12, 0x13
> +};

What are these magic numbers?

A comment would be helpful here.

> +
> +static void thunder_uncore_start(struct perf_event *event, int flags)
> +{
> +	struct thunder_uncore *uncore = event_to_thunder_uncore(event);
> +	struct hw_perf_event *hwc = &event->hw;
> +	struct thunder_uncore_node *node;
> +	struct thunder_uncore_unit *unit;
> +	u64 prev;
> +
> +	node = get_node(hwc->config, uncore);
> +
> +	/* restore counter value divided by units into all counters */
> +	if (flags & PERF_EF_RELOAD) {
> +		prev = local64_read(&hwc->prev_count);
> +		prev = prev / node->nr_units;
> +
> +		list_for_each_entry(unit, &node->unit_list, entry)
> +			writeq(prev, hwc->event_base + unit->map);
> +	}
> +
> +	hwc->state = 0;
> +	perf_event_update_userpage(event);
> +}

This looks practically identical to the code in patch 2. Please factor
the common portion into the library code from patch 1 (zeroing the
registers), and share it.

> +
> +static void thunder_uncore_stop(struct perf_event *event, int flags)
> +{
> +	struct hw_perf_event *hwc = &event->hw;
> +
> +	if ((flags & PERF_EF_UPDATE) && !(hwc->state & PERF_HES_UPTODATE)) {
> +		thunder_uncore_read(event);
> +		hwc->state |= PERF_HES_UPTODATE;
> +	}
> +}

There's no stop control for this PMU?

I was under the impression the core perf code could read the counter
while it was stopped, and it would unexpectedly count increasing values.

Does PERF_HES_UPTODATE stop the core from reading the counter, or is
it the responsibility of the backend to check that? I see that
thunder_uncore_read does not.

Do you need PERF_HES_STOPPED, or does that not matter due to the lack of
interrupts?

> +
> +static int thunder_uncore_add(struct perf_event *event, int flags)
> +{
> +	struct thunder_uncore *uncore = event_to_thunder_uncore(event);
> +	struct hw_perf_event *hwc = &event->hw;
> +	struct thunder_uncore_node *node;
> +	int id, i;
> +
> +	WARN_ON_ONCE(!uncore);
> +	node = get_node(hwc->config, uncore);
> +	id = get_id(hwc->config);
> +
> +	/* are we already assigned? */
> +	if (hwc->idx != -1 && node->events[hwc->idx] == event)
> +		goto out;
> +
> +	for (i = 0; i < node->num_counters; i++) {
> +		if (node->events[i] == event) {
> +			hwc->idx = i;
> +			goto out;
> +		}
> +	}
> +
> +	/* these counters are self-sustained so idx must match the counter! */
> +	hwc->idx = -1;
> +	for (i = 0; i < node->num_counters; i++) {
> +		if (l2c_cbc_events[i] == id) {
> +			if (cmpxchg(&node->events[i], NULL, event) == NULL) {
> +				hwc->idx = i;
> +				break;
> +			}
> +		}
> +	}
> +
> +out:
> +	if (hwc->idx == -1)
> +		return -EBUSY;
> +
> +	hwc->event_base = id * sizeof(unsigned long long);
> +
> +	/* counter is not stoppable so avoiding PERF_HES_STOPPED */
> +	hwc->state = PERF_HES_UPTODATE;
> +
> +	if (flags & PERF_EF_START)
> +		thunder_uncore_start(event, 0);
> +
> +	return 0;
> +}

This looks practically identical to code from path 2, and all my
comments there apply.

Please factor this out into the library code in patch 1, taking into
account my comments on patch 2.

Likewise, the remainder of the file is mostly a copy+paste of patch 2.
All those comments apply equally to this patch.

Thanks,
Mark.
