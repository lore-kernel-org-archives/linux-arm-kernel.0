From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sun, 8 Jun 2014 14:05:22 +0200
Subject: [RESEND PATCH v7 3/4] arm: dirty log write protect management
 support
In-Reply-To: <1402076021-9425-1-git-send-email-m.smarduch@samsung.com>
References: <1401837567-5527-1-git-send-email-m.smarduch@samsung.com>
 <1402076021-9425-1-git-send-email-m.smarduch@samsung.com>
Message-ID: <20140608120522.GG3279@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 06, 2014 at 10:33:41AM -0700, Mario Smarduch wrote:
> kvm_vm_ioctl_get_dirty_log() is generic used by x86, ARM. x86 recent patch 
> changed this function, this patch picks up those changes, re-tested everything
> works. Applies cleanly with other patches.
> 
> This patch adds support for keeping track of VM dirty pages. As dirty page log
> is retrieved, the pages that have been written are write protected again for
> next write and log read.
> 
> Signed-off-by: Mario Smarduch <m.smarduch@samsung.com>
> ---
>  arch/arm/include/asm/kvm_host.h |    3 ++
>  arch/arm/kvm/arm.c              |    5 ---
>  arch/arm/kvm/mmu.c              |   79 +++++++++++++++++++++++++++++++++++
>  arch/x86/kvm/x86.c              |   86 ---------------------------------------
>  virt/kvm/kvm_main.c             |   86 +++++++++++++++++++++++++++++++++++++++
>  5 files changed, 168 insertions(+), 91 deletions(-)
> 
> diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
> index 59565f5..b760f9c 100644
> --- a/arch/arm/include/asm/kvm_host.h
> +++ b/arch/arm/include/asm/kvm_host.h
> @@ -232,5 +232,8 @@ u64 kvm_arm_timer_get_reg(struct kvm_vcpu *, u64 regid);
>  int kvm_arm_timer_set_reg(struct kvm_vcpu *, u64 regid, u64 value);
>  
>  void kvm_mmu_wp_memory_region(struct kvm *kvm, int slot);
> +void kvm_mmu_write_protect_pt_masked(struct kvm *kvm,
> +	struct kvm_memory_slot *slot,
> +	gfn_t gfn_offset, unsigned long mask);

Do all other architectures implement this function?  arm64?

>  
>  #endif /* __ARM_KVM_HOST_H__ */
> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
> index dfd63ac..f06fb21 100644
> --- a/arch/arm/kvm/arm.c
> +++ b/arch/arm/kvm/arm.c
> @@ -780,11 +780,6 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
>  	}
>  }
>  
> -int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log)
> -{
> -	return -EINVAL;
> -}
> -

What about the other architectures implementing this function?

