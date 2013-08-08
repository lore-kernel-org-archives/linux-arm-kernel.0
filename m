From: Sudeep.KarkadaNagesha@arm.com (Sudeep KarkadaNagesha)
Date: Thu, 08 Aug 2013 15:54:55 +0100
Subject: [PATCH 3/5] ARM: mach-mvebu: remove redundant DT parsing and
 validation
In-Reply-To: <1374579164-30255-4-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1374579164-30255-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1374579164-30255-4-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Message-ID: <5203B13F.4060009@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/07/13 12:32, Sudeep KarkadaNagesha wrote:
> From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
> 
> arm_dt_init_cpu_maps parses the device tree, validates and sets the
> cpu_possible_mask appropriately. It is unnecessary to do another DT
> parse to get the number of cpus, use num_possible_cpus instead.
> 
Hi Gregory,

Does this change look fine ?
If OK, not sure if you prefer to pick up this or want me to send to
arm-soc guys.

Regards,
Sudeep

> Cc: Gregory Clement <gregory.clement@free-electrons.com>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
> ---
>  arch/arm/mach-mvebu/platsmp.c | 19 +------------------
>  1 file changed, 1 insertion(+), 18 deletions(-)
> 
> diff --git a/arch/arm/mach-mvebu/platsmp.c b/arch/arm/mach-mvebu/platsmp.c
> index ce81d30..2e4508a 100644
> --- a/arch/arm/mach-mvebu/platsmp.c
> +++ b/arch/arm/mach-mvebu/platsmp.c
> @@ -87,28 +87,11 @@ static int armada_xp_boot_secondary(unsigned int cpu, struct task_struct *idle)
>  
>  static void __init armada_xp_smp_init_cpus(void)
>  {
> -	struct device_node *np;
> -	unsigned int i, ncores;
> +	unsigned int ncores = num_possible_cpus();
>  
> -	np = of_find_node_by_name(NULL, "cpus");
> -	if (!np)
> -		panic("No 'cpus' node found\n");
> -
> -	ncores = of_get_child_count(np);
>  	if (ncores == 0 || ncores > ARMADA_XP_MAX_CPUS)
>  		panic("Invalid number of CPUs in DT\n");
>  
> -	/* Limit possible CPUs to defconfig */
> -	if (ncores > nr_cpu_ids) {
> -		pr_warn("SMP: %d CPUs physically present. Only %d configured.",
> -			ncores, nr_cpu_ids);
> -		pr_warn("Clipping CPU count to %d\n", nr_cpu_ids);
> -		ncores = nr_cpu_ids;
> -	}
> -
> -	for (i = 0; i < ncores; i++)
> -		set_cpu_possible(i, true);
> -
>  	set_smp_cross_call(armada_mpic_send_doorbell);
>  }
>  
> 
