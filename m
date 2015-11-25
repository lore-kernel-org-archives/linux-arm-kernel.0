From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 25 Nov 2015 11:35:38 +0000
Subject: [PATCH] ARM: avoid SMP DT initialisation on UP-only capable
 systems
In-Reply-To: <E1a1XXS-00060O-GS@rmk-PC.arm.linux.org.uk>
References: <E1a1XXS-00060O-GS@rmk-PC.arm.linux.org.uk>
Message-ID: <20151125113538.GB12434@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 25, 2015 at 10:43:02AM +0000, Russell King wrote:
> arm_dt_init_cpu_maps() initialises the CPU possible map even when the
> boot CPU indicates that it is not SMP capable.  This can happen with
> SoCs where the SoC may have a single UP-only CPU, or may have a pair of
> SMP CPUs - and this is the only difference.
> 
> One solution is to increase the number of DT files by forcing peopl to
> properly describe the hardware: this means all the iMX6DL DT files need
> to be duplicated for iMX6S and a whole raft of updates to boot loaders
> and the like.
>
> Another solution is to decide that it is inappropriate to initialise the
> cpu_possible map with anything but the boot CPU on non-SMP capable
> systems.  This is implemented by this patch.
> 
> The situation currently may provoke a warning on earlier kernels,
> printed during SMP bringup where we attempt to bring CPU1 online inspite
> of CPU0 being a UP-only CPU, and this only failing due to the lack of
> SMP operations.

I think that even if we work around this, we should have a warning
regarding the erroneous DT.

There are plenty of other things people may get wrong in their DT that
we may or may not be able to detect and/or workaround. We should
generally discourage relying on fixups and encourage people to do the
right thing.

> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/kernel/devtree.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
> index 65addcbf5b30..bd72ce91d7a2 100644
> --- a/arch/arm/kernel/devtree.c
> +++ b/arch/arm/kernel/devtree.c
> @@ -170,15 +170,18 @@ void __init arm_dt_init_cpu_maps(void)
>  		return;
>  	}
>  
> -	/*
> -	 * Since the boot CPU node contains proper data, and all nodes have
> -	 * a reg property, the DT CPU list can be considered valid and the
> -	 * logical map created in smp_setup_processor_id() can be overridden
> -	 */
> -	for (i = 0; i < cpuidx; i++) {
> -		set_cpu_possible(i, true);
> -		cpu_logical_map(i) = tmp_map[i];
> -		pr_debug("cpu logical map 0x%x\n", cpu_logical_map(i));
> +	if (is_smp()) {

Can we not change this to something like:

if (!is_smp() && cpuidx >1) {
	pr_warn("Boot CPU is UP, but DT contains multiple CPUs. Skipping!\n");
} else {

Other than that, this looks good to me.

If you're happy with the above:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.

> +		/*
> +		 * Since the boot CPU node contains proper data, and all
> +		 * nodes have a reg property, the DT CPU list can be
> +		 * considered valid and the logical map created in
> +		 * smp_setup_processor_id() can be overridden
> +		 */
> +		for (i = 0; i < cpuidx; i++) {
> +			set_cpu_possible(i, true);
> +			cpu_logical_map(i) = tmp_map[i];
> +			pr_debug("cpu logical map 0x%x\n", cpu_logical_map(i));
> +		}
>  	}
>  }
>  
> -- 
> 2.1.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
