From: anup@brainfault.org (Anup Patel)
Date: Tue, 26 Nov 2013 09:29:20 +0530
Subject: [PATCH 2/2] ARM/ARM64: KVM: Forward PSCI SYSTEM_OFF and
 SYSTEM_RESET to user space
In-Reply-To: <1385394599-15439-3-git-send-email-anup.patel@linaro.org>
References: <1385394599-15439-1-git-send-email-anup.patel@linaro.org>
 <1385394599-15439-3-git-send-email-anup.patel@linaro.org>
Message-ID: <CAAhSdy1NQnkNEjhA4PdP-OuAb76D1Kiir1tjoLCAHkCM2hkCPQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(Adding Christoffer, forgot to add him to CC)

On Mon, Nov 25, 2013 at 9:19 PM, Anup Patel <anup.patel@linaro.org> wrote:
> The PSCI SYSTEM_OFF and SYSTEM_RESET functions are system-level
> functions hence cannot be fully emulated by the in-kernel PSCI
> emulation code.
>
> To tackle this, we forward PSCI SYSTEM_OFF and SYSTEM_RESET function
> calls from guest to user space (i.e. QEMU or KVMTOOL) via KVM run
> structure using KVM_EXIT_SHUTDOWN and KVM_EXIT_RESET exit reasons.
>
> Signed-off-by: Anup Patel <anup.patel@linaro.org>
> Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
> ---
>  arch/arm/include/asm/kvm_psci.h   |    2 +-
>  arch/arm/include/uapi/asm/kvm.h   |    2 ++
>  arch/arm/kvm/handle_exit.c        |    7 ++++++-
>  arch/arm/kvm/psci.c               |   38 +++++++++++++++++++++++++++++--------
>  arch/arm64/include/asm/kvm_psci.h |    2 +-
>  arch/arm64/include/uapi/asm/kvm.h |    2 ++
>  arch/arm64/kvm/handle_exit.c      |   10 ++++++----
>  7 files changed, 48 insertions(+), 15 deletions(-)
>
> diff --git a/arch/arm/include/asm/kvm_psci.h b/arch/arm/include/asm/kvm_psci.h
> index 9a83d98..992d7f1 100644
> --- a/arch/arm/include/asm/kvm_psci.h
> +++ b/arch/arm/include/asm/kvm_psci.h
> @@ -18,6 +18,6 @@
>  #ifndef __ARM_KVM_PSCI_H__
>  #define __ARM_KVM_PSCI_H__
>
> -bool kvm_psci_call(struct kvm_vcpu *vcpu);
> +int kvm_psci_call(struct kvm_vcpu *vcpu);
>
>  #endif /* __ARM_KVM_PSCI_H__ */
> diff --git a/arch/arm/include/uapi/asm/kvm.h b/arch/arm/include/uapi/asm/kvm.h
> index c498b60..f4de20c 100644
> --- a/arch/arm/include/uapi/asm/kvm.h
> +++ b/arch/arm/include/uapi/asm/kvm.h
> @@ -172,6 +172,8 @@ struct kvm_arch_memory_slot {
>  #define KVM_PSCI_FN_CPU_OFF            KVM_PSCI_FN(1)
>  #define KVM_PSCI_FN_CPU_ON             KVM_PSCI_FN(2)
>  #define KVM_PSCI_FN_MIGRATE            KVM_PSCI_FN(3)
> +#define KVM_PSCI_FN_SYSTEM_OFF         KVM_PSCI_FN(4)
> +#define KVM_PSCI_FN_SYSTEM_RESET       KVM_PSCI_FN(5)
>
>  #define KVM_PSCI_RET_SUCCESS           0
>  #define KVM_PSCI_RET_NI                        ((unsigned long)-1)
> diff --git a/arch/arm/kvm/handle_exit.c b/arch/arm/kvm/handle_exit.c
> index a920790..c96c7e8 100644
> --- a/arch/arm/kvm/handle_exit.c
> +++ b/arch/arm/kvm/handle_exit.c
> @@ -40,11 +40,16 @@ static int handle_svc_hyp(struct kvm_vcpu *vcpu, struct kvm_run *run)
>
>  static int handle_hvc(struct kvm_vcpu *vcpu, struct kvm_run *run)
>  {
> +       int ret;
> +
>         trace_kvm_hvc(*vcpu_pc(vcpu), *vcpu_reg(vcpu, 0),
>                       kvm_vcpu_hvc_get_imm(vcpu));
>
> -       if (kvm_psci_call(vcpu))
> +       ret = kvm_psci_call(vcpu);
> +       if (ret == 0)
>                 return 1;
> +       else if (ret > 0)
> +               return 0;
>
>         kvm_inject_undefined(vcpu);
>         return 1;
> diff --git a/arch/arm/kvm/psci.c b/arch/arm/kvm/psci.c
> index 0881bf1..c8d3fcd 100644
> --- a/arch/arm/kvm/psci.c
> +++ b/arch/arm/kvm/psci.c
> @@ -84,18 +84,31 @@ static unsigned long kvm_psci_vcpu_on(struct kvm_vcpu *source_vcpu)
>         return KVM_PSCI_RET_SUCCESS;
>  }
>
> +static void kvm_psci_system_off(struct kvm_vcpu *vcpu)
> +{
> +       vcpu->run->exit_reason = KVM_EXIT_SHUTDOWN;
> +}
> +
> +static void kvm_psci_system_reset(struct kvm_vcpu *vcpu)
> +{
> +       vcpu->run->exit_reason = KVM_EXIT_RESET;
> +}
> +
>  /**
>   * kvm_psci_call - handle PSCI call if r0 value is in range
>   * @vcpu: Pointer to the VCPU struct
>   *
>   * Handle PSCI calls from guests through traps from HVC instructions.
> - * The calling convention is similar to SMC calls to the secure world where
> - * the function number is placed in r0 and this function returns true if the
> - * function number specified in r0 is withing the PSCI range, and false
> - * otherwise.
> + * The calling convention is similar to SMC calls to the secure world
> + * where the function number is placed in r0 and function number
> + * specified in r0 is withing the PSCI range.
> + *
> + * This function returns: 0 (success), > 0 (success but exit to user
> + * space), and < 0 (failure)
>   */
> -bool kvm_psci_call(struct kvm_vcpu *vcpu)
> +int kvm_psci_call(struct kvm_vcpu *vcpu)
>  {
> +       int ret = 0;
>         unsigned long psci_fn = *vcpu_reg(vcpu, 0) & ~((u32) 0);
>         unsigned long val;
>
> @@ -111,11 +124,20 @@ bool kvm_psci_call(struct kvm_vcpu *vcpu)
>         case KVM_PSCI_FN_MIGRATE:
>                 val = KVM_PSCI_RET_NI;
>                 break;
> -
> +       case KVM_PSCI_FN_SYSTEM_OFF:
> +               kvm_psci_system_off(vcpu);
> +               val = KVM_PSCI_RET_SUCCESS;
> +               ret = 1;
> +               break;
> +       case KVM_PSCI_FN_SYSTEM_RESET:
> +               kvm_psci_system_reset(vcpu);
> +               val = KVM_PSCI_RET_SUCCESS;
> +               ret = 1;
> +               break;
>         default:
> -               return false;
> +               return -EINVAL;
>         }
>
>         *vcpu_reg(vcpu, 0) = val;
> -       return true;
> +       return ret;
>  }
> diff --git a/arch/arm64/include/asm/kvm_psci.h b/arch/arm64/include/asm/kvm_psci.h
> index e301a48..9bd0ee8 100644
> --- a/arch/arm64/include/asm/kvm_psci.h
> +++ b/arch/arm64/include/asm/kvm_psci.h
> @@ -18,6 +18,6 @@
>  #ifndef __ARM64_KVM_PSCI_H__
>  #define __ARM64_KVM_PSCI_H__
>
> -bool kvm_psci_call(struct kvm_vcpu *vcpu);
> +int kvm_psci_call(struct kvm_vcpu *vcpu);
>
>  #endif /* __ARM64_KVM_PSCI_H__ */
> diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
> index d9f026b..f678902 100644
> --- a/arch/arm64/include/uapi/asm/kvm.h
> +++ b/arch/arm64/include/uapi/asm/kvm.h
> @@ -158,6 +158,8 @@ struct kvm_arch_memory_slot {
>  #define KVM_PSCI_FN_CPU_OFF            KVM_PSCI_FN(1)
>  #define KVM_PSCI_FN_CPU_ON             KVM_PSCI_FN(2)
>  #define KVM_PSCI_FN_MIGRATE            KVM_PSCI_FN(3)
> +#define KVM_PSCI_FN_SYSTEM_OFF         KVM_PSCI_FN(4)
> +#define KVM_PSCI_FN_SYSTEM_RESET       KVM_PSCI_FN(5)
>
>  #define KVM_PSCI_RET_SUCCESS           0
>  #define KVM_PSCI_RET_NI                        ((unsigned long)-1)
> diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
> index 8da5606..a5b5b6a 100644
> --- a/arch/arm64/kvm/handle_exit.c
> +++ b/arch/arm64/kvm/handle_exit.c
> @@ -30,8 +30,13 @@ typedef int (*exit_handle_fn)(struct kvm_vcpu *, struct kvm_run *);
>
>  static int handle_hvc(struct kvm_vcpu *vcpu, struct kvm_run *run)
>  {
> -       if (kvm_psci_call(vcpu))
> +       int ret;
> +
> +       ret = kvm_psci_call(vcpu);
> +       if (ret == 0)
>                 return 1;
> +       else if (ret > 0)
> +               return 0;
>
>         kvm_inject_undefined(vcpu);
>         return 1;
> @@ -39,9 +44,6 @@ static int handle_hvc(struct kvm_vcpu *vcpu, struct kvm_run *run)
>
>  static int handle_smc(struct kvm_vcpu *vcpu, struct kvm_run *run)
>  {
> -       if (kvm_psci_call(vcpu))
> -               return 1;
> -
>         kvm_inject_undefined(vcpu);
>         return 1;
>  }
> --
> 1.7.9.5
>
> _______________________________________________
> kvmarm mailing list
> kvmarm at lists.cs.columbia.edu
> https://lists.cs.columbia.edu/cucslists/listinfo/kvmarm
