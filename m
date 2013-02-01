From: chris@cloudcar.com (Christoffer Dall)
Date: Fri, 1 Feb 2013 13:37:20 -0500
Subject: [PATCH v4] ARM: LPAE: Fix mapping in alloc_init_pte for unaligned
 addresses
In-Reply-To: <20130201174246.GJ5151@arm.com>
References: <1359472036-7613-1-git-send-email-r.sricharan@ti.com>
 <20130201162631.GG5151@arm.com>
 <CANOGCgOp=kSatDu8fL7grk+bXLQ2pgKAEvEK6LoG8Ba4mqUH=w@mail.gmail.com>
 <20130201163722.GH5151@arm.com>
 <CANOGCgMbzEWpJQE8PH2nS9_wa0DP_14E4=whGgKxWGJ_HpwomQ@mail.gmail.com>
 <20130201174246.GJ5151@arm.com>
Message-ID: <CANOGCgM4J-CGgJirSbky17=b4FzJif7g-bnV3u+m0_aHKcVcHQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]

>
> Another try. This time I kept the same logic as before but added a loop
> on the outside (and indented the code). With classic MMU
> pmd_addr_end(addr, end) always return end, so the logic doesn't change.
> With LPAE we should get the standard looping over pmd entries. Again,
> only tested on C-A9.
>

I think the logic should be explained in a comment in the code if we
take this approach - it's not logical to understand that you switch
between using the outer vs. inner loop depending on your config.

>
> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> index 9f06102..47154f3 100644
> --- a/arch/arm/mm/mmu.c
> +++ b/arch/arm/mm/mmu.c
> @@ -581,34 +581,36 @@ static void __init alloc_init_section(pud_t *pud, unsigned long addr,
>                                       const struct mem_type *type)
>  {
>         pmd_t *pmd = pmd_offset(pud, addr);
> +       unsigned long next;
>
> -       /*
> -        * Try a section mapping - end, addr and phys must all be aligned
> -        * to a section boundary.  Note that PMDs refer to the individual
> -        * L1 entries, whereas PGDs refer to a group of L1 entries making
> -        * up one logical pointer to an L2 table.
> -        */
> -       if (type->prot_sect && ((addr | end | phys) & ~SECTION_MASK) == 0) {
> -               pmd_t *p = pmd;
> +       do {
> +               next = pmd_addr_end(addr, end);
> +
> +               /*
> +                * Try a section mapping - next, addr and phys must all be
> +                * aligned to a section boundary.  Note that PMDs refer to the
> +                * individual L1 entries, whereas PGDs refer to a group of L1
> +                * entries making up one logical pointer to an L2 table.
> +                */
> +               if (((addr | next | phys) & ~SECTION_MASK) == 0) {
> +                       pmd_t *p = pmd;
>
>  #ifndef CONFIG_ARM_LPAE
> -               if (addr & SECTION_SIZE)
> -                       pmd++;
> +                       if (addr & SECTION_SIZE)
> +                               pmd++;
>  #endif

perhaps we could comment this ifdef now when we're at it, I spent a
considerable amount of time understanding it, and now I forgot again.
IIRC the logic relies on state set up during early assembly boot,
which is a little much to ask of the reader of this code...

> +                       do {
> +                               *pmd = __pmd(phys | type->prot_sect);
> +                               phys += SECTION_SIZE;
> +                       } while (pmd++, addr += SECTION_SIZE, addr != next);
>
> -               do {
> -                       *pmd = __pmd(phys | type->prot_sect);
> -                       phys += SECTION_SIZE;
> -               } while (pmd++, addr += SECTION_SIZE, addr != end);
> -
> -               flush_pmd_entry(p);
> -       } else {
> -               /*
> -                * No need to loop; pte's aren't interested in the
> -                * individual L1 entries.
> -                */
> -               alloc_init_pte(pmd, addr, end, __phys_to_pfn(phys), type);
> -       }
> +                       flush_pmd_entry(p);
> +               } else {
> +                       alloc_init_pte(pmd, addr, next, __phys_to_pfn(phys), type);
> +                       phys += next - addr;
> +                       pmd++;
> +               }
> +       } while (addr = next, addr != end);

aren't you still wasting memory for the individual PTEs inside alloc_init_pte?

also, I would prefer having two distinct loops than this outer/inner
scheme, but with the right comment I'm fine with it.

>  }
>
>  static void __init alloc_init_pud(pgd_t *pgd, unsigned long addr,

Let me know if you'd like me to test it on omap5.

-Christoffer
