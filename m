From: mel@csn.ul.ie (Mel Gorman)
Date: Tue, 13 Jul 2010 10:26:58 +0100
Subject: About SECTION_SIZE_BITS for Sparsemem
In-Reply-To: <AANLkTinkujX3VbL0sXjjghovr8eX9Os0huw3OTBut2UP@mail.gmail.com>
References: <000601cb219c$c7830b60$56892220$%kim@samsung.com>
	<AANLkTinTrt7VKuKvleiJj4lv2tWqCcDYHVXAQIHLA7bh@mail.gmail.com>
	<001b01cb21aa$ef0e4d80$cd2ae880$%kim@samsung.com>
	<AANLkTinkujX3VbL0sXjjghovr8eX9Os0huw3OTBut2UP@mail.gmail.com>
Message-ID: <20100713092658.GB29885@csn.ul.ie>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 12, 2010 at 07:35:17PM +0900, Minchan Kim wrote:
> >> On Mon, Jul 12, 2010 at 5:32 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> >> > Russell,
> >> >
> >> > Hi,
> >> >
> >> > Kukjin Kim wrote:
> >> >> Russell wrote:
> >> >> > So, memory starts at 0x20000000 and finishes at 0x25000000. ?That's fine.
> >> >> > That doesn't mean the section size is 16MB.
> >> >> >
> >> >> > As I've already said, the section size has _nothing_ what so ever to do
> >> >> > with the size of memory, or the granularity of the size of memory. ?By
> >> >> > way of illustration, it is perfectly legal to have a section size of
> >> >> > 256MB but only have 1MB in a section and this is perfectly legal. ?So
> >> >> > sections do not have to be completely filled.
> >> >> >

This is accurate although there is an expectation that a section is as
larger or larger than MAX_ORDER_NR_PAGES.

> >> >> Actually, as you know, the hole's area of mem_map is freed from bootmem if
> >> > a
> >> >> section has a hole when initializing sparse memory.
> >> >>
> >> >> I identified that a section doesn't need to be a contiguous area of physical
> >> >> memory when reading your comment with the fact that the mem_map of a section
> >> >> can be smaller than the size of a section.
> >> >>

This should only happen in one case, on ARM and it breaks assumptions.
It is typically assumed that if a page is valid within a block of
MAX_ORDER_NR_PAGES, then the entire range is active. If
CONFIG_HOLES_IN_ZONE is set, then there may be holes within a
MAX_ORDER_NR_PAGES range and there is a performance hit as a result.

There is also an assumption that a section is fully populated or empty.
Look at the implementation of pfn_valid for sparsemem, it checks if the
section has SECTION_HAS_MEM_MAP set and it's the same check for any page
within that section. If there are holes in the section, the pfn_valid()
check would return true.

Check out the comment for memmap_valid_within() which tries to get
around this problem on ARM which is the only architecture punching holes
in its mem_map. As it's only depended on for the information in one proc
file, the performance hit is not a problem but it should not be
considered a typical thing.

> >> >> I found, however, the kernel panics when modifying min_free_kbytes file
> > in
> >> >> the proc filesystem if a section has a hole.
> >> >>
> >> >> While processing the change of min_free_kbytes in the kernel, page
> >> >> descriptors in a hole of an online section is accessed.
> >> >
> >> > As I said, following error happens.
> >> > It would be helpful to me if any opinions or comments.
> >> >
> >>
> >> Could you test below patch?
> >> Also, you should select ARCH_HAS_HOLES_MEMORYMODEL in your config.
> >>
> > Yes, I did it, and no kernel panic happens :-)
> >
> > Same test...
> > [root at Samsung ~]# cat /proc/sys/vm/min_free_kbytes
> > 2736
> > [root at Samsung ~]# echo "2730" > /proc/sys/vm/min_free_kbytes
> > [root at Samsung ~]#
> > [root at Samsung ~]# cat /proc/sys/vm/min_free_kbytes
> > 2730
> >
> >
> >> @@ -2824,8 +2825,13 @@ static void setup_zone_migrate_reserve(struct zone
> >> *zone)
> >> ? ? ? ? for (pfn = start_pfn; pfn < end_pfn; pfn += pageblock_nr_pages) {
> >> ? ? ? ? ? ? ? ? if (!pfn_valid(pfn))
> >> ? ? ? ? ? ? ? ? ? ? ? ? continue;
> >> +
> >> ? ? ? ? ? ? ? ? page = pfn_to_page(pfn);
> >>
> >> + ? ? ? ? ? ? ? ?/* Watch for unexpected holes punched in the memmap */
> >> + ? ? ? ? ? ? ? ?if (!memmap_valid_within(pfn, page, zone))
> >> + ? ? ? ? ? ? ? ? ? ? ? ?continue;
> >> +
> >> ? ? ? ? ? ? ? ? /* Watch out for overlapping nodes */
> >> ? ? ? ? ? ? ? ? if (page_to_nid(page) != zone_to_nid(zone))
> >> ? ? ? ? ? ? ? ? ? ? ? ? continue;
> >>
> >>
> >>
> >
> > ...Could you please explain about this issue?
> 

The issue is that ARM can create holes within a section of memory which
breaks the memory model by allowing pfn_valid() to return true for PFNs
backed by no memmap. This causes awkwardness.

> The setup_zone_migrate_reserve doesn't check memmap hole.

It doesn't. The worst case scenario is where the hole is punched at the
beginning of a section, pfn_valid returns true but the PFN is junk and
crashes shortly afterwards. This would require a zone to start in a hole
which should never happen - it makes no sense. If this is the scenario
being encountered, ensure that zones do not start in holes.

> I think
> compaction would have the  same problem, too.
> I don't know there is a
> problem in elsewhere.
> Anyway, I think memmap_valid_within calling whenever walking whole pfn
> range isn't a good solution.

No, it's not. The rules for pfn_valid and pfn_valid_within are already poorly
understood and we shouldn't add additional rules on memmap_valid_within just
for ARM if possible. If the problems are being encountered on sparsemem on
ARM, I'd prefer to simply see holes not punched in the memmap within a section!

> We already have pfn_valid. Could we check
> this in there?

Ordinarily, yes you would use pfn_valid or pfn_valid_within. It's only on ARM
where assumptions of the memory model are violated that memmap_valid_within
is used. It's unsatisfactory even there but as it was only used for a
proc file, it wasn't important. I'd really hate to see its use increased.

At the time it was discussed, a "proper" fix would have consumed as much
memory as saved by deleting portions of the memmap and was rejected.

> For example, mem_section have a valid pfn range and then valid section
> can test it in pfn_valid.
> 
> What do you think about it?
> 
> P.S)
> I know Mel is very busy to test to avoid writeback in direct reclaim.

I'm also heavily distracted by internal bugs so I'm afraid I didn't read
this thread. Hopefully the above information is useful to you.
> 

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
