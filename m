From: jintack@cs.columbia.edu (Jintack Lim)
Date: Tue, 18 Jul 2017 22:24:37 -0400
Subject: [RFC PATCH v2 37/38] KVM: arm64: Respect the virtual HCR_EL2.NV1
 bit setting
In-Reply-To: <1500397144-16232-38-git-send-email-jintack.lim@linaro.org>
References: <1500397144-16232-1-git-send-email-jintack.lim@linaro.org>
 <1500397144-16232-38-git-send-email-jintack.lim@linaro.org>
Message-ID: <CAHyh4xhj0tqMMFz8N1Xrx9Z=Ltwh4DKB_ARnsSfc=iP7=R9grQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 18, 2017 at 12:59 PM, Jintack Lim <jintack.lim@linaro.org> wrote:
> Forward ELR_EL1, SPSR_EL1 and VBAR_EL1 traps to the virtual EL2 if the
> virtual HCR_EL2.NV bit is set.
>
> This is for recursive nested virtualization.
>
> Signed-off-by: Jintack Lim <jintack@cs.columbia.edu>

This should be linaro e-mail address. Will fix it.

> ---
>  arch/arm64/include/asm/kvm_arm.h |  1 +
>  arch/arm64/kvm/sys_regs.c        | 18 ++++++++++++++++++
>  2 files changed, 19 insertions(+)
>
> diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
> index aeaac4e..a1274b7 100644
> --- a/arch/arm64/include/asm/kvm_arm.h
> +++ b/arch/arm64/include/asm/kvm_arm.h
> @@ -23,6 +23,7 @@
>  #include <asm/types.h>
>
>  /* Hyp Configuration Register (HCR) bits */
> +#define HCR_NV1                (UL(1) << 43)
>  #define HCR_NV         (UL(1) << 42)
>  #define HCR_E2H                (UL(1) << 34)
>  #define HCR_ID         (UL(1) << 33)
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index 3e4ec5e..6f67666 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -1031,6 +1031,15 @@ static bool trap_el2_regs(struct kvm_vcpu *vcpu,
>         return true;
>  }
>
> +/* This function is to support the recursive nested virtualization */
> +static bool forward_nv1_traps(struct kvm_vcpu *vcpu, struct sys_reg_params *p)
> +{
> +       if (!vcpu_mode_el2(vcpu) && (vcpu_sys_reg(vcpu, HCR_EL2) & HCR_NV1))
> +               return true;
> +
> +       return false;
> +}
> +
>  static bool access_elr(struct kvm_vcpu *vcpu,
>                 struct sys_reg_params *p,
>                 const struct sys_reg_desc *r)
> @@ -1038,6 +1047,9 @@ static bool access_elr(struct kvm_vcpu *vcpu,
>         if (el12_reg(p) && forward_nv_traps(vcpu))
>                 return kvm_inject_nested_sync(vcpu, kvm_vcpu_get_hsr(vcpu));
>
> +       if (!el12_reg(p) && forward_nv1_traps(vcpu, p))
> +               return kvm_inject_nested_sync(vcpu, kvm_vcpu_get_hsr(vcpu));
> +
>         access_rw(p, &vcpu->arch.ctxt.gp_regs.elr_el1);
>         return true;
>  }
> @@ -1049,6 +1061,9 @@ static bool access_spsr(struct kvm_vcpu *vcpu,
>         if (el12_reg(p) && forward_nv_traps(vcpu))
>                 return kvm_inject_nested_sync(vcpu, kvm_vcpu_get_hsr(vcpu));
>
> +       if (!el12_reg(p) && forward_nv1_traps(vcpu, p))
> +               return kvm_inject_nested_sync(vcpu, kvm_vcpu_get_hsr(vcpu));
> +
>         access_rw(p, &vcpu->arch.ctxt.gp_regs.spsr[KVM_SPSR_EL1]);
>         return true;
>  }
> @@ -1060,6 +1075,9 @@ static bool access_vbar(struct kvm_vcpu *vcpu,
>         if (el12_reg(p) && forward_nv_traps(vcpu))
>                 return kvm_inject_nested_sync(vcpu, kvm_vcpu_get_hsr(vcpu));
>
> +       if (!el12_reg(p) && forward_nv1_traps(vcpu, p))
> +               return kvm_inject_nested_sync(vcpu, kvm_vcpu_get_hsr(vcpu));
> +
>         access_rw(p, &vcpu_sys_reg(vcpu, r->reg));
>         return true;
>  }
> --
> 1.9.1
>
