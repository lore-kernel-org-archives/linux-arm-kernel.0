From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 6 Nov 2013 21:12:29 -0800
Subject: [PATCH v3 2/2] arm/arm64: KVM: propagate caller endianness to
 the incomming vcpu
In-Reply-To: <1383677895-3728-3-git-send-email-marc.zyngier@arm.com>
References: <1383677895-3728-1-git-send-email-marc.zyngier@arm.com>
 <1383677895-3728-3-git-send-email-marc.zyngier@arm.com>
Message-ID: <20131107051229.GB18387@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 05, 2013 at 06:58:15PM +0000, Marc Zyngier wrote:
> When booting a vcpu using PSCI, make sure we start it with the
> endianness of the caller. Otherwise, secondaries can be pretty
> unhappy to execute a BE kernel in LE mode...
> 
> This conforms to PSCI spec Rev B, 5.13.3.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm/include/asm/kvm_emulate.h   | 5 +++++
>  arch/arm/kvm/psci.c                  | 4 ++++
>  arch/arm64/include/asm/kvm_emulate.h | 8 ++++++++
>  3 files changed, 17 insertions(+)
> 
> diff --git a/arch/arm/include/asm/kvm_emulate.h b/arch/arm/include/asm/kvm_emulate.h
> index 8a6be05..e844b33 100644
> --- a/arch/arm/include/asm/kvm_emulate.h
> +++ b/arch/arm/include/asm/kvm_emulate.h
> @@ -157,6 +157,11 @@ static inline u32 kvm_vcpu_hvc_get_imm(struct kvm_vcpu *vcpu)
>  	return kvm_vcpu_get_hsr(vcpu) & HSR_HVC_IMM_MASK;
>  }
>  
> +static inline void kvm_vcpu_set_be(struct kvm_vcpu *vcpu)
> +{
> +	*vcpu_cpsr(vcpu) |= PSR_E_BIT;
> +}
> +
>  static inline bool kvm_vcpu_is_be(struct kvm_vcpu *vcpu)
>  {
>  	return !!(*vcpu_cpsr(vcpu) & PSR_E_BIT);
> diff --git a/arch/arm/kvm/psci.c b/arch/arm/kvm/psci.c
> index 86a693a..ae0e06b 100644
> --- a/arch/arm/kvm/psci.c
> +++ b/arch/arm/kvm/psci.c
> @@ -62,6 +62,10 @@ static unsigned long kvm_psci_vcpu_on(struct kvm_vcpu *source_vcpu)
>  		vcpu_set_thumb(vcpu);
>  	}
>  
> +	/* Propagate caller endianness */
> +	if (kvm_vcpu_is_be(source_vcpu))
> +		kvm_vcpu_set_be(vcpu);
> +
>  	*vcpu_pc(vcpu) = target_pc;
>  	vcpu->arch.pause = false;
>  	smp_mb();		/* Make sure the above is visible */
> diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
> index 3a7d058..c8ea23f 100644
> --- a/arch/arm64/include/asm/kvm_emulate.h
> +++ b/arch/arm64/include/asm/kvm_emulate.h
> @@ -177,6 +177,14 @@ static inline u8 kvm_vcpu_trap_get_fault(const struct kvm_vcpu *vcpu)
>  	return kvm_vcpu_get_hsr(vcpu) & ESR_EL2_FSC_TYPE;
>  }
>  
> +static inline void kvm_vcpu_set_be(struct kvm_vcpu *vcpu)
> +{
> +	if (vcpu_mode_is_32bit(vcpu))
> +		*vcpu_cpsr(vcpu) |= COMPAT_PSR_E_BIT;
> +	else
> +		vcpu_sys_reg(vcpu, SCTLR_EL1) |= (1 << 25);
> +}
> +
>  static inline bool kvm_vcpu_is_be(struct kvm_vcpu *vcpu)
>  {
>  	if (vcpu_mode_is_32bit(vcpu))
> -- 
> 1.8.2.3
> 
> 
Looks quite nice to me:
Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
