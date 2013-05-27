From: cdall@cs.columbia.edu (Christoffer Dall)
Date: Mon, 27 May 2013 13:01:43 -0700
Subject: [PATCH v3 7/7] ARM: KVM: drop use of PAGE_S2_DEVICE
In-Reply-To: <1368529900-22572-8-git-send-email-marc.zyngier@arm.com>
References: <1368529900-22572-1-git-send-email-marc.zyngier@arm.com>
 <1368529900-22572-8-git-send-email-marc.zyngier@arm.com>
Message-ID: <CAEDV+gJeeQUOOLjFpkvoPk7e=csjmvvefhdp1miiWtosABwW6Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 14, 2013 at 4:11 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> At the moment, when mapping a device into Stage-2 for a guest,
> we override whatever the guest uses by forcing a device memory
> type in Stage-2.
>
> While this is not exactly wrong, this isn't really the "spirit" of
> the architecture. The hardware shouldn't have to cope for a broken
> guest mapping to a device as normal memory.
>

So I'm trying to think of a scenario where this feature in the
architecture would actually be useful, and it sounds like from you
guys that it's only useful to properly run a broken guest.

Are we 100% sure that a malicious guest can't leverage this to break
isolation? I'm thinking something along the lines of writing to a
device (for example the gic virtual cpu interface) with a cached
mapping. If such a write is in fact written back to cache, and not
evicted from the cache before a later time, where a different VM is
running, can't that adversely affect the other VM?

Probably this can never happen, but I wasn't able to convince myself
of this from going through the ARM ARM...?

> As such, let's get rid of the memory type overrides, and map
> everything as PAGE_S2 in Stage-2. This simplifies the code and
> let the guest do its own thing, whether it is stupid or not.
>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm/include/asm/pgtable.h | 2 --
>  arch/arm/kvm/mmu.c             | 2 +-
>  arch/arm/mm/mmu.c              | 6 ++----
>  3 files changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
> index 9bcd262..c3410a8 100644
> --- a/arch/arm/include/asm/pgtable.h
> +++ b/arch/arm/include/asm/pgtable.h
> @@ -81,7 +81,6 @@ extern pgprot_t               pgprot_user;
>  extern pgprot_t                pgprot_kernel;
>  extern pgprot_t                pgprot_hyp_device;
>  extern pgprot_t                pgprot_s2;
> -extern pgprot_t                pgprot_s2_device;
>
>  #define _MOD_PROT(p, b)        __pgprot(pgprot_val(p) | (b))
>
> @@ -97,7 +96,6 @@ extern pgprot_t               pgprot_s2_device;
>  #define PAGE_HYP               _MOD_PROT(pgprot_kernel, L_PTE_HYP)
>  #define PAGE_HYP_DEVICE                _MOD_PROT(pgprot_hyp_device, L_PTE_HYP)
>  #define PAGE_S2                        _MOD_PROT(pgprot_s2, L_PTE_S2_RDONLY)
> -#define PAGE_S2_DEVICE         _MOD_PROT(pgprot_s2_device, L_PTE_USER | L_PTE_S2_RDONLY)
>
>  #define __PAGE_NONE            __pgprot(_L_PTE_DEFAULT | L_PTE_RDONLY | L_PTE_XN | L_PTE_NONE)
>  #define __PAGE_SHARED          __pgprot(_L_PTE_DEFAULT | L_PTE_USER | L_PTE_XN)
> diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
> index 693d16c..f2a8416 100644
> --- a/arch/arm/kvm/mmu.c
> +++ b/arch/arm/kvm/mmu.c
> @@ -495,7 +495,7 @@ int kvm_phys_addr_ioremap(struct kvm *kvm, phys_addr_t guest_ipa,
>         pfn = __phys_to_pfn(pa);
>
>         for (addr = guest_ipa; addr < end; addr += PAGE_SIZE) {
> -               pte_t pte = pfn_pte(pfn, PAGE_S2_DEVICE);
> +               pte_t pte = pfn_pte(pfn, PAGE_S2);
>                 kvm_set_s2pte_writable(&pte);
>
>                 ret = mmu_topup_memory_cache(&cache, 2, 2);
> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> index e0d8565..bc001f5 100644
> --- a/arch/arm/mm/mmu.c
> +++ b/arch/arm/mm/mmu.c
> @@ -60,7 +60,6 @@ pgprot_t pgprot_user;
>  pgprot_t pgprot_kernel;
>  pgprot_t pgprot_hyp_device;
>  pgprot_t pgprot_s2;
> -pgprot_t pgprot_s2_device;
>
>  EXPORT_SYMBOL(pgprot_user);
>  EXPORT_SYMBOL(pgprot_kernel);
> @@ -343,7 +342,7 @@ static void __init build_mem_type_table(void)
>         struct cachepolicy *cp;
>         unsigned int cr = get_cr();
>         pteval_t user_pgprot, kern_pgprot, vecs_pgprot;
> -       pteval_t hyp_device_pgprot, s2_pgprot, s2_device_pgprot;
> +       pteval_t hyp_device_pgprot, s2_pgprot;
>         int cpu_arch = cpu_architecture();
>         int i;
>
> @@ -456,7 +455,7 @@ static void __init build_mem_type_table(void)
>         cp = &cache_policies[cachepolicy];
>         vecs_pgprot = kern_pgprot = user_pgprot = cp->pte;
>         s2_pgprot = cp->pte_s2;
> -       hyp_device_pgprot = s2_device_pgprot = mem_types[MT_DEVICE].prot_pte;
> +       hyp_device_pgprot = mem_types[MT_DEVICE].prot_pte;
>
>         /*
>          * ARMv6 and above have extended page tables.
> @@ -536,7 +535,6 @@ static void __init build_mem_type_table(void)
>         pgprot_kernel = __pgprot(L_PTE_PRESENT | L_PTE_YOUNG |
>                                  L_PTE_DIRTY | kern_pgprot);
>         pgprot_s2  = __pgprot(L_PTE_PRESENT | L_PTE_YOUNG | s2_pgprot);
> -       pgprot_s2_device  = __pgprot(s2_device_pgprot);
>         pgprot_hyp_device  = __pgprot(hyp_device_pgprot);
>
>         mem_types[MT_LOW_VECTORS].prot_l1 |= ecc_mask;
> --
> 1.8.2.3
>
>
