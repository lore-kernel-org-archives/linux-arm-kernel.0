From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 10 Feb 2016 10:54:54 +0000
Subject: [PATCHv4 2/3] arm64: Add support for ARCH_SUPPORTS_DEBUG_PAGEALLOC
In-Reply-To: <20160210103814.GC13577@e104818-lin.cambridge.arm.com>
References: <1454718288-31374-1-git-send-email-labbott@fedoraproject.org>
 <1454718288-31374-3-git-send-email-labbott@fedoraproject.org>
 <20160210103814.GC13577@e104818-lin.cambridge.arm.com>
Message-ID: <20160210105453.GB2632@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 10, 2016 at 10:38:14AM +0000, Catalin Marinas wrote:
> On Fri, Feb 05, 2016 at 04:24:47PM -0800, Laura Abbott wrote:
> > --- a/arch/arm64/mm/mmu.c
> > +++ b/arch/arm64/mm/mmu.c
> > @@ -149,6 +149,19 @@ static void split_pud(pud_t *old_pud, pmd_t *pmd)
> >  	} while (pmd++, i++, i < PTRS_PER_PMD);
> >  }
> >  
> > +bool block_mappings_allowed(phys_addr_t (*pgtable_alloc)(void))
> > +{
> > +
> > +	/*
> > +	 * If debug_page_alloc is enabled we must map the linear map
> > +	 * using pages. However, other mappings created by
> > +	 * create_mapping_noalloc must use sections in some cases. Allow
> > +	 * sections to be used in those cases, where no pgtable_alloc
> > +	 * function is provided.
> > +	 */
> > +	return !pgtable_alloc || !debug_pagealloc_enabled();
> > +}
> 
> This breaks the build when CONFIG_DEBUG_PAGEALLOC is not enabled
> (defconfig) since debug_pagealloc_enabled() is not defined. A fix went
> in next/master as commit 0987684b855c
> ("mm-slab-clean-up-debug_pagealloc-processing-code-fix"). I need to
> track it down and merge it via the arm64 tree, otherwise I'll add some
> #ifdefs in this function.

In the cover for v2 [1],  it was mentioend that we needed a patch [2]
"mm: provide debug_pagealloc_enabled() without CONFIG_DEBUG_PAGEALLOC".
I assumed that was already queued via the mm tree.

> BTW, shouldn't the block_mappings_allowed() function be static?

That would make sense to me, yes.

Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-January/403439.html  
[2] http://article.gmane.org/gmane.linux.kernel.mm/1452
