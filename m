From: jamie@jamieiles.com (Jamie Iles)
Date: Mon, 2 Apr 2012 19:16:11 +0100
Subject: [BUG?] vic MULTI_IRQ_HANDLER (was [PATCH] ep93xx: Implement
 double buffering for M2M DMA channels)
In-Reply-To: <ADE657CA350FB648AAC2C43247A983F0020698409ABF@AUSP01VMBX24.collaborationhost.net>
References: <ADE657CA350FB648AAC2C43247A983F0020698409ABF@AUSP01VMBX24.collaborationhost.net>
Message-ID: <CACb=_tQ4pSXtmKnqM23p97iyRbnrdZicw6ao68t2KjL46srAuQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hartley,

On 2 April 2012 18:55, H Hartley Sweeten <hartleys@visionengravers.com> wrote:
> Jamie,
>
> We are seeing a problem on ep93xxthat appears to be caused with the MULTI_IRQ_HANDLER
> change to the vic code.
>
> Following is the latest discussion. Maybe you have an idea?
>
> On Sunday, April 01, 2012 11:49 AM, Mika Westerberg wrote:
>> On Thu, Mar 29, 2012 at 05:33:49PM -0500, H Hartley Sweeten wrote:
>>
>>> I tried doing a bit more debugging with the handle_one_vic function. It
>>> appears that the timer tick is what's causing the spi dma interrupts grief.
>>> I'm just not sure how it's happening or how to fix it...
>>>
>>> I modified handle_one_vic to output a message when multiple interrupts
>>> are detected in the stat. Then, if multiple interrupts were detected, to output
>>> a message with the new calculated stat and the actual stat. These "should"
>>> occur one right after the other when multiple interrupts are detected. But
>>> that's not what I'm getting. Here's a sample trace with comments:
>>>
>>> handle_one_vic: stat:0x00060000 - handling irq:17 now
>>> ? ? ?stat shows interrupts 17 and 18
>>> handle_one_vic: stat:0x00040010 - handling irq:4 now
>>> ? ? ?stat shows interrupts 4 and 18, 17 was handled
>>> handle_one_vic: next stat:0x00040000 - actual stat:0x00040000
>>> ? ? ?next stat shows interrupt 18, 4 was handled, 18 is pending
>>> handle_one_vic: stat:0x00040000 - handling irq:18 now
>>> ? ? ?stat shows interrupt 18
>>> handle_one_vic: next stat:0x00000000 - actual stat:0x00000010
>>> ? ? ?next stat shows no interrupts, 18 was handled, 4 is pending
>>> handle_one_vic: next stat:0x00040000 - actual stat:0x00000000
>>> ? ? ?next stat shows interrupt 18, it was already handled, none are pending
>>> handle_one_vic: stat:0x00040000 - handling irq:18 now
>>> ? ? ?stat shows interrupt 18 (which was already handled)
>>> dma dma1chan1: spurious interrupt: status=00002180
>>> ? ? ?bang... spurious interrupt
>>>
>>> It looks like the timer interrupt (4) is causing vic_handle_irq to start
>>> iterating over the VIC's while an iteration is already in progress. ?One
>>> of the iterations is handling interrupt 18 correctly but, since the stat
>>> is only read once, the second iteration also tries to handle it.
>>>
>>> Any ideas?
>>
>> Unfortunately no :-/ I've been investigating this also and so far haven't
>> found anything which could explain this behaviour. It is good that you found
>> that the timer interrupt might have something to do with this. I'm going to
>> add some more debugging code and see if that helps to identify the reason for
>> this.
>>
>> It might also be that the ep93xx_dma driver is doing something wrong in its
>> interrupt handler which causes the DONE bit to stay asserted even though the
>> first thing it does is to write 0 to M2M_INTERRUPT register which is supposed
>> to clear the interrupt..
>
> From what I can tell, the interrupt handler in the ep93xx_dma driver is fine. It
> is clearing the interrupt as it should.
>
> The root cause appears to be the timer interrupt causing a new iteration over
> the VIC's to start before the current iteration is complete. Both iterations are
> reading the vic status register and seeing an interrupt pending for irq 18. One of
> the iterations properly handles this interrupt but, because the status register is
> only ready once, the other iteration also tries to handle the interrupt. Since it's
> already been handled we end up with the spurious interrupt.
>
> So...
>
> 1) Are interrupts supposed to be still enabled when vic_handle_irq is called to
> handle the pending interrupts the first time? If they "are" disabled, what is
> re-enabling them and causing the timer interrupt to start a new iteration?

No, I believe that at this point IRQ's should be disabled.  This gets
called very early by the entry macros, and not much has run before
this gets called.  I can only guess that something inside one of the
interrupt handlers is reenabling interrupts for some period.

> 2) Should the vic status be re-checked after each interrupt is handled in
> handle_one_vic? This could cause a problem where an aggressive interrupt,
> i.e. the timer on ep93xx, could cause other interrupts to not get handled quickly.

No, I think I may have had this when I first introduced this code and
there were objections to the fairness of that, so the current approach
where we try and service each interrupt before restarting was the most
fair way of doing it.

I wonder if looking at IRQ tracing to find out when and where
interrupts are being enabled from might be useful for tracking this
down.

Jamie
