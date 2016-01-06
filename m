From: dennis.chen@arm.com (Dennis Chen)
Date: Wed, 6 Jan 2016 10:55:21 +0800
Subject: [linux-next PATCH] arm64: fix kernel crash with 48-bit VA and
 64KB granule
In-Reply-To: <20160105154444.GF10705@arm.com>
References: <1451960299-14123-1-git-send-email-dennis.chen@arm.com>
 <CAKv+Gu-pz8rA2EfU6NwCndmoYneOjYUt8_PodTdZkepV3cRXJQ@mail.gmail.com>
 <20160105123153.GE10705@arm.com>
 <CAKv+Gu-btc7FX9JG=aEoDcSPYXQuB+Vf9ynXbKNxVn25bxtW_Q@mail.gmail.com>
 <20160105154444.GF10705@arm.com>
Message-ID: <20160106025520.GG13942@arm.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 05, 2016 at 03:44:44PM +0000, Will Deacon wrote:
> On Tue, Jan 05, 2016 at 01:47:11PM +0100, Ard Biesheuvel wrote:
> > On 5 January 2016 at 13:31, Will Deacon <will.deacon@arm.com> wrote:
> > > On Tue, Jan 05, 2016 at 08:36:39AM +0100, Ard Biesheuvel wrote:
> > >> The issue only occurs when PGD_SIZE != PAGE_SIZE, which is why I did
> > >> not see it myself. I only tested with 4k/39-bits and 64k/42-bits IIRC,
> > >> since the series this is part of primarily concerns ARM not arm64.
> > >>
> > >> Anyway, shuffling init ordering is my least favorite way of fixing
> > >> bugs. Since only ARM requires pgd_alloc() (for the kernel mappings),
> > >> we could also simply factor out pgd_alloc() into efi_pgd_alloc(), and
> > >> define it to mean '__get_free_page(PGALLOC_GFP)' on arm64.
> > >
> > > Or we could put the pgd_cache initialisation in pgtable_cache_init, which
> > > sounds like the right place for it anyway.
> > >
> >
> > Indeed.
>
> Patch below. Seems to do the job on my Juno.
>
> Will
>
> --->8
>
> From 39b5be9b4233a9f212b98242bddf008f379b5122 Mon Sep 17 00:00:00 2001
> From: Will Deacon <will.deacon@arm.com>
> Date: Tue, 5 Jan 2016 15:36:59 +0000
> Subject: [PATCH] arm64: mm: move pgd_cache initialisation to
>  pgtable_cache_init
>
> Initialising the suppport for EFI runtime services requires us to
> allocate a pgd off the back of an early_initcall. On systems where the
> PGD_SIZE is smaller than PAGE_SIZE (e.g. 64k pages and 48-bit VA), the
> pgd_cache isn't initialised at this stage, and we panic with a NULL
> dereference during boot:
>
>   Unable to handle kernel NULL pointer dereference at virtual address 00000000
>
>   __create_mapping.isra.5+0x84/0x350
>   create_pgd_mapping+0x20/0x28
>   efi_create_mapping+0x5c/0x6c
>   arm_enable_runtime_services+0x154/0x1e4
>   do_one_initcall+0x8c/0x190
>   kernel_init_freeable+0x84/0x1ec
>   kernel_init+0x10/0xe0
>   ret_from_fork+0x10/0x50
>
> This patch fixes the problem by initialising the pgd_cache earlier, in
> the pgtable_cache_init callback, which sounds suspiciously like what it
> was intended for.
>
> Reported-by: Dennis Chen <dennis.chen@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/include/asm/pgtable.h |  3 ++-
>  arch/arm64/mm/pgd.c              | 12 ++++++------
>  2 files changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 35a318c2fd87..a87e964d2791 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -676,7 +676,8 @@ extern int kern_addr_valid(unsigned long addr);
>
>  #include <asm-generic/pgtable.h>
>
> -#define pgtable_cache_init() do { } while (0)
> +void pgd_cache_init(void);
> +#define pgtable_cache_init   pgd_cache_init
>
>  /*
>   * On AArch64, the cache coherency is handled via the set_pte_at() function.
> diff --git a/arch/arm64/mm/pgd.c b/arch/arm64/mm/pgd.c
> index cb3ba1b812e7..ae11d4e03d0e 100644
> --- a/arch/arm64/mm/pgd.c
> +++ b/arch/arm64/mm/pgd.c
> @@ -46,14 +46,14 @@ void pgd_free(struct mm_struct *mm, pgd_t *pgd)
>               kmem_cache_free(pgd_cache, pgd);
>  }
>
> -static int __init pgd_cache_init(void)
> +void __init pgd_cache_init(void)
>  {
> +     if (PGD_SIZE == PAGE_SIZE)
> +             return;
> +
It doesn't need to add a new if statement here.
>       /*
>        * Naturally aligned pgds required by the architecture.
>        */
> -     if (PGD_SIZE != PAGE_SIZE)
> -             pgd_cache = kmem_cache_create("pgd_cache", PGD_SIZE, PGD_SIZE,
> -                                           SLAB_PANIC, NULL);
The deleted code here is more better, seems we don't need to change it here
> -     return 0;
Nice.
> +     pgd_cache = kmem_cache_create("pgd_cache", PGD_SIZE, PGD_SIZE,
> +                                   SLAB_PANIC, NULL);

>  }
> -core_initcall(pgd_cache_init);
The new patch is reasonable for me.

> --
> 2.1.4
>
IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
