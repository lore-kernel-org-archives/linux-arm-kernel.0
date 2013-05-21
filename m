From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 21 May 2013 16:16:04 +0100
Subject: [PATCH v4 16/32] arm64: KVM: HYP mode world switch implementation
In-Reply-To: <1368540840-26750-17-git-send-email-marc.zyngier@arm.com>
References: <1368540840-26750-1-git-send-email-marc.zyngier@arm.com>
 <1368540840-26750-17-git-send-email-marc.zyngier@arm.com>
Message-ID: <20130521151604.GH27002@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 14, 2013 at 03:13:44PM +0100, Marc Zyngier wrote:
> +// void __kvm_tlb_flush_vmid_ipa(struct kvm *kvm, phys_addr_t ipa);
> +ENTRY(__kvm_tlb_flush_vmid_ipa)
> +       kern_hyp_va     x0
> +       ldr     x2, [x0, #KVM_VTTBR]
> +       msr     vttbr_el2, x2
> +       isb
> +
> +       /*
> +        * We could do so much better if we had the VA as well.
> +        * Instead, we invalidate Stage-2 for this IPA, and the
> +        * whole of Stage-1. Weep...
> +        */
> +       tlbi    ipas2e1is, x1
> +       dsb     sy
> +       tlbi    vmalle1is
> +       dsb     sy
> +       isb
> +
> +       msr     vttbr_el2, xzr
> +       isb
> +       ret
> +ENDPROC(__kvm_tlb_flush_vmid_ipa)

There are some isbs here which could be removed if you need an eret
anyway.

> +ENTRY(__kvm_flush_vm_context)
> +       tlbi    alle1is
> +       ic      ialluis
> +       dsb     sy
> +       isb
> +       ret
> +ENDPROC(__kvm_flush_vm_context)

I didn't fully understand - why do we need I-cache maintenance here? Is
it for ASID-tagged VIVT I-cache?

BTW, the arch/arm equivalent has some better comments on this code ;).

-- 
Catalin
