From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 05 Mar 2014 12:33:07 -0800
Subject: [PATCH] ARM: kernel: respect device tree status of cpu nodes
In-Reply-To: <1393240960-31846-1-git-send-email-j@bitron.ch>
References: <1393240960-31846-1-git-send-email-j@bitron.ch>
Message-ID: <53178A03.3090004@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+Lorenzo

On 02/24/14 03:22, J?rg Billeter wrote:
> Skip 'disabled' cpu nodes when building the cpu logical map. This avoids
> booting cpus that have been disabled in the device tree.
>
> Signed-off-by: J?rg Billeter <j@bitron.ch>
> Reviewed-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>  arch/arm/kernel/devtree.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
> index 739c3df..9aed299 100644
> --- a/arch/arm/kernel/devtree.c
> +++ b/arch/arm/kernel/devtree.c
> @@ -95,6 +95,10 @@ void __init arm_dt_init_cpu_maps(void)
>  		if (of_node_cmp(cpu->type, "cpu"))
>  			continue;
>  
> +		/* Check if CPU is enabled */
> +		if (!of_device_is_available(cpu))
> +			continue;
> +
>  		pr_debug(" * %s...\n", cpu->full_name);
>  		/*
>  		 * A device tree containing CPU nodes with missing "reg"

This doesn't follow the ePAPR spec. According to ePAPR status="disabled"
in a cpu node means "the cpu is in a quiescent state" and one can enable
it by using the "enable-method". At the least, we should document this
in bindings/arm/cpus.txt if we can all agree that we want this
definition of disabled.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
