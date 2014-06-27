From: trblinux@gmail.com (Tushar Behera)
Date: Fri, 27 Jun 2014 08:36:42 +0530
Subject: mainline boot: 64 boots: 62 pass, 2 fail (v3.16-rc1-2-gebe0618)
In-Reply-To: <53AC77A2.4090207@codeaurora.org>
References: <53A2AE11.2050208@gmail.com> <53A2BE94.2010308@gmail.com>
 <53A7A579.4010702@gmail.com>
 <CAGa+x85H510fNGTXJHGYfQybRa2FGgg2NyCgJ8rmjJ6TE7GNbA@mail.gmail.com>
 <53A9B99F.4040806@codeaurora.org> <53A9FBB5.60709@codeaurora.org>
 <53AABCF5.4050403@gmail.com> <53AB45D1.90909@codeaurora.org>
 <53ABC13C.8030908@gmail.com>
 <CAGa+x84UTbmFc2Twg9zEcr+ZP2xsq68gFvk=385+_cFM5hvGHg@mail.gmail.com>
 <20140626151756.GU32514@n2100.arm.linux.org.uk>
 <53AC77A2.4090207@codeaurora.org>
Message-ID: <53ACDFC2.5020206@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/27/2014 01:12 AM, Laura Abbott wrote:

>  
> +static unsigned int bank_cnt;
> +static unsigned int max_cnt;
> +
>  int __init arm_add_memory(u64 start, u64 size)
>  {
>  	u64 aligned_start;
>  
>  	/*
> +	 * Some buggy bootloaders rely on the old meminfo behavior of not adding
> +	 * more than n banks since anything past that may contain invalid data.
> +	 */
> +	if (bank_cnt >= max_cnt) {
> +		pr_crit("Max banks too low, ignoring memory at 0x%08llx\n",
> +			(long long)start);
> +		return -EINVAL;
> +	}
> +
> +	bank_cnt++;
> +
> +	/*
>  	 * Ensure that start/size are aligned to a page boundary.
>  	 * Size is appropriately rounded down, start is rounded up.
>  	 */
> @@ -879,6 +894,7 @@ void __init setup_arch(char **cmdline_p)
>  		mdesc = setup_machine_tags(__atags_pointer, __machine_arch_type);
>  	machine_desc = mdesc;
>  	machine_name = mdesc->name;
> +	max_cnt = mdesc->bank_limit;

arm_add_memory is getting called before this is being set, resulting in
none of the memory banks getting added[1].

setup_machine_fdt -> early_init_dt_scan -> early_init_dt_scan_memory

Would it make sense to re-introduce the config option ARM_NR_BANKS and
replace max_cnt with NR_BANKS?

[1] http://pastebin.com/MawYD7kb

>  
>  	if (mdesc->reboot_mode != REBOOT_HARD)
>  		reboot_mode = mdesc->reboot_mode;
> diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
> index f38cf7c..91283fd 100644
> --- a/arch/arm/mach-exynos/exynos.c
> +++ b/arch/arm/mach-exynos/exynos.c
> @@ -350,4 +350,5 @@ DT_MACHINE_START(EXYNOS_DT, "SAMSUNG EXYNOS (Flattened Device Tree)")
>  	.dt_compat	= exynos_dt_compat,
>  	.restart	= exynos_restart,
>  	.reserve	= exynos_reserve,
> +	.bank_limit     = 8,
>  MACHINE_END
> 


-- 
Tushar Behera
