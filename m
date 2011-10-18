From: mina86@mina86.com (Michal Nazarewicz)
Date: Tue, 18 Oct 2011 11:00:34 -0700
Subject: [PATCH 2/9] mm: alloc_contig_freed_pages() added
In-Reply-To: <1318960126.4465.249.camel@nimitz>
References: <1317909290-29832-1-git-send-email-m.szyprowski@samsung.com>
	<1317909290-29832-3-git-send-email-m.szyprowski@samsung.com>
	<20111018122109.GB6660@csn.ul.ie> <op.v3j5ent03l0zgt@mpn-glaptop>
	<1318960126.4465.249.camel@nimitz>
Message-ID: <op.v3j6y8i33l0zgt@mpn-glaptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 18 Oct 2011 10:48:46 -0700, Dave Hansen <dave@linux.vnet.ibm.com> wrote:

> On Tue, 2011-10-18 at 10:26 -0700, Michal Nazarewicz wrote:
>> > You can do this in a more general fashion by checking the
>> > zone boundaries and resolving the pfn->page every MAX_ORDER_NR_PAGES.
>> > That will not be SPARSEMEM specific.
>>
>> I've tried doing stuff that way but it ended up with much more code.
>
> I guess instead of:
>
>>> +static inline bool zone_pfn_same_memmap(unsigned long pfn1, unsigned long pfn2)
>>> +{
>>> +    return pfn_to_section_nr(pfn1) == pfn_to_section_nr(pfn2);
>>> +}
>
> You could do:
>
> static inline bool zone_pfn_same_maxorder(unsigned long pfn1, unsigned long pfn2)
> {
> 	unsigned long mask = MAX_ORDER_NR_PAGES-1;
> 	return (pfn1 & mask) == (pfn2 & mask);
> }
>
> I think that works.  Should be the same code you have now, basically.

Makes sense.  It'd require calling pfn_to_page() every MAX_ORDER_NR_PAGES even
in memory models that have linear mapping of struct page, but I guess that's
not that bad.

-- 
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=./ `o
..o | Computer Science,  Micha? ?mina86? Nazarewicz    (o o)
ooo +----<email/xmpp: mpn@google.com>--------------ooO--(_)--Ooo--
