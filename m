From: Bharat.Bhushan@freescale.com (Bharat.Bhushan at freescale.com)
Date: Thu, 13 Mar 2014 11:00:27 +0000
Subject: [PATCH] ARM64: Kernel managed pages are only flushed
In-Reply-To: <20140312172642.GU17083@arm.com>
References: <1394018446-16738-1-git-send-email-Bharat.Bhushan@freescale.com>
 <20140306065339.GA2975@localhost>
 <b9ecee11764146c98dd41b811ebc05ae@BN1PR03MB266.namprd03.prod.outlook.com>
 <20140312145653.GA9691@mudshark.cambridge.arm.com>
 <20140312160340.GI17083@arm.com> <20140312172642.GU17083@arm.com>
Message-ID: <dc834a6b0a1548ac8c4d27fa34261fd0@BN1PR03MB266.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Catalin Marinas [mailto:catalin.marinas at arm.com]
> Sent: Wednesday, March 12, 2014 10:57 PM
> To: Will Deacon
> Cc: Bhushan Bharat-R65777; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH] ARM64: Kernel managed pages are only flushed
> 
> On Wed, Mar 12, 2014 at 04:03:40PM +0000, Catalin Marinas wrote:
> > On Wed, Mar 12, 2014 at 02:56:53PM +0000, Will Deacon wrote:
> > > On Wed, Mar 12, 2014 at 02:41:31PM +0000, Bharat.Bhushan at freescale.com
> wrote:
> > > > Did you get the chance to look into this? What is your take for
> > > > this patch or you want to suggest some other solution?
> > >
> > > See my reply to Laura here:
> > >
> > >
> > > http://lists.infradead.org/pipermail/linux-arm-kernel/2014-March/238
> > > 510.html
> > >
> > > We *really* don't want executable device mappings.
> >
> > /dev/mem mapping use pgprot_noncached() but I think we could
> > generalise any of the writecombine and dmacoherent mappings to XN like
> > in the patch
> > below:
> >
> > diff --git a/arch/arm64/include/asm/pgtable.h
> > b/arch/arm64/include/asm/pgtable.h
> > index b524dcd17243..2d3cede62709 100644
> > --- a/arch/arm64/include/asm/pgtable.h
> > +++ b/arch/arm64/include/asm/pgtable.h
> > @@ -286,11 +286,11 @@ static inline int has_transparent_hugepage(void)
> >   * Mark the prot value as uncacheable and unbufferable.
> >   */
> >  #define pgprot_noncached(prot) \
> > -	__pgprot_modify(prot, PTE_ATTRINDX_MASK, PTE_ATTRINDX(MT_DEVICE_nGnRnE))
> > +	__pgprot_modify(prot, PTE_ATTRINDX_MASK,
> > +PTE_ATTRINDX(MT_DEVICE_nGnRnE) | PTE_PXN | PTE_UXN)
> >  #define pgprot_writecombine(prot) \
> > -	__pgprot_modify(prot, PTE_ATTRINDX_MASK, PTE_ATTRINDX(MT_NORMAL_NC))
> > +	__pgprot_modify(prot, PTE_ATTRINDX_MASK, PTE_ATTRINDX(MT_NORMAL_NC)
> > +| PTE_PXN | PTE_UXN)
> >  #define pgprot_dmacoherent(prot) \
> > -	__pgprot_modify(prot, PTE_ATTRINDX_MASK, PTE_ATTRINDX(MT_NORMAL_NC))
> > +	__pgprot_modify(prot, PTE_ATTRINDX_MASK, PTE_ATTRINDX(MT_NORMAL_NC)
> > +| PTE_PXN | PTE_UXN)
> >  #define __HAVE_PHYS_MEM_ACCESS_PROT
> >  struct file;
> >  extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long
> > pfn,
> 
> And one more patch as suggested by Steve Capper. Both would be needed.
> 
> -------------8<----------------------
> 
> From 31d84855d71778e4a0f615f61ab836be3a70a58b Mon Sep 17 00:00:00 2001
> From: Catalin Marinas <catalin.marinas@arm.com>
> Date: Wed, 12 Mar 2014 16:28:09 +0000
> Subject: [PATCH] arm64: Do not synchronise I and D caches for special ptes
> 
> Special pte mappings are not intended to be executable and do not even have an
> associated struct page. This patch ensures that we do not call
> __sync_icache_dcache() on such ptes.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Reported-by: Steve Capper <Steve.Capper@arm.com>
> ---
>  arch/arm64/include/asm/pgtable.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 2d3cede62709..72c9ac38cdd9 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -199,7 +199,7 @@ static inline void set_pte_at(struct mm_struct *mm, unsigned
> long addr,
>  			      pte_t *ptep, pte_t pte)
>  {
>  	if (pte_valid_user(pte)) {
> -		if (pte_exec(pte))
> +		if (!pte_special(pte) && pte_exec(pte))
>  			__sync_icache_dcache(pte, addr);
>  		if (pte_dirty(pte) && pte_write(pte))
>  			pte_val(pte) &= ~PTE_RDONLY;
> 

Tested-by: Bharat Bhushan <Bharat.Bhushan@freescale.com>

Thanks
-Bharat
