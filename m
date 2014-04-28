From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 28 Apr 2014 07:23:29 -0700
Subject: [PATCH v10 11/12] ARM/ARM64: KVM: Emulate PSCI v0.2 CPU_SUSPEND
In-Reply-To: <1398085206-30555-12-git-send-email-anup.patel@linaro.org>
References: <1398085206-30555-1-git-send-email-anup.patel@linaro.org>
 <1398085206-30555-12-git-send-email-anup.patel@linaro.org>
Message-ID: <20140428142329.GH2868@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 21, 2014 at 06:30:05PM +0530, Anup Patel wrote:
> This patch adds emulation of PSCI v0.2 CPU_SUSPEND function call for
> KVM ARM/ARM64. This is a CPU-level function call which can suspend
> current CPU or current CPU cluster. We don't have VCPU clusters in
> KVM so we only suspend the current VCPU.
> 
> The CPU_SUSPEND emulation is not tested much because currently there
> is no CPUIDLE driver in Linux kernel that uses PSCI CPU_SUSPEND. The
> PSCI CPU_SUSPEND implementation in ARM64 kernel was tested using a
> Simple CPUIDLE driver which is not published due to unstable DT-bindings
> for PSCI.
> (For more info, http://lwn.net/Articles/574950/)
> 
> For simplicity, we implement CPU_SUSPEND emulation similar to WFI
> (Wait-for-interrupt) emulation and we also treat power-down request
> to be same as stand-by request. This is consistent with section
> 5.4.1 and section 5.4.2 of PSCI v0.2 specification.
> 
> Signed-off-by: Anup Patel <anup.patel@linaro.org>
> Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
> ---
>  arch/arm/kvm/psci.c |   28 ++++++++++++++++++++++++----
>  1 file changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/kvm/psci.c b/arch/arm/kvm/psci.c
> index b582e99..757e506 100644
> --- a/arch/arm/kvm/psci.c
> +++ b/arch/arm/kvm/psci.c
> @@ -37,6 +37,26 @@ static unsigned long psci_affinity_mask(unsigned long affinity_level)
>  	return 0;
>  }
>  
> +static unsigned long kvm_psci_vcpu_suspend(struct kvm_vcpu *vcpu)
> +{
> +	/*
> +	 * NOTE: For simplicity, we make VCPU suspend emulation to be
> +	 * same-as WFI (Wait-for-interrupt) emulation.
> +	 *
> +	 * This means for KVM the wakeup events are interrupts and
> +	 * this is consistent with intended use of StateID as described
> +	 * in section 5.4.1 of PSCI v0.2 specification (ARM DEN 0022A).
> +	 *
> +	 * Further, we also treat power-down request to be same as
> +	 * stand-by request as-per section 5.4.2 clause 3 of PSCI v0.2
> +	 * specification (ARM DEN 0022A). This means all suspend states
> +	 * for KVM will preserve the register state.
> +	 */
> +	kvm_vcpu_block(vcpu);
> +
> +	return PSCI_RET_SUCCESS;
> +}
> +
>  static void kvm_psci_vcpu_off(struct kvm_vcpu *vcpu)
>  {
>  	vcpu->arch.pause = true;
> @@ -183,6 +203,10 @@ static int kvm_psci_0_2_call(struct kvm_vcpu *vcpu)
>  		 */
>  		val = 2;
>  		break;
> +	case PSCI_0_2_FN_CPU_SUSPEND:
> +	case PSCI_0_2_FN64_CPU_SUSPEND:
> +		val = kvm_psci_vcpu_suspend(vcpu);
> +		break;
>  	case PSCI_0_2_FN_CPU_OFF:
>  		kvm_psci_vcpu_off(vcpu);
>  		val = PSCI_RET_SUCCESS;
> @@ -221,10 +245,6 @@ static int kvm_psci_0_2_call(struct kvm_vcpu *vcpu)
>  		val = PSCI_RET_INTERNAL_FAILURE;
>  		ret = 0;
>  		break;
> -	case PSCI_0_2_FN_CPU_SUSPEND:
> -	case PSCI_0_2_FN64_CPU_SUSPEND:
> -		val = PSCI_RET_NOT_SUPPORTED;
> -		break;
>  	default:
>  		return -EINVAL;
>  	}
> -- 
> 1.7.9.5
> 
Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
