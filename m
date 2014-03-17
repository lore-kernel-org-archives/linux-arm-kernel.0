From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sun, 16 Mar 2014 20:41:11 -0700
Subject: [PATCH v4 08/10] ARM/ARM64: KVM: Emulate PSCI v0.2
 MIGRATE_INFO_TYPE and related functions
In-Reply-To: <1391686302-19451-9-git-send-email-anup.patel@linaro.org>
References: <1391686302-19451-1-git-send-email-anup.patel@linaro.org>
 <1391686302-19451-9-git-send-email-anup.patel@linaro.org>
Message-ID: <20140317034111.GI20648@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 06, 2014 at 05:01:40PM +0530, Anup Patel wrote:
> This patch adds emulation of PSCI v0.2 MIGRATE, MIGRATE_INFO_TYPE, and
> MIGRATE_INFO_UP_CPU function calls for KVM ARM/ARM64.
> 
> KVM ARM/ARM64 being a hypervisor (and not a Trusted OS), we cannot provide
> this functions hence we emulate these functions in following way:
> 1. MIGRATE - Returns "Not Supported"
> 2. MIGRATE_INFO_TYPE - Return 2 i.e. Trusted OS is either not present
>    or does not require migration
> 3. MIGRATE_INFO_UP_CPU - Returns "Not Supported"
> 
> Signed-off-by: Anup Patel <anup.patel@linaro.org>
> Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
> ---
>  arch/arm/kvm/psci.c |   23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/kvm/psci.c b/arch/arm/kvm/psci.c
> index 9890710..75447a3 100644
> --- a/arch/arm/kvm/psci.c
> +++ b/arch/arm/kvm/psci.c
> @@ -120,7 +120,8 @@ static unsigned long kvm_psci_vcpu_affinity_info(struct kvm_vcpu *vcpu)
>  	/* Ignore other bits of target affinity */
>  	target_affinity &= target_affinity_mask;
>  
> -	/* If one or more VCPU matching target affinity are running
> +	/*
> +	 * If one or more VCPU matching target affinity are running

ah, you fixed it here, please move change to previous patch, thanks.

>  	 * then return 0 (ON) else return 1 (OFF)
>  	 */
>  	kvm_for_each_vcpu(i, tmp, kvm) {
> @@ -185,6 +186,21 @@ static int kvm_psci_0_2_call(struct kvm_vcpu *vcpu)
>  	case KVM_PSCI_0_2_FN64_AFFINITY_INFO:
>  		val = kvm_psci_vcpu_affinity_info(vcpu);
>  		break;
> +	case KVM_PSCI_0_2_FN_MIGRATE:
> +	case KVM_PSCI_0_2_FN64_MIGRATE:
> +		val = KVM_PSCI_RET_NI;
> +		break;
> +	case KVM_PSCI_0_2_FN_MIGRATE_INFO_TYPE:
> +		/*
> +		 * Trusted OS is either not present or
> +		 * does not require migration
> +		 */
> +		val = 2;
> +		break;
> +	case KVM_PSCI_0_2_FN_MIGRATE_INFO_UP_CPU:
> +	case KVM_PSCI_0_2_FN64_MIGRATE_INFO_UP_CPU:
> +		val = KVM_PSCI_RET_NI;
> +		break;
>  	case KVM_PSCI_0_2_FN_SYSTEM_OFF:
>  		kvm_psci_system_off(vcpu);
>  		val = KVM_PSCI_RET_SUCCESS;
> @@ -196,12 +212,7 @@ static int kvm_psci_0_2_call(struct kvm_vcpu *vcpu)
>  		ret = 0;
>  		break;
>  	case KVM_PSCI_0_2_FN_CPU_SUSPEND:
> -	case KVM_PSCI_0_2_FN_MIGRATE:
> -	case KVM_PSCI_0_2_FN_MIGRATE_INFO_TYPE:
> -	case KVM_PSCI_0_2_FN_MIGRATE_INFO_UP_CPU:
>  	case KVM_PSCI_0_2_FN64_CPU_SUSPEND:
> -	case KVM_PSCI_0_2_FN64_MIGRATE:
> -	case KVM_PSCI_0_2_FN64_MIGRATE_INFO_UP_CPU:
>  		val = KVM_PSCI_RET_NI;
>  		break;
>  	default:
> -- 
> 1.7.9.5
> 

Otherwise:
Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
