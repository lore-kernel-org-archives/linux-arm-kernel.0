From: cdall@linaro.org (Christoffer Dall)
Date: Mon, 16 Oct 2017 22:08:11 +0200
Subject: [PATCH 06/10] KVM: arm/arm64: Only clean the dcache on
 translation fault
In-Reply-To: <20171009152032.27804-7-marc.zyngier@arm.com>
References: <20171009152032.27804-1-marc.zyngier@arm.com>
 <20171009152032.27804-7-marc.zyngier@arm.com>
Message-ID: <20171016200811.GH1845@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 09, 2017 at 04:20:28PM +0100, Marc Zyngier wrote:
> The only case where we actually need to perform a dache maintenance
> is when we map the page for the first time, and subsequent permission
> faults do not require cache maintenance. Let's make it conditional
> on not being a permission fault (and thus a translation fault).

Why do we actually need to do any dcache maintenance when faulting in a
page?

Is this for the case when the stage 1 MMU is disabled, or to support
guest mappings using uncached attributes?  Can we do better, for example
by only flushing the cache if the guest MMU is disabled?

Beyond that:

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>

> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  virt/kvm/arm/mmu.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
> index 1d47da22f75c..1911fadde88b 100644
> --- a/virt/kvm/arm/mmu.c
> +++ b/virt/kvm/arm/mmu.c
> @@ -1400,7 +1400,9 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>  			new_pmd = kvm_s2pmd_mkwrite(new_pmd);
>  			kvm_set_pfn_dirty(pfn);
>  		}
> -		coherent_dcache_guest_page(vcpu, pfn, PMD_SIZE);
> +
> +		if (fault_status != FSC_PERM)
> +			coherent_dcache_guest_page(vcpu, pfn, PMD_SIZE);
>  
>  		if (exec_fault) {
>  			new_pmd = kvm_s2pmd_mkexec(new_pmd);
> @@ -1416,7 +1418,9 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>  			kvm_set_pfn_dirty(pfn);
>  			mark_page_dirty(kvm, gfn);
>  		}
> -		coherent_dcache_guest_page(vcpu, pfn, PAGE_SIZE);
> +
> +		if (fault_status != FSC_PERM)
> +			coherent_dcache_guest_page(vcpu, pfn, PAGE_SIZE);
>  
>  		if (exec_fault) {
>  			new_pte = kvm_s2pte_mkexec(new_pte);
> -- 
> 2.14.1
> 
