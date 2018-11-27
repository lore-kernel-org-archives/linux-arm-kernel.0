From: james.morse@arm.com (James Morse)
Date: Tue, 27 Nov 2018 09:51:03 +0000
Subject: [PATCH v2 6/8] arm64: KVM: Add synchronization on translation
 regime change for erratum 1165522
In-Reply-To: <20181123184107.39334-7-marc.zyngier@arm.com>
References: <20181123184107.39334-1-marc.zyngier@arm.com>
 <20181123184107.39334-7-marc.zyngier@arm.com>
Message-ID: <488a0599-fcc3-65bb-acf2-d017c02e39ac@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On 23/11/2018 18:41, Marc Zyngier wrote:
> In order to ensure that slipping HCR_EL2.TGE is done at the right
> time when switching translation regime, let insert the required ISBs
> that will be patched in when erratum 1165522 is detected.

Reviewed-by: James Morse <james.morse@arm.com>


> diff --git a/arch/arm64/include/asm/kvm_hyp.h b/arch/arm64/include/asm/kvm_hyp.h
> index 23aca66767f9..ce46bb1c5f4b 100644
> --- a/arch/arm64/include/asm/kvm_hyp.h
> +++ b/arch/arm64/include/asm/kvm_hyp.h
> @@ -163,6 +163,13 @@ static __always_inline void __hyp_text __load_guest_stage2(struct kvm *kvm)
>  {
>  	write_sysreg(kvm->arch.vtcr, vtcr_el2);
>  	write_sysreg(kvm->arch.vttbr, vttbr_el2);
> +
> +	/*
> +	 * ARM erratum 1165522 requires the actual execution of the above
> +	 * before we can switch to the EL1/EL0 translation regime used by
> +	 * the guest.
> +	 */
> +	asm(ALTERNATIVE("nop", "isb", ARM64_WORKAROUND_1165522));

(kvm_hyp.h doesn't include alternative.h, .... but already uses ALTERNATIVE())


Thanks,

James
