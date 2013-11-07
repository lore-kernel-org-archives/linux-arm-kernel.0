From: joshc@codeaurora.org (Josh Cartwright)
Date: Wed, 6 Nov 2013 19:50:05 -0600
Subject: [PATCH 05/11] ARM: Introduce CPU_METHOD_OF_DECLARE() for cpu
 hotplug/smp
In-Reply-To: <1383343739-23080-6-git-send-email-sboyd@codeaurora.org>
References: <1383343739-23080-1-git-send-email-sboyd@codeaurora.org>
 <1383343739-23080-6-git-send-email-sboyd@codeaurora.org>
Message-ID: <20131107015005.GE22684@joshc.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Stephen-

Nit/suggestion below:

On Fri, Nov 01, 2013 at 03:08:53PM -0700, Stephen Boyd wrote:
[..]
> diff --git a/arch/arm/include/asm/smp.h b/arch/arm/include/asm/smp.h
> index a8cae71c..c27ec55 100644
> --- a/arch/arm/include/asm/smp.h
> +++ b/arch/arm/include/asm/smp.h
> @@ -112,6 +112,15 @@ struct smp_operations {
>  #endif
>  };
>  
> +struct of_cpu_method {
> +	const char *method;
> +	struct smp_operations *ops;
> +};
> +
> +#define CPU_METHOD_OF_DECLARE(name, _method, _ops)			\
> +	static const struct of_cpu_method __cpu_method_of_table_##name	\
> +		__used __section(__cpu_method_of_table)			\
> +		= { .method = _method, .ops = _ops }
>  /*
>   * set platform specific SMP operations
>   */
> diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
> index f35906b..71a8592 100644
> --- a/arch/arm/kernel/devtree.c
> +++ b/arch/arm/kernel/devtree.c
> @@ -25,6 +25,7 @@
>  #include <asm/smp_plat.h>
>  #include <asm/mach/arch.h>
>  #include <asm/mach-types.h>
> +#include <asm/smp.h>
>  
>  void __init early_init_dt_add_memory_arch(u64 base, u64 size)
>  {
> @@ -63,6 +64,36 @@ void __init arm_dt_memblock_reserve(void)
>  	}
>  }
>  
> +#ifdef CONFIG_SMP
> +extern struct of_cpu_method __cpu_method_of_table[];
> +
> +static const struct of_cpu_method __cpu_method_of_table_sentinel
> +	__used __section(__cpu_method_of_table_end);

Having a sentinel allocated into the linked image makes a lot of sense
in other cases (IRQCHIP/CLOCKSOURCE_OF_DECLARE, etc), where it's used to
terminate an of_device_id table (as is expected by of_match_table and
friends).

In this case, however, you aren't building a match table, so having a
sentinel allocated isn't necessary.  I'd suggest bookending the table
with a VMLINUX_SYMBOL(__cpu_method_of_table_end) instead.

A whole 2 pointers worth of savings!

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
