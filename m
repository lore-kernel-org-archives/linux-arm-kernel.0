From: mina86@mina86.com (Michal Nazarewicz)
Date: Sun, 23 Oct 2011 18:00:30 -0700
Subject: [PATCH 2/9] mm: alloc_contig_freed_pages() added
In-Reply-To: <20111021100624.GB4029@csn.ul.ie>
References: <1317909290-29832-1-git-send-email-m.szyprowski@samsung.com>
	<1317909290-29832-3-git-send-email-m.szyprowski@samsung.com>
	<20111018122109.GB6660@csn.ul.ie> <op.v3j5ent03l0zgt@mpn-glaptop>
	<20111021100624.GB4029@csn.ul.ie>
Message-ID: <op.v3tzq4q53l0zgt@mpn-glaptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 21 Oct 2011 03:06:24 -0700, Mel Gorman <mel@csn.ul.ie> wrote:

> On Tue, Oct 18, 2011 at 10:26:37AM -0700, Michal Nazarewicz wrote:
>> On Tue, 18 Oct 2011 05:21:09 -0700, Mel Gorman <mel@csn.ul.ie> wrote:
>>
>> >At this point, I'm going to apologise for not reviewing this a long long
>> >time ago.
>> >
>> >On Thu, Oct 06, 2011 at 03:54:42PM +0200, Marek Szyprowski wrote:
>> >>From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
>> >>
>> >>This commit introduces alloc_contig_freed_pages() function
>> >>which allocates (ie. removes from buddy system) free pages
>> >>in range. Caller has to guarantee that all pages in range
>> >>are in buddy system.
>> >>
>> >
>> >Straight away, I'm wondering why you didn't use
>> >
>> >mm/compaction.c#isolate_freepages()
>> >
>> >It knows how to isolate pages within ranges. All its control information
>> >is passed via struct compact_control() which I recognise may be awkward
>> >for CMA but compaction.c know how to manage all the isolated pages and
>> >pass them to migrate.c appropriately.
>>
>> It is something to consider.  At first glance, I see that isolate_freepages
>> seem to operate on pageblocks which is not desired for CMA.
>>
>
> isolate_freepages_block operates on a range of pages that happens to be
> hard-coded to be a pageblock because that was the requirements. It calculates
> end_pfn and it is possible to make that a function parameter.

Yes, this seems doable.  I'll try and rewrite the patches to use it.

The biggest difference is in how CMA and compaction treat pages which are not
free.  CMA treat it as an error and compaction just skips those.  This is
solvable by an argument though.

-- 
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=./ `o
..o | Computer Science,  Micha? ?mina86? Nazarewicz    (o o)
ooo +----<email/xmpp: mpn@google.com>--------------ooO--(_)--Ooo--