>  static int kvm_vm_ioctl_set_device_addr(struct kvm *kvm,
>  					struct kvm_arm_device_addr *dev_addr)
>  {
> diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
> index e5dff85..907344c 100644
> --- a/arch/arm/kvm/mmu.c
> +++ b/arch/arm/kvm/mmu.c
> @@ -874,6 +874,85 @@ void kvm_mmu_wp_memory_region(struct kvm *kvm, int slot)
>  	spin_unlock(&kvm->mmu_lock);
>  }
>  
> +/**
> + * stage2_wp_mask_range() - write protect memslot pages set in mask
> + * @pmd - pointer to page table
> + * @start_ipa - the start range of mask
> + * @addr - start_ipa or start range of adjusted mask if crossing PMD range
> + * @mask - mask of dirty pages
> + *
> + * Walk mask and write protect the associated dirty pages in the memory region.
> + * If mask crosses a PMD range adjust it to next page table and return.
> + */
> +static void stage2_wp_mask_range(pmd_t *pmd, phys_addr_t start_ipa,
> +		phys_addr_t *addr, unsigned long *mask)
> +{
> +	pte_t *pte;
> +	bool crosses_pmd;
> +	int i = __ffs(*mask);
> +
> +	if (unlikely(*addr > start_ipa))
> +		start_ipa = *addr - i * PAGE_SIZE;

huh?

> +	pte = pte_offset_kernel(pmd, start_ipa);
> +	for (*addr = start_ipa + i * PAGE_SIZE; *mask;
> +		i = __ffs(*mask), *addr = start_ipa + i * PAGE_SIZE) {
> +		crosses_pmd = !!((start_ipa & PMD_MASK) ^ (*addr & PMD_MASK));
> +		if (unlikely(crosses_pmd)) {
> +			/* Adjust mask dirty bits relative to next page table */
> +			*mask >>= (PTRS_PER_PTE - pte_index(start_ipa));
> +			return;
> +		}
> +		if (!pte_none(pte[i]))
> +			kvm_set_s2pte_readonly(&pte[i]);
> +		*mask &= ~(1 << i);

This is *really* complicated, and *really* unintuitive and *really* hard
to read!

I feel this may very likely break, and is optimizing prematurely for
some very special case.  Can't you follow the usual scheme of traversing
the levels one-by-one and just calculate the 'end' address based on the
number of bits in your long, and just adjust the mask in the calling
function each time you are about to call a lower-level function?

In fact, I think this could be trivially implemented as an extension to
your existing wp_range functions.  On ARM you are mostly going to
consider 32 pages, on arm64 you are mostly going to consider 64 pages,
just calculate that range in terms of IPAs and set that as the limit for
calling stage2_wp_pgd_range (which should be factor'ed out into its
function and called from kvm_mmu_wp_memory_region).



> +	}
> +}
> +
> +/**
> + * kvm_mmu_write_protected_pt_masked() - write protect dirty pages set in mask
> + * @kvm:        The KVM pointer
> + * @slot:       The memory slot associated with mask
> + * @gfn_offset: The gfn offset in memory slot
> + * @mask:       The mask of dirty pages at offset 'gnf_offset' in this memory

s/gnf_offset/gfn_offset/

> + *              slot to be write protected
> + *
> + * Called from dirty page logging read function to write protect bits set in
> + * mask to record future writes to these pages in dirty page log. This function
> + * uses simplified page table walk given  mask can spawn no more then 2 PMD

random double white space before mask

> + * table range.
> + * 'kvm->mmu_lock' must be  held to protect against concurrent modification
> + * of page tables (2nd stage fault, mmu modifiers, ...)
> + *
> + */
> +void kvm_mmu_write_protect_pt_masked(struct kvm *kvm,
> +		struct kvm_memory_slot *slot,
> +		gfn_t gfn_offset, unsigned long mask)
> +{
> +	pud_t *pud;
> +	pmd_t *pmd;
> +	phys_addr_t start_ipa = (slot->base_gfn + gfn_offset) << PAGE_SHIFT;
> +	phys_addr_t end_ipa = start_ipa + BITS_PER_LONG * PAGE_SIZE;
> +	phys_addr_t addr = start_ipa;
> +	pgd_t *pgdp = kvm->arch.pgd, *pgd;
> +
> +	do {
> +		pgd = pgdp + pgd_index(addr);
> +		if (pgd_present(*pgd)) {
> +			pud = pud_offset(pgd, addr);
> +			if (!pud_none(*pud) && !pud_huge(*pud)) {
> +				pmd = pmd_offset(pud, addr);
> +				if (!pmd_none(*pmd) && !kvm_pmd_huge(*pmd))
> +					stage2_wp_mask_range(pmd, start_ipa,
> +								&addr, &mask);
> +				else
> +					addr += PMD_SIZE;
> +			} else
> +				addr += PUD_SIZE;

is this correct? what if your gfn_offset puts you at the last page of a
PUD, don't you need pud_addr_end() instead?

> +		} else
> +			addr += PGDIR_SIZE;

please use braces for both of the single-line else-clauses above when
the main if-clause is multi-line (see Documentation/CodingStyle chapter
3, just before 3.1).

> +	} while (mask && addr < end_ipa);

this seems like a complicated loop condition.  It seems to me that
either you clear all the bits in the mask you want to check or you check
for an address range, why is there a need for both?

> +}
> +
>  static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>  			  struct kvm_memory_slot *memslot,
>  			  unsigned long fault_status)

[...]

Thanks,
-Christoffer
