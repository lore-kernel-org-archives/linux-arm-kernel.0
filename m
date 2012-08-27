From: omycle@gmail.com (Li Haifeng)
Date: Mon, 27 Aug 2012 10:42:40 +0800
Subject: For buddy system initialization, the holes between banks adjacent
 will be released to buddy allocator?
In-Reply-To: <CAFNq8R6kBonhW4Q+Zj_6GV7y88pcAUJ_MrYn1nYM9LHtMZqdvQ@mail.gmail.com>
References: <CAFNq8R6kBonhW4Q+Zj_6GV7y88pcAUJ_MrYn1nYM9LHtMZqdvQ@mail.gmail.com>
Message-ID: <CAFNq8R7fCyD5P4mAA8LGzcOvVynSJa8mOBDwrLOF9mVvo9q5VA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just now, I tested it on my ARM development board.

The holes between banks does be released to buddy allocator. And the
buddy system will allocate holes for thread, which will cause fault.
Is it right?

2012/8/26 Li Haifeng <omycle@gmail.com>:
> Sorry to disturb you again.
>
> I am still confused about holes between banks adjacent.
>
> The lines 180~181 get the low memory's range, and the range includes holes.
> But while releasing the memory to buddy allocator, the code doesn't
> prevent the holes from releasing to the buddy allocator.
>
> 172 static unsigned long __init free_all_bootmem_core(bootmem_data_t *bdata)
> 173 {
> 174         struct page *page;
> 175         unsigned long start, end, pages, count = 0;
> 176
> 177         if (!bdata->node_bootmem_map)
> 178                 return 0;
> 179
> 180         start = bdata->node_min_pfn;
> 181         end = bdata->node_low_pfn;
> 182
> 183         bdebug("nid=%td start=%lx end=%lx\n",
> 184                 bdata - bootmem_node_data, start, end);
> 185
> 186         while (start < end) {
> 187                 unsigned long *map, idx, vec;
> 188
> 189                 map = bdata->node_bootmem_map;
> 190                 idx = start - bdata->node_min_pfn;
> 191                 vec = ~map[idx / BITS_PER_LONG];
> 192                 /*
> 193                  * If we have a properly aligned and fully unreserved
> 194                  * BITS_PER_LONG block of pages in front of us, free
> 195                  * it in one go.
> 196                  */
> 197                 if (IS_ALIGNED(start, BITS_PER_LONG) && vec == ~0UL) {
> 198                         int order = ilog2(BITS_PER_LONG);
> 199
> 200                         __free_pages_bootmem(pfn_to_page(start), order);
> 201                         count += BITS_PER_LONG;
> 202                         start += BITS_PER_LONG;
> 203                 } else {
> 204                         unsigned long off = 0;
> 205
> 206                         while (vec && off < BITS_PER_LONG) {
> 207                                 if (vec & 1) {
> 208                                         page = pfn_to_page(start + off);
> 209                                         __free_pages_bootmem(page, 0);
> 210                                         count++;
> 211                                 }
> 212                                 vec >>= 1;
> 213                                 off++;
> 214                         }
> 215                         start = ALIGN(start + 1, BITS_PER_LONG);
> 216                 }
> 217         }
> 218
> 219         page = virt_to_page(bdata->node_bootmem_map);
> 220         pages = bdata->node_low_pfn - bdata->node_min_pfn;
> 221         pages = bootmem_bootmap_pages(pages);
> 222         count += pages;
> 223         while (pages--)
> 224                 __free_pages_bootmem(page++, 0);
> 225
> 226         bdebug("nid=%td released=%lx\n", bdata - bootmem_node_data, count);
> 227
> 228         return count;
> 229 }
