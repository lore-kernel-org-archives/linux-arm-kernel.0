From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 7 Oct 2014 11:48:46 +0100
Subject: [PATCH v2 1/3] arm64: KVM: Implement 48 VA support for KVM EL2
 and Stage-2
In-Reply-To: <1412627427-28629-2-git-send-email-christoffer.dall@linaro.org>
References: <1412627427-28629-1-git-send-email-christoffer.dall@linaro.org>
 <1412627427-28629-2-git-send-email-christoffer.dall@linaro.org>
Message-ID: <20141007104846.GB12675@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 06, 2014 at 09:30:25PM +0100, Christoffer Dall wrote:
> +/**
> + * kvm_prealloc_hwpgd - allocate inital table for VTTBR
> + * @kvm:       The KVM struct pointer for the VM.
> + * @pgd:       The kernel pseudo pgd
> + *
> + * When the kernel uses more levels of page tables than the guest, we allocate
> + * a fake PGD and pre-populate it to point to the next-level page table, which
> + * will be the real initial page table pointed to by the VTTBR.
> + *
> + * When KVM_PREALLOC_LEVEL==2, we allocate a single page for the PMD and
> + * the kernel will use folded pud.  When KVM_PREALLOC_LEVEL==1, we
> + * allocate 2 consecutive PUD pages.
> + */
> +#if defined(CONFIG_ARM64_64K_PAGES) && CONFIG_ARM64_PGTABLE_LEVELS == 3
> +#define KVM_PREALLOC_LEVEL     2
> +#define PTRS_PER_S2_PGD                1
> +#define S2_PGD_ORDER           get_order(PTRS_PER_S2_PGD * sizeof(pgd_t))

I agree that my magic equation wasn't readable ;) (I had troubles
re-understanding it as well), but you also have some constants here that
are not immediately obvious where you got to them from. IIUC,
KVM_PREALLOC_LEVEL == 2 here means that the hardware only understands
stage 2 pmd and pte. I guess you could look into the ARM ARM tables but
it's still not clear.

Let's look at PTRS_PER_S2_PGD as I think it's simpler. My proposal was:

#if PGDIR_SHIFT > KVM_PHYS_SHIFT
#define PTRS_PER_S2_PGD			(1)
#else
#define PTRS_PER_S2_PGD			(1 << (KVM_PHYS_SHIFT - PGDIR_SHIFT))
#endif

In this case PGDIR_SHIFT is 42, so we get PTRS_PER_S2_PGD == 1. The 4K
and 4 levels case below is also correct.

The KVM start level calculation, we could assume that KVM needs either
host levels or host levels - 1 (unless we go for some weirdly small
KVM_PHYS_SHIFT). So we could define them KVM_PREALLOC_LEVEL as:

#if PTRS_PER_S2_PGD <= 16
#define KVM_PREALLOC_LEVEL	(4 - CONFIG_ARM64_PGTABLE_LEVELS + 1)
#else
#define KVM_PREALLOC_LEVEL	(0)
#endif

Basically if you can concatenate 16 or less pages@the level below the
top, the architecture does not allow a small top level. In this case,
(4 - CONFIG_ARM64_PGTABLE_LEVELS) represents the first level for the
host and we add 1 to go to the next level for KVM stage 2 when
PTRS_PER_S2_PGD is 16 or less. We use 0 when we don't need to
preallocate.

> +static inline int kvm_prealloc_hwpgd(struct kvm *kvm, pgd_t *pgd)
> +{
> +       pud_t *pud;
> +       pmd_t *pmd;
> +
> +       pud = pud_offset(pgd, 0);
> +       pmd = (pmd_t *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, 0);
> +
> +       if (!pmd)
> +               return -ENOMEM;
> +       pud_populate(NULL, pud, pmd);
> +
> +       return 0;
> +}
> +
> +static inline void kvm_free_hwpgd(struct kvm *kvm)
> +{
> +       pgd_t *pgd = kvm->arch.pgd;
> +       pud_t *pud = pud_offset(pgd, 0);
> +       pmd_t *pmd = pmd_offset(pud, 0);
> +       free_pages((unsigned long)pmd, 0);
> +}
> +
> +static inline phys_addr_t kvm_get_hwpgd(struct kvm *kvm)
> +{
> +       pgd_t *pgd = kvm->arch.pgd;
> +       pud_t *pud = pud_offset(pgd, 0);
> +       pmd_t *pmd = pmd_offset(pud, 0);
> +       return virt_to_phys(pmd);
> +
> +}
> +#elif defined(CONFIG_ARM64_4K_PAGES) && CONFIG_ARM64_PGTABLE_LEVELS == 4
> +#define KVM_PREALLOC_LEVEL     1
> +#define PTRS_PER_S2_PGD                2
> +#define S2_PGD_ORDER           get_order(PTRS_PER_S2_PGD * sizeof(pgd_t))

Here PGDIR_SHIFT is 39, so we get PTRS_PER_S2_PGD == (1 << (40 - 39))
which is 2 and KVM_PREALLOC_LEVEL == 1.

> +static inline int kvm_prealloc_hwpgd(struct kvm *kvm, pgd_t *pgd)
> +{
> +       pud_t *pud;
> +
> +       pud = (pud_t *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, 1);
> +       if (!pud)
> +               return -ENOMEM;
> +       pgd_populate(NULL, pgd, pud);
> +       pgd_populate(NULL, pgd + 1, pud + PTRS_PER_PUD);
> +
> +       return 0;
> +}

You still need to define these functions but you can make their
implementation dependent solely on the KVM_PREALLOC_LEVEL rather than
64K/4K and levels combinations. If it is KVM_PREALLOC_LEVEL is 1, you
allocate pud and populate the pgds (in a loop based on the
PTRS_PER_S2_PGD). If it is 2, you allocate the pmd and populate the pud
(still in a loop though it would probably be 1 iteration). We know based
on the assumption above that you can't get KVM_PREALLOC_LEVEL == 2 and
CONFIG_ARM64_PGTABLE_LEVELS == 4.

-- 
Catalin
