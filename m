From: yaojun8558363@gmail.com (Jun Yao)
Date: Mon, 10 Sep 2018 19:41:53 +0800
Subject: [RESEND PATCH v4 5/6] arm64/mm: Populate the swapper_pg_dir by
 fixmap.
In-Reply-To: <2bf9b9d1-271c-f85e-5a98-0eb74f2fedd9@arm.com>
References: <20180822095432.12125-1-yaojun8558363@gmail.com>
 <20180822095432.12125-6-yaojun8558363@gmail.com>
 <2bf9b9d1-271c-f85e-5a98-0eb74f2fedd9@arm.com>
Message-ID: <20180910114153.GA10734@toy>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi James,

On Fri, Sep 07, 2018 at 10:58:22AM +0100, James Morse wrote:
> On 22/08/18 10:54, Jun Yao wrote:
> >  	WRITE_ONCE(*pmdp, pmd);
> >  	dsb(ishst);
> >  }
> > @@ -480,6 +511,19 @@ static inline phys_addr_t pmd_page_paddr(pmd_t pmd)
> >  
> >  static inline void set_pud(pud_t *pudp, pud_t pud)
> >  {
> > +#ifdef __PAGETABLE_PUD_FOLDED
> > +	if (in_swapper_pgdir(pudp)) {
> > +		pud_t *fixmap_pudp;
> > +
> > +		spin_lock(&swapper_pgdir_lock);
> > +		fixmap_pudp = (pud_t *)pgd_set_fixmap(__pa(pudp));
> 
> This is a bit subtle: are you using the pgd fixmap entry because the path from
> map_mem() uses the other three?
> 
> Using the pgd fix slot for a pud looks a bit strange to me, but its arguably a
> side-effect of the folding.

Yes, it's a side-effect of the folding.

When the CONFIG_PGTABLE_LEVELS == 3, the pud is folded into the pgd. It
means that the pgd is never none and it is also a pud. That's why I use
the pgd fixmap entry.

Maybe write this more clearly:

static inline void set_pud(pud_t *pudp, pud_t pud)
{
#ifdef __PAGETABLE_PUD_FOLDED
	pgd_t *pgdp = (pgd_t *)pudp;

	if (...) {
		pgd_t *fixmap_pgdp;
		pud_t *fixmap_pudp;

		spin_lock(...);
		fixmap_pgdp = pgd_set_fixmap(__pa(pgdp));
		fixmap_pudp = pud_set_fixmap_offset(fixmap_pgdp, 0UL);
		...
	}

Do you have any way to make it look more reasonable?

> I see this called 68 times during boot on a 64K/42bit-VA, 65 of which appear to
> be during paging_init(). What do you think to keeping paging_init()s use of the
> pgd fixmap for swapper_pg_dir, deliberately to skip the in_swapper_pgdir() test
> during paging_init()?

I think the set_pud() should not be called on a 64K/42bit-VA. As only
the level 2 and level 3 page tables are in use. It means that the pmd is
folded into the pud and the pud is never none. So the set_pud() should
not be called.

I think a variable can be introduced to indicate whether paging_init()
has been completed. And decide whether or not to skip the
in_swapper_pgdir() base on the value of it.

I don't know if this is reasonable. What do you think?

Thanks,

Jun
