From: slapdau@yahoo.com.au (Craig McGeachie)
Date: Thu, 26 Sep 2013 20:19:18 +1200
Subject: [PATCH] irq: bcm2835: Re-implement the hardware IRQ handler.
In-Reply-To: <5e0b6222e8648fb0c63aa649ee70b29d11f4924f@8b5064a13e22126c1b9329f0dc35b8915774b7c3.invalid>
References: <1379751251-2799-1-git-send-email-slapdau@yahoo.com.au>
 <5e0b6222e8648fb0c63aa649ee70b29d11f4924f@8b5064a13e22126c1b9329f0dc35b8915774b7c3.invalid>
Message-ID: <5243EE06.1020200@yahoo.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/24/2013 03:38 PM, Stephen Warren wrote:
> I'm not actually sure that's a good change. If we read e.g. PEND1 and
> saw 4 bits asserted, why wouldn't we optimize by handling each of those
> 4 bits. Re-reading the PEND1 register for each bit, and presumably
> seeing the exact same set of remaining bits still set (or even more),
> just seems like a waste. We know we're going to have to process all the
> interrupts, so why not just process them?


On 09/25/2013 11:33 PM, Simon Arlott wrote:
> On Sat, September 21, 2013 09:14, Craig McGeachie wrote:
>>   * Restore the flow of control that re-reads the base pending register
>>     after handling any interrupt. The current version handles all
>>     interrupts found in a GPU pending register before re-reading the
>>     base pending register. In the original Broadcom assembly code, there
>>     appear to be defect tracking numbers next to code inserted to create
>>     this behaviour.
>
> This was by design so that continuous interrupts in a bank did not impact
> progress of interrupts in other bank. If there are defects with this
> strategy, then check that they do not exist in your interrupt handlers
> instead of the interrupt controller itself. Unless there is a real bug
> in the interrupt controller, you're decreasing the performance by
> re-reading the base pending register every time.

I don't understand the concern with re-reading two volatile registers 
between each dispatch.  Given the amount of processing that occurs 
between the call to handle_IRQ and the calls to the possibly multiple 
registered interrupt handlers, plus the processing that the handlers 
perform (even if they are implemented as top/bottom halves), I think the 
performance overhead of the two extra reads is vanishingly small.  In 
fact, I think that focusing on eliminating them is premature 
optimisation.  Developers are notoriously bad at identifying performance 
hotspots through visual inspection.

The point about the registers being volatile is important.  It's a C 
keyword for a very good reason. The state of those registers can change 
due to actions that the interrupt controller knows nothing about.  And 
as noted previously, there is in fact quite a lot of time for them to 
change. Especially with over a dozen bits of independent silicon logic 
beavering away.  I don't think the interrupt controller code can make 
any assumptions about which future interrupts it may, or may not, have 
to dispatch.

Let's start with the DMA controller as an example.  There are 15 
channels (maybe 16 but I think one is unusable by the ARM core) mapped 
onto 12 interrupt lines.  As well as 12 IRQs that the DMA controller 
module could register for, there is a 16 bit register that it can read 
to find the current interrupt status of all DMA channels.  The register 
is also documented as writeable, so my guess is that it is also the 
acknowledgement mechanism.  Given the overloading of the interrupt 
lines, I imagine the chip designers added this to resolve the issue of 
overloaded interrupts[1].  I'm going to be understandably cautious about 
saying this, but there doesn't seem to be any reason that the DMA 
controller couldn't read all the interrupt status bits in its register 
and optimise processing by handling them all at once.[2]

If this is done, and the interrupt controller code doesn't re-read the 
pending registers, then the result is not a minor performance gain, but 
a major performance loss as the execution path between handle_IRQ and 
the DMA handler is needlessly traversed multiple times.

That, and the ability to slave DMA channels to other devices, means 
making assumptions about the validity of the pending status registers is 
a risky proposition.

I don't think you can even assume that more important IRQs won't be 
raised.  I think the mailbox might be an example.  With the callback 
mechanism that Jassi Brar and Suman Anna implemented, it might even be 
possible to issue mailbox requests from interrupt handlers.  Not totally 
risk free, but avoiding deadlocks should be straight forward.  I'm 
really going out on a limb on this one, but given that device power 
management is a mailbox call to the properties channel, I can easily 
imagine good reasons to turn devices on and off in response to 
interrupts [3].  This really is a stretch.  I think this should be done 
in a tasklet, but I don't want to preclude the possibility that doing it 
from the handler directly is the better implementation option.

And if anyone is going to attempt this sort of trickery, then I'm fairly 
certain that having a well defined interrupt prioritisation scheme is 
going to be important.  Not being able to make a good prediction of 
which interrupt handler will be invoked next because you don't know what 
bit pattern the interrupt controller currently has cached doesn't seem 
good enough.

As I understand it, interrupt prioritisation isn't about some abstract 
notion of fairness.  Some interrupts are just more important than others 
and you handle them first - always.  The way to ensure all interrupts 
are handled is for the handlers to do the minimum amount of work 
required to acknowledge the interrupt, and to schedule future work.  If 
the interrupts are still coming too thick and fast, then you probably 
have some other problem intruding from the outside physical world. 
Masking may or may not help.  It would depend on the situation.

You aren't developing a framework for a bunch of cosseted application 
developers who can't even get basic resource management right.  Your 
users are device driver developers who should damn well know better than 
to hog the system.  And that is the sort of developer who would 
appreciate some more control and some slightly better guarantees from 
other code, even if the rest of the world isn't going to play ball.

Cheers,
Craig.


[1] I'm very sorry about that, but it was irresistible.

[2] Yes, I know that the ARM core isn't allowed to use all the channels 
and has to find out from the videocore which ones are permitted.  I'm 
skipping over that for simplicity's sake.

[3] I'd really like better power management.  There are a lot of people 
building battery powered projects (or solar powered) and I'd like to see 
Linux held up as the poster child for good power management.
