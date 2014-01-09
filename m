From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 09 Jan 2014 11:17:29 -0800
Subject: [PATCH 2/7] ARM: perf_event: Support percpu irqs for the CPU PMU
In-Reply-To: <20140109104943.GB17838@mudshark.cambridge.arm.com>
References: <1389221984-10973-1-git-send-email-sboyd@codeaurora.org>
 <1389221984-10973-3-git-send-email-sboyd@codeaurora.org>
 <20140109104943.GB17838@mudshark.cambridge.arm.com>
Message-ID: <52CEF5C9.1010701@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/09/14 02:49, Will Deacon wrote:
>
>> +static irq_handler_t cpu_handler;
>> +
>> +static irqreturn_t cpu_pmu_dispatch_irq(int irq, void *dev)
>> +{
>> +	struct arm_pmu *arm_pmu = *(struct arm_pmu **)dev;
>> +	return cpu_handler(irq, arm_pmu);
>> +}
> I don't like this bit -- having a global cpu_handler field is going to
> interfere with the big.LITTLE work and casting the per-cpu dev token is also
> pretty hacky.
>
> However, you're forced down this route by the need to invoke the armpmu IRQ
> dispatcher. Now, that only exists as a workaround for the braindead
> interrupt routing on the u8500 (they OR'd all the PMU SPIs together) -- it's
> not a problem that will affect a system using PPIs. If you look, there is
> only one use of the thing in: arch/arm/mach-ux500/cpu-db8500.c.
>
> So, we could rename that callback to make it clear that it's not so much an
> IRQ handler wrapper as a specific hack to deal with broken SPIs. Then the
> cpu_pmu code can neglect to make the callback if it's using PPI.
>
> What do you think?

Yeah I hate this bouncing layer too but it was the best I could come up
with. I'll rename it to 'armpmu_dispatch_spi_irq' (bikeshedding welcome).

We can avoid the hacky cast of the per-cpu dev token by using the
cpu_pmu pointer directly, but we'll still need to pass something to the
percpu interrupt handler otherwise the genirq layer doesn't allow us to
request the PPI. I can pass hw_events I guess. Is that what you're
thinking? Or were you thinking that we could just use
cpu_pmu->handle_irq as the handler argument in request_percpu_irq()? I
can't figure out how that is supposed to work.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
