From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 11 Jan 2013 23:57:48 +0530
Subject: [PATCH 15/16] ARM: vexpress/dcscb: handle platform coherency
 exit/setup and CCI
In-Reply-To: <1357777251-13541-16-git-send-email-nicolas.pitre@linaro.org>
References: <1357777251-13541-1-git-send-email-nicolas.pitre@linaro.org>
 <1357777251-13541-16-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <50F059A4.4010107@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 10 January 2013 05:50 AM, Nicolas Pitre wrote:
> From: Dave Martin <dave.martin@linaro.org>
>
> Add the required code to properly handle race free platform coherency exit
> to the DCSCB power down method.
>
> The power_up_setup callback is used to enable the CCI interface for
> the cluster being brought up.  This must be done in assembly before
> the kernel environment is entered.
>
> Thanks to Achin Gupta and Nicolas Pitre for their help and
> contributions.
>
> Signed-off-by: Dave Martin <dave.martin@linaro.org>
> Signed-off-by: Nicolas Pitre <nico@linaro.org>
> ---
[..]

> diff --git a/arch/arm/mach-vexpress/dcscb.c b/arch/arm/mach-vexpress/dcscb.c
> index 59b690376f..95a2d0df20 100644
> --- a/arch/arm/mach-vexpress/dcscb.c
> +++ b/arch/arm/mach-vexpress/dcscb.c
> @@ -15,6 +15,7 @@
>   #include <linux/spinlock.h>
>   #include <linux/errno.h>
>   #include <linux/vexpress.h>
> +#include <linux/arm-cci.h>
>
>   #include <asm/bL_entry.h>
>   #include <asm/proc-fns.h>
> @@ -104,6 +105,8 @@ static void dcscb_power_down(void)
>   	pr_debug("%s: cpu %u cluster %u\n", __func__, cpu, cluster);
>   	BUG_ON(cpu >= 4 || cluster >= 2);
>
> +	__bL_cpu_going_down(cpu, cluster);
> +
>   	arch_spin_lock(&dcscb_lock);
>   	dcscb_use_count[cpu][cluster]--;
>   	if (dcscb_use_count[cpu][cluster] == 0) {
> @@ -111,6 +114,7 @@ static void dcscb_power_down(void)
>   		rst_hold |= cpumask;
>   		if (((rst_hold | (rst_hold >> 4)) & cluster_mask) == cluster_mask) {
>   			rst_hold |= (1 << 8);
> +			BUG_ON(__bL_cluster_state(cluster) != CLUSTER_UP);
>   			last_man = true;
>   		}
>   		writel(rst_hold, dcscb_base + RST_HOLD0 + cluster * 4);
> @@ -124,35 +128,71 @@ static void dcscb_power_down(void)
>   		skip_wfi = true;
>   	} else
>   		BUG();
> -	arch_spin_unlock(&dcscb_lock);
>
> -	/*
> -	 * Now let's clean our L1 cache and shut ourself down.
> -	 * If we're the last CPU in this cluster then clean L2 too.
> -	 */
> -
> -	/*
> -	 * A15/A7 can hit in the cache with SCTLR.C=0, so we don't need
> -	 * a preliminary flush here for those CPUs.  At least, that's
> -	 * the theory -- without the extra flush, Linux explodes on
> -	 * RTSM (maybe not needed anymore, to be investigated)..
> -	 */
> -	flush_cache_louis();
> -	cpu_proc_fin();
> +	if (last_man && __bL_outbound_enter_critical(cpu, cluster)) {
> +		arch_spin_unlock(&dcscb_lock);
>
> -	if (!last_man) {
> -		flush_cache_louis();
> -	} else {
> +		/*
> +		 * Flush all cache levels for this cluster.
> +		 *
> +		 * A15/A7 can hit in the cache with SCTLR.C=0, so we don't need
> +		 * a preliminary flush here for those CPUs.  At least, that's
> +		 * the theory -- without the extra flush, Linux explodes on
> +		 * RTSM (maybe not needed anymore, to be investigated).
> +		 */
>   		flush_cache_all();
> +		cpu_proc_fin(); /* disable allocation into internal caches*/
I see now. In previous patch I missed the cpu_proc_fin() which clears
C bit
> +		flush_cache_all();
> +
> +		/*
> +		 * This is a harmless no-op.  On platforms with a real
> +		 * outer cache this might either be needed or not,
> +		 * depending on where the outer cache sits.
> +		 */
>   		outer_flush_all();
> +
> +		/* Disable local coherency by clearing the ACTLR "SMP" bit: */
> +		asm volatile (
> +			"mrc	p15, 0, ip, c1, c0, 1 \n\t"
> +			"bic	ip, ip, #(1 << 6) @ clear SMP bit \n\t"
> +			"mcr	p15, 0, ip, c1, c0, 1 \n\t"
> +			"isb \n\t"
> +			"dsb"
> +			: : : "ip" );
> +
> +		/*
> +		 * Disable cluster-level coherency by masking
> +		 * incoming snoops and DVM messages:
> +		 */
> +		disable_cci(cluster);
> +
> +		__bL_outbound_leave_critical(cluster, CLUSTER_DOWN);
> +	} else {
> +		arch_spin_unlock(&dcscb_lock);
> +
> +		/*
> +		 * Flush the local CPU cache.
> +		 *
> +		 * A15/A7 can hit in the cache with SCTLR.C=0, so we don't need
> +		 * a preliminary flush here for those CPUs.  At least, that's
> +		 * the theory -- without the extra flush, Linux explodes on
> +		 * RTSM (maybe not needed anymore, to be investigated).
> +		 */
This is expected if the entire code is not in one stack frame and the
additional flush is needed to avoid possible stack corruption. This
issue has been discussed in past on the list.

> +		flush_cache_louis();
> +		cpu_proc_fin(); /* disable allocation into internal caches*/
> +		flush_cache_louis();
> +
> +		/* Disable local coherency by clearing the ACTLR "SMP" bit: */
> +		asm volatile (
> +			"mrc	p15, 0, ip, c1, c0, 1 \n\t"
> +			"bic	ip, ip, #(1 << 6) @ clear SMP bit \n\t"
> +			"mcr	p15, 0, ip, c1, c0, 1 \n\t"
> +			"isb \n\t"
> +			"dsb"
> +			: : : "ip" );
>   	}
>
> -	/* Disable local coherency by clearing the ACTLR "SMP" bit: */
> -	asm volatile (
> -		"mrc	p15, 0, ip, c1, c0, 1 \n\t"
> -		"bic	ip, ip, #(1 << 6) @ clear SMP bit \n\t"
> -		"mcr	p15, 0, ip, c1, c0, 1"
> -		: : : "ip" );
> +	__bL_cpu_down(cpu, cluster);
>
>   	/* Now we are prepared for power-down, do it: */
>   	if (!skip_wfi)

Regards,
Santosh
