From: slash.tmp@free.fr (Mason)
Date: Sun, 4 Jun 2017 19:18:59 +0200
Subject: Design of interrupt controller driver
In-Reply-To: <alpine.DEB.2.20.1706041551530.2813@nanos>
References: <8bce8bdd-5801-f0c3-ada3-e1c68acc8913@free.fr>
 <alpine.DEB.2.20.1706041551530.2813@nanos>
Message-ID: <025780ef-06e6-1e85-58da-4ce8f6c93536@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/06/2017 15:55, Thomas Gleixner wrote:

> On Sat, 3 Jun 2017, Mason wrote:
>
>> 1) The interrupt router has 128 inputs and 24 outputs.
>> Therefore, several devices have to share an output line.
>> I believe they *must* be of the same interrupt type?
>> In the limit, we could use
>> - 1 output line for level high
>> - 1 output line for level low
>> - 1 output line for edge rising
>> - 1 output line for edge falling
>> Is that correct?
> 
> No. You CANNOT share edge type interrupts, simply because it might be
> impossible to figure out which device fired the interrupt.

I understand that now.
It dawned on me in point 2.

The interrupt controller's designers consider that
"pulse" interrupt requests are "broken by design",
because they can be missed if the edge detector is
sampling at too low a frequency.

>> As for the DMA interrupt, the HW designers consider it
>> a level interrupt. When the engine is busy processing
>> a command, the interrupt signal is low; when the engine's
>> command queue is empty, the interrupt signal is high.
>> Thus, there is no risk of "missing a pulse". But maz
>> has stated twice that the relevant *event* is the
>> transition from "busy" to "idle", which makes this
>> an edge (rising) interrupt. However, it doesn't have
>> the problem described in 2)  The interrupt signal
>> will remain high, so there is no risk of "missing"
>> a pulse. So they can be grouped. Is that correct?
> 
> That depends on the DMA controller. If you can disable the interrupt line
> at the DMA device level, then you can use that scheme. If not, you'll get
> an interrupt storm as long as the DMA engine is idle.

I don't follow. If the interrupt is configured
as rising edge, only transitions from busy to
idle will trigger an interrupt. The interrupt
storm would be if the interrupt is configured
level high. Right?

I'm using a DMA driver right now which expects
the ISR to be invoked on rising edges, and
everything works as expected.

Regards, and have a nice weekend.
