From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 6 Jul 2016 12:24:44 +0100
Subject: [PATCH v2 0/2] arm64: dts: rockchip: Support PMU for rk3399 SoCs
In-Reply-To: <1467792357-9749-1-git-send-email-wxt@rock-chips.com>
References: <1467792357-9749-1-git-send-email-wxt@rock-chips.com>
Message-ID: <20160706112444.GB14657@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 06, 2016 at 04:05:55PM +0800, Caesar Wang wrote:
> Hello Heiko, Marc & ARM guys

Hi,

These patches themselves look fine, so FWIW:

Acked-by: Mark Rutland <mark.rutland@arm.com>

The prerequisite patch from Marc [1] also largely looks fine, but there
are some minor details to sort out [2], so at this point in time I'm
guesssing this is all v4.9 material.

Thanks,
Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-July/440647.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-July/441495.html

> When Jay first submitted the rk3399.dtsi upstream
> <https://patchwork.kernel.org/patch/8885821/> he had the PMU node in there,
> but then took it out because the upstream binding wasn't done yet.
> It looks as if the upstream stuff has landed, since in linux/master I see:
> 287e9357abcc DT/arm,gic-v3: Documment PPI partition support
> e3825ba1af3a irqchip/gic-v3: Add support for partitioned PPIs
> 9e2c986cb460 irqchip: Add per-cpu interrupt partitioning library
> 222df54fd8b7 genirq: Allow the affinity of a percpu interrupt to be set/retrieved
> 651e8b54abde irqdomain: Allow domain matching on irq_fwspec
> 
> This series patches add to support the rk3399 SoCs PMU.
> I pick up the https://patchwork.kernel.org/patch/9209369/.
> 
> As do some tests with ChromeOs for my rk3399 board.
> Tested with linus master 4.7-rc6 kernel on rk3399 board.
> https://github.com/Caesar-github/rockchip/tree/rk3399/pmu-upstream
> 
> localhost / # perf list
> 
> List of pre-defined events (to be used in -e):
> cpu-cycles OR cycles [Hardware event]
> instructions [Hardware event]
> cache-references [Hardware event]
> cache-misses [Hardware event]
> branch-instructions OR branches [Hardware event]
> branch-misses [Hardware event]
> bus-cycles [Hardware event]
> ...
> 
> perf stat --cpu 0/1/2/3..... to minitor
> e.g. cpu0;
> 
> localhost / # perf stat --cpu 0
> 
> Performance counter stats for 'CPU(s) 0':
> 
> 3374.917571 task-clock (msec) # 1.001 CPUs utilized [100.00%]
> 20 context-switches # 0.006 K/sec [100.00%]
> 2 cpu-migrations # 0.001 K/sec [100.00%]
> 55 page-faults # 0.016 K/sec
> 7151843 cycles # 0.002 GHz [100.00%]
> <not supported> stalled-cycles-frontend
> <not supported> stalled-cycles-backend
> 4272536 instructions # 0.60 insns per cycle [100.00%]
> 568406 branches # 0.168 M/sec [100.00%]
> 65652 branch-misses # 11.55% of all branches
> 
> Also, 'perf top' to monitor the PMU interrupts from cpus
> 
> -Caesar
> 
> 
> Changes in v2:
> - AS Mark comments on https://patchwork.kernel.org/patch/9209369/
>   remove the interrupt-affinity property, we need depend on Marc' perf
>   code on https://patchwork.kernel.org/patch/9209369/.
> 
> Caesar Wang (2):
>   arm64: dts: rockchip: change all interrupts cells for 4 on rk3399 SoCs
>   arm64: dts: rockchip: support the pmu node for rk3399
> 
>  arch/arm64/boot/dts/rockchip/rk3399.dtsi | 118 ++++++++++++++++++-------------
>  1 file changed, 69 insertions(+), 49 deletions(-)
> 
> -- 
> 1.9.1
> 
