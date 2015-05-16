From: mingo@kernel.org (Ingo Molnar)
Date: Sat, 16 May 2015 09:09:55 +0200
Subject: [PATCH] ARM: 8351/1: perf: fix memory leak on return
In-Reply-To: <1431693789-9679-1-git-send-email-colin.king@canonical.com>
References: <1431693789-9679-1-git-send-email-colin.king@canonical.com>
Message-ID: <20150516070955.GA2429@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Colin King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> Recent commit 3b8786ff7a1b31645ae2c26a2ec32dbd42ac1094
> ("ARM: 8352/1: perf: Fix the pmu node name in warning message")
> introduced a memory leak of irqs on the "Don't bother with PPIs"
> return path. This was picked up by static analysis by cppcheck:
> 
> [arch/arm/kernel/perf_event_cpu.c:315]: (error) Memory leak: irqs
> 
> simpele fix is to free irqs when returning.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  arch/arm/kernel/perf_event_cpu.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/kernel/perf_event_cpu.c b/arch/arm/kernel/perf_event_cpu.c
> index 213919b..9e5b2a5 100644
> --- a/arch/arm/kernel/perf_event_cpu.c
> +++ b/arch/arm/kernel/perf_event_cpu.c
> @@ -311,8 +311,10 @@ static int of_pmu_irq_cfg(struct platform_device *pdev)
>  
>  	/* Don't bother with PPIs; they're already affine */
>  	irq = platform_get_irq(pdev, 0);
> -	if (irq >= 0 && irq_is_percpu(irq))
> +	if (irq >= 0 && irq_is_percpu(irq)) {
> +		kfree(irqs);
>  		return 0;
> +	}
>  
>  	for (i = 0; i < pdev->num_resources; ++i) {
>  		struct device_node *dn;

So returning from the middle of a function isn't very clean.

Also, why do we return 0 in an error case?

Furthermore, this function already has a (partially hidden) error 
cleanup path:

        if (i == pdev->num_resources)
                cpu_pmu->irq_affinity = irqs;
        else
                kfree(irqs);

So this code should use proper goto driven cleanup. That's faster and 
cleaner, and is less likely to result in bugs like the above.

Thanks,

	Ingo
