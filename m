From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 21 Mar 2016 10:35:08 +0000
Subject: [PATCH V1] perf: qcom: Add L3 cache PMU driver
In-Reply-To: <1458333422-8963-1-git-send-email-agustinv@codeaurora.org>
References: <1458333422-8963-1-git-send-email-agustinv@codeaurora.org>
Message-ID: <20160321103507.GB17326@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 18, 2016 at 04:37:02PM -0400, Agustin Vega-Frias wrote:
> This adds a new dynamic PMU to the Perf Events framework to program
> and control the L3 cache PMUs in some Qualcomm Technologies SOCs.
> 
> The driver supports a distributed cache architecture where the overall
> cache is comprised of multiple slices each with its own PMU. The driver
> aggregates counts across the whole system to provide a global picture
> of the metrics selected by the user.
> 
> The driver exports formatting and event information to sysfs so it can
> be used by the perf user space tools with the syntaxes:
>    perf stat -a -e l3cache/read-miss/
>    perf stat -a -e l3cache/event=0x21/
> 
> Signed-off-by: Agustin Vega-Frias <agustinv@codeaurora.org>
> ---
>  arch/arm64/kernel/Makefile                   |   4 +
>  arch/arm64/kernel/perf_event_qcom_l3_cache.c | 816 +++++++++++++++++++++++++++
>  2 files changed, 820 insertions(+)
>  create mode 100644 arch/arm64/kernel/perf_event_qcom_l3_cache.c

Move this to drivers/bus (where the CCI and CCN PMU drivers live), or
drivers/perf (where some common infrastructure lives).

This isn't architectural, and isn't CPU-specific, so it has no reason to
live in arch/arm64.

> +static
> +int qcom_l3_cache__event_init(struct perf_event *event)
> +{
> +	struct hw_perf_event *hwc = &event->hw;
> +
> +	if (event->attr.type != l3cache_pmu.pmu.type)
> +		return -ENOENT;
> +
> +	/*
> +	 * There are no per-counter mode filters in the PMU.
> +	 */
> +	if (event->attr.exclude_user || event->attr.exclude_kernel ||
> +	    event->attr.exclude_hv || event->attr.exclude_idle)
> +		return -EINVAL;
> +
> +	hwc->idx = -1;
> +
> +	/*
> +	 * Sampling not supported since these events are not core-attributable.
> +	 */
> +	if (hwc->sample_period)
> +		return -EINVAL;
> +
> +	/*
> +	 * Task mode not available, we run the counters as system counters,
> +	 * not attributable to any CPU and therefore cannot attribute per-task.
> +	 */
> +	if (event->cpu < 0)
> +		return -EINVAL;
> +
> +	return 0;
> +}

Please follow what the other system PMUs do and (forcefully) ensure that all
events share the same CPU in event_init.

Otherwise, events can exist in multiple percpu contexts, and management
thereof can race on things line pmu_{enable,disable}.

You'll also want to expose a cpumask to userspace for that, to ensure that it
only opens events on a single CPU.

For an example, see drivers/bus/arm-ccn.c. That also handles migrating
events to a new CPU upon hotplug.

> +static
> +int qcom_l3_cache__event_add(struct perf_event *event, int flags)
> +{
> +	struct l3cache_pmu *system = to_l3cache_pmu(event->pmu);
> +	struct hw_perf_event *hwc = &event->hw;
> +	int idx;
> +	int prev_cpu;
> +	int err = 0;
> +
> +	/*
> +	 * We need to disable the pmu while adding the event, otherwise
> +	 * the perf tick might kick-in and re-add this event.
> +	 */
> +	perf_pmu_disable(event->pmu);
> +
> +	/*
> +	 * This ensures all events are on the same CPU context. No need to open
> +	 * these on all CPUs since they are system events. The strategy here is
> +	 * to set system->cpu when the first event is created and from that
> +	 * point on, only events in the same CPU context will be allowed to be
> +	 * active. system->cpu will get reset back to -1 when the last event
> +	 * is deleted, please see qcom_l3_cache__event_del below.
> +	 */
> +	prev_cpu = atomic_cmpxchg(&system->cpu, -1, event->cpu);
> +	if ((event->cpu != prev_cpu) && (prev_cpu != -1)) {
> +		err = -EAGAIN;
> +		goto out;
> +	}

As above, handle this in event_init, as other system PMUs do.

Handling it here is rather late, and unnecessarily fragile.

> +/*
> + * In some platforms interrupt resources might not come directly from the GIC,
> + * but from separate IRQ circuitry that signals a summary IRQ to the GIC and
> + * is handled by a secondary IRQ controller. This is problematic under ACPI boot
> + * because the ACPI core does not use the Resource Source field on the Extended
> + * Interrupt Descriptor, which in theory could be used to specify an alternative
> + * IRQ controller.
> +
> + * For this reason in these platforms we implement the secondary IRQ controller
> + * using the gpiolib and specify the IRQs as GpioInt resources, so when getting
> + * an IRQ from the device we first try platform_get_irq and if it fails we try
> + * devm_gpiod_get_index/gpiod_to_irq.
> + */
> +static
> +int qcom_l3_cache_pmu_get_slice_irq(struct platform_device *pdev,
> +				    struct platform_device *sdev)
> +{
> +	int virq = platform_get_irq(sdev, 0);
> +	struct gpio_desc *desc;
> +
> +	if (virq >= 0)
> +		return virq;
> +
> +	desc = devm_gpiod_get_index(&sdev->dev, NULL, 0, GPIOD_ASIS);
> +	if (IS_ERR(desc))
> +		return -ENOENT;
> +
> +	return gpiod_to_irq(desc);
> +}
> +

As Marc Zyngier pointed out in another thread, you should represent your
interrupt controller as an interrupt controller rather than pretending it is a
GPIO controller.

Drivers should be able to remain blissfully unaware what the other end of their
interrupt line is wired up to, and shouldn't have to jump through hoops like
the above.

Thanks,
Mark.
