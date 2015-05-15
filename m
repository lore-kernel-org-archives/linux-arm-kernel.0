From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 15 May 2015 18:07:07 +0100
Subject: [PATCH 10/10] arm: perf: Fix memory leak when probing PMU PPIs
In-Reply-To: <1431704514-4204-1-git-send-email-shailendra.capricorn@gmail.com>
References: <1431704514-4204-1-git-send-email-shailendra.capricorn@gmail.com>
Message-ID: <20150515170707.GE23652@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 15, 2015 at 04:41:54PM +0100, Shailendra Verma wrote:
> Commit 338d9dd3e2ae ("ARM: 8351/1: perf: don't warn about missing
> interrupt-affinity property for PPIs") added a check for PPIs so that
> we avoid parsing the interrupt-affinity property for these naturally
> affine interrupts.
> 
> Unfortunately, this check can trigger an early (successful) return and
> we will leak the irqs array. This patch fixes the issue by reordering
> the code so that the check is performed before any independent
> allocation.
> 
> Signed-off-by: Shailendra Verma <shailendra.capricorn@gmail.com>
> ---
>  arch/arm/kernel/perf_event_cpu.c |   10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/kernel/perf_event_cpu.c b/arch/arm/kernel/perf_event_cpu.c
> index 213919b..a7099ee 100644
> --- a/arch/arm/kernel/perf_event_cpu.c
> +++ b/arch/arm/kernel/perf_event_cpu.c
> @@ -303,17 +303,17 @@ static int probe_current_pmu(struct arm_pmu *pmu)
>  
>  static int of_pmu_irq_cfg(struct platform_device *pdev)
>  {
> -	int i, irq;
> -	int *irqs = kcalloc(pdev->num_resources, sizeof(*irqs), GFP_KERNEL);
> -
> -	if (!irqs)
> -		return -ENOMEM;
> +	int i, irq, *irqs;
>  
>  	/* Don't bother with PPIs; they're already affine */
>  	irq = platform_get_irq(pdev, 0);
>  	if (irq >= 0 && irq_is_percpu(irq))
>  		return 0;
>  
> +	irqs = kcalloc(pdev->num_resources, sizeof(*irqs), GFP_KERNEL);
> +	if (!irqs)
> +		return -ENOMEM;
> +

Will Deacon posted a patch for this a few days ago [1], and it's
allready in Russell's patch system as 8357/1.

Thanks,
Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-May/342367.html
[2] http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=8357/1
