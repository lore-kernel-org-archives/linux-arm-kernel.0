From: m.nazarewicz@samsung.com (=?utf-8?B?TWljaGHFgiBOYXphcmV3aWN6?=)
Date: Thu, 26 Aug 2010 04:40:46 +0200
Subject: [PATCH/RFCv4 0/6] The Contiguous Memory Allocator framework
In-Reply-To: <20100825155814.25c783c7.akpm@linux-foundation.org>
References: <cover.1282286941.git.m.nazarewicz@samsung.com>
	<1282310110.2605.976.camel@laptop>
	<20100825155814.25c783c7.akpm@linux-foundation.org>
Message-ID: <op.vh0xp8ix7p4s8u@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Andrew,

I think Pawel has replied to most of your comments, so I'll just add my own
0.02 KRW. ;)

> Peter Zijlstra <peterz@infradead.org> wrote:
>> So the idea is to grab a large chunk of memory at boot time and then
>> later allow some device to use it?
>>
>> I'd much rather we'd improve the regular page allocator to be smarter
>> about this. We recently added a lot of smarts to it like memory
>> compaction, which allows large gobs of contiguous memory to be freed for
>> things like huge pages.
>>
>> If you want guarantees you can free stuff, why not add constraints to
>> the page allocation type and only allow MIGRATE_MOVABLE pages inside a
>> certain region, those pages are easily freed/moved aside to satisfy
>> large contiguous allocations.

On Thu, 26 Aug 2010 00:58:14 +0200, Andrew Morton <akpm@linux-foundation.org> wrote:
> That would be good.  Although I expect that the allocation would need
> to be 100% rock-solid reliable, otherwise the end user has a
> non-functioning device.  Could generic core VM provide the required level
> of service?

I think that the biggest problem is fragmentation here.  For instance,
I think that a situation where there is enough free space but it's
fragmented so no single contiguous chunk can be allocated is a serious
problem.  However, I would argue that if there's simply no space left,
a multimedia device could fail and even though it's not desirable, it
would not be such a big issue in my eyes.

So, if only movable or discardable pages are allocated in CMA managed
regions all should work well.  When a device needs memory discardable
pages would get freed and movable moved unless there is no space left
on the device in which case allocation would fail.

Critical devices (just a hypothetical entities) could have separate
regions on which only discardable pages can be allocated so that memory
can always be allocated for them.

> I agree that having two "contiguous memory allocators" floating about
> on the list is distressing.  Are we really all 100% diligently certain
> that there is no commonality here with Zach's work?

As Pawel said, I think Zach's trying to solve a different problem.  No
matter, as I've said in response to Konrad's message, I have thought
about unifying Zach's IOMMU and CMA in such a way that devices could
work on both systems with and without IOMMU if only they would limit
the usage of the API to some subset which always works.

> Please cc me on future emails on this topic?

Not a problem.

-- 
Best regards,                                        _     _
| Humble Liege of Serenely Enlightened Majesty of  o' \,=./ `o
| Computer Science,  Micha? "mina86" Nazarewicz       (o o)
+----[mina86*mina86.com]---[mina86*jabber.org]----ooO--(_)--Ooo--
