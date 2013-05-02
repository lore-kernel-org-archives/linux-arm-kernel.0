From: will.deacon@arm.com (Will Deacon)
Date: Thu, 2 May 2013 16:03:56 +0100
Subject: [PATCH v2 3/5] ARM: KVM: relax cache maintainance when building
 page tables
In-Reply-To: <1367505542-2231-4-git-send-email-marc.zyngier@arm.com>
References: <1367505542-2231-1-git-send-email-marc.zyngier@arm.com>
 <1367505542-2231-4-git-send-email-marc.zyngier@arm.com>
Message-ID: <20130502150355.GA25022@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 02, 2013 at 03:39:00PM +0100, Marc Zyngier wrote:
> Patch 5a677ce044f1 (ARM: KVM: switch to a dual-step HYP init code)
> introduced code that flushes page tables to the point of coherency.
> This is overkill (point of unification is enough and already done),
> and actually not required if running on a SMP capable platform
> (the HW PTW can snoop other cpus' L1).
> 
> Remove this code and let ae8a8b9553bd (ARM: 7691/1: mm: kill unused
> TLB_CAN_READ_FROM_L1_CACHE and use ALT_SMP instead) turn it into
> a no-op for SMP ARMv7.
> 
> Reported-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm/kvm/mmu.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
> index 4a838db..d79b594 100644
> --- a/arch/arm/kvm/mmu.c
> +++ b/arch/arm/kvm/mmu.c
> @@ -234,7 +234,6 @@ static void create_hyp_pte_mappings(pmd_t *pmd, unsigned long start,
>  		pte = pte_offset_kernel(pmd, addr);
>  		kvm_set_pte(pte, pfn_pte(pfn, prot));
>  		get_page(virt_to_page(pte));
> -		kvm_flush_dcache_to_poc(pte, sizeof(*pte));
>  		pfn++;
>  	} while (addr += PAGE_SIZE, addr != end);

Could you remove the flushing code out of kvm_set_pte, then flush the range
after the loop? Then you get one flush and one barrier for the whole range.

Will
