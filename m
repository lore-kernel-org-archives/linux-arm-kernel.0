From: m.nazarewicz@samsung.com (=?utf-8?B?TWljaGHFgiBOYXphcmV3aWN6?=)
Date: Fri, 29 Oct 2010 14:43:51 +0200
Subject: [RFC][PATCH 0/3] big chunk memory allocator v2
In-Reply-To: <20101029122928.GA17792@gargoyle.fritz.box>
References: <20101026190042.57f30338.kamezawa.hiroyu@jp.fujitsu.com>
	<AANLkTim4fFXQKqmFCeR8pvi0SZPXpjDqyOkbV6PYJYkR@mail.gmail.com>
	<op.vlbywq137p4s8u@pikus> <20101029103154.GA10823@gargoyle.fritz.box>
	<20101029195900.88559162.kamezawa.hiroyu@jp.fujitsu.com>
	<20101029122928.GA17792@gargoyle.fritz.box>
Message-ID: <op.vlb8bda87p4s8u@pikus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>> When I was posting CMA, it had been suggested to create a new migration type
>>>> dedicated to contiguous allocations.  I think I already did that and thanks to
>>>> this new migration type we have (i) an area of memory that only accepts movable
>>>> and reclaimable pages and

>> Andi Kleen <andi.kleen@intel.com> wrote:
>>> Aka highmem next generation :-(

> On Fri, Oct 29, 2010 at 11:59:00AM +0100, KAMEZAWA Hiroyuki wrote:
>> yes. But Nick's new shrink_slab() may be a new help even without
>> new zone.

On Fri, 29 Oct 2010 14:29:28 +0200, Andi Kleen <andi.kleen@intel.com> wrote:
> You would really need callbacks into lots of code. Christoph
> used to have some patches for directed shrink of dcache/icache,
> but they are currently not on the table.
>
> I don't think Nick's patch does that, he simply optimizes the existing
> shrinker (which in practice tends to not shrink a lot) to be a bit
> less wasteful.
>
> The coverage will never be 100% in any case. So you always have to
> make a choice between movable or fully usable. That's essentially
> highmem with most of its problems.

Yep.

>>>> (ii) is used only if all other (non-reserved) pages have
>>>> been allocated.

>>> That will be near always the case after some uptime, as memory fills up
>>> with caches. Unless you do early reclaim?

Hmm... true.  Still the point remains that only movable and reclaimable pages are
allowed in the marked regions.  This in effect means that from unmovable pages
point of view, the area is unusable but I havn't thought of any other way to
guarantee that because of fragmentation, long sequence of free/movable/reclaimable
pages is available.

>> memory migration always do work with alloc_page() for getting migration target
>> pages. So, memory will be reclaimed if filled by cache.
>
> Was talking about that paragraph CMA, not your patch.
>
> If I understand it correctly CMA wants to define
> a new zone which is somehow similar to movable, but only sometimes used
> when another zone is full (which is the usual state in normal
> operation actually)
>
> It was unclear to me how this was all supposed to work. At least
> as described in the paragraph it cannot I think.

It's not a new zone, just a new migrate type.  I haven't tested it yet,
but the idea is that once pageblock's migrate type is set to this
new MIGRATE_CMA type, buddy allocator never changes it and in
fallback list it's put on the end of entries for MIGRATE_RECLAIMABLE
and MIGRATE_MOVABLE.

If I got everything right, this means that pages from MIGRATE_CMA pageblocks
are available for movable and reclaimable allocations but not for unmovable.

-- 
Best regards,                                        _     _
| Humble Liege of Serenely Enlightened Majesty of  o' \,=./ `o
| Computer Science,  Micha? "mina86" Nazarewicz       (o o)
+----[mina86*mina86.com]---[mina86*jabber.org]----ooO--(_)--Ooo--
