From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 27 Mar 2014 10:55:15 +0000
Subject: [PATCH] ARM64: Kernel managed pages are only flushed
In-Reply-To: <d7741589c5ba48eaa13c9254b57dd5e2@BN1PR03MB266.namprd03.prod.outlook.com>
References: <1394018446-16738-1-git-send-email-Bharat.Bhushan@freescale.com>
 <20140306065339.GA2975@localhost>
 <b9ecee11764146c98dd41b811ebc05ae@BN1PR03MB266.namprd03.prod.outlook.com>
 <20140312145653.GA9691@mudshark.cambridge.arm.com>
 <20140312160340.GI17083@arm.com> <20140312172642.GU17083@arm.com>
 <d7741589c5ba48eaa13c9254b57dd5e2@BN1PR03MB266.namprd03.prod.outlook.com>
Message-ID: <20140327105513.GA20298@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 26, 2014 at 03:16:29AM +0000, Bharat.Bhushan at freescale.com wrote:
> > From 31d84855d71778e4a0f615f61ab836be3a70a58b Mon Sep 17 00:00:00 2001
> > From: Catalin Marinas <catalin.marinas@arm.com>
> > Date: Wed, 12 Mar 2014 16:28:09 +0000
> > Subject: [PATCH] arm64: Do not synchronise I and D caches for special ptes
> > 
> > Special pte mappings are not intended to be executable and do not even have an
> > associated struct page. This patch ensures that we do not call
> > __sync_icache_dcache() on such ptes.
> > 
> > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> > Reported-by: Steve Capper <Steve.Capper@arm.com>
> > ---
> >  arch/arm64/include/asm/pgtable.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> > index 2d3cede62709..72c9ac38cdd9 100644
> > --- a/arch/arm64/include/asm/pgtable.h
> > +++ b/arch/arm64/include/asm/pgtable.h
> > @@ -199,7 +199,7 @@ static inline void set_pte_at(struct mm_struct *mm, unsigned
> > long addr,
> >  			      pte_t *ptep, pte_t pte)
> >  {
> >  	if (pte_valid_user(pte)) {
> > -		if (pte_exec(pte))
> > +		if (!pte_special(pte) && pte_exec(pte))
> >  			__sync_icache_dcache(pte, addr);
> >  		if (pte_dirty(pte) && pte_write(pte))
> >  			pte_val(pte) &= ~PTE_RDONLY;
> 
> These patches are not yet posted if I have not missed. Also a little
> bit of confusion, will you be posting these patches or you want
> me/someone to post these couple of patches? I am assuming you will be
> posting these patches, if so any idea when we can see these patches?

I added them in the arm64 for-next/core branch (on git.kernel.org) and
they are in linux-next (with a cc stable, though I didn't bother sending
a late -rc pull request for them).

-- 
Catalin
