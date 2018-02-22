From: drjones@redhat.com (Andrew Jones)
Date: Thu, 22 Feb 2018 16:38:42 +0100
Subject: [PATCH v4 32/40] KVM: arm64: Directly call VHE and non-VHE
 FPSIMD enabled functions
In-Reply-To: <20180215210332.8648-33-christoffer.dall@linaro.org>
References: <20180215210332.8648-1-christoffer.dall@linaro.org>
 <20180215210332.8648-33-christoffer.dall@linaro.org>
Message-ID: <20180222153842.mdqlaxnxizqfhfnq@kamzik.brq.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 15, 2018 at 10:03:24PM +0100, Christoffer Dall wrote:
> There is no longer a need for an alternative to choose the right
> function to tell us whether or not FPSIMD was enabled for the VM,
> because we can simply cann the appropriate functions directly fromwithin

s/cann/call/
s/fromwithin/from within/

> the _vhe and _nvhe run functions.
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> ---
> 
> Notes:
>     Changes since v3:
>      - New patch since we no longer defer FPSIMD handling to load/put
> 
>  arch/arm64/kvm/hyp/switch.c | 15 +++------------
>  1 file changed, 3 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
> index 17e3c6f26a34..9c40e203bd09 100644
> --- a/arch/arm64/kvm/hyp/switch.c
> +++ b/arch/arm64/kvm/hyp/switch.c
> @@ -33,20 +33,11 @@ static bool __hyp_text __fpsimd_enabled_nvhe(void)
>  	return !(read_sysreg(cptr_el2) & CPTR_EL2_TFP);
>  }
>  
> -static bool __hyp_text __fpsimd_enabled_vhe(void)
> +static bool fpsimd_enabled_vhe(void)
>  {
>  	return !!(read_sysreg(cpacr_el1) & CPACR_EL1_FPEN);
>  }
>  
> -static hyp_alternate_select(__fpsimd_is_enabled,
> -			    __fpsimd_enabled_nvhe, __fpsimd_enabled_vhe,
> -			    ARM64_HAS_VIRT_HOST_EXTN);
> -
> -bool __hyp_text __fpsimd_enabled(void)
> -{
> -	return __fpsimd_is_enabled()();
> -}
> -
>  /* Save the 32-bit only FPSIMD system register state */
>  static inline void __hyp_text __fpsimd_save_fpexc32(struct kvm_vcpu *vcpu)
>  {
> @@ -413,7 +404,7 @@ int kvm_vcpu_run_vhe(struct kvm_vcpu *vcpu)
>  		/* And we're baaack! */
>  	} while (fixup_guest_exit(vcpu, &exit_code));
>  
> -	fp_enabled = __fpsimd_enabled();
> +	fp_enabled = fpsimd_enabled_vhe();
>  
>  	sysreg_save_guest_state_vhe(guest_ctxt);
>  	__vgic_save_state(vcpu);
> @@ -478,7 +469,7 @@ int __hyp_text __kvm_vcpu_run_nvhe(struct kvm_vcpu *vcpu)
>  			__qcom_hyp_sanitize_btac_predictors();
>  	}
>  
> -	fp_enabled = __fpsimd_enabled();
> +	fp_enabled = __fpsimd_enabled_nvhe();
>  
>  	__sysreg_save_state_nvhe(guest_ctxt);
>  	__sysreg32_save_state(vcpu);
> -- 
> 2.14.2
>

Reviewed-by: Andrew Jones <drjones@redhat.com>
