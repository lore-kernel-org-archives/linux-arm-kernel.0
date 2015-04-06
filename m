From: horms@verge.net.au (Simon Horman)
Date: Mon, 6 Apr 2015 09:44:06 +0900
Subject: [PATCH v2] ARM: kexec: Relax SMP validation to improve DT
 compatibility
In-Reply-To: <1427891447-30695-1-git-send-email-geert+renesas@glider.be>
References: <1427891447-30695-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20150406004405.GE1841@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 01, 2015 at 02:30:47PM +0200, Geert Uytterhoeven wrote:
> When trying to kexec into a new kernel on a platform where multiple CPU
> cores are present, but no SMP bringup code is available yet, the
> kexec_load system call fails with:
> 
>     kexec_load failed: Invalid argument
> 
> The SMP test added to machine_kexec_prepare() in commit 2103f6cba61a8b8b
> ("ARM: 7807/1: kexec: validate CPU hotplug support") wants to prohibit
> kexec on SMP platforms where it cannot disable secondary CPUs.
> However, this test is too strict: if the secondary CPUs couldn't be
> enabled in the first place, there's no need to disable them later at
> kexec time.  Hence skip the test in the absence of SMP bringup code.
> 
> This allows to add all CPU cores to the DTS from the beginning, without
> having to implement SMP bringup first, improving DT compatibility.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Stephen Warren <swarren@nvidia.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

> ---
> v2:
>   - Add Acked-by.
> ---
>  arch/arm/include/asm/smp_plat.h | 1 +
>  arch/arm/kernel/machine_kexec.c | 3 ++-
>  arch/arm/kernel/smp.c           | 5 +++++
>  3 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/include/asm/smp_plat.h b/arch/arm/include/asm/smp_plat.h
> index 0ad7d490ee6f2657..993e5224d8f7eeeb 100644
> --- a/arch/arm/include/asm/smp_plat.h
> +++ b/arch/arm/include/asm/smp_plat.h
> @@ -104,6 +104,7 @@ static inline u32 mpidr_hash_size(void)
>  	return 1 << mpidr_hash.bits;
>  }
>  
> +extern int platform_can_secondary_boot(void);
>  extern int platform_can_cpu_hotplug(void);
>  
>  #endif
> diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
> index de2b085ad7535da7..8bf3b7c098881b95 100644
> --- a/arch/arm/kernel/machine_kexec.c
> +++ b/arch/arm/kernel/machine_kexec.c
> @@ -46,7 +46,8 @@ int machine_kexec_prepare(struct kimage *image)
>  	 * and implements CPU hotplug for the current HW. If not, we won't be
>  	 * able to kexec reliably, so fail the prepare operation.
>  	 */
> -	if (num_possible_cpus() > 1 && !platform_can_cpu_hotplug())
> +	if (num_possible_cpus() > 1 && platform_can_secondary_boot() &&
> +	    !platform_can_cpu_hotplug())
>  		return -EINVAL;
>  
>  	/*
> diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
> index 86ef244c5a24b4fa..cca5b87581855244 100644
> --- a/arch/arm/kernel/smp.c
> +++ b/arch/arm/kernel/smp.c
> @@ -145,6 +145,11 @@ void __init smp_init_cpus(void)
>  		smp_ops.smp_init_cpus();
>  }
>  
> +int platform_can_secondary_boot(void)
> +{
> +	return !!smp_ops.smp_boot_secondary;
> +}
> +
>  int platform_can_cpu_hotplug(void)
>  {
>  #ifdef CONFIG_HOTPLUG_CPU
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
