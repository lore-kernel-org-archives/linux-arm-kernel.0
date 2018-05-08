From: dianders@chromium.org (Doug Anderson)
Date: Tue, 8 May 2018 12:46:25 -0700
Subject: [RESEND PATCH] pinctrl: rockchip: Disable interrupt when changing
 it's capability
In-Reply-To: <20180508015623.GA61455@rodete-desktop-imager.corp.google.com>
References: <20180503065553.7762-1-jeffy.chen@rock-chips.com>
 <20180507221511.GA6448@rodete-desktop-imager.corp.google.com>
 <5AF0FF18.1050905@rock-chips.com>
 <20180508015623.GA61455@rodete-desktop-imager.corp.google.com>
Message-ID: <CAD=FV=W_v+aoNT09k-2exVABTFzOp0heY-XWcLi95uPisZhiGQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, May 7, 2018 at 6:56 PM, Brian Norris <briannorris@chromium.org> wrote:
> On Tue, May 08, 2018 at 09:36:24AM +0800, Jeffy Chen wrote:
>> On 05/08/2018 06:15 AM, Brian Norris wrote:
>> > On the other hand...this also implies there may be a race condition
>> > there, where we might lose an interrupt if there is an edge between the
>> > re-configuration of the polarity in rockchip_irq_demux() and the
>> > clearing/handling of the interrupt (handle_edge_irq() ->
>> > chip->irq_ack()). If we have an edge between there, then we might ack
>> > it, but leave the polarity such that we aren't ready for the next
>> > (inverted) edge.
>>
>> if let me guess, the unexpected irq we saw is the hardware trying to avoid
>> losing irq? for example, we set a EDGE_RISING, and the hardware saw the gpio
>> is already high, then though it might lost an irq, so fake one for safe?
>
> I won't pretend to know what the IC designers were doing, but I don't
> think that would resolve the problem I'm talking about. The sequence is
> something like:
> 1. EDGE_BOTH IRQ occurs (e.g., low to high)
> 2. reconfigure polarity in rockchip_irq_demux() (polarity=low)
> 3. continue to handle_edge_irq()
> 4. another HW edge occurs (e.g., high to low)
> 5. handle_edge_irq() (from 3) acks (clears) IRQ (before a subsequent
>    rockchip_irq_demux() gets a chance to run and flip the polarity)
> ...
>
> Now the polarity is still low, but the next trigger should be a
> low-to-high edge.
>
>> i'll try to confirm it with IC guys.

One note is that in the case Brian points at (where we need to
simulate EDGE_BOTH by swapping edges) we purposely ignored the TRM and
we needed to do that to avoid losing interrupts.  For details, see
commit 53b1bfc76df2 ("pinctrl: rockchip: Avoid losing interrupts when
supporting both edges").  We did this because:

1. We believed that the IP block in Rockchip SoCs has nearly the same
logic as "gpio-dwapb.c" and that's what "gpio-dwapb.c" did.

2. We were actually losing real interrupts and this was the only way
we could figure out how to fix it.

When I tested that back in the day I was fairly convinced that we
weren't losing any interrupts in the EDGE_BOTH case after my fix, but
I certainly could have messed up.


For the EDGE_BOTH case it was important not to lose an interrupt
because, as you guys are talking about, we could end up configured the
wrong way.  I think in your case where you're just picking one
polarity losing an interrupt shouldn't matter since it's undefined
exactly if an edge happens while you're in the middle of executing
rockchip_irq_set_type().  Is that right?


-Doug
