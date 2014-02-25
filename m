From: will.deacon@arm.com (Will Deacon)
Date: Tue, 25 Feb 2014 18:07:27 +0000
Subject: [PATCH 15/18] arm64: KVM: split GICv2 world switch from hyp code
In-Reply-To: <1391607050-540-16-git-send-email-marc.zyngier@arm.com>
References: <1391607050-540-1-git-send-email-marc.zyngier@arm.com>
 <1391607050-540-16-git-send-email-marc.zyngier@arm.com>
Message-ID: <20140225180727.GI23136@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 05, 2014 at 01:30:47PM +0000, Marc Zyngier wrote:
> Move the GICv2 world switch code into its own file, and add the
> necessary indirection to the arm64 switch code.
> 
> Also introduce a new type field to the vgic_params structure.
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm/include/asm/kvm_host.h   |   5 ++
>  arch/arm64/include/asm/kvm_asm.h  |   8 +++
>  arch/arm64/include/asm/kvm_host.h |  16 +++++
>  arch/arm64/kvm/Makefile           |   4 +-
>  arch/arm64/kvm/hyp.S              | 119 +++++---------------------------
>  arch/arm64/kvm/vgic-v2-switch.S   | 141 ++++++++++++++++++++++++++++++++++++++
>  include/kvm/arm_vgic.h            |   7 +-
>  virt/kvm/arm/vgic-v2.c            |  15 ++--
>  virt/kvm/arm/vgic.c               |   3 +
>  9 files changed, 208 insertions(+), 110 deletions(-)
>  create mode 100644 arch/arm64/kvm/vgic-v2-switch.S
> 
> diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
> index 098f7dd..228ae1c 100644
> --- a/arch/arm/include/asm/kvm_host.h
> +++ b/arch/arm/include/asm/kvm_host.h
> @@ -222,6 +222,11 @@ static inline int kvm_arch_dev_ioctl_check_extension(long ext)
>         return 0;
>  }
> 
> +static inline void vgic_arch_setup(const struct vgic_params *vgic)
> +{
> +       BUG_ON(vgic->type != VGIC_V2);
> +}
> +
>  int kvm_perf_init(void);
>  int kvm_perf_teardown(void);
> 
> diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
> index dddb345..e5fbdce 100644
> --- a/arch/arm64/include/asm/kvm_asm.h
> +++ b/arch/arm64/include/asm/kvm_asm.h
> @@ -104,6 +104,14 @@ extern void __kvm_flush_vm_context(void);
>  extern void __kvm_tlb_flush_vmid_ipa(struct kvm *kvm, phys_addr_t ipa);
> 
>  extern int __kvm_vcpu_run(struct kvm_vcpu *vcpu);
> +
> +/*
> + * These are really code, but as they do not use the PCS we don't
> + * describe them as functions...
> + */

I don't understand what the PCS has to do with anything.

> +extern char __save_vgic_v2_state[];
> +extern char __restore_vgic_v2_state[];
> +
>  #endif
> 
>  #endif /* __ARM_KVM_ASM_H__ */
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 0a1d697..b562d67 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -200,4 +200,20 @@ static inline void __cpu_init_hyp_mode(phys_addr_t boot_pgd_ptr,
>                      hyp_stack_ptr, vector_ptr);
>  }
> 
> +static inline void vgic_arch_setup(const struct vgic_params *vgic)
> +{
> +       extern char *__vgic_sr_vectors[2];
> +
> +       switch(vgic->type)
> +       {
> +       case VGIC_V2:
> +               __vgic_sr_vectors[0] = __save_vgic_v2_state;
> +               __vgic_sr_vectors[1] = __restore_vgic_v2_state;

If you make this array a struct then you can use asm_offsets to generate
indices for your asm.

Will
