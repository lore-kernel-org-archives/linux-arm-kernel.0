From: will.deacon@arm.com (Will Deacon)
Date: Fri, 15 Feb 2013 09:51:53 +0000
Subject: [patch 1/2] arm: Mark pmu interupt IRQF_NO_THREAD
In-Reply-To: <20130214205304.923585891@linutronix.de>
References: <20130214205204.109023136@linutronix.de>
 <20130214205304.923585891@linutronix.de>
Message-ID: <20130215095153.GA11145@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 14, 2013 at 08:53:52PM +0000, Thomas Gleixner wrote:
> PMU interrupts must not be threaded.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/arm/kernel/perf_event_cpu.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> Index: linux-2.6/arch/arm/kernel/perf_event_cpu.c
> ===================================================================
> --- linux-2.6.orig/arch/arm/kernel/perf_event_cpu.c
> +++ linux-2.6/arch/arm/kernel/perf_event_cpu.c
> @@ -118,7 +118,8 @@ static int cpu_pmu_request_irq(struct ar
>  			continue;
>  		}
>  
> -		err = request_irq(irq, handler, IRQF_NOBALANCING, "arm-pmu",
> +		err = request_irq(irq, handler,
> +				  IRQF_NOBALANCING | IRQF_NO_THREAD, "arm-pmu",
>  				  cpu_pmu);
>  		if (err) {
>  			pr_err("unable to request IRQ%d for ARM PMU counters\n",
> 
> 

Yup, we certainly don't want these to be threaded! Cheers, I'll add this to
my perf queue.

Will
