From: will.deacon@arm.com (Will Deacon)
Date: Tue, 30 Apr 2013 15:30:01 +0100
Subject: [PATCH 3/4] ARM: KVM: relax cache maintainance when building
 page pables
In-Reply-To: <1367331446-28030-4-git-send-email-marc.zyngier@arm.com>
References: <1367331446-28030-1-git-send-email-marc.zyngier@arm.com>
 <1367331446-28030-4-git-send-email-marc.zyngier@arm.com>
Message-ID: <20130430143001.GA6001@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 30, 2013 at 03:17:25PM +0100, Marc Zyngier wrote:
> Patch 5a677ce044f1 (ARM: KVM: switch to a dual-step HYP init code)
> introduced code that flushes page tables to the point of coherency.
> This is overkill (point of unification is enough), and actually
> not required if running on a SMP capable platform.
> 
> Change this code to use clean_dcache_area(), which is updated by
> ae8a8b9553bd (ARM: 7691/1: mm: kill unused TLB_CAN_READ_FROM_L1_CACHE
> and use ALT_SMP instead) to behave as a no-op on SMP ARMv7.
> 
> Reported-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm/include/asm/kvm_mmu.h | 1 +
>  arch/arm/kvm/mmu.c             | 6 +++---
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
> index 472ac70..2459821 100644
> --- a/arch/arm/include/asm/kvm_mmu.h
> +++ b/arch/arm/include/asm/kvm_mmu.h
> @@ -129,6 +129,7 @@ static inline void coherent_icache_guest_page(struct kvm *kvm, gfn_t gfn)
>  }
>  
>  #define kvm_flush_dcache_to_poc(a,l)	__cpuc_flush_dcache_area((a), (l))
> +#define kvm_clean_dcache_to_pou(a,l)	clean_dcache_area((a), (l))

I don't think the name helps, since this sounds like it could be used for
things other than flushing page tables (for example, writing instructions)
but apart from that:

  Reviewed-by: Will Deacon <will.deacon@arm.com>

Will
