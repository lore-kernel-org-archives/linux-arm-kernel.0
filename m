From: slash.tmp@free.fr (Mason)
Date: Sat, 3 Jun 2017 18:49:58 +0200
Subject: Design of interrupt controller driver
Message-ID: <8bce8bdd-5801-f0c3-ada3-e1c68acc8913@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

My previous thread was a dud.

I will post a formal patch on Tuesday, but I would like
to clarify a few nagging doubts, the answer to which
have an impact on the driver's design.

1) The interrupt router has 128 inputs and 24 outputs.
Therefore, several devices have to share an output line.
I believe they *must* be of the same interrupt type?
In the limit, we could use
- 1 output line for level high
- 1 output line for level low
- 1 output line for edge rising
- 1 output line for edge falling
Is that correct?

2) Assume a device that signals an interrupt by pulsing
its interrupt line, i.e. the signal rises and then falls
a few cycles later. Assume we have grouped several such
devices on a single output line. When an interrupt triggers,
I see no way to determine which device requested attention
from the processor.
Does this mean that edge interrupts cannot be grouped
on a single output line for such a controller?


I have discussed this limitation with the HW designers.
They said "edge interrupts are not supported".
Looking at the current DT, I see two devices declared
with edge interrupts (DMA engine and ethernet PHY).

Looking more closely at the ethernet PHY description:

"Interrupt Signal to System; default OD-gate, needs an
external 10Kohm pull-up, active low; can be configured
to I/O by register, active high."

As maz points out, this sounds very level.
However, defining it as such in the DT hangs the system,
while it appears to work with edge rising. I don't know
how this is possible, but I have to investigate. Anyone
would care to venture a guess?


As for the DMA interrupt, the HW designers consider it
a level interrupt. When the engine is busy processing
a command, the interrupt signal is low; when the engine's
command queue is empty, the interrupt signal is high.
Thus, there is no risk of "missing a pulse". But maz
has stated twice that the relevant *event* is the
transition from "busy" to "idle", which makes this
an edge (rising) interrupt. However, it doesn't have
the problem described in 2)  The interrupt signal
will remain high, so there is no risk of "missing"
a pulse. So they can be grouped. Is that correct?


Regards.
