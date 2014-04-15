From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 15 Apr 2014 13:14:56 +0100
Subject: [PATCH v9 11/12] ARM/ARM64: KVM: Emulate PSCI v0.2 CPU_SUSPEND
In-Reply-To: <1397542455-354-12-git-send-email-anup.patel@linaro.org> (Anup
 Patel's message of "Tue, 15 Apr 2014 07:14:14 +0100")
References: <1397542455-354-1-git-send-email-anup.patel@linaro.org>
 <1397542455-354-12-git-send-email-anup.patel@linaro.org>
Message-ID: <878ur6zt4v.fsf@approximate.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 15 2014 at  7:14:14 am BST, Anup Patel <anup.patel@linaro.org> wrote:
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
> Even if we had stable DT-bindings for PSCI and CPUIDLE driver that
> uses PSCI CPU_SUSPEND then still we need to define SUSPEND states
> and WAKEUP events for KVM ARM/ARM64.
>
> Due to above, we implement CPU_SUSPEND emulation similar to WFI
> (Wait-for-interrupt) emulation and we also treat power-down request
> to be same as stand-by request. This is consistent with section
> 5.4.1 and section 5.4.2 of PSCI v0.2 specification.
>
> Signed-off-by: Anup Patel <anup.patel@linaro.org>
> Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
> ---
>  arch/arm/kvm/psci.c |   29 +++++++++++++++++++++++++----
>  1 file changed, 25 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/kvm/psci.c b/arch/arm/kvm/psci.c
> index f59f09d..fdb347a 100644
> --- a/arch/arm/kvm/psci.c
> +++ b/arch/arm/kvm/psci.c
> @@ -37,6 +37,27 @@ static unsigned long psci_affinity_mask(unsigned long affinity_level)
>  	return 0;
>  }
>  
> +static unsigned long kvm_psci_vcpu_suspend(struct kvm_vcpu *vcpu)
> +{
> +	/*
> +	 * NOTE: Currently, we don't have any wakeup events defined
> +	 * for KVM so for simplicity we make VCPU suspend emulation
> +	 * to be same-as WFI (Wait-for-interrupt) emulation.

Well, in this implementation, any interrupt is a wakeup event, so you
can remove the comment about "we don't have any wakeup events". We
arguably have too many of them.

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
> @@ -183,6 +204,10 @@ static int kvm_psci_0_2_call(struct kvm_vcpu *vcpu)
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
> @@ -221,10 +246,6 @@ static int kvm_psci_0_2_call(struct kvm_vcpu *vcpu)
>  		val = PSCI_RET_SUCCESS;
>  		ret = 0;
>  		break;
> -	case PSCI_0_2_FN_CPU_SUSPEND:
> -	case PSCI_0_2_FN64_CPU_SUSPEND:
> -		val = PSCI_RET_NOT_SUPPORTED;
> -		break;
>  	default:
>  		return -EINVAL;
>  	}

-- 
Jazz is not dead. It just smells funny.
