From: will.deacon@arm.com (Will Deacon)
Date: Tue, 30 Jun 2015 09:52:26 +0100
Subject: [PATCH] arm: perf: Set affinity for PPI based PMUs
In-Reply-To: <1435615126-16492-1-git-send-email-sboyd@codeaurora.org>
References: <1435615126-16492-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <20150630085225.GA25828@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Mon, Jun 29, 2015 at 10:58:46PM +0100, Stephen Boyd wrote:
> For PPI based PMUs, we bail out early in of_pmu_irq_cfg() without
> setting the PMU's supported_cpus bitmap. This causes the
> smp_call_function_any() in armv7_probe_num_events() to fail. Set
> the bitmap to be all CPUs so that we properly probe PMUs that use
> PPIs.
> 
> Fixes: cc88116da0d1 ("arm: perf: treat PMUs as CPU affine")
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  arch/arm/kernel/perf_event.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
> index 54272e0be713..7d5379c1c443 100644
> --- a/arch/arm/kernel/perf_event.c
> +++ b/arch/arm/kernel/perf_event.c
> @@ -795,8 +795,10 @@ static int of_pmu_irq_cfg(struct arm_pmu *pmu)
>  
>  	/* Don't bother with PPIs; they're already affine */
>  	irq = platform_get_irq(pdev, 0);
> -	if (irq >= 0 && irq_is_percpu(irq))
> +	if (irq >= 0 && irq_is_percpu(irq)) {
> +		cpumask_setall(&pmu->supported_cpus);
>  		return 0;
> +	}

Looks good to me as a fix, but I'm currently working on extending the
interrupt-affinity property to work with both SPIs and PPIs so that we
can use it to identify PMU affinity on multi-cluster systems.

  https://git.kernel.org/cgit/linux/kernel/git/will/linux.git/commit/?h=perf/updates&id=633fa0b629d86e58d68aff295f92031877dd0294

Any chance you could take that for a spin on your platform, please?

Will
