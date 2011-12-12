From: mina86@mina86.com (Michal Nazarewicz)
Date: Mon, 12 Dec 2011 17:46:13 +0100
Subject: [PATCH 02/11] mm: compaction: introduce
 isolate_{free,migrate}pages_range().
In-Reply-To: <20111212163052.GK3277@csn.ul.ie>
References: <1321634598-16859-1-git-send-email-m.szyprowski@samsung.com>
 <1321634598-16859-3-git-send-email-m.szyprowski@samsung.com>
 <20111212140728.GC3277@csn.ul.ie> <op.v6dub1ms3l0zgt@mpn-glaptop>
 <20111212163052.GK3277@csn.ul.ie>
Message-ID: <op.v6dx7bo43l0zgt@mpn-glaptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 12 Dec 2011 17:30:52 +0100, Mel Gorman <mel@csn.ul.ie> wrote:

> On Mon, Dec 12, 2011 at 04:22:39PM +0100, Michal Nazarewicz wrote:
>> > <SNIP>
>> >
>> >>+		if (!pfn_valid_within(pfn))
>> >>+			goto skip;
>> >
>> >The flow of this function in general with gotos of skipped and next
>> >is confusing in comparison to the existing function. For example,
>> >if this PFN is not valid, and no freelist is provided, then we call
>> >__free_page() on a PFN that is known to be invalid.
>> >
>> >>+		++nr_scanned;
>> >>+
>> >>+		if (!PageBuddy(page)) {
>> >>+skip:
>> >>+			if (freelist)
>> >>+				goto next;
>> >>+			for (; start < pfn; ++start)
>> >>+				__free_page(pfn_to_page(pfn));
>> >>+			return 0;
>> >>+		}
>> >
>> >So if a PFN is valid and !PageBuddy and no freelist is provided, we
>> >call __free_page() on it regardless of reference count. That does not
>> >sound safe.
>>
>> Sorry about that.  It's a bug in the code which was caught later on.  The
>> code should read ???__free_page(pfn_to_page(start))???.

On Mon, 12 Dec 2011 17:30:52 +0100, Mel Gorman <mel@csn.ul.ie> wrote:
> That will call free on valid PFNs but why is it safe to call
> __free_page() at all?  You say later that CMA requires that all
> pages in the range be valid but if the pages are in use, that does
> not mean that calling __free_page() is safe. I suspect you have not
> seen a problem because the pages in the range were free as expected
> and not in use because of MIGRATE_ISOLATE.

All pages from [start, pfn) have passed through the loop body which
means that they are valid and they have been removed from buddy (for
caller's use).  Also, because of split_free_page(), all of those pages
have been split into 0-order pages.  Therefore, in error recovery, to
undo what the loop has done so far, we put give back to buddy by
calling __free_page() on each 0-order page.

>> >> 		/* Found a free page, break it into order-0 pages */
>> >> 		isolated = split_free_page(page);
>> >> 		total_isolated += isolated;
>> >>-		for (i = 0; i < isolated; i++) {
>> >>-			list_add(&page->lru, freelist);
>> >>-			page++;
>> >>+		if (freelist) {
>> >>+			struct page *p = page;
>> >>+			for (i = isolated; i; --i, ++p)
>> >>+				list_add(&p->lru, freelist);
>> >> 		}
>> >>
>> >>-		/* If a page was split, advance to the end of it */
>> >>-		if (isolated) {
>> >>-			blockpfn += isolated - 1;
>> >>-			cursor += isolated - 1;
>> >>-		}
>> >>+next:
>> >>+		pfn += isolated;
>> >>+		page += isolated;
>> >
>> >The name isolated is now confusing because it can mean either
>> >pages isolated or pages scanned depending on context. Your patch
>> >appears to be doing a lot more than is necessary to convert
>> >isolate_freepages_block into isolate_freepages_range and at this point,
>> >it's unclear why you did that.
>>
>> When CMA uses this function, it requires all pages in the range to be valid
>> and free. (Both conditions should be met but you never know.)

To be clear, I meant that the CMA expects pages to be in buddy when the function
is called but after the function finishes, all the pages in the range are removed
 from buddy.  This, among other things, is why the call to split_free_page() is
necessary.

> It seems racy but I guess you are depending on MIGRATE_ISOLATE to keep
> things sane which is fine. However, I strongly suspect that if there
> is a race and a page is in use, then you will need to retry the
> migration step. Calling __free_page does not look right because
> something still has a reference to the page.
>
>> This change
>> adds a second way isolate_freepages_range() works, which is when freelist is
>> not specified, abort on invalid or non-free page, but continue as usual if
>> freelist is provided.
>
> Ok, I think you should be able to do that by not calling split_free_page
> or adding to the list if !freelist with a comment explaining why the
> pages are left on the buddy lists for the caller to figure out. Bail if
> a page-in-use is found and have the caller check that the return value
> of isolate_freepages_block == end_pfn - start_pfn.

-- 
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=./ `o
..o | Computer Science,  Micha? ?mina86? Nazarewicz    (o o)
ooo +----<email/xmpp: mpn@google.com>--------------ooO--(_)--Ooo--
