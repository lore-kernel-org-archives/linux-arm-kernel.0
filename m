From: cdall@cs.columbia.edu (Christoffer Dall)
Date: Wed, 3 Apr 2013 16:16:10 -0700
Subject: [PATCH 7/7] ARM: KVM: perform HYP initilization for hotplugged
 CPUs
In-Reply-To: <1364909115-3810-8-git-send-email-marc.zyngier@arm.com>
References: <1364909115-3810-1-git-send-email-marc.zyngier@arm.com>
 <1364909115-3810-8-git-send-email-marc.zyngier@arm.com>
Message-ID: <20130403231610.GH29227@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 02, 2013 at 02:25:15PM +0100, Marc Zyngier wrote:
> Now that we have the necessary infrastructure to boot a hotplugged CPU
> at any point in time, wire a CPU notifier that will perform the HYP
> init for the incoming CPU.
> 
> Note that this depends on the platform code and/or firmware to boot the
> incoming CPU with HYP mode enabled and return to the kernel by following
> the normal boot path (HYP stub installed).
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm/kvm/arm.c | 47 +++++++++++++++++++++++++++++++----------------
>  1 file changed, 31 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
> index f0f3290..6cc076e 100644
> --- a/arch/arm/kvm/arm.c
> +++ b/arch/arm/kvm/arm.c
> @@ -793,8 +793,9 @@ long kvm_arch_vm_ioctl(struct file *filp,
>  	}
>  }
>  
> -static void cpu_init_hyp_mode(void *vector)
> +static void cpu_init_hyp_mode(void *dummy)
>  {
> +	phys_addr_t init_vector_addr = virt_to_phys(__kvm_hyp_init);
>  	unsigned long long boot_pgd_ptr;
>  	unsigned long long pgd_ptr;
>  	unsigned long hyp_stack_ptr;
> @@ -802,7 +803,7 @@ static void cpu_init_hyp_mode(void *vector)
>  	unsigned long vector_ptr;
>  
>  	/* Switch from the HYP stub to our own HYP init vector */
> -	__hyp_set_vectors((unsigned long)vector);
> +	__hyp_set_vectors(init_vector_addr);
>  
>  	boot_pgd_ptr = (unsigned long long)kvm_mmu_get_boot_httbr();
>  	pgd_ptr = (unsigned long long)kvm_mmu_get_httbr();
> @@ -813,12 +814,28 @@ static void cpu_init_hyp_mode(void *vector)
>  	__cpu_init_hyp_mode(boot_pgd_ptr, pgd_ptr, hyp_stack_ptr, vector_ptr);
>  }
>  
> +static int hyp_init_cpu_notify(struct notifier_block *self,
> +			       unsigned long action, void *cpu)
> +{
> +	switch (action) {
> +	case CPU_STARTING:
> +	case CPU_STARTING_FROZEN:
> +		cpu_init_hyp_mode(NULL);
> +		break;
> +	}
> +
> +	return NOTIFY_OK;
> +}
> +
> +static struct notifier_block hyp_init_cpu_nb = {
> +	.notifier_call = hyp_init_cpu_notify,
> +};
> +
>  /**
>   * Inits Hyp-mode on all online CPUs
>   */
>  static int init_hyp_mode(void)
>  {
> -	phys_addr_t init_phys_addr;
>  	int cpu;
>  	int err = 0;
>  
> @@ -851,19 +868,6 @@ static int init_hyp_mode(void)
>  	}
>  
>  	/*
> -	 * Execute the init code on each CPU.
> -	 *
> -	 * Note: The stack is not mapped yet, so don't do anything else than
> -	 * initializing the hypervisor mode on each CPU using a local stack
> -	 * space for temporary storage.
> -	 */
> -	init_phys_addr = virt_to_phys(__kvm_hyp_init);
> -	for_each_online_cpu(cpu) {
> -		smp_call_function_single(cpu, cpu_init_hyp_mode,
> -					 (void *)(long)init_phys_addr, 1);
> -	}
> -
> -	/*
>  	 * Map the Hyp-code called directly from the host
>  	 */
>  	err = create_hyp_mappings(__kvm_hyp_code_start, __kvm_hyp_code_end);
> @@ -908,6 +912,11 @@ static int init_hyp_mode(void)
>  	}
>  
>  	/*
> +	 * Execute the init code on each CPU.
> +	 */
> +	on_each_cpu(cpu_init_hyp_mode, NULL, 1);
> +
> +	/*
>  	 * Init HYP view of VGIC
>  	 */
>  	err = kvm_vgic_hyp_init();
> @@ -963,6 +972,12 @@ int kvm_arch_init(void *opaque)
>  	if (err)
>  		goto out_err;
>  
> +	err = register_cpu_notifier(&hyp_init_cpu_nb);
> +	if (err) {
> +		kvm_err("Cannot register HYP init CPU notifier (%d)\n", err);
> +		goto out_err;
> +	}
> +
>  	kvm_coproc_table_init();
>  	return 0;
>  out_err:
> -- 
> 1.8.1.4
> 
> 
Acked-by: Christoffer Dall <cdall@cs.columbia.edu>
