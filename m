From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 26 Apr 2013 12:05:58 +0100
Subject: [PATCH v4 5/7] ARM: KVM: rework HYP page table freeing
In-Reply-To: <1365790327-2138-6-git-send-email-marc.zyngier@arm.com>
References: <1365790327-2138-1-git-send-email-marc.zyngier@arm.com>
 <1365790327-2138-6-git-send-email-marc.zyngier@arm.com>
Message-ID: <20130426110558.GE5007@localhost.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 12, 2013 at 07:12:05PM +0100, Marc Zyngier wrote:
> diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
> index bfc5927..7464824 100644
> --- a/arch/arm/kvm/mmu.c
> +++ b/arch/arm/kvm/mmu.c
...
> +static void clear_pmd_entry(pmd_t *pmd)
> +{
> +	pte_t *pte_table = pte_offset_kernel(pmd, 0);
> +	pmd_clear(pmd);
> +	pte_free_kernel(NULL, pte_table);
> +	put_page(virt_to_page(pmd));
> +}
...
>  static void unmap_stage2_range(struct kvm *kvm, phys_addr_t start, u64 size)

Is there a chance that this function (or the other unmapping function
for Hyp pages) is called on an active stage 2 table (VTTBR pointing to
this pgd)? If yes, than you probably have to follow the mmu_gather
mechanism of freeing page table pages to avoid speculative loads.
Basically flushing the TLB between pmd_clear and pte_free_kernel.

-- 
Catalin
