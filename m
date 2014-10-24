From: bjorn@kryo.se (Bjorn Andersson)
Date: Fri, 24 Oct 2014 16:12:55 -0700
Subject: [PATCH] genirq: Introduce irq_read_line()
In-Reply-To: <544A936D.5040409@arm.com>
References: <1408479811-26088-1-git-send-email-bjorn.andersson@sonymobile.com>
 <CAJAp7OgGPZZuCgC8iUiW2jrEVubK=KCATxd6eazdT1x1sSrffg@mail.gmail.com>
 <alpine.DEB.2.11.1410211120430.5308@nanos>
 <544628BF.8010809@arm.com>
 <CAJAp7OjpN-+S=OH1BW6Fcme9mp4qj8AsSNC3_41fhfpYzX-Shg@mail.gmail.com>
 <544A936D.5040409@arm.com>
Message-ID: <CAJAp7OjQ8qRspy_ocUnp+es+HPiR1jULhKK6g4DBXXZcOsABug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 24, 2014 at 10:59 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> Hi Bjorn,
>
> On 24/10/14 18:31, Bjorn Andersson wrote:
>> On Tue, Oct 21, 2014 at 2:34 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
[..]
>> I would prefer to see that you had explicit functions for the various things
>> that you would like to set and get. It would in my eyes give cleaner client
>> code, at the cost of a few extra functions.
>
> I don't really like the idea of having a gazillion of accessors for each
> individual property. I'd rather have an extensible API.
>

Okay, either way will work. Feel free to proceed with your approach.

>>> Basic idea is that you can read (and possibly write back) various
>>> low-level attributes (pending, masked, active) that an interrupt
>>> controller may implement. Given your use case, we should loose the
>>> checks on the interrupt being forwarded, as this makes little sense
>>> outside of virtualization.
>>>
>>
>> Relaxing the forwarding requirement seems to solve my use cases. May I ask why
>> your accessors would only be made available for forwarded IRQs - at a framework
>> level?
>
> This was never intended for wider use, and restricting it to forwarded
> interrupts was a concious design decision, as I find the idea of a
> device driver messing with the internal state of the interrupt
> controller positively repulsive... But hey, the more the merrier.
>

Makes sense and now that it comes without the forwarding part it looks
reasonable.

[..]
>>> I'm planning to respin the series this week, as I have a number of
>>> changes (there is hardly any need for the various states to be reported
>>> atomically, for example), and a number of bugs have been found.
>>>
>>
>> Sounds good, for clarity I would like them to be explicit separate functions.
>> But as long as it's not limited to forwarded IRQs we should be able to use it.
>
> I just pushed out a branch:
> git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git
> irq/irqchip_state
>
> Please let me know if that's useful for you.
>

I think that my irq_read_line() would be equivalent of
irq_get_irqchip_state(IRQCHIP_STATE_PENDING), i.e. the state of the
interrupt ignoring masking. And the rest would be EINVAL.
So I think this would work out just fine for us!


Is ACTIVE the line level with the mask considered and setting ACTIVE,
would that be the same as acking the interrupt? What's the expected
behaviour of setting PENDING?

I would appreciate if you commented the state enum, to make it obvious
what pending and active means.

Regards,
Bjorn
