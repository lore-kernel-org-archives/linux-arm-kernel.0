From: cdall@cs.columbia.edu (Christoffer Dall)
Date: Mon, 27 May 2013 19:11:21 -0700
Subject: [PATCH v3 4/7] ARM: KVM: use phys_addr_t instead of unsigned
 long long for HYP PGDs
In-Reply-To: <1368529900-22572-5-git-send-email-marc.zyngier@arm.com>
References: <1368529900-22572-1-git-send-email-marc.zyngier@arm.com>
 <1368529900-22572-5-git-send-email-marc.zyngier@arm.com>
Message-ID: <20130528021121.GD16071@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 14, 2013 at 12:11:37PM +0100, Marc Zyngier wrote:
> HYP PGDs are passed around as phys_addr_t, except just before calling
> into the hypervisor init code, where they are cast to a rather weird
> unsigned long long.
> 
> Just keep them around as phys_addr_t, which is what makes the most
> sense.
> 
> Reported-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm/include/asm/kvm_host.h | 4 ++--
>  arch/arm/kvm/arm.c              | 8 ++++----
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
> index 57cb786..ff49193 100644
> --- a/arch/arm/include/asm/kvm_host.h
> +++ b/arch/arm/include/asm/kvm_host.h
> @@ -190,8 +190,8 @@ int kvm_arm_coproc_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *);
>  int handle_exit(struct kvm_vcpu *vcpu, struct kvm_run *run,
>  		int exception_index);
>  
> -static inline void __cpu_init_hyp_mode(unsigned long long boot_pgd_ptr,
> -				       unsigned long long pgd_ptr,
> +static inline void __cpu_init_hyp_mode(phys_addr_t boot_pgd_ptr,
> +				       phys_addr_t pgd_ptr,
>  				       unsigned long hyp_stack_ptr,
>  				       unsigned long vector_ptr)
>  {
> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
> index 37d216d..327a1fb 100644
> --- a/arch/arm/kvm/arm.c
> +++ b/arch/arm/kvm/arm.c
> @@ -789,8 +789,8 @@ long kvm_arch_vm_ioctl(struct file *filp,
>  
>  static void cpu_init_hyp_mode(void *dummy)
>  {
> -	unsigned long long boot_pgd_ptr;
> -	unsigned long long pgd_ptr;
> +	phys_addr_t boot_pgd_ptr;
> +	phys_addr_t pgd_ptr;
>  	unsigned long hyp_stack_ptr;
>  	unsigned long stack_page;
>  	unsigned long vector_ptr;
> @@ -798,8 +798,8 @@ static void cpu_init_hyp_mode(void *dummy)
>  	/* Switch from the HYP stub to our own HYP init vector */
>  	__hyp_set_vectors(kvm_get_idmap_vector());
>  
> -	boot_pgd_ptr = (unsigned long long)kvm_mmu_get_boot_httbr();
> -	pgd_ptr = (unsigned long long)kvm_mmu_get_httbr();
> +	boot_pgd_ptr = kvm_mmu_get_boot_httbr();
> +	pgd_ptr = kvm_mmu_get_httbr();
>  	stack_page = __get_cpu_var(kvm_arm_hyp_stack_page);
>  	hyp_stack_ptr = stack_page + PAGE_SIZE;
>  	vector_ptr = (unsigned long)__kvm_hyp_vector;
> -- 
> 1.8.2.3
> 
> 
Applied, thanks.

-Christoffer
