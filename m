From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 02 Feb 2011 15:48:21 -0500 (EST)
Subject: [PATCH v2] ARM: kexec: selective MMU identity mapping
In-Reply-To: <1296657809-1589-1-git-send-email-per.xx.fransson@stericsson.com>
References: <1296657809-1589-1-git-send-email-per.xx.fransson@stericsson.com>
Message-ID: <alpine.LFD.2.00.1102021444530.8212@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2 Feb 2011, Per Fransson wrote:

> When restarting using the kernel kexec functionality the MMU
> needs to be turned off. Any code which does this needs to use
> identity mapped addresses to get reliable results. In the ARM
> kexec case this identity mapping is done:
> 
> - using the page table of the current task
> 
> - for all addresses normally used by user space,
>   i.e. 0x00000000-PAGE_OFFSET
> 
> If kexec is used at a kernel crash to collect a core dump this
> means that we lose important information.

setup_mm_for_reboot is rather heavy handed indeed.

> This is what this patches does:
> 
> * Actually turns off the MMU, which has been omitted by mistake

Please make this into a patch of its own.

> * Sets up a more selective identity mapping
> 
> * Restores the old mapping once the MMU is off
> 
> Signed-off-by: Per Fransson <per.xx.fransson@stericsson.com>

More comments below.

> ---
> v2 changes:
> 
> * now uses (modified versions of) the identity mapping functions in idmap.c
>   as they look in 2.6.38-rc1. Some pud-level code has been added there in
>   linux-next.
> 
>  arch/arm/include/asm/pgtable.h    |    4 +++-
>  arch/arm/kernel/machine_kexec.c   |   26 +++++++++++++++++++++-----
>  arch/arm/kernel/relocate_kernel.S |   23 +++++++++++++++++++++++
>  arch/arm/kernel/smp.c             |    7 ++++---
>  arch/arm/mm/idmap.c               |   20 +++++++++++++++-----
>  arch/arm/mm/proc-v7.S             |    4 ++++
>  include/linux/kexec.h             |    6 +++++-
>  7 files changed, 75 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
> index ebcb643..08dd591 100644
> --- a/arch/arm/include/asm/pgtable.h
> +++ b/arch/arm/include/asm/pgtable.h
> @@ -458,6 +458,7 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
>  #define kern_addr_valid(addr)	(1)
>  
>  #include <asm-generic/pgtable.h>
> +#include <linux/kexec.h>
>  
>  /*
>   * We provide our own arch_get_unmapped_area to cope with VIPT caches.
> @@ -473,7 +474,8 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
>  
>  #define pgtable_cache_init() do { } while (0)
>  
> -void identity_mapping_add(pgd_t *, unsigned long, unsigned long);
> +void identity_mapping_add(pgd_t *, unsigned long, unsigned long,
> +			  struct kexec_mmu_ent *);

I would try to avoid contaminating such a generic function with kexec 
specific structures.

>  void identity_mapping_del(pgd_t *, unsigned long, unsigned long);
>  
>  #endif /* !__ASSEMBLY__ */
> diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
> index 30ead13..bd53684 100644
> --- a/arch/arm/kernel/machine_kexec.c
> +++ b/arch/arm/kernel/machine_kexec.c
> @@ -16,8 +16,6 @@
>  extern const unsigned char relocate_new_kernel[];
>  extern const unsigned int relocate_new_kernel_size;
>  
> -extern void setup_mm_for_reboot(char mode);
> -
>  extern unsigned long kexec_start_address;
>  extern unsigned long kexec_indirection_page;
>  extern unsigned long kexec_mach_type;
> @@ -79,9 +77,9 @@ void machine_kexec(struct kimage *image)
>  {
>  	unsigned long page_list;
>  	unsigned long reboot_code_buffer_phys;
> +	unsigned long cpu_reset_phys;
>  	void *reboot_code_buffer;
>  
> -
>  	page_list = image->head & PAGE_MASK;
>  
>  	/* we need both effective and real address here */
> @@ -95,18 +93,36 @@ void machine_kexec(struct kimage *image)
>  	kexec_mach_type = machine_arch_type;
>  	kexec_boot_atags = image->start - KEXEC_ARM_ZIMAGE_OFFSET + KEXEC_ARM_ATAGS_OFFSET;
>  
> +	/* Identity map the code which turns off the mmu (cpu_reset) and
> +	   the code which will be executed immediately afterwards
> +	   (relocate_new_kernel).
> +	   Store the old entries so they can be restored. */
> +	/* cpu_reset cannot be used directly when MULTI_CPU is true, see
> +	   cpu-multi32.h, instead processor.reset will have to be used */
> +#ifdef MULTI_CPU
> +	cpu_reset_phys = virt_to_phys(processor.reset);
> +#else
> +	cpu_reset_phys = virt_to_phys(cpu_reset);
> +#endif

Why not always using processor.reset in all cases instead?

> +
> +	identity_mapping_add(current->active_mm->pgd, cpu_reset_phys,
> +			     ALIGN(cpu_reset_phys, PGDIR_SIZE)+PGDIR_SIZE,
> +			     &kexec_mmu_ents[0]);
> +	identity_mapping_add(current->active_mm->pgd, reboot_code_buffer_phys,
> +			     ALIGN(reboot_code_buffer_phys, PGDIR_SIZE)
> +			     + PGDIR_SIZE, &kexec_mmu_ents[2]);
> +	local_flush_tlb_all();
> +
>  	/* copy our kernel relocation code to the control code page */
>  	memcpy(reboot_code_buffer,
>  	       relocate_new_kernel, relocate_new_kernel_size);
>  
> -
>  	flush_icache_range((unsigned long) reboot_code_buffer,
>  			   (unsigned long) reboot_code_buffer + KEXEC_CONTROL_PAGE_SIZE);
>  	printk(KERN_INFO "Bye!\n");
>  
>  	local_irq_disable();
>  	local_fiq_disable();
> -	setup_mm_for_reboot(0); /* mode is not used, so just pass 0*/
>  	flush_cache_all();
>  	outer_flush_all();
>  	outer_disable();
> diff --git a/arch/arm/kernel/relocate_kernel.S b/arch/arm/kernel/relocate_kernel.S
> index 9cf4cbf..a5e155e 100644
> --- a/arch/arm/kernel/relocate_kernel.S
> +++ b/arch/arm/kernel/relocate_kernel.S
> @@ -7,6 +7,24 @@
>  	.globl relocate_new_kernel
>  relocate_new_kernel:
>  
> +	/* We get here when the MMU is in a transitional state.
> +	   Wait for the virtual address mapping to wear off before
> +	   overwriting the identity mappings (set up for the sake
> +	   of MMU disabling) with the previous mappings. */
> +	ldr	r0, =100
> +0:
> +	subs	r0, r0, #1
> +	beq	0b

Two problems here:

1) This will never loop as you load r0 with 100, decrement it once, and 
   then test for zero to branch back, which at this point it won't.

