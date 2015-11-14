From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sat, 14 Nov 2015 08:02:37 +0100
Subject: [PATCH 2/2] arm: kvm: Fix STRICT_MM_TYPECHECK errors
In-Reply-To: <1447207401-12023-2-git-send-email-labbott@fedoraproject.org>
References: <1447207401-12023-1-git-send-email-labbott@fedoraproject.org>
 <1447207401-12023-2-git-send-email-labbott@fedoraproject.org>
Message-ID: <CAKv+Gu-2yx2j-ke2DNTq7aiNyzrog2fQxsWaSwwF1FPUR-nr0w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 November 2015 at 03:03, Laura Abbott <labbott@fedoraproject.org> wrote:
>
> PAGE_S2_DEVICE is a pgprot val and needs to be accessed using the proper
> accessors. Switch to these accessors to avoid errors with
> STRICT_MM_TYPECHECK.
>
> Signed-off-by: Laura Abbott <labbott@fedoraproject.org>
> ---
> Found in the course of other work

Already fixed here:
http://thread.gmane.org/gmane.comp.emulators.kvm.devel/142953

Looks like we may need a mutex :-)

> ---
>  arch/arm/kvm/mmu.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
> index 6984342..43f8162 100644
> --- a/arch/arm/kvm/mmu.c
> +++ b/arch/arm/kvm/mmu.c
> @@ -213,7 +213,8 @@ static void unmap_ptes(struct kvm *kvm, pmd_t *pmd,
>                         kvm_tlb_flush_vmid_ipa(kvm, addr);
>
>                         /* No need to invalidate the cache for device mappings */
> -                       if ((pte_val(old_pte) & PAGE_S2_DEVICE) != PAGE_S2_DEVICE)
> +                       if ((pte_val(old_pte) & pgprot_val(PAGE_S2_DEVICE)) !=
> +                            pgprot_val(PAGE_S2_DEVICE))
>                                 kvm_flush_dcache_pte(old_pte);
>
>                         put_page(virt_to_page(pte));
> @@ -306,7 +307,8 @@ static void stage2_flush_ptes(struct kvm *kvm, pmd_t *pmd,
>         pte = pte_offset_kernel(pmd, addr);
>         do {
>                 if (!pte_none(*pte) &&
> -                   (pte_val(*pte) & PAGE_S2_DEVICE) != PAGE_S2_DEVICE)
> +                   (pte_val(*pte) & pgprot_val(PAGE_S2_DEVICE)) !=
> +                    pgprot_val(PAGE_S2_DEVICE))
>                         kvm_flush_dcache_pte(*pte);
>         } while (pte++, addr += PAGE_SIZE, addr != end);
>  }
> --
> 2.5.0
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
