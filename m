From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Wed, 7 Jan 2015 10:54:01 +0000
Subject: [PATCH] arm64: KVM: Fix HCR setting for 32bit guests
In-Reply-To: <1420627503-25183-1-git-send-email-marc.zyngier@arm.com>
References: <1420627503-25183-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <54AD1049.9050202@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On 07/01/15 10:45, Marc Zyngier wrote:
> Commit b856a59141b1 (arm/arm64: KVM: Reset the HCR on each vcpu
> when resetting the vcpu) moved the init of the HCR register to
> happen later in the init of a vcpu, but left out the fixup
> done in kvm_reset_vcpu when preparing for a 32bit guest.
>
> As a result, the 32bit guest is run as a 64bit guest, but the
> rest of the kernel still manages it as a 32bit. Fun follows.
>
> Moving the fixup to vcpu_reset_hcr solves the problem for good.
>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm64/include/asm/kvm_emulate.h | 2 ++
>  arch/arm64/kvm/reset.c               | 1 -
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
> index 8127e45..36dcef6 100644
> --- a/arch/arm64/include/asm/kvm_emulate.h
> +++ b/arch/arm64/include/asm/kvm_emulate.h
> @@ -41,6 +41,8 @@ void kvm_inject_pabt(struct kvm_vcpu *vcpu, unsigned long addr);
>  static inline void vcpu_reset_hcr(struct kvm_vcpu *vcpu)
>  {
>       vcpu->arch.hcr_el2 = HCR_GUEST_FLAGS;
> +     if (test_bit(KVM_ARM_VCPU_EL1_32BIT, vcpu->arch.features))
                                                                  ^
                                                   whitespace is here

Vladimir

> +             vcpu->arch.hcr_el2 &= ~HCR_RW;
>  }
>
>  static inline unsigned long *vcpu_pc(const struct kvm_vcpu *vcpu)
> diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
> index 70a7816..0b43265 100644
> --- a/arch/arm64/kvm/reset.c
> +++ b/arch/arm64/kvm/reset.c
> @@ -90,7 +90,6 @@ int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
>                       if (!cpu_has_32bit_el1())
>                               return -EINVAL;
>                       cpu_reset = &default_regs_reset32;
> -                     vcpu->arch.hcr_el2 &= ~HCR_RW;
>               } else {
>                       cpu_reset = &default_regs_reset;
>               }
>


-- IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium.  Thank you.

ARM Limited, Registered office 110 Fulbourn Road, Cambridge CB1 9NJ, Registered in England & Wales, Company No:  2557590
ARM Holdings plc, Registered office 110 Fulbourn Road, Cambridge CB1 9NJ, Registered in England & Wales, Company No:  2548782
