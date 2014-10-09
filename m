From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 09 Oct 2014 14:07:49 +0100
Subject: [PATCH 3/6] arm/arm64: KVM: add 'writable' parameter to
 kvm_phys_addr_ioremap
In-Reply-To: <1410990981-665-4-git-send-email-ard.biesheuvel@linaro.org>
References: <1410990981-665-1-git-send-email-ard.biesheuvel@linaro.org>
 <1410990981-665-4-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <543688A5.9020300@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/09/14 22:56, Ard Biesheuvel wrote:
> Add support for read-only MMIO passthrough mappings by adding a
> 'writable' parameter to kvm_phys_addr_ioremap. For the moment,
> mappings will be read-write even if 'writable' is false, but once
> the definition of PAGE_S2_DEVICE gets changed, those mappings will
> be created read-only.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm/kvm/mmu.c               | 5 ++++-
>  arch/arm64/include/asm/kvm_mmu.h | 2 +-
>  virt/kvm/arm/vgic.c              | 3 ++-
>  3 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
> index c093e95ff7ef..fe53c3a30383 100644
> --- a/arch/arm/kvm/mmu.c
> +++ b/arch/arm/kvm/mmu.c
> @@ -674,7 +674,7 @@ static int stage2_set_pte(struct kvm *kvm, struct kvm_mmu_memory_cache *cache,
>   * @size:	The size of the mapping
>   */
>  int kvm_phys_addr_ioremap(struct kvm *kvm, phys_addr_t guest_ipa,
> -			  phys_addr_t pa, unsigned long size)
> +			  phys_addr_t pa, unsigned long size, bool writable)
>  {
>  	phys_addr_t addr, end;
>  	int ret = 0;
> @@ -687,6 +687,9 @@ int kvm_phys_addr_ioremap(struct kvm *kvm, phys_addr_t guest_ipa,
>  	for (addr = guest_ipa; addr < end; addr += PAGE_SIZE) {
>  		pte_t pte = pfn_pte(pfn, PAGE_S2_DEVICE);
>  
> +		if (writable)
> +			kvm_set_s2pte_writable(&pte);
> +
>  		ret = mmu_topup_memory_cache(&cache, 2, 2);
>  		if (ret)
>  			goto out;
> diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
> index 737da742b293..7474e611bb2a 100644
> --- a/arch/arm64/include/asm/kvm_mmu.h
> +++ b/arch/arm64/include/asm/kvm_mmu.h
> @@ -78,7 +78,7 @@ void free_hyp_pgds(void);
>  int kvm_alloc_stage2_pgd(struct kvm *kvm);
>  void kvm_free_stage2_pgd(struct kvm *kvm);
>  int kvm_phys_addr_ioremap(struct kvm *kvm, phys_addr_t guest_ipa,
> -			  phys_addr_t pa, unsigned long size);
> +			  phys_addr_t pa, unsigned long size, bool writable);

I'm afraid you missed the equivalent 32bit declaration.

>  
>  int kvm_handle_guest_abort(struct kvm_vcpu *vcpu, struct kvm_run *run);
>  
> diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
> index 73eba793b17f..c2bdbf4e25c2 100644
> --- a/virt/kvm/arm/vgic.c
> +++ b/virt/kvm/arm/vgic.c
> @@ -1628,7 +1628,8 @@ int kvm_vgic_init(struct kvm *kvm)
>  	}
>  
>  	ret = kvm_phys_addr_ioremap(kvm, kvm->arch.vgic.vgic_cpu_base,
> -				    vgic->vcpu_base, KVM_VGIC_V2_CPU_SIZE);
> +				    vgic->vcpu_base, KVM_VGIC_V2_CPU_SIZE,
> +				    true);
>  	if (ret) {
>  		kvm_err("Unable to remap VGIC CPU to VCPU\n");
>  		goto out;
> 

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
