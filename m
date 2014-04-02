From: robherring2@gmail.com (Rob Herring)
Date: Wed, 2 Apr 2014 08:04:43 -0500
Subject: [PATCH v7 08/12] ARM/ARM64: KVM: Emulate PSCI v0.2 AFFINITY_INFO
In-Reply-To: <1396435347-20056-9-git-send-email-anup.patel@linaro.org>
References: <1396435347-20056-1-git-send-email-anup.patel@linaro.org>
 <1396435347-20056-9-git-send-email-anup.patel@linaro.org>
Message-ID: <CAL_JsqJAg1afXRL_CO9ukAUE7mW_ykr61XGhN_G_yFP-d5QoBw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 2, 2014 at 5:42 AM, Anup Patel <anup.patel@linaro.org> wrote:
> This patch adds emulation of PSCI v0.2 AFFINITY_INFO function call
> for KVM ARM/ARM64. This is a VCPU-level function call which will be
> used to determine current state of given affinity level.
>
> Signed-off-by: Anup Patel <anup.patel@linaro.org>
> Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
> Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
> ---
>  arch/arm/kvm/psci.c |   67 +++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 65 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/kvm/psci.c b/arch/arm/kvm/psci.c
> index b964aa4..5fccf0b 100644
> --- a/arch/arm/kvm/psci.c
> +++ b/arch/arm/kvm/psci.c
> @@ -27,6 +27,31 @@
>   * as described in ARM document number ARM DEN 0022A.
>   */
>
> +static unsigned long psci_affinity_mask(unsigned long affinity_level)
> +{
> +       unsigned long affinity_mask = MPIDR_HWID_BITMASK;
> +
> +       switch (affinity_level) {
> +       case 0: /* All affinity levels are valid */
> +               affinity_mask &= ~0x0UL;
> +               break;
> +       case 1: /* Aff0 ignored */
> +               affinity_mask &= ~0xFFUL;
> +               break;
> +       case 2: /* Aff0 and Aff1 ignored */
> +               affinity_mask &= ~0xFFFFUL;
> +               break;
> +       case 3: /* Aff0, Aff1, and Aff2 ignored */
> +               affinity_mask &= ~0xFFFFFFUL;
> +               break;
> +       default:
> +               affinity_mask = 0;
> +               break;
> +       };
> +
> +       return affinity_mask;

This function can be written as:

if (affinity_level <= 3)
    return MPIDR_HWID_BITMASK & ~GEN_MASK_ULL((affinity_level * 8) - 1, 0);

return 0;

> +}
> +
>  static void kvm_psci_vcpu_off(struct kvm_vcpu *vcpu)
>  {
>         vcpu->arch.pause = true;
> @@ -85,6 +110,42 @@ static unsigned long kvm_psci_vcpu_on(struct kvm_vcpu *source_vcpu)
>         return PSCI_RET_SUCCESS;
>  }
>
> +static unsigned long kvm_psci_vcpu_affinity_info(struct kvm_vcpu *vcpu)
> +{
> +       int i;
> +       unsigned long mpidr;
> +       unsigned long target_affinity;
> +       unsigned long target_affinity_mask;
> +       unsigned long lowest_affinity_level;
> +       struct kvm *kvm = vcpu->kvm;
> +       struct kvm_vcpu *tmp;
> +
> +       target_affinity = *vcpu_reg(vcpu, 1);
> +       lowest_affinity_level = *vcpu_reg(vcpu, 2);
> +
> +       /* Determine target affinity mask */
> +       target_affinity_mask = psci_affinity_mask(lowest_affinity_level);
> +       if (!target_affinity_mask)
> +               return PSCI_RET_INVALID_PARAMS;
> +
> +       /* Ignore other bits of target affinity */
> +       target_affinity &= target_affinity_mask;
> +
> +       /*
> +        * If one or more VCPU matching target affinity are running
> +        * then return 0 (ON) else return 1 (OFF)
> +        */
> +       kvm_for_each_vcpu(i, tmp, kvm) {
> +               mpidr = kvm_vcpu_get_mpidr(tmp);
> +               if (((mpidr & target_affinity_mask) == target_affinity) &&
> +                   !tmp->arch.pause) {
> +                       return 0;
> +               }
> +       }
> +
> +       return 1;
> +}
> +
>  static inline void kvm_prepare_system_event(struct kvm_vcpu *vcpu, u32 type)
>  {
>         memset(&vcpu->run->system_event, 0, sizeof(vcpu->run->system_event));
> @@ -132,6 +193,10 @@ static int kvm_psci_0_2_call(struct kvm_vcpu *vcpu)
>         case PSCI_0_2_FN64_CPU_ON:
>                 val = kvm_psci_vcpu_on(vcpu);
>                 break;
> +       case PSCI_0_2_FN_AFFINITY_INFO:
> +       case PSCI_0_2_FN64_AFFINITY_INFO:
> +               val = kvm_psci_vcpu_affinity_info(vcpu);
> +               break;
>         case PSCI_0_2_FN_SYSTEM_OFF:
>                 kvm_psci_system_off(vcpu);
>                 val = PSCI_RET_SUCCESS;
> @@ -143,12 +208,10 @@ static int kvm_psci_0_2_call(struct kvm_vcpu *vcpu)
>                 ret = 0;
>                 break;
>         case PSCI_0_2_FN_CPU_SUSPEND:
> -       case PSCI_0_2_FN_AFFINITY_INFO:
>         case PSCI_0_2_FN_MIGRATE:
>         case PSCI_0_2_FN_MIGRATE_INFO_TYPE:
>         case PSCI_0_2_FN_MIGRATE_INFO_UP_CPU:
>         case PSCI_0_2_FN64_CPU_SUSPEND:
> -       case PSCI_0_2_FN64_AFFINITY_INFO:
>         case PSCI_0_2_FN64_MIGRATE:
>         case PSCI_0_2_FN64_MIGRATE_INFO_UP_CPU:
>                 val = PSCI_RET_NOT_SUPPORTED;
> --
> 1.7.9.5
>
> _______________________________________________
> kvmarm mailing list
> kvmarm at lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
