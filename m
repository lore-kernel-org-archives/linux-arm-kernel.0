From: cl@linux-foundation.org (Christoph Lameter)
Date: Mon, 26 Jul 2010 11:40:44 -0500 (CDT)
Subject: [PATCH] Tight check of pfn_valid on sparsemem - v4
In-Reply-To: <1280159163-23386-1-git-send-email-minchan.kim@gmail.com>
References: <1280159163-23386-1-git-send-email-minchan.kim@gmail.com>
Message-ID: <alpine.DEB.2.00.1007261136160.5438@router.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 27 Jul 2010, Minchan Kim wrote:

> This patch registers address of mem_section to memmap itself's page struct's
> pg->private field. This means the page is used for memmap of the section.
> Otherwise, the page is used for other purpose and memmap has a hole.

What if page->private just happens to be the value of the page struct?
Even if that is not possible today, someday someone may add new
functionality to the kernel where page->pivage == page is used for some
reason.

Checking for PG_reserved wont work?

> +void mark_valid_memmap(unsigned long start, unsigned long end);
> +
> +#ifdef CONFIG_ARCH_HAS_HOLES_MEMORYMODEL
> +static inline int memmap_valid(unsigned long pfn)
> +{
> +	struct page *page = pfn_to_page(pfn);
> +	struct page *__pg = virt_to_page(page);
> +	return page_private(__pg) == (unsigned long)__pg;

Hmmm.. hmmm....
