From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 10 Feb 2014 10:29:35 +0000
Subject: [PATCH] ARM: mm: report both sections from PMD
In-Reply-To: <20140209221826.GA30556@www.outflux.net>
References: <20140209221826.GA30556@www.outflux.net>
Message-ID: <20140210102935.GC25305@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 09, 2014 at 10:18:26PM +0000, Kees Cook wrote:
> diff --git a/arch/arm/mm/dump.c b/arch/arm/mm/dump.c
> index 1f7b1e13d945..ff1559f9200c 100644
> --- a/arch/arm/mm/dump.c
> +++ b/arch/arm/mm/dump.c
> @@ -264,6 +264,9 @@ static void walk_pmd(struct pg_state *st, pud_t *pud, unsigned long start)
>  			note_page(st, addr, 3, pmd_val(*pmd));
>  		else
>  			walk_pte(st, pmd, addr);
> +
> +		if (SECTION_SIZE < PMD_SIZE && pmd_sect(*pmd))
> +			note_page(st, addr + SECTION_SIZE, 3, pmd_val(pmd[1]));

You can  use pmd_large() here as well.

But I think this function is broken (the "for" statement not shown
here). The pmd_t is 32-bit with classic MMU and it uses pmd++ while the
address grows by PMD_SIZE (two pmd_t entries).

-- 
Catalin
