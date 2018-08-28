From: will.deacon@arm.com (Will Deacon)
Date: Tue, 28 Aug 2018 18:02:58 +0100
Subject: [PATCH] perf: Convert to using %pOFn instead of device_node.name
In-Reply-To: <20180828015252.28511-38-robh@kernel.org>
References: <20180828015252.28511-1-robh@kernel.org>
 <20180828015252.28511-38-robh@kernel.org>
Message-ID: <20180828170258.GD19825@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 27, 2018 at 08:52:39PM -0500, Rob Herring wrote:
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
> 
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/perf/arm_pmu_platform.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Cheers, I can queue this up for 4.20. Let me know if you'd rather take it
along with the name pointer removal instead.

Will

> diff --git a/drivers/perf/arm_pmu_platform.c b/drivers/perf/arm_pmu_platform.c
> index 96075cecb0ae..933bd8410fc2 100644
> --- a/drivers/perf/arm_pmu_platform.c
> +++ b/drivers/perf/arm_pmu_platform.c
> @@ -77,14 +77,14 @@ static int pmu_parse_irq_affinity(struct device_node *node, int i)
>  
>  	dn = of_parse_phandle(node, "interrupt-affinity", i);
>  	if (!dn) {
> -		pr_warn("failed to parse interrupt-affinity[%d] for %s\n",
> -			i, node->name);
> +		pr_warn("failed to parse interrupt-affinity[%d] for %pOFn\n",
> +			i, node);
>  		return -EINVAL;
>  	}
>  
>  	cpu = of_cpu_node_to_id(dn);
>  	if (cpu < 0) {
> -		pr_warn("failed to find logical CPU for %s\n", dn->name);
> +		pr_warn("failed to find logical CPU for %pOFn\n", dn);
>  		cpu = nr_cpu_ids;
>  	}
>  
> -- 
> 2.17.1
> 
