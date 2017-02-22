From: cdall@linaro.org (Christoffer Dall)
Date: Wed, 22 Feb 2017 14:38:03 +0100
Subject: [RFC 35/55] KVM: arm/arm64: Support mmu for the virtual EL2
 execution
In-Reply-To: <1483943091-1364-36-git-send-email-jintack@cs.columbia.edu>
References: <1483943091-1364-1-git-send-email-jintack@cs.columbia.edu>
 <1483943091-1364-36-git-send-email-jintack@cs.columbia.edu>
Message-ID: <20170222133803.GU26976@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 09, 2017 at 01:24:31AM -0500, Jintack Lim wrote:
> From: Christoffer Dall <christoffer.dall@linaro.org>
> 
> When running a guest hypervisor in virtual EL2, the translation context
> has to be separate from the rest of the system, including the guest
> EL1/0 translation regime, so we allocate a separate VMID for this mode.
> 
> Considering that we have two different vttbr values due to separate
> VMIDs, it's racy to keep a vttbr value in a struct (kvm_s2_mmu) and
> share it between multiple vcpus. So, keep the vttbr value per vcpu.
> 
> Hypercalls to flush tlb now have vttbr as a parameter instead of mmu,
> since mmu structure does not have vttbr any more.
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> Signed-off-by: Jintack Lim <jintack@cs.columbia.edu>
> ---
>  arch/arm/include/asm/kvm_asm.h       |  6 ++--
>  arch/arm/include/asm/kvm_emulate.h   |  4 +++
>  arch/arm/include/asm/kvm_host.h      | 14 ++++++---
>  arch/arm/include/asm/kvm_mmu.h       | 11 +++++++
>  arch/arm/kvm/arm.c                   | 60 +++++++++++++++++++-----------------
>  arch/arm/kvm/hyp/switch.c            |  4 +--
>  arch/arm/kvm/hyp/tlb.c               | 15 ++++-----
>  arch/arm/kvm/mmu.c                   |  9 ++++--
>  arch/arm64/include/asm/kvm_asm.h     |  6 ++--
>  arch/arm64/include/asm/kvm_emulate.h |  8 +++++
>  arch/arm64/include/asm/kvm_host.h    | 14 ++++++---
>  arch/arm64/include/asm/kvm_mmu.h     | 11 +++++++
>  arch/arm64/kvm/hyp/switch.c          |  4 +--
>  arch/arm64/kvm/hyp/tlb.c             | 16 ++++------
>  14 files changed, 112 insertions(+), 70 deletions(-)
> 
> diff --git a/arch/arm/include/asm/kvm_asm.h b/arch/arm/include/asm/kvm_asm.h
> index 36e3856..aa214f7 100644
> --- a/arch/arm/include/asm/kvm_asm.h
> +++ b/arch/arm/include/asm/kvm_asm.h
> @@ -65,9 +65,9 @@
>  extern char __kvm_hyp_vector[];
>  
>  extern void __kvm_flush_vm_context(void);
> -extern void __kvm_tlb_flush_vmid_ipa(struct kvm_s2_mmu *mmu, phys_addr_t ipa);
> -extern void __kvm_tlb_flush_vmid(struct kvm_s2_mmu *mmu);
> -extern void __kvm_tlb_flush_local_vmid(struct kvm_s2_mmu *mmu);
> +extern void __kvm_tlb_flush_vmid_ipa(u64 vttbr, phys_addr_t ipa);
> +extern void __kvm_tlb_flush_vmid(u64 vttbr);
> +extern void __kvm_tlb_flush_local_vmid(u64 vttbr);
>  
>  extern int __kvm_vcpu_run(struct kvm_vcpu *vcpu);
>  
> diff --git a/arch/arm/include/asm/kvm_emulate.h b/arch/arm/include/asm/kvm_emulate.h
> index 05d5906..6285f4f 100644
> --- a/arch/arm/include/asm/kvm_emulate.h
> +++ b/arch/arm/include/asm/kvm_emulate.h
> @@ -305,4 +305,8 @@ static inline unsigned long vcpu_data_host_to_guest(struct kvm_vcpu *vcpu,
>  	}
>  }
>  
> +static inline struct kvm_s2_vmid *vcpu_get_active_vmid(struct kvm_vcpu *vcpu)
> +{
> +	return &vcpu->kvm->arch.mmu.vmid;
> +}
>  #endif /* __ARM_KVM_EMULATE_H__ */
> diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
> index f84a59c..da45394 100644
> --- a/arch/arm/include/asm/kvm_host.h
> +++ b/arch/arm/include/asm/kvm_host.h
> @@ -53,16 +53,18 @@
>  int kvm_reset_vcpu(struct kvm_vcpu *vcpu);
>  void kvm_reset_coprocs(struct kvm_vcpu *vcpu);
>  
> -struct kvm_s2_mmu {
> +struct kvm_s2_vmid {
>  	/* The VMID generation used for the virt. memory system */
>  	u64    vmid_gen;
>  	u32    vmid;
> +};
> +
> +struct kvm_s2_mmu {
> +	struct kvm_s2_vmid vmid;
> +	struct kvm_s2_vmid el2_vmid;

So this is subtle:  We use struct kvm_s2_mmu for the stage-2 context
used for the L1 VM, and for the L2 VM as well, right?  But only in the
first case can the el2_vmid have any valid meaning, and it's simply
ignored in other contexts.

Not sure if we can improve on this data structure design, but we could
at least add a comment on this somewhere.

Thanks,
-Christoffer
