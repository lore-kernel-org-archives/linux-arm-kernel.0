From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 19 Feb 2015 13:40:02 +0000
Subject: [RFC/RFT PATCH 3/3] arm64: KVM: keep trapping of VM sysreg writes
 enabled
In-Reply-To: <1424343286-6792-4-git-send-email-ard.biesheuvel@linaro.org>
References: <1424343286-6792-1-git-send-email-ard.biesheuvel@linaro.org>
 <1424343286-6792-4-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <54E5E7B2.2080501@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/02/15 10:54, Ard Biesheuvel wrote:
> ---
>  arch/arm/kvm/mmu.c               | 2 +-
>  arch/arm64/include/asm/kvm_arm.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
> index 136662547ca6..fa8ec55220ea 100644
> --- a/arch/arm/kvm/mmu.c
> +++ b/arch/arm/kvm/mmu.c
> @@ -1530,7 +1530,7 @@ void kvm_toggle_cache(struct kvm_vcpu *vcpu, bool was_enabled)
>  		stage2_flush_vm(vcpu->kvm);
>  
>  	/* Caches are now on, stop trapping VM ops (until a S/W op) */
> -	if (now_enabled)
> +	if (0)//now_enabled)
>  		vcpu_set_hcr(vcpu, vcpu_get_hcr(vcpu) & ~HCR_TVM);
>  
>  	trace_kvm_toggle_cache(*vcpu_pc(vcpu), was_enabled, now_enabled);
> diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
> index 8afb863f5a9e..437e1ec17539 100644
> --- a/arch/arm64/include/asm/kvm_arm.h
> +++ b/arch/arm64/include/asm/kvm_arm.h
> @@ -75,7 +75,7 @@
>   * FMO:		Override CPSR.F and enable signaling with VF
>   * SWIO:	Turn set/way invalidates into set/way clean+invalidate
>   */
> -#define HCR_GUEST_FLAGS (HCR_TSC | HCR_TSW | HCR_TWE | HCR_TWI | HCR_VM | \
> +#define HCR_GUEST_FLAGS (HCR_TSC | /* HCR_TSW | */ HCR_TWE | HCR_TWI | HCR_VM | \

Why do we stop to trap S/W ops here? We can't let the guest issue those
without doing anything, as this will break anything that expects the
data to make it to memory. Think of the 32bit kernel decompressor, for
example.

	M.
-- 
Jazz is not dead. It just smells funny...
