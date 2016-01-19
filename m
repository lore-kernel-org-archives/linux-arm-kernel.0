From: rientjes@google.com (David Rientjes)
Date: Tue, 19 Jan 2016 14:17:03 -0800 (PST)
Subject: [PATCH] mm: avoid uninitialized variable in tracepoint
In-Reply-To: <20160118230324.GF14531@node.shutemov.name>
References: <4117363.Ys1FTDH7Wz@wuerfel>
 <20160118230324.GF14531@node.shutemov.name>
Message-ID: <alpine.DEB.2.10.1601191415480.7346@chino.kir.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 19 Jan 2016, Kirill A. Shutemov wrote:

> > A newly added tracepoint in the hugepage code uses a variable in the
> > error handling that is not initialized at that point:
> > 
> > include/trace/events/huge_memory.h:81:230: error: 'isolated' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> > 
> > The result is relatively harmless, as the trace data will in rare
> > cases contain incorrect data.
> > 
> > This works around the problem by adding an explicit initialization.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > Fixes: 7d2eba0557c1 ("mm: add tracepoint for scanning pages")
> 
> There's the same patch in mm tree, but it got lost on the way to Linus'
> tree:
> 
> https://ozlabs.org/~akpm/mmots/broken-out/mm-make-optimistic-check-for-swapin-readahead-fix.patch
> 
> Andrew?
> 

Looks like the patch got the wrong title, 
mm-make-optimistic-check-for-swapin-readahead-fix.patch, since the subject 
is "khugepaged: avoid usage of uninitialized variable 'isolated'".

Anyway, feel free to add

Acked-by: David Rientjes <rientjes@google.com>

to either patch.

> > 
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index b2db98136af9..bb3b763b1829 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -2320,7 +2320,7 @@ static void collapse_huge_page(struct mm_struct *mm,
> >  	pgtable_t pgtable;
> >  	struct page *new_page;
> >  	spinlock_t *pmd_ptl, *pte_ptl;
> > -	int isolated, result = 0;
> > +	int isolated = 0, result = 0;
> >  	unsigned long hstart, hend;
> >  	struct mem_cgroup *memcg;
> >  	unsigned long mmun_start;	/* For mmu_notifiers */
> > 
