From: minchan.kim@gmail.com (Minchan Kim)
Date: Mon, 12 Jul 2010 18:52:28 +0900
Subject: About SECTION_SIZE_BITS for Sparsemem
In-Reply-To: <000601cb219c$c7830b60$56892220$%kim@samsung.com>
References: <000601cb219c$c7830b60$56892220$%kim@samsung.com>
Message-ID: <AANLkTinTrt7VKuKvleiJj4lv2tWqCcDYHVXAQIHLA7bh@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On Mon, Jul 12, 2010 at 5:32 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> Russell,
>
> Hi,
>
> Kukjin Kim wrote:
>> Russell wrote:
>> > So, memory starts at 0x20000000 and finishes at 0x25000000. ?That's
> fine.
>> > That doesn't mean the section size is 16MB.
>> >
>> > As I've already said, the section size has _nothing_ what so ever to do
>> > with the size of memory, or the granularity of the size of memory. ?By
>> > way of illustration, it is perfectly legal to have a section size of
>> > 256MB but only have 1MB in a section and this is perfectly legal. ?So
>> > sections do not have to be completely filled.
>> >
>> Actually, as you know, the hole's area of mem_map is freed from bootmem if
> a
>> section has a hole when initializing sparse memory.
>>
>> I identified that a section doesn't need to be a contiguous area of
> physical
>> memory when reading your comment with the fact that the mem_map of a
> section
>> can be smaller than the size of a section.
>>
>> I found, however, the kernel panics when modifying min_free_kbytes file in
>> the proc filesystem if a section has a hole.
>>
>> While processing the change of min_free_kbytes in the kernel, page
>> descriptors in a hole of an online section is accessed.
>
> As I said, following error happens.
> It would be helpful to me if any opinions or comments.
>

Could you test below patch?
Also, you should select ARCH_HAS_HOLES_MEMORYMODEL in your config.

@@ -2824,8 +2825,13 @@ static void setup_zone_migrate_reserve(struct zone *zone)
        for (pfn = start_pfn; pfn < end_pfn; pfn += pageblock_nr_pages) {
                if (!pfn_valid(pfn))
                        continue;
+
                page = pfn_to_page(pfn);

+                /* Watch for unexpected holes punched in the memmap */
+                if (!memmap_valid_within(pfn, page, zone))
+                        continue;
+
                /* Watch out for overlapping nodes */
                if (page_to_nid(page) != zone_to_nid(zone))
                        continue;



-- 
Kind regards,
Minchan Kim
