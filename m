From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 15 Jul 2013 13:39:22 +0100
Subject: [PATCH] arm64: KVM: Support X-Gene guest VCPU on APM X-Gene host
In-Reply-To: <1373888788-8055-1-git-send-email-anup.patel@linaro.org>
References: <1373888788-8055-1-git-send-email-anup.patel@linaro.org>
Message-ID: <51E3ED7A.7050207@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Anup,

On 15/07/13 12:46, Anup Patel wrote:
> This patch allows us to have X-Gene guest VCPU when using
> KVM arm64 on APM X-Gene host.
> 
> We add KVM_ARM_TARGET_XGENE_V8 for X-Gene compatible guest VCPU
> and we return KVM_ARM_TARGET_XGENE_V8 in kvm_target_cpu() when
> running on X-Gene host.
> 
> Signed-off-by: Anup Patel <anup.patel@linaro.org>
> Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
> ---
>  arch/arm64/include/uapi/asm/kvm.h    |    3 ++-
>  arch/arm64/kvm/guest.c               |   34 ++++++++++++++++++++++------------
>  arch/arm64/kvm/sys_regs_generic_v8.c |    3 +++
>  3 files changed, 27 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
> index 5031f42..8194707 100644
> --- a/arch/arm64/include/uapi/asm/kvm.h
> +++ b/arch/arm64/include/uapi/asm/kvm.h
> @@ -55,8 +55,9 @@ struct kvm_regs {
>  #define KVM_ARM_TARGET_AEM_V8		0
>  #define KVM_ARM_TARGET_FOUNDATION_V8	1
>  #define KVM_ARM_TARGET_CORTEX_A57	2
> +#define KVM_ARM_TARGET_XGENE_V8		3
>  
> -#define KVM_ARM_NUM_TARGETS		3
> +#define KVM_ARM_NUM_TARGETS		4
>  
>  /* KVM_ARM_SET_DEVICE_ADDR ioctl id encoding */
>  #define KVM_ARM_DEVICE_TYPE_SHIFT	0
> diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
> index 2c3ff67..e99b0a5 100644
> --- a/arch/arm64/kvm/guest.c
> +++ b/arch/arm64/kvm/guest.c
> @@ -207,19 +207,29 @@ int __attribute_const__ kvm_target_cpu(void)
>  	unsigned long implementor = read_cpuid_implementor();
>  	unsigned long part_number = read_cpuid_part_number();
>  
> -	if (implementor != ARM_CPU_IMP_ARM)
> -		return -EINVAL;
> -
> -	switch (part_number) {
> -	case ARM_CPU_PART_AEM_V8:
> -		return KVM_ARM_TARGET_AEM_V8;
> -	case ARM_CPU_PART_FOUNDATION:
> -		return KVM_ARM_TARGET_FOUNDATION_V8;
> -	case ARM_CPU_PART_CORTEX_A57:
> -		/* Currently handled by the generic backend */
> -		return KVM_ARM_TARGET_CORTEX_A57;
> +	switch (implementor) {
> +	case ARM_CPU_IMP_ARM:
> +		switch (part_number) {
> +		case ARM_CPU_PART_AEM_V8:
> +			return KVM_ARM_TARGET_AEM_V8;
> +		case ARM_CPU_PART_FOUNDATION:
> +			return KVM_ARM_TARGET_FOUNDATION_V8;
> +		case ARM_CPU_PART_CORTEX_A57:
> +			return KVM_ARM_TARGET_CORTEX_A57;
> +		default:
> +			return -EINVAL;
> +		}
> +		break;
> +	case ARM_CPU_IMP_APM:
> +		switch (part_number) {
> +		case APM_CPU_PART_POTENZA:
> +			return KVM_ARM_TARGET_XGENE_V8;

Why don't we have KVM_ARM_TARGET_XGENE_POTENZA (or something similar)
instead? I don't expect all the X-Gene CPUs to be the same forever...

	M.
-- 
Jazz is not dead. It just smells funny...
