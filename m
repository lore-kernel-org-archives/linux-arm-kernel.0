From: kirill.shutemov@linux.intel.com (Kirill A. Shutemov)
Date: Fri, 11 Oct 2013 00:53:43 +0300
Subject: [PATCH 11/34] arm: handle pgtable_page_ctor() fail
In-Reply-To: <20131010201805.GR25034@n2100.arm.linux.org.uk>
References: <1381428359-14843-1-git-send-email-kirill.shutemov@linux.intel.com>
 <1381428359-14843-12-git-send-email-kirill.shutemov@linux.intel.com>
 <20131010201805.GR25034@n2100.arm.linux.org.uk>
Message-ID: <20131010215343.GA2359@otc-wbsnb-06>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 10, 2013 at 09:18:05PM +0100, Russell King - ARM Linux wrote:
> So, all I see is this patch, with such a brilliant description which
> describes what this change is about, why it is being made, and so
> forth, and you're sending it to me, presumably because you want me to
> do something with it.  No, not really.

Fair enough. Description should be better.

> What context do I have to say whether this is correct or not?  How can
> I test it when the mainline version of pgtable_page_ctor returns void,
> so if I were to apply this patch I'd get compile errors.
> 
> Oh, I guess you're changing pgtable_page_ctor() in some way.  What is
> the nature of that change?
> 
> Please, I'm not a mind reader.  Please ensure that your "generic" patch
> of your series reaches the appropriate recipients: if you don't want to
> explicitly Cc: all the people individually, please at least copy all
> relevant mailing lists found for the entire series.

The patchset touches every arch with MMU -- the list would be too long.
I hoped all maintainers has access to archive of linux-kernel/linux-arch
to get context.

mbox with cover letter and three relevant patches attached.

> (No, I am not on the excessively noisy linux-arch: I dropped off it
> years ago because it just became yet another mailing list to endlessly
> talk mainly about x86 rather than being a separate list to linux-kernel
> which discussed problems relevant to many arch maintainers.)
> 
> Thanks.
> 
> On Thu, Oct 10, 2013 at 09:05:36PM +0300, Kirill A. Shutemov wrote:
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Cc: Russell King <linux@arm.linux.org.uk>
> > ---
> >  arch/arm/include/asm/pgalloc.h | 12 +++++++-----
> >  1 file changed, 7 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/arm/include/asm/pgalloc.h b/arch/arm/include/asm/pgalloc.h
> > index 943504f53f..78a7793616 100644
> > --- a/arch/arm/include/asm/pgalloc.h
> > +++ b/arch/arm/include/asm/pgalloc.h
> > @@ -102,12 +102,14 @@ pte_alloc_one(struct mm_struct *mm, unsigned long addr)
> >  #else
> >  	pte = alloc_pages(PGALLOC_GFP, 0);
> >  #endif
> > -	if (pte) {
> > -		if (!PageHighMem(pte))
> > -			clean_pte_table(page_address(pte));
> > -		pgtable_page_ctor(pte);
> > +	if (!pte)
> > +		return NULL;
> > +	if (!PageHighMem(pte))
> > +		clean_pte_table(page_address(pte));
> > +	if (!pgtable_page_ctor(pte)) {
> > +		__free_page(pte);
> > +		return NULL;
> >  	}
> > -
> >  	return pte;
> >  }
> >  
> > -- 
> > 1.8.4.rc3
> > 
-- 
 Kirill A. Shutemov
-------------- next part --------------
A non-text attachment was scrubbed...
Name: ptl.mbox
Type: application/mbox
Size: 23969 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131011/84c9c2eb/attachment-0001.mbox>
