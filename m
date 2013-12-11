From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 11 Dec 2013 21:13:33 +0000
Subject: [PATCH] arm64: Correct virt_addr_valid
In-Reply-To: <20131211172635.GJ26730@mudshark.cambridge.arm.com>
References: <1386724982-16997-1-git-send-email-lauraa@codeaurora.org>
 <1386724982-16997-2-git-send-email-lauraa@codeaurora.org>
 <20131211104429.GE26730@mudshark.cambridge.arm.com>
 <20131211110618.GG4360@n2100.arm.linux.org.uk>
 <20131211172635.GJ26730@mudshark.cambridge.arm.com>
Message-ID: <20131211211333.GI4360@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 11, 2013 at 05:26:35PM +0000, Will Deacon wrote:
> On Wed, Dec 11, 2013 at 11:06:18AM +0000, Russell King - ARM Linux wrote:
> > On Wed, Dec 11, 2013 at 10:44:29AM +0000, Will Deacon wrote:
> > > Hmm, this is pretty expensive on both arm and arm64, since we end up doing a
> > > binary search through all of the memblocks.
> > 
> > People say "binary search == expensive" almost as a knee jerk
> > reaction, because classical thinking is that binary searches are
> > expensive for systems with caches.  Have you considered how many
> > memblocks you end up with on a normal system?
> > 
> > How expensive is a binary search across one element?  Two elements?
> > Four elements?  In the very very rare case (there's only one platform)
> > eight elements?
> > 
> > For one element, it's the same as a linear search - we only have to
> > look at one element and confirm whether the pointer is within range.
> > Same for two - we check one and check the other.  As memblock is array
> > based, both blocks share the same cache line.
> > 
> > For four, it means we look at most three elements, at least two of
> > which share a cache line.  In terms of cache line loading, it's no
> > more expensive than a linear search.  In terms of CPU cycles, it's
> > a win because we don't need to expend cycles looking at the fourth
> > element.
> > 
> > For eight (which is starting to get into the "rare" territory, and
> > three cache lines, four elements vs a linear search which can be up
> > to four cache lines and obviously eight elements.
> > 
> > Now, bear in mind that the normal case is one, there's a number with
> > two, four starts to become rare, and eight is almost non-existent...
> 
> Sure, but it's going to be notably more expensive than what we currently
> have. The question then is: does this code occur frequently (i.e. in a loop)
> on some hot path?
> 
> Turning to grep, the answer seems to be "no", so I'll stop complaining about
> a problem that we don't have :)

There is actually a concern here, and that's if the v:p translation isn't
linear, could it return false results?

According to my grep skills, we have one platform where this is true -
Realview:

 * 256MB @ 0x00000000 -> PAGE_OFFSET
 * 512MB @ 0x20000000 -> PAGE_OFFSET + 0x10000000
 * 256MB @ 0x80000000 -> PAGE_OFFSET + 0x30000000

The v:p translation is done via:

         ((virt) >= PAGE_OFFSET2 ? (virt) - PAGE_OFFSET2 + 0x80000000 : \
          (virt) >= PAGE_OFFSET1 ? (virt) - PAGE_OFFSET1 + 0x20000000 : \
          (virt) - PAGE_OFFSET)

Now the questions - what do values below PAGE_OFFSET give us?  Very
large numbers, which pfn_valid() should return false for.  What about
values > PAGE_OFFSET2 + 256MB?  The same.

So this all _looks_ fine.  Wait a moment, what about highmem?  Let's say
that the last 256MB is only available as highmem, and let's go back to
Laura's patch:

old:
#define	virt_addr_valid(kaddr)	(((void *)(kaddr) >= (void *)PAGE_OFFSET) && \
				 ((void *)(kaddr) < (void *)high_memory))
new:
#define	virt_addr_valid(kaddr)	pfn_valid(__pa(kaddr) >> PAGE_SHIFT)

The former _excludes_ highmem, but the latter _includes_ it.

virt_addr_valid(v) should only ever return _true_ for the lowmem area,
never anywhere else - that's part of its point.  It's there to answer
the question "is this a valid virtual pointer which I can dereference".

So... We actually need a combination of both of these tests.
