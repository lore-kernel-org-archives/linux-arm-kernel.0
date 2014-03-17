From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sun, 16 Mar 2014 20:41:04 -0700
Subject: [PATCH v4 07/10] ARM/ARM64: KVM: Emulate PSCI v0.2 AFFINITY_INFO
In-Reply-To: <1391686302-19451-8-git-send-email-anup.patel@linaro.org>
References: <1391686302-19451-1-git-send-email-anup.patel@linaro.org>
 <1391686302-19451-8-git-send-email-anup.patel@linaro.org>
Message-ID: <20140317034104.GH20648@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 06, 2014 at 05:01:39PM +0530, Anup Patel wrote:
> This patch adds emulation of PSCI v0.2 AFFINITY_INFO function call
> for KVM ARM/ARM64. This is a VCPU-level function call which will be
> used to determine current state of given affinity level.
> 
> Signed-off-by: Anup Patel <anup.patel@linaro.org>
> Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
> ---
>  arch/arm/kvm/psci.c |   55 +++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 53 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/kvm/psci.c b/arch/arm/kvm/psci.c
> index 1f1720a..9890710 100644
> --- a/arch/arm/kvm/psci.c
> +++ b/arch/arm/kvm/psci.c
> @@ -85,6 +85,55 @@ static unsigned long kvm_psci_vcpu_on(struct kvm_vcpu *source_vcpu)
>  	return KVM_PSCI_RET_SUCCESS;
>  }
>  
> +static unsigned long kvm_psci_vcpu_affinity_info(struct kvm_vcpu *vcpu)
> +{
> +	int i;
> +	unsigned long mpidr;
> +	unsigned long target_affinity;
> +	unsigned long target_affinity_mask;
> +	unsigned long lowest_affinity_level;
> +	struct kvm *kvm = vcpu->kvm;
> +	struct kvm_vcpu *tmp;
> +
> +	target_affinity = *vcpu_reg(vcpu, 1);
> +	lowest_affinity_level = *vcpu_reg(vcpu, 2);
> +
> +	/* Determine target affinity mask */
> +	target_affinity_mask = MPIDR_HWID_BITMASK;
> +	switch (lowest_affinity_level) {
> +	case 0: /* All affinity levels are valid */
> +		target_affinity_mask &= ~0x0UL;
> +		break;
> +	case 1: /* Aff0 ignored */
> +		target_affinity_mask &= ~0xFFUL;
> +		break;
> +	case 2: /* Aff0 and Aff1 ignored */
> +		target_affinity_mask &= ~0xFFFFUL;
> +		break;
> +	case 3: /* Aff0, Aff1, and Aff2 ignored */
> +		target_affinity_mask &= ~0xFFFFFFUL;
> +		break;
> +	default:
> +		return KVM_PSCI_RET_INVAL;
> +	};
> +
> +	/* Ignore other bits of target affinity */
> +	target_affinity &= target_affinity_mask;
> +
> +	/* If one or more VCPU matching target affinity are running
> +	 * then return 0 (ON) else return 1 (OFF)
> +	 */

nit: this is not kernel commenting style, checkpatch should complain.

> +	kvm_for_each_vcpu(i, tmp, kvm) {
> +		mpidr = kvm_vcpu_get_mpidr(tmp);
> +		if (((mpidr & target_affinity_mask) == target_affinity) &&
> +		    !tmp->arch.pause) {
> +			return 0;
> +		}
> +	}
> +
> +	return 1;
> +}
> +
>  static inline void kvm_prepare_system_event(struct kvm_vcpu *vcpu, u32 type)
>  {
>  	memset(&vcpu->run->system_event, 0, sizeof(vcpu->run->system_event));
> @@ -132,6 +181,10 @@ static int kvm_psci_0_2_call(struct kvm_vcpu *vcpu)
>  	case KVM_PSCI_0_2_FN64_CPU_ON:
>  		val = kvm_psci_vcpu_on(vcpu);
>  		break;
> +	case KVM_PSCI_0_2_FN_AFFINITY_INFO:
> +	case KVM_PSCI_0_2_FN64_AFFINITY_INFO:
> +		val = kvm_psci_vcpu_affinity_info(vcpu);
> +		break;
>  	case KVM_PSCI_0_2_FN_SYSTEM_OFF:
>  		kvm_psci_system_off(vcpu);
>  		val = KVM_PSCI_RET_SUCCESS;
> @@ -143,12 +196,10 @@ static int kvm_psci_0_2_call(struct kvm_vcpu *vcpu)
>  		ret = 0;
>  		break;
>  	case KVM_PSCI_0_2_FN_CPU_SUSPEND:
> -	case KVM_PSCI_0_2_FN_AFFINITY_INFO:
>  	case KVM_PSCI_0_2_FN_MIGRATE:
>  	case KVM_PSCI_0_2_FN_MIGRATE_INFO_TYPE:
>  	case KVM_PSCI_0_2_FN_MIGRATE_INFO_UP_CPU:
>  	case KVM_PSCI_0_2_FN64_CPU_SUSPEND:
> -	case KVM_PSCI_0_2_FN64_AFFINITY_INFO:
>  	case KVM_PSCI_0_2_FN64_MIGRATE:
>  	case KVM_PSCI_0_2_FN64_MIGRATE_INFO_UP_CPU:
>  		val = KVM_PSCI_RET_NI;
> -- 
> 1.7.9.5
> 

Besides the nit:
Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
