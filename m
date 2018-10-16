From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Tue, 16 Oct 2018 10:27:01 +0900
Subject: [PATCH v2 2/6] clocksource: exynos_mct: Fix error path in timer
 resources initialization
In-Reply-To: <20181015123112.9379-3-m.szyprowski@samsung.com>
References: <20181015123112.9379-1-m.szyprowski@samsung.com>
 <CGME20181015123135eucas1p18df135504c9476cead8da6463226cdec@eucas1p1.samsung.com>
 <20181015123112.9379-3-m.szyprowski@samsung.com>
Message-ID: <5BC53E65.7050500@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Marek,

On 2018? 10? 15? 21:31, Marek Szyprowski wrote:
> While freeing interrupt handlers in error path, don't assume that all
> requested interrupts are per-processor interrupts and properly release
> standard interrupts too.
> 
> Suggested-by: Krzysztof Kozlowski <krzk@kernel.org>
> Fixes: 56a94f13919c ("clocksource: exynos_mct: Avoid blocking calls in the cpu hotplug notifier")
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/clocksource/exynos_mct.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
> index 43b335ff4a96..a379f11fad2d 100644
> --- a/drivers/clocksource/exynos_mct.c
> +++ b/drivers/clocksource/exynos_mct.c
> @@ -562,7 +562,19 @@ static int __init exynos4_timer_resources(struct device_node *np, void __iomem *
>  	return 0;
>  
>  out_irq:
> -	free_percpu_irq(mct_irqs[MCT_L0_IRQ], &percpu_mct_tick);
> +	if (mct_int_type == MCT_INT_PPI) {
> +		free_percpu_irq(mct_irqs[MCT_L0_IRQ], &percpu_mct_tick);
> +	} else {
> +		for_each_possible_cpu(cpu) {
> +			struct mct_clock_event_device *pcpu_mevt =
> +				per_cpu_ptr(&percpu_mct_tick, cpu);
> +
> +			if (pcpu_mevt->evt.irq != -1) {
> +				free_irq(pcpu_mevt->evt.irq, pcpu_mevt);
> +				pcpu_mevt->evt.irq = -1;
> +			}
> +		}
> +	}
>  	return err;
>  }
>  
> 

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
