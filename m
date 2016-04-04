From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 4 Apr 2016 14:55:57 +0100
Subject: [PATCH] arm64: KVM: unregister notifiers in hyp mode teardown path
In-Reply-To: <1459777611-22592-1-git-send-email-sudeep.holla@arm.com>
References: <1459777611-22592-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <5702726D.7000505@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sudeep,

On 04/04/16 14:46, Sudeep Holla wrote:
> Commit 1e947bad0b63 ("arm64: KVM: Skip HYP setup when already running
> in HYP") re-organized the hyp init code and ended up leaving the CPU
> hotplug and PM notifier even if hyp mode initialization fails.
> 
> Since KVM is not yet supported with ACPI, the above mentioned commit
> breaks CPU hotplug in ACPI boot.
> 
> This patch fixes teardown_hyp_mode to properly unregister both CPU
> hotplug and PM notifiers in the teardown path.
> 
> Fixes: 1e947bad0b63 ("arm64: KVM: Skip HYP setup when already running in HYP")
> Cc: Christoffer Dall <christoffer.dall@linaro.org>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

This looks OK to me, with a question below though:

> ---
>  arch/arm/kvm/arm.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
> index 6accd66d26f0..42b3a1f83271 100644
> --- a/arch/arm/kvm/arm.c
> +++ b/arch/arm/kvm/arm.c
> @@ -1101,10 +1101,17 @@ static void __init hyp_cpu_pm_init(void)
>  {
>  	cpu_pm_register_notifier(&hyp_init_cpu_pm_nb);
>  }
> +static void __init hyp_cpu_pm_exit(void)
> +{
> +	cpu_pm_unregister_notifier(&hyp_init_cpu_pm_nb);
> +}
>  #else
>  static inline void hyp_cpu_pm_init(void)
>  {
>  }
> +static inline void hyp_cpu_pm_exit(void)
> +{
> +}
>  #endif
>  
>  static void teardown_common_resources(void)
> @@ -1166,6 +1173,8 @@ static void teardown_hyp_mode(void)
>  	free_hyp_pgds();
>  	for_each_possible_cpu(cpu)
>  		free_page(per_cpu(kvm_arm_hyp_stack_page, cpu));
> +	unregister_cpu_notifier(&hyp_init_cpu_nb);
> +	hyp_cpu_pm_exit();
>  }
>  
>  static int init_vhe_mode(void)
> @@ -1270,12 +1279,7 @@ static int init_hyp_mode(void)
>  	free_boot_hyp_pgd();
>  #endif
>  
> -	cpu_notifier_register_begin();
> -
> -	err = __register_cpu_notifier(&hyp_init_cpu_nb);
> -
> -	cpu_notifier_register_done();
> -
> +	err = register_cpu_notifier(&hyp_init_cpu_nb);

We went from something like this to the cpu_notifier_register_begin/end
with 8146875de ("arm, kvm: Fix CPU hotplug callback registration").

What makes it more acceptable now?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
