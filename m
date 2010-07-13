From: kamezawa.hiroyu@jp.fujitsu.com (KAMEZAWA Hiroyuki)
Date: Tue, 13 Jul 2010 10:53:24 +0900
Subject: About SECTION_SIZE_BITS for Sparsemem
In-Reply-To: <20100713092522.6d9939ac.kamezawa.hiroyu@jp.fujitsu.com>
References: <000601cb219c$c7830b60$56892220$%kim@samsung.com>
	<AANLkTinTrt7VKuKvleiJj4lv2tWqCcDYHVXAQIHLA7bh@mail.gmail.com>
	<001b01cb21aa$ef0e4d80$cd2ae880$%kim@samsung.com>
	<AANLkTinkujX3VbL0sXjjghovr8eX9Os0huw3OTBut2UP@mail.gmail.com>
	<20100713092522.6d9939ac.kamezawa.hiroyu@jp.fujitsu.com>
Message-ID: <20100713105324.07f2f97b.kamezawa.hiroyu@jp.fujitsu.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 13 Jul 2010 09:25:22 +0900
KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> wrote:

> On Mon, 12 Jul 2010 19:35:17 +0900
> Minchan Kim <minchan.kim@gmail.com> wrote:
> 
> > Hi, Mel and Kame.
> > 
> > On Mon, Jul 12, 2010 at 7:13 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> > > Minchan Kim wrote:
> > >>
> > >> Hello.
> > >>
> > > Hello :-)
> > >
> > >> On Mon, Jul 12, 2010 at 5:32 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> > >> > Russell,
> > >> >
> > >> > Hi,
> > >> >
> > >> > Kukjin Kim wrote:
> > >> >> Russell wrote:
> > >> >> > So, memory starts at 0x20000000 and finishes at 0x25000000. ?That's
> > >> > fine.
> > >> >> > That doesn't mean the section size is 16MB.
> > >> >> >
> > >> >> > As I've already said, the section size has _nothing_ what so ever to
> > > do
> > >> >> > with the size of memory, or the granularity of the size of memory.
> > > ?By
> > >> >> > way of illustration, it is perfectly legal to have a section size of
> > >> >> > 256MB but only have 1MB in a section and this is perfectly legal. ?So
> > >> >> > sections do not have to be completely filled.
> > >> >> >
> > >> >> Actually, as you know, the hole's area of mem_map is freed from bootmem
> > > if
> > >> > a
> > >> >> section has a hole when initializing sparse memory.
> > >> >>
> > >> >> I identified that a section doesn't need to be a contiguous area of
> > >> > physical
> > >> >> memory when reading your comment with the fact that the mem_map of a
> > >> > section
> > >> >> can be smaller than the size of a section.
> > >> >>
> > >> >> I found, however, the kernel panics when modifying min_free_kbytes file
> > > in
> > >> >> the proc filesystem if a section has a hole.
> > >> >>
> > >> >> While processing the change of min_free_kbytes in the kernel, page
> > >> >> descriptors in a hole of an online section is accessed.
> > >> >
> > >> > As I said, following error happens.
> > >> > It would be helpful to me if any opinions or comments.
> > >> >
> > >>
> > >> Could you test below patch?
> > >> Also, you should select ARCH_HAS_HOLES_MEMORYMODEL in your config.
> > >>
> > > Yes, I did it, and no kernel panic happens :-)
> > >
> > > Same test...
> > > [root at Samsung ~]# cat /proc/sys/vm/min_free_kbytes
> > > 2736
> > > [root at Samsung ~]# echo "2730" > /proc/sys/vm/min_free_kbytes
> > > [root at Samsung ~]#
> > > [root at Samsung ~]# cat /proc/sys/vm/min_free_kbytes
> > > 2730
> > >
> > >
> > >> @@ -2824,8 +2825,13 @@ static void setup_zone_migrate_reserve(struct zone
> > >> *zone)
> > >> ? ? ? ? for (pfn = start_pfn; pfn < end_pfn; pfn += pageblock_nr_pages) {
> > >> ? ? ? ? ? ? ? ? if (!pfn_valid(pfn))
> > >> ? ? ? ? ? ? ? ? ? ? ? ? continue;
> > >> +
> > >> ? ? ? ? ? ? ? ? page = pfn_to_page(pfn);
> > >>
> > >> + ? ? ? ? ? ? ? ?/* Watch for unexpected holes punched in the memmap */
> > >> + ? ? ? ? ? ? ? ?if (!memmap_valid_within(pfn, page, zone))
> > >> + ? ? ? ? ? ? ? ? ? ? ? ?continue;
> > >> +
> > >> ? ? ? ? ? ? ? ? /* Watch out for overlapping nodes */
> > >> ? ? ? ? ? ? ? ? if (page_to_nid(page) != zone_to_nid(zone))
> > >> ? ? ? ? ? ? ? ? ? ? ? ? continue;
> > >>
> > >>
> > >>
> > >
> > > ...Could you please explain about this issue?
> > 
> > The setup_zone_migrate_reserve doesn't check memmap hole. I think
> > compaction would have the  same problem, too. I don't know there is a
> > problem in elsewhere.
> > Anyway, I think memmap_valid_within calling whenever walking whole pfn
> > range isn't a good solution. We already have pfn_valid. Could we check
> > this in there?
> > For example, mem_section have a valid pfn range and then valid section
> > can test it in pfn_valid.
> > 
> > What do you think about it?
> > 
> 
> please map another "fake" page when you free memmap.
> 
> For example, prepare a page filled with (1 << PG_reserved).
> and replace it with unnecessary memmap rather than freeing a page for memmap.
> 
> Then, you can find a PageReserved() page there. However it doesn't have valid
> nid,zid,secitonID, I don't think it can cause trouble.
> But you may see some BUG_ON() hit. If so, I think ARM guys can add
> 

yet another _very easy_ solution is, define pfn_valid() as following.

==
static inline arm_pfn_valid(unsigned long pfn)
{
	struct page *page = pfn_to_page(pfn);
	char *end_of_page = (char *)(page + 1) - 1;
	char byte;

	if ((((unsigned long)page) && PAGE_MASK) ==
		(((unsigned long)end_of_page) & PAGE_MASK))
		return (__get_user(byte, page) == 0);
	return (__get_user(byte, page) == 0) && (__get_user(byte, __end_of_page)== 0); 
}
==
And replace this with default pfn_valid() for SPARSEMEM.
(please see ia64_pfn_valid().)

I hope this is enough quick.....no ?
(we use get_user but the "page" will be accessed soon, anyway.)


Thanks,
-Kame
