From: ming.lei@canonical.com (Ming Lei)
Date: Mon, 29 Aug 2011 23:55:29 +0800
Subject: [PATCH] usb: ehci: fix update qtd->token in qh_append_tds
In-Reply-To: <Pine.LNX.4.44L0.1108290951250.2525-100000@iolanthe.rowland.org>
References: <20110829085209.GB26917@n2100.arm.linux.org.uk>
	<Pine.LNX.4.44L0.1108290951250.2525-100000@iolanthe.rowland.org>
Message-ID: <CACVXFVNTGsaw2jLosqrTOdnZX399VfE7dWuVYvLcN50_bsa+tQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Aug 29, 2011 at 9:57 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Mon, 29 Aug 2011, Russell King - ARM Linux wrote:
>
>> > You know better than I do what is needed to resolve the ordering issue.
>> > However, contrary to what the original patch description said, this
>> > isn't entirely a matter of making the write visible to the host
>> > controller: No doubt in time the write will eventually become visible
>> > anyway. ?It's a matter of making the write become visible reasonably
>> > quickly and in the correct order with respect to other writes.
>>
>> I'm not entirely sure what the problem is - I think its about a write
>> by the CPU to dma coherent memory being delayed and not being visible
>> to the HC in a timely manner. ?Either mb() or wmb() placed after the
>> write on ARM will do that - and ARM has no requirement to do a read-
>> back after the barrier.
>
> Okay, then this needs to be done in a way that won't slow down other
> architectures with an unnecessary memory barrier. ?And there needs to
> be a comment in the code explaining that the new mb() instruction isn't
> being used as a memory barrier but rather to expedite writeback of the
> L2 cache.

If writing to coherent memory can't reach physical memory immediately on
other ARCHs,  the problem can still happen on these ARCHs. But I am
not sure if there are these kind of ARCHs except for ARM.

Anyway, current memory barriers in qh_append_tds() can't prevent the problem
from happening on ARM.

If no better solutions, maybe we have to use 'mb()' after
'dummy->hw_token = token'
to fix the problem:

>
> This certainly is starting to sound like something that needs to be
> addressed in the arch-specific #include files...
>
>> > Is this extra L2-cache "poke" needed for proper ordering, or is it
>> > needed merely to flush the write out to memory in a timely manner?
>>
>> Both, though primerily it's about ensuring correct ordering. ?A side
>> effect of it is that it will flush all pending writes in L2 before
>> completing.
>>
>> From the theoretical viewpoint, I think I'm right to say that mb()
>> doesn't need to provide that level of ordering as its supposed to be
>> an inter-CPU barrier - which probably means we need to invent a new
>> barrier to deal with DMA memory ordering. ?However, given the
>> difficulty of getting the existing barriers placed correctly, I don't
>> think inventing new barriers is a very good idea.
>>
>> What we can do is view devices which perform DMA as being strongly
>> ordered with respect to their memory accesses - iow, they have an
>> implicit memory barrier before and after their accesses to memory.
>> This would make the CPUs use of mb() have a conceptual pairing with
>> the DMA agents.
>
> Yes, that's the model I have been using all along. ?After all, if a DMA
> master carries out its memory accesses in some random order then it's
> impossible for the CPU to make any guarantees.
>
> Alan Stern
>
>
