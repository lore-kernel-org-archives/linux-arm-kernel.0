From: dave@linux.vnet.ibm.com (Dave Hansen)
Date: Wed, 21 Sep 2011 07:07:36 -0700
Subject: [PATCH 2/8] mm: alloc_contig_freed_pages() added
In-Reply-To: <op.v15tv0183l0zgt@mnazarewicz-glaptop>
References: <1313764064-9747-1-git-send-email-m.szyprowski@samsung.com>
	<1313764064-9747-3-git-send-email-m.szyprowski@samsung.com>
	<1315505152.3114.9.camel@nimitz>
	<op.v15tv0183l0zgt@mnazarewicz-glaptop>
Message-ID: <1316614056.16137.278.camel@nimitz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-09-21 at 15:17 +0200, Michal Nazarewicz wrote:
> > This 'struct page *'++ stuff is OK, but only for small, aligned areas.
> > For at least some of the sparsemem modes (non-VMEMMAP), you could walk
> > off of the end of the section_mem_map[] when you cross a MAX_ORDER
> > boundary.  I'd feel a little bit more comfortable if pfn_to_page() was
> > being done each time, or only occasionally when you cross a section
> > boundary.
> 
> I'm fine with that.  I've used pointer arithmetic for performance reasons
> but if that may potentially lead to bugs then obviously pfn_to_page()  
> should be used

pfn_to_page() on x86 these days is usually:

	#define __pfn_to_page(pfn)      (vmemmap + (pfn))

Even for the non-vmemmap sparsemem it stays pretty quick because the
section array is in cache as you run through the loop.

There are ways to _minimize_ the number of pfn_to_page() calls by
checking when you cross a section boundary, or even at a
MAX_ORDER_NR_PAGES boundary.  But, I don't think it's worth the trouble.

-- Dave
