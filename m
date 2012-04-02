From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Mon, 2 Apr 2012 13:27:07 -0500
Subject: [BUG?] vic MULTI_IRQ_HANDLER (was [PATCH] ep93xx: Implement
 double buffering for M2M DMA channels)
In-Reply-To: <CACb=_tQ4pSXtmKnqM23p97iyRbnrdZicw6ao68t2KjL46srAuQ@mail.gmail.com>
References: <ADE657CA350FB648AAC2C43247A983F0020698409ABF@AUSP01VMBX24.collaborationhost.net>
 <CACb=_tQ4pSXtmKnqM23p97iyRbnrdZicw6ao68t2KjL46srAuQ@mail.gmail.com>
Message-ID: <ADE657CA350FB648AAC2C43247A983F0020698409AE8@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, April 02, 2012 11:16 AM, Jamie Iles wrote:
> Hi Hartley,
>
> On 2 April 2012 18:55, H Hartley Sweeten <hartleys@visionengravers.com> wrote:
>> The root cause appears to be the timer interrupt causing a new iteration over
>> the VIC's to start before the current iteration is complete. Both iterations are
>> reading the vic status register and seeing an interrupt pending for irq 18. One of
>> the iterations properly handles this interrupt but, because the status register is
>> only ready once, the other iteration also tries to handle the interrupt. Since it's
>> already been handled we end up with the spurious interrupt.
>>
>> So...
>>
>> 1) Are interrupts supposed to be still enabled when vic_handle_irq is called to
>> handle the pending interrupts the first time? If they "are" disabled, what is
>> re-enabling them and causing the timer interrupt to start a new iteration?
>
> No, I believe that at this point IRQ's should be disabled.  This gets
> called very early by the entry macros, and not much has run before
> this gets called.  I can only guess that something inside one of the
> interrupt handlers is reenabling interrupts for some period.

I don't see anything in the relevant ep93xx drivers that would be re-enabling the
interrupts.

>
>> 2) Should the vic status be re-checked after each interrupt is handled in
>> handle_one_vic? This could cause a problem where an aggressive interrupt,
>> i.e. the timer on ep93xx, could cause other interrupts to not get handled quickly.
>
> No, I think I may have had this when I first introduced this code and
> there were objections to the fairness of that, so the current approach
> where we try and service each interrupt before restarting was the most
> fair way of doing it.

I remember seeing this discussion on the list. I agree the current approach
is the most "fair" way of handling the interrupts.

> I wonder if looking at IRQ tracing to find out when and where
> interrupts are being enabled from might be useful for tracking this
> down.

I'm willing to do the IRQ tracing... How... ;-)

I don't see anything in the Kernel Hacking options to enable IRQ tracing.

Regards,
Hartley
