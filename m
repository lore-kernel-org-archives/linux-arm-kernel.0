From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 3 Feb 2017 14:22:16 +0000
Subject: [PATCH v31 04/12] arm64: mm: allow for unmapping part of kernel
 mapping
In-Reply-To: <20170203061317.GC29585@linaro.org>
References: <20170201124218.5823-1-takahiro.akashi@linaro.org>
 <20170201124630.6016-3-takahiro.akashi@linaro.org>
 <20170201160354.GF4756@leverpostej>
 <20170202102131.GD13549@linaro.org>
 <20170202114437.GH31394@leverpostej>
 <20170202140102.GA22666@fireball>
 <20170202143535.GM31394@leverpostej>
 <20170202145553.GA3238@fireball>
 <20170203061317.GC29585@linaro.org>
Message-ID: <20170203142216.GF30497@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Feb 03, 2017 at 03:13:18PM +0900, AKASHI Takahiro wrote:
> On Thu, Feb 02, 2017 at 11:55:54PM +0900, AKASHI Takahiro wrote:
> > On Thu, Feb 02, 2017 at 02:35:35PM +0000, Mark Rutland wrote:

> > > I think that if we only allow ourselves to make PTEs invalid, we don't
> > > have to handle that case. If we use page_mappings_only, we should only
> > > check pgattr_change_is_safe() for the pte level, and the {pmd,pud,pgd}
> > > entries shouldn't change.
> > > 
> > > Is the below sufficient to allow that, or have I missed something?
> > 
> > I think it will be OK, but will double-check tomorrow.
> > However, is is acceptable that create_pgd_mapping( __prot(0) ) can
> > only handle the cases of page-mapping-only?
> > That would be fine to kdump, but in general?

Given we're only going to use this for page mappings, I think it's fine
(and preferable) to restrict it to page mappings for now. Until we need
to do this for the pmd/pud/pgd levels, those won't see any testing, and
it will be very easy for us to accidentally break this.

> My proposed code is attached below.
> I think that the changes are quite trivial and it works even if
> there is a section mapping as far as we refrain from reclaiming
> unsed p[ug]d tables.
> 
> (Of course, we can't merely unmap a subset of a section mapping here.)

Sure. We have a similar restriction when changing permissions, so I
think that's fine.

> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 17243e43184e..7f96eabc99d7 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -140,7 +140,11 @@ static void alloc_init_pte(pmd_t *pmd, unsigned long addr,
>                         __prot = prot;
>         }
> 
> -		set_pte(pte, pfn_pte(pfn, __prot));
> +		if (pgprot_val(prot) & PTE_VALID)
> +			set_pte(pte, pfn_pte(pfn, __prot));
> +		else
> +			pte_clear(null, null, pte);

It took me a moment to figure out how this line could compile. ;)

I'm happy to take this approach in alloc_init_pte(), but as above I'd
prefer that we only handled it there, and left the pmd/pud/pgd code
as-is for now.

We can/should add a comment to make that clear.

Thanks,
Mark.
