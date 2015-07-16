From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 16 Jul 2015 15:44:45 +0200
Subject: [PATCH] ARM: kvm: prevent freeing boot_hyp_pgd when CPU_PM is
 selected
In-Reply-To: <1436433835-26030-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1436433835-26030-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <20150716134445.GG7845@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 09, 2015 at 10:23:55AM +0100, Lorenzo Pieralisi wrote:
> The boot_hyp_pgd is required to install HYP context through
> cpu_init_hyp_mode, on cold-boot for primary and secondary cpus, but
> also on the warm-boot path for secondaries (ie when a CPU is hotplugged
> in). On platforms with power management capabilities (eg suspend to RAM
> or idle-states that allow the core to enter deep idle where core is
> shutdown on power down entry), the boot_hyp_pgd is required to restore
> HYP context too upon CPU_PM notification, so the boot_hyp_pgd must not be
> freed to guarantee a proper HYP context restore, which in turn ensures
> proper core resume from low-power.
> 
> This patch adds an additional guard to free_boot_hyp_pgd() to remove
> its call from the kernel if CPU_PM is enabled, so that on platforms
> where HOTPLUG_CPU is disabled (eg UP), CPU_PM operations (suspend and
> CPUidle) are still guaranteed to function.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Christoffer Dall <christoffer.dall@linaro.org>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  arch/arm/kvm/arm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
> index bc738d2..5e050c2 100644
> --- a/arch/arm/kvm/arm.c
> +++ b/arch/arm/kvm/arm.c
> @@ -1068,7 +1068,7 @@ static int init_hyp_mode(void)
>  	if (err)
>  		goto out_free_mappings;
>  
> -#ifndef CONFIG_HOTPLUG_CPU
> +#if !defined(CONFIG_HOTPLUG_CPU) && !defined(CONFIG_CPU_PM)
>  	free_boot_hyp_pgd();
>  #endif
>  
> -- 
> 2.2.1
> 

Without knowing a lot about power management in Linux and exactly what
these defines mean, I'm fine with this:

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
