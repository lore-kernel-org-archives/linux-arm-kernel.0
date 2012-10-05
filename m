From: mingyu84.kim@samsung.com (Min-gyu Kim)
Date: Fri, 05 Oct 2012 11:23:30 +0900
Subject: [PATCH v2 06/14] KVM: ARM: Memory virtualization setup
In-Reply-To: <20121001091042.49198.93241.stgit@ubuntu>
References: <20121001090945.49198.68950.stgit@ubuntu>
 <20121001091042.49198.93241.stgit@ubuntu>
Message-ID: <000401cda2a0$69670a40$3c351ec0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: kvm-owner at vger.kernel.org [mailto:kvm-owner at vger.kernel.org] On
> Behalf Of Christoffer Dall
> Sent: Monday, October 01, 2012 6:11 PM
> To: kvm at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> kvmarm at lists.cs.columbia.edu
> Cc: Marc Zyngier
> Subject: [PATCH v2 06/14] KVM: ARM: Memory virtualization setup
> 
> +static void stage2_set_pte(struct kvm *kvm, struct kvm_mmu_memory_cache
> *cache,
> +			   phys_addr_t addr, const pte_t *new_pte) {
> +	pgd_t *pgd;
> +	pud_t *pud;
> +	pmd_t *pmd;
> +	pte_t *pte, old_pte;
> +
> +	/* Create 2nd stage page table mapping - Level 1 */
> +	pgd = kvm->arch.pgd + pgd_index(addr);
> +	pud = pud_offset(pgd, addr);
> +	if (pud_none(*pud)) {
> +		if (!cache)
> +			return; /* ignore calls from kvm_set_spte_hva */
> +		pmd = mmu_memory_cache_alloc(cache);
> +		pud_populate(NULL, pud, pmd);
> +		pmd += pmd_index(addr);
> +		get_page(virt_to_page(pud));
> +	} else
> +		pmd = pmd_offset(pud, addr);
> +
> +	/* Create 2nd stage page table mapping - Level 2 */
> +	if (pmd_none(*pmd)) {
> +		if (!cache)
> +			return; /* ignore calls from kvm_set_spte_hva */
> +		pte = mmu_memory_cache_alloc(cache);
> +		clean_pte_table(pte);
> +		pmd_populate_kernel(NULL, pmd, pte);
> +		pte += pte_index(addr);
> +		get_page(virt_to_page(pmd));
> +	} else
> +		pte = pte_offset_kernel(pmd, addr);
> +
> +	/* Create 2nd stage page table mapping - Level 3 */
> +	old_pte = *pte;
> +	set_pte_ext(pte, *new_pte, 0);
> +	if (pte_present(old_pte))
> +		__kvm_tlb_flush_vmid(kvm);
> +	else
> +		get_page(virt_to_page(pte));
> +}


I'm not sure about the 3-level page table, but isn't it necessary to
clean the page table for 2nd level?
There are two mmu_memory_cache_alloc calls. One has following clean_pte_table
and the other doesn't have. 

And why do you ignore calls from kvm_set_spte_hva? It is supposed to happen when
host moves the page, right? Then you ignore the case because it can be handled
later when fault actually happens? Is there any other reason that I miss?