2) There is certainly a better architecturally defined way to ensure the 
   MMU is actually disabled, such as reading back the control register 
   and queuing a data dependency on the register it was read into?

In any case, given that the loop in 1) above is broken, we can assume 
this wasn't needed anyway in your testing.

> +
> +	adr	r0, kexec_mmu_ents
> +	.rept 4
> +	ldr	r1, [r0], #4
> +	ldr	r2, [r0], #4
> +	str	r2, [r1], #4
> +	ldr	r2, [r0], #4
> +	str	r2, [r1], #4
> +	.endr

This is burying knowledge about the pmd implementation a bit too deep.  
If the pmd implementation changes, such as with the A15 page table 
format, then this may easily be missed.  Better create a generic copy 
list with <data_size><data_dest_addr><data...> and zero terminate it.  
This would also allow for a variable number of pmds to restore, as right 
now your code won't work as expected if the identity mapping is crossing 
a pmd boundary.

> +
>  	ldr	r0,kexec_indirection_page
>  	ldr	r1,kexec_start_address
>  
> @@ -69,6 +87,11 @@ kexec_start_address:
>  kexec_indirection_page:
>  	.long	0x0
>  
> +	.globl kexec_mmu_ents
> +kexec_mmu_ents:
> +	.space 4*12, 0
> +
> +
>  	.globl kexec_mach_type
>  kexec_mach_type:
>  	.long	0x0
> diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
> index 4539ebc..607b6a8 100644
> --- a/arch/arm/kernel/smp.c
> +++ b/arch/arm/kernel/smp.c
> @@ -93,10 +93,11 @@ int __cpuinit __cpu_up(unsigned int cpu)
>  
>  	if (PHYS_OFFSET != PAGE_OFFSET) {
>  #ifndef CONFIG_HOTPLUG_CPU
> -		identity_mapping_add(pgd, __pa(__init_begin), __pa(__init_end));
> +		identity_mapping_add(pgd, __pa(__init_begin), __pa(__init_end),
> +				     NULL);
>  #endif
> -		identity_mapping_add(pgd, __pa(_stext), __pa(_etext));
> -		identity_mapping_add(pgd, __pa(_sdata), __pa(_edata));
> +		identity_mapping_add(pgd, __pa(_stext), __pa(_etext), NULL);
> +		identity_mapping_add(pgd, __pa(_sdata), __pa(_edata), NULL);
>  	}
>  
>  	/*
> diff --git a/arch/arm/mm/idmap.c b/arch/arm/mm/idmap.c
> index 5729944..d5d313d 100644
> --- a/arch/arm/mm/idmap.c
> +++ b/arch/arm/mm/idmap.c
> @@ -1,14 +1,19 @@
>  #include <linux/kernel.h>
> +#include <linux/kexec.h>
>  
>  #include <asm/cputype.h>
>  #include <asm/pgalloc.h>
>  #include <asm/pgtable.h>
>  
>  static void idmap_add_pmd(pgd_t *pgd, unsigned long addr, unsigned long end,
> -	unsigned long prot)
> +			  unsigned long prot, struct kexec_mmu_ent *store)
>  {
>  	pmd_t *pmd = pmd_offset(pgd, addr);
> -
> +	if (store) {
> +		pmd_t *pmd_store = pmd_offset(&store->store, addr);
> +		pmd_store[0] = pmd[0];
> +		pmd_store[1] = pmd[1];
> +	}
>  	addr = (addr & PMD_MASK) | prot;
>  	pmd[0] = __pmd(addr);
>  	addr += SECTION_SIZE;
> @@ -16,7 +21,8 @@ static void idmap_add_pmd(pgd_t *pgd, unsigned long addr, unsigned long end,
>  	flush_pmd_entry(pmd);
>  }
>  
> -void identity_mapping_add(pgd_t *pgd, unsigned long addr, unsigned long end)
> +void identity_mapping_add(pgd_t *pgd, unsigned long addr, unsigned long end,
> +			  struct kexec_mmu_ent *store)
>  {
>  	unsigned long prot, next;
>  
> @@ -27,7 +33,11 @@ void identity_mapping_add(pgd_t *pgd, unsigned long addr, unsigned long end)
>  	pgd += pgd_index(addr);
>  	do {
>  		next = pgd_addr_end(addr, end);
> -		idmap_add_pmd(pgd, addr, next, prot);
> +		idmap_add_pmd(pgd, addr, next, prot, store);
> +		if (store) {
> +			store->ptr = (pgd_t *)virt_to_phys(pgd);
> +			store++;
> +		}
>  	} while (pgd++, addr = next, addr != end);
>  }
>  
> @@ -62,6 +72,6 @@ void setup_mm_for_reboot(char mode)
>  	 * we don't have any user-mode mappings so we use the context that we
>  	 * "borrowed".
>  	 */
> -	identity_mapping_add(current->active_mm->pgd, 0, TASK_SIZE);
> +	identity_mapping_add(current->active_mm->pgd, 0, TASK_SIZE, NULL);
>  	local_flush_tlb_all();
>  }
> diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
> index 0c1172b..762bb43 100644
> --- a/arch/arm/mm/proc-v7.S
> +++ b/arch/arm/mm/proc-v7.S
> @@ -61,6 +61,10 @@ ENDPROC(cpu_v7_proc_fin)
>   */
>  	.align	5
>  ENTRY(cpu_v7_reset)
> +	sub	pc, pc, #PAGE_OFFSET+4		@ go to physical addresses
> +	mrc	p15, 0, ip, c1, c0, 0		@ ctrl register
> +	bic	ip, ip, #0x0001			@ ...............m
> +	mcr	p15, 0, ip, c1, c0, 0		@ ctrl register
>  	mov	pc, r0
>  ENDPROC(cpu_v7_reset)
>  
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 03e8e8d..6a1345b 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -106,7 +106,11 @@ struct kimage {
>  #endif
>  };
>  
> -
> +struct kexec_mmu_ent {
> +	pgd_t *ptr;
> +	pgd_t store;
> +};
> +extern struct kexec_mmu_ent kexec_mmu_ents[4];
>  
>  /* kexec interface functions */
>  extern void machine_kexec(struct kimage *image);
> -- 
> 1.7.3.2
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
