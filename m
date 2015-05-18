From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 18 May 2015 12:15:38 +0100
Subject: [PATCH][V2] ARM: 8351/1: perf: fix memory leak on return
In-Reply-To: <1431946836-11243-1-git-send-email-colin.king@canonical.com>
References: <1431946836-11243-1-git-send-email-colin.king@canonical.com>
Message-ID: <20150518111538.GU2067@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 18, 2015 at 12:00:36PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Recent commit 3b8786ff7a1b31645ae2c26a2ec32dbd42ac1094
> ("ARM: 8352/1: perf: Fix the pmu node name in warning message")
> introduced a memory leak of irqs on the "Don't bother with PPIs"
> return path. This was picked up by static analysis by cppcheck:
> 
> [arch/arm/kernel/perf_event_cpu.c:315]: (error) Memory leak: irqs
> 
> Perform allocation of irqs after getting the irq hence removing need to
> clean up an allocation on the PPI affine return path.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Your subject line refers to patch 8351/1 in a form which is the standard
format for patches applied by my patch system.  However, what you're
including is not that patch.  You go on to talk about 8352/1 in your
commit message, but I don't see the relevance of 8352/1 to the patch
you've included.

I think you mean to refer to the 8351/1 commit ID and its summary line
in your commit body.  Please fix this as at the moment it's misleading.
Also, please drop the reference to 8351/1 in your subject line, and
update the summary line to be a little more relevant and specific.

Lastly, please include a Fixes: tag so that tools can parse the
referred commit.  The Fixes: tag has the format:

Fixes: 12-character-git-id ("commit-summary-line")

So that would be:

Fixes: 338d9dd3e2ae ("ARM: 8351/1: perf: don't warn about missing interrupt-affinity property for PPIs")

with no text wrapping.  Thanks.

For reference, 8351/1 was:

commit 338d9dd3e2aee00a9198e8bf6e7d535d3feeaf32
Author: Will Deacon <will.deacon@arm.com>
Date:   Fri May 1 17:15:23 2015 +0100

    ARM: 8351/1: perf: don't warn about missing interrupt-affinity property for PPIs

    PPIs are affine by nature, so the interrupt-affinity property is not
    used and therefore we shouldn't print a warning in its absence.

    Reported-by: Maxime Ripard <maxime.ripard@free-electrons.com>
    Reviewed-by: Maxime Ripard <maxime.ripard@free-electrons.com>
    Signed-off-by: Will Deacon <will.deacon@arm.com>
    Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

and 8352/1 was:

commit 3b8786ff7a1b31645ae2c26a2ec32dbd42ac1094
Author: Will Deacon <will.deacon@arm.com>
Date:   Fri May 1 17:16:01 2015 +0100

    ARM: 8352/1: perf: Fix the pmu node name in warning message

    With commit 9fd85eb502a7 ("ARM: pmu: add support for interrupt-affinity
    property"), we print a warning when we find a PMU SPI with a missing
    missing interrupt-affinity property in a pmu node. Unfortunately, we
    pass the wrong (NULL) device node to of_node_full_name, resulting in
    unhelpful messages such as:

     hw perfevents: Failed to parse <no-node>/interrupt-affinity[0]

    This patch fixes the name to that of the pmu node.

    Fixes: 9fd85eb502a7 (ARM: pmu: add support for interrupt-affinity property)

    Acked-by: Mark Rutland <mark.rutland@arm.com>
    Signed-off-by: Will Deacon <will.deacon@arm.com>
    Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

> ---
>  arch/arm/kernel/perf_event_cpu.c | 10 +++++-----
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
>  	for (i = 0; i < pdev->num_resources; ++i) {
>  		struct device_node *dn;
>  		int cpu;
> -- 
> 2.1.4
> 

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
