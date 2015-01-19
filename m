From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 19 Jan 2015 17:48:18 +0000
Subject: [RFC PATCH 5/5] arm: perf: Use FIQ to handle PMU events.
In-Reply-To: <1421166931-14134-6-git-send-email-daniel.thompson@linaro.org>
References: <1421166931-14134-1-git-send-email-daniel.thompson@linaro.org>
 <1421166931-14134-6-git-send-email-daniel.thompson@linaro.org>
Message-ID: <20150119174818.GD26493@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 13, 2015 at 04:35:31PM +0000, Daniel Thompson wrote:
> +/*
> + * This handler is called *unconditionally* from the default NMI/FIQ
> + * handler. The irq may not be anything to do with us so the main
> + * job of this function is to figure out if the irq passed in is ours
> + * or not.
> + */
> +void cpu_pmu_handle_fiq(int irq)
> +{
> +	int cpu = smp_processor_id();

This can be either debug_smp_processor_id() or raw_smp_processor_id().
raw_smp_processor_id() is fine from FIQ contexts, as seems to be
debug_smp_processor_id(), but only because we guarantee that
irqs_disabled() in there will be true.

> +
> +	if (irq != get_cpu_var(cpu_pmu_irqs))
> +		return;

get_cpu_var() needs put_cpu_var() to undo its effects.  get_cpu_var()
calls preempt_disable(), which calls into lockdep...  I think we
determined that was fine last time we went digging?  put_cpu_var()
would call preempt_enable() which I'd hope would be safe in FIQ/NMI
contexts?

> +
> +	(void)armpmu_dispatch_irq(irq,
> +				  get_cpu_ptr(&cpu_pmu->hw_events->percpu_pmu));

Again, get_cpu_xxx() needs to be balanced with a put_cpu_xxx().


-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
