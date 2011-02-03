From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 03 Feb 2011 17:09:20 +0000
Subject: [PATCH v4 09/19] ARM: LPAE: Page table maintenance for the
	3-level format
In-Reply-To: <1295891761-18366-10-git-send-email-catalin.marinas@arm.com>
References: <1295891761-18366-1-git-send-email-catalin.marinas@arm.com>
	<1295891761-18366-10-git-send-email-catalin.marinas@arm.com>
Message-ID: <1296752960.28466.16.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-01-24 at 17:55 +0000, Catalin Marinas wrote:
> --- a/arch/arm/mm/pgd.c
> +++ b/arch/arm/mm/pgd.c
> @@ -80,20 +98,36 @@ void pgd_free(struct mm_struct *mm, pgd_t *pgd_base)
>         if (!pgd_base)
>                 return;
> 
> -       pgd = pgd_base + pgd_index(0);
> -       if (pgd_none_or_clear_bad(pgd))
> -               goto no_pgd;
> +       if (!vectors_high()) {
> +               pgd = pgd_base + pgd_index(0);
> +               if (pgd_none_or_clear_bad(pgd))
> +                       goto no_pgd;
> 
> -       pmd = pmd_offset(pgd, 0);
> -       if (pmd_none_or_clear_bad(pmd))
> -               goto no_pmd;
> +               pmd = pmd_offset(pgd, 0);
> +               if (pmd_none_or_clear_bad(pmd))
> +                       goto no_pmd;
> 
> -       pte = pmd_pgtable(*pmd);
> -       pmd_clear(pmd);
> -       pte_free(mm, pte);
> +               pte = pmd_pgtable(*pmd);
> +               pmd_clear(pmd);
> +               pte_free(mm, pte);
>  no_pmd:
> -       pgd_clear(pgd);
> -       pmd_free(mm, pmd);
> +               pgd_clear(pgd);
> +               pmd_free(mm, pmd);
> +       }
>  no_pgd:

I pushed some fixups to the arm-lpae branch mentioned in the cover
letter.

The hunk above doesn't need to be applied since FIRST_USER_ADDRESS is
non-zero on ARM and free_pgtables() misses the first PMD when cleaning
up user page tables (hence leaking some memory).

-- 
Catalin
