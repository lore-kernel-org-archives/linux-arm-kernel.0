From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 30 Mar 2016 17:30:10 +0100
Subject: [PATCH] arm64: KVM: Register CPU notifiers when the kernel runs
 at HYP
In-Reply-To: <1459353370-589-1-git-send-email-james.morse@arm.com>
References: <1459353370-589-1-git-send-email-james.morse@arm.com>
Message-ID: <56FBFF12.60109@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi James,

On 30/03/16 16:56, James Morse wrote:
> When the kernel is running at EL2, it doesn't need init_hyp_mode() to
> configure page tables for HYP. This function also registers the CPU
> hotplug and lower power notifiers that cause HYP to be re-initialised
> after the CPU has been reset.
> 
> To avoid losing the register state that controls stage2 translation, move
> the registering of these notifiers into init_subsystems(), and add an
> is_kernel_in_hyp_mode() path to each callback.
> 
> Fixes: 1e947bad0b6 ("arm64: KVM: Skip HYP setup when already running in HYP")
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  arch/arm/kvm/arm.c | 51 +++++++++++++++++++++++++++++++++------------------
>  1 file changed, 33 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
> index 6accd66d26f0..cf0184edf4f5 100644
> --- a/arch/arm/kvm/arm.c
> +++ b/arch/arm/kvm/arm.c
> @@ -1067,8 +1067,16 @@ static int hyp_init_cpu_notify(struct notifier_block *self,
>  	switch (action) {
>  	case CPU_STARTING:
>  	case CPU_STARTING_FROZEN:
> -		if (__hyp_get_vectors() == hyp_default_vectors)
> -			cpu_init_hyp_mode(NULL);
> +		if (is_kernel_in_hyp_mode()) {
> +			/*
> +			 * cpu_init_stage2() is safe to call even if the PM
> +			 * event was cancelled before the CPU was reset.
> +			 */
> +			cpu_init_stage2(NULL);
> +		} else {
> +			if (__hyp_get_vectors() == hyp_default_vectors)
> +				cpu_init_hyp_mode(NULL);
> +		}
>  		break;
>  	}
>  
> @@ -1084,9 +1092,13 @@ static int hyp_init_cpu_pm_notifier(struct notifier_block *self,
>  				    unsigned long cmd,
>  				    void *v)
>  {
> -	if (cmd == CPU_PM_EXIT &&
> -	    __hyp_get_vectors() == hyp_default_vectors) {
> -		cpu_init_hyp_mode(NULL);
> +	if (cmd == CPU_PM_EXIT) {
> +		if (is_kernel_in_hyp_mode()) {
> +			cpu_init_stage2(NULL);
> +		} else {
> +			if (__hyp_get_vectors() == hyp_default_vectors)
> +				cpu_init_hyp_mode(NULL);
> +		}

Any reason why we can't isolate that snippet in a separate function and
use it in both locations?

>  		return NOTIFY_OK;
>  	}
>  
> @@ -1128,6 +1140,22 @@ static int init_subsystems(void)
>  	int err;
>  
>  	/*
> +	 * Register CPU Hotplug notifier
> +	 */
> +	cpu_notifier_register_begin();
> +	err = __register_cpu_notifier(&hyp_init_cpu_nb);
> +	cpu_notifier_register_done();
> +	if (err) {
> +		kvm_err("Cannot register KVM init CPU notifier (%d)\n", err);
> +		return err;
> +	}
> +
> +	/*
> +	 * Register CPU lower-power notifier
> +	 */
> +	hyp_cpu_pm_init();
> +
> +	/*
>  	 * Init HYP view of VGIC
>  	 */
>  	err = kvm_vgic_hyp_init();
> @@ -1270,19 +1298,6 @@ static int init_hyp_mode(void)
>  	free_boot_hyp_pgd();
>  #endif
>  
> -	cpu_notifier_register_begin();
> -
> -	err = __register_cpu_notifier(&hyp_init_cpu_nb);
> -
> -	cpu_notifier_register_done();
> -
> -	if (err) {
> -		kvm_err("Cannot register HYP init CPU notifier (%d)\n", err);
> -		goto out_err;
> -	}
> -
> -	hyp_cpu_pm_init();
> -
>  	/* set size of VMID supported by CPU */
>  	kvm_vmid_bits = kvm_get_vmid_bits();
>  	kvm_info("%d-bit VMID\n", kvm_vmid_bits);
> 

Otherwise looks good to me.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
