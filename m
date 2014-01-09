From: will.deacon@arm.com (Will Deacon)
Date: Thu, 9 Jan 2014 10:49:43 +0000
Subject: [PATCH 2/7] ARM: perf_event: Support percpu irqs for the CPU PMU
In-Reply-To: <1389221984-10973-3-git-send-email-sboyd@codeaurora.org>
References: <1389221984-10973-1-git-send-email-sboyd@codeaurora.org>
 <1389221984-10973-3-git-send-email-sboyd@codeaurora.org>
Message-ID: <20140109104943.GB17838@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, Jan 08, 2014 at 10:59:39PM +0000, Stephen Boyd wrote:
> Some CPU PMUs are wired up with one PPI for all the CPUs instead
> of with a different SPI for each CPU. Add support for these
> devices.
> 
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  arch/arm/kernel/perf_event_cpu.c | 107 +++++++++++++++++++++++++++++----------
>  1 file changed, 79 insertions(+), 28 deletions(-)

[...]

> +static irq_handler_t cpu_handler;
> +
> +static irqreturn_t cpu_pmu_dispatch_irq(int irq, void *dev)
> +{
> +	struct arm_pmu *arm_pmu = *(struct arm_pmu **)dev;
> +	return cpu_handler(irq, arm_pmu);
> +}

I don't like this bit -- having a global cpu_handler field is going to
interfere with the big.LITTLE work and casting the per-cpu dev token is also
pretty hacky.

However, you're forced down this route by the need to invoke the armpmu IRQ
dispatcher. Now, that only exists as a workaround for the braindead
interrupt routing on the u8500 (they OR'd all the PMU SPIs together) -- it's
not a problem that will affect a system using PPIs. If you look, there is
only one use of the thing in: arch/arm/mach-ux500/cpu-db8500.c.

So, we could rename that callback to make it clear that it's not so much an
IRQ handler wrapper as a specific hack to deal with broken SPIs. Then the
cpu_pmu code can neglect to make the callback if it's using PPI.

What do you think?

Will
