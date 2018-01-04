From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 4 Jan 2018 16:31:36 +0000
Subject: [PATCH 11/11] arm64: Implement branch predictor hardening for
 affected Cortex-A CPUs
In-Reply-To: <1515078515-13723-12-git-send-email-will.deacon@arm.com>
References: <1515078515-13723-1-git-send-email-will.deacon@arm.com>
 <1515078515-13723-12-git-send-email-will.deacon@arm.com>
Message-ID: <CAKv+Gu8E=yWRE9PThFeG3efuT5JLbAK+RpmhTvuEeXwk-iuN9g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 January 2018 at 15:08, Will Deacon <will.deacon@arm.com> wrote:
> Cortex-A57, A72, A73 and A75 are susceptible to branch predictor aliasing
> and can theoretically be attacked by malicious code.
>
> This patch implements a PSCI-based mitigation for these CPUs when available.
> The call into firmware will invalidate the branch predictor state, preventing
> any malicious entries from affecting other victim contexts.
>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/kernel/bpi.S        | 24 ++++++++++++++++++++++++
>  arch/arm64/kernel/cpu_errata.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 66 insertions(+)
>
> diff --git a/arch/arm64/kernel/bpi.S b/arch/arm64/kernel/bpi.S
> index 06a931eb2673..2b10d52a0321 100644
> --- a/arch/arm64/kernel/bpi.S
> +++ b/arch/arm64/kernel/bpi.S
> @@ -53,3 +53,27 @@ ENTRY(__bp_harden_hyp_vecs_start)
>         vectors __kvm_hyp_vector
>         .endr
>  ENTRY(__bp_harden_hyp_vecs_end)
> +ENTRY(__psci_hyp_bp_inval_start)
> +       stp     x0, x1, [sp, #-16]!
> +       stp     x2, x3, [sp, #-16]!
> +       stp     x4, x5, [sp, #-16]!
> +       stp     x6, x7, [sp, #-16]!
> +       stp     x8, x9, [sp, #-16]!
> +       stp     x10, x11, [sp, #-16]!
> +       stp     x12, x13, [sp, #-16]!
> +       stp     x14, x15, [sp, #-16]!
> +       stp     x16, x17, [sp, #-16]!
> +       stp     x18, x19, [sp, #-16]!

Would it be better to update sp only once here?
Also, do x18 and x19 need to be preserved/restored here?

> +       mov     x0, #0x84000000
> +       smc     #0
> +       ldp     x18, x19, [sp], #16
> +       ldp     x16, x17, [sp], #16
> +       ldp     x14, x15, [sp], #16
> +       ldp     x12, x13, [sp], #16
> +       ldp     x10, x11, [sp], #16
> +       ldp     x8, x9, [sp], #16
> +       ldp     x6, x7, [sp], #16
> +       ldp     x4, x5, [sp], #16
> +       ldp     x2, x3, [sp], #16
> +       ldp     x0, x1, [sp], #16
> +ENTRY(__psci_hyp_bp_inval_end)
> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
> index 16ea5c6f314e..cb0fb3796bb8 100644
> --- a/arch/arm64/kernel/cpu_errata.c
> +++ b/arch/arm64/kernel/cpu_errata.c
> @@ -53,6 +53,8 @@ static int cpu_enable_trap_ctr_access(void *__unused)
>  DEFINE_PER_CPU_READ_MOSTLY(struct bp_hardening_data, bp_hardening_data);
>
>  #ifdef CONFIG_KVM
> +extern char __psci_hyp_bp_inval_start[], __psci_hyp_bp_inval_end[];
> +
>  static void __copy_hyp_vect_bpi(int slot, const char *hyp_vecs_start,
>                                 const char *hyp_vecs_end)
>  {
> @@ -94,6 +96,9 @@ static void __install_bp_hardening_cb(bp_hardening_cb_t fn,
>         spin_unlock(&bp_lock);
>  }
>  #else
> +#define __psci_hyp_bp_inval_start      NULL
> +#define __psci_hyp_bp_inval_end                NULL
> +
>  static void __install_bp_hardening_cb(bp_hardening_cb_t fn,
>                                       const char *hyp_vecs_start,
>                                       const char *hyp_vecs_end)
> @@ -118,6 +123,21 @@ static void  install_bp_hardening_cb(const struct arm64_cpu_capabilities *entry,
>
>         __install_bp_hardening_cb(fn, hyp_vecs_start, hyp_vecs_end);
>  }
> +
> +#include <linux/psci.h>
> +
> +static int enable_psci_bp_hardening(void *data)
> +{
> +       const struct arm64_cpu_capabilities *entry = data;
> +
> +       if (psci_ops.get_version)
> +               install_bp_hardening_cb(entry,
> +                                      (bp_hardening_cb_t)psci_ops.get_version,
> +                                      __psci_hyp_bp_inval_start,
> +                                      __psci_hyp_bp_inval_end);
> +
> +       return 0;
> +}
>  #endif /* CONFIG_HARDEN_BRANCH_PREDICTOR */
>
>  #define MIDR_RANGE(model, min, max) \
> @@ -261,6 +281,28 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
>                 MIDR_ALL_VERSIONS(MIDR_CORTEX_A73),
>         },
>  #endif
> +#ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
> +       {
> +               .capability = ARM64_HARDEN_BRANCH_PREDICTOR,
> +               MIDR_ALL_VERSIONS(MIDR_CORTEX_A57),
> +               .enable = enable_psci_bp_hardening,
> +       },
> +       {
> +               .capability = ARM64_HARDEN_BRANCH_PREDICTOR,
> +               MIDR_ALL_VERSIONS(MIDR_CORTEX_A72),
> +               .enable = enable_psci_bp_hardening,
> +       },
> +       {
> +               .capability = ARM64_HARDEN_BRANCH_PREDICTOR,
> +               MIDR_ALL_VERSIONS(MIDR_CORTEX_A73),
> +               .enable = enable_psci_bp_hardening,
> +       },
> +       {
> +               .capability = ARM64_HARDEN_BRANCH_PREDICTOR,
> +               MIDR_ALL_VERSIONS(MIDR_CORTEX_A75),
> +               .enable = enable_psci_bp_hardening,
> +       },
> +#endif
>         {
>         }
>  };
> --
> 2.1.4
>
