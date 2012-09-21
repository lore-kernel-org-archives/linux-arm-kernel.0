From: will.deacon@arm.com (Will Deacon)
Date: Fri, 21 Sep 2012 10:22:21 +0100
Subject: [PATCH 3/4] ARM: mm: introduce L_PTE_VALID for page table entries
In-Reply-To: <20120920222105.GB1837@n2100.arm.linux.org.uk>
References: <1348156605-30398-1-git-send-email-will.deacon@arm.com>
 <1348156605-30398-4-git-send-email-will.deacon@arm.com>
 <20120920222105.GB1837@n2100.arm.linux.org.uk>
Message-ID: <20120921092221.GB24613@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Thu, Sep 20, 2012 at 11:21:05PM +0100, Russell King - ARM Linux wrote:
> On Thu, Sep 20, 2012 at 04:56:44PM +0100, Will Deacon wrote:
> > diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
> > index 41dc31f..df206c1 100644
> > --- a/arch/arm/include/asm/pgtable.h
> > +++ b/arch/arm/include/asm/pgtable.h
> > @@ -203,9 +203,7 @@ static inline pte_t *pmd_page_vaddr(pmd_t pmd)
> >  #define pte_exec(pte)		(!(pte_val(pte) & L_PTE_XN))
> >  #define pte_special(pte)	(0)
> >  
> > -#define pte_present_user(pte) \
> > -	((pte_val(pte) & (L_PTE_PRESENT | L_PTE_USER)) == \
> > -	 (L_PTE_PRESENT | L_PTE_USER))
> > +#define pte_present_user(pte)  (pte_present(pte) && (pte_val(pte) & L_PTE_USER))
> 
> This causes the compiler to do the "present" test and then, only if that
> evaluates true, to do the "user" test.  That's not what we want, we want
> the compiler to combine the two tests into one (which it should be able
> to do so.)

This is tricky for LPAE because PTEs with the following suffixes must all be
treated as present:

	...1xxxx01	/* L_PTE_USER | L_PTE_VALID -- will be used by hugetlb */
	...1xxxx10	/* L_PTE_USER | L_PTE_PRESENT[1] */
	...1xxxx11	/* L_PTE_USER | L_PTE_PRESENT */

so you need to check that (a) L_PTE_USER is set and (b) that at least one
of the bottom two bits is set. How about something like:

	((pte_val(pte) & (L_PTE_PRESENT | L_PTE_USER)) > L_PTE_USER)

Will
