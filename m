From: slash.tmp@free.fr (Mason)
Date: Sat, 3 Jun 2017 20:20:33 +0200
Subject: Design of interrupt controller driver
In-Reply-To: <8bce8bdd-5801-f0c3-ada3-e1c68acc8913@free.fr>
References: <8bce8bdd-5801-f0c3-ada3-e1c68acc8913@free.fr>
Message-ID: <6f8f3b96-ba86-51a8-1789-4c7d75c92079@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/06/2017 18:49, Mason wrote:

> 1) The interrupt router has 128 inputs and 24 outputs.
> Therefore, several devices have to share an output line.
> I believe they *must* be of the same interrupt type?
> In the limit, we could use
> - 1 output line for level high
> - 1 output line for level low
> - 1 output line for edge rising
> - 1 output line for edge falling
> Is that correct?
>
> 2) Assume a device that signals an interrupt by pulsing
> its interrupt line, i.e. the signal rises and then falls
> a few cycles later. Assume we have grouped several such
> devices on a single output line. When an interrupt triggers,
> I see no way to determine which device requested attention
> from the processor.
> Does this mean that edge interrupts cannot be grouped
> on a single output line for such a controller?

A year ago, maz wrote:

> OK, so this is definitely a pure router, and the lack of latch makes 
> it completely unsuitable for a a cascaded interrupt controller. At 
> least, we've managed to establish that this thing will never be able 
> to handle more than 24 devices in a sane way. So let's forget about 
> Mason's idea of cascading everything to a single output line, and 
> let's focus on your initial idea of having something similar to TI's 
> crossbar, which is a much saner approach.
Then later added:

> Unless you limit your mux [to] level interrupts only, I cannot see how
> you could deal with cascaded interrupts. By the time you receive an
> edge, the line will have dropped, and you won't be able to identify
> the source interrupt.
To recap:
Sharing level interrupts would be OK.
Sharing "pulse" (rapid high/low) interrupts is impossible.
Sharing the DMA interrupts should be OK.

AFAIK, there are no devices using "pulses" in the system.

Will carefully re-read the July patch RFC.

Regards.
