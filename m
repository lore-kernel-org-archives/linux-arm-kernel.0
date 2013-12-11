From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 11 Dec 2013 11:06:18 +0000
Subject: [PATCH] arm64: Correct virt_addr_valid
In-Reply-To: <20131211104429.GE26730@mudshark.cambridge.arm.com>
References: <1386724982-16997-1-git-send-email-lauraa@codeaurora.org>
 <1386724982-16997-2-git-send-email-lauraa@codeaurora.org>
 <20131211104429.GE26730@mudshark.cambridge.arm.com>
Message-ID: <20131211110618.GG4360@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 11, 2013 at 10:44:29AM +0000, Will Deacon wrote:
> Hmm, this is pretty expensive on both arm and arm64, since we end up doing a
> binary search through all of the memblocks.

People say "binary search == expensive" almost as a knee jerk
reaction, because classical thinking is that binary searches are
expensive for systems with caches.  Have you considered how many
memblocks you end up with on a normal system?

How expensive is a binary search across one element?  Two elements?
Four elements?  In the very very rare case (there's only one platform)
eight elements?

For one element, it's the same as a linear search - we only have to
look at one element and confirm whether the pointer is within range.
Same for two - we check one and check the other.  As memblock is array
based, both blocks share the same cache line.

For four, it means we look at most three elements, at least two of
which share a cache line.  In terms of cache line loading, it's no
more expensive than a linear search.  In terms of CPU cycles, it's
a win because we don't need to expend cycles looking at the fourth
element.

For eight (which is starting to get into the "rare" territory, and
three cache lines, four elements vs a linear search which can be up
to four cache lines and obviously eight elements.

Now, bear in mind that the normal case is one, there's a number with
two, four starts to become rare, and eight is almost non-existent...
