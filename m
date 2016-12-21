From: minchan@kernel.org (Minchan Kim)
Date: Thu, 22 Dec 2016 08:54:22 +0900
Subject: jemalloc testsuite stalls in memset
In-Reply-To: <87d1gshscr.fsf@suse.de>
References: <mvmmvfy37g1.fsf@hawking.suse.de> <20161214235031.GA2912@bbox>
 <mvm4m2535pc.fsf@hawking.suse.de> <20161216063940.GA1334@bbox>
 <87d1gshscr.fsf@suse.de>
Message-ID: <20161221235422.GA12727@bbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello, Andreas

Sorry for long delay. I was on vacation.

On Fri, Dec 16, 2016 at 03:16:20PM +0100, Andreas Schwab wrote:
> On Dez 16 2016, Minchan Kim <minchan@kernel.org> wrote:
> 
> > Below helps?
> >
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index e10a4fe..dc37c9a 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -1611,6 +1611,7 @@ int madvise_free_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
> >  			tlb->fullmm);
> >  		orig_pmd = pmd_mkold(orig_pmd);
> >  		orig_pmd = pmd_mkclean(orig_pmd);
> > +		orig_pmd = pmd_wrprotect(orig_pmd);
> >  
> >  		set_pmd_at(mm, addr, pmd, orig_pmd);
> >  		tlb_remove_pmd_tlb_entry(tlb, pmd, addr);
> 
> Thanks, this fixes the issue (tested with 4.9).

It was a quick hack to know what exact problem is there and your confirming
helped a lot to understand the problem clear.

More right approach is to support pmd dirty handling in general page fault
handler rather than tweaking MADV_FREE. I just sent a new patch with Ccing
you.

Could you test it, please?
Thanks!
