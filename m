From: dave@linux.vnet.ibm.com (Dave Hansen)
Date: Tue, 18 Oct 2011 10:48:46 -0700
Subject: [PATCH 2/9] mm: alloc_contig_freed_pages() added
In-Reply-To: <op.v3j5ent03l0zgt@mpn-glaptop>
References: <1317909290-29832-1-git-send-email-m.szyprowski@samsung.com>
	<1317909290-29832-3-git-send-email-m.szyprowski@samsung.com>
	<20111018122109.GB6660@csn.ul.ie>  <op.v3j5ent03l0zgt@mpn-glaptop>
Message-ID: <1318960126.4465.249.camel@nimitz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-10-18 at 10:26 -0700, Michal Nazarewicz wrote:
> > You can do this in a more general fashion by checking the
> > zone boundaries and resolving the pfn->page every MAX_ORDER_NR_PAGES.
> > That will not be SPARSEMEM specific.
> 
> I've tried doing stuff that way but it ended up with much more code.

I guess instead of:

>> +static inline bool zone_pfn_same_memmap(unsigned long pfn1, unsigned long pfn2)
>> +{
>> +    return pfn_to_section_nr(pfn1) == pfn_to_section_nr(pfn2);
>> +}

You could do:

static inline bool zone_pfn_same_maxorder(unsigned long pfn1, unsigned long pfn2)
{
	unsigned long mask = MAX_ORDER_NR_PAGES-1;
	return (pfn1 & mask) == (pfn2 & mask);
}

I think that works.  Should be the same code you have now, basically.

-- Dave
