From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 8 Feb 2016 15:00:56 +0100
Subject: [PATCH v2] clocksource/arm_arch_timer: Enable and verify MMIO
 access
In-Reply-To: <71bf617f4083b116b2aeab24f13fc5fed99a816f.1454327031.git.robin.murphy@arm.com>
References: <71bf617f4083b116b2aeab24f13fc5fed99a816f.1454327031.git.robin.murphy@arm.com>
Message-ID: <56B89F98.7020909@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/01/2016 01:00 PM, Robin Murphy wrote:
> So far, we have been blindly assuming that having access to a
> memory-mapped timer frame implies that the individual elements of that
> frame frame are already enabled. Whilst it's the firmware's job to give
> us non-secure access to frames in the first place, we should not rely
> on implementations always being generous enough to also configure CNTACR
> for those non-secure frames (e.g. [1]).
>
> Explicitly enable feature-level access per-frame, and verify that the
> access we want is really implemented before trying to make use of it.
>
> [1]:https://github.com/ARM-software/tf-issues/issues/170
>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---

Hi Marc,

can you give your opinion on this patch ?

Thanks

   -- Daniel

> Changes from v1:
> - Remove CNTACR_RFRQ check since the "no access, CNTFRQ reads as zero"
>    case can be handled the same way the driver deals with the "CNTFRQ
>    accessible, but not programmed" case.
> - Reword the commit message to make more sense.
>
>   drivers/clocksource/arm_arch_timer.c | 36 ++++++++++++++++++++++++++++--------
>   1 file changed, 28 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index c64d543..7c567f0 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -32,6 +32,14 @@
>   #define CNTTIDR		0x08
>   #define CNTTIDR_VIRT(n)	(BIT(1) << ((n) * 4))
>
> +#define CNTACR(n)	(0x40 + ((n) * 4))
> +#define CNTACR_RPCT	BIT(0)
> +#define CNTACR_RVCT	BIT(1)
> +#define CNTACR_RFRQ	BIT(2)
> +#define CNTACR_RVOFF	BIT(3)
> +#define CNTACR_RWVT	BIT(4)
> +#define CNTACR_RWPT	BIT(5)
> +
>   #define CNTVCT_LO	0x08
>   #define CNTVCT_HI	0x0c
>   #define CNTFRQ		0x10
> @@ -757,7 +765,6 @@ static void __init arch_timer_mem_init(struct device_node *np)
>   	}
>
>   	cnttidr = readl_relaxed(cntctlbase + CNTTIDR);
> -	iounmap(cntctlbase);
>
>   	/*
>   	 * Try to find a virtual capable frame. Otherwise fall back to a
> @@ -765,20 +772,31 @@ static void __init arch_timer_mem_init(struct device_node *np)
>   	 */
>   	for_each_available_child_of_node(np, frame) {
>   		int n;
> +		u32 cntacr;
>
>   		if (of_property_read_u32(frame, "frame-number", &n)) {
>   			pr_err("arch_timer: Missing frame-number\n");
> -			of_node_put(best_frame);
>   			of_node_put(frame);
> -			return;
> +			goto out;
>   		}
>
> -		if (cnttidr & CNTTIDR_VIRT(n)) {
> +		/* Try enabling everything, and see what sticks */
> +		cntacr = CNTACR_RFRQ | CNTACR_RWPT | CNTACR_RPCT |
> +			 CNTACR_RWVT | CNTACR_RVOFF | CNTACR_RVCT;
> +		writel_relaxed(cntacr, cntctlbase + CNTACR(n));
> +		cntacr = readl_relaxed(cntctlbase + CNTACR(n));
> +
> +		if ((cnttidr & CNTTIDR_VIRT(n)) &&
> +		    !(~cntacr & (CNTACR_RWVT | CNTACR_RVCT))) {
>   			of_node_put(best_frame);
>   			best_frame = frame;
>   			arch_timer_mem_use_virtual = true;
>   			break;
>   		}
> +
> +		if (~cntacr & (CNTACR_RWPT | CNTACR_RPCT))
> +			continue;
> +
>   		of_node_put(best_frame);
>   		best_frame = of_node_get(frame);
>   	}
> @@ -786,24 +804,26 @@ static void __init arch_timer_mem_init(struct device_node *np)
>   	base = arch_counter_base = of_iomap(best_frame, 0);
>   	if (!base) {
>   		pr_err("arch_timer: Can't map frame's registers\n");
> -		of_node_put(best_frame);
> -		return;
> +		goto out;
>   	}
>
>   	if (arch_timer_mem_use_virtual)
>   		irq = irq_of_parse_and_map(best_frame, 1);
>   	else
>   		irq = irq_of_parse_and_map(best_frame, 0);
> -	of_node_put(best_frame);
> +
>   	if (!irq) {
>   		pr_err("arch_timer: Frame missing %s irq",
>   		       arch_timer_mem_use_virtual ? "virt" : "phys");
> -		return;
> +		goto out;
>   	}
>
>   	arch_timer_detect_rate(base, np);
>   	arch_timer_mem_register(base, irq);
>   	arch_timer_common_init();
> +out:
> +	iounmap(cntctlbase);
> +	of_node_put(best_frame);
>   }
>   CLOCKSOURCE_OF_DECLARE(armv7_arch_timer_mem, "arm,armv7-timer-mem",
>   		       arch_timer_mem_init);
>


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
