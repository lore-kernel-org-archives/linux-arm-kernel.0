From: andy.gross@linaro.org (Andy Gross)
Date: Tue, 19 Jul 2016 17:47:13 -0500
Subject: SOC-specific action for irq_set_wake
In-Reply-To: <20160719181804.GX3847@xsjsorenbubuntu>
References: <20160719181804.GX3847@xsjsorenbubuntu>
Message-ID: <20160719224713.GA13533@hector.attlocal.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 19, 2016 at 11:18:04AM -0700, S?ren Brinkmann wrote:
> Hi,
> 
> we are working on the PM solution for Zynq MPSOC and ran into some
> problem when setting the wake source.
> 
> The situation is that when the A53 is in suspend, the GIC(v2) may be
> powered down. In that state a companion core is handling wake
> events/IRQs, but we expect the OS/Linux to notify the companion core
> about what device/IRQ is a wake up source. Hence, my idea was to capture
> enabling/disabling wake IRQs in our platform PM code and then
> communicate with the FW as needed during suspend operations. The problem
> is: I don't see a good way to notify the platform code about these
> events.

On Qualcomm platforms there is something similar.  When the system is power
collapsed, the GIC loses context and can no longer handle/generate IRQs.  There
is a separate block called the MPM that provides some registers that the user
can program.  These registers allow for up to 64 wake IRQs, each of which can
map to either a GPIO pin or an GIC IRQ.  The MPM also has a timer that can
generate a wake IRQ so that the system can wake up and maintain the time.

> 
> My ideas were:
> 1. Use the irq_chip irq_set_wake function
>   My thought was to implement the irq_set_wake function in a
>   SOC-specific way (could even be generic and call some notifier chain or
>   similar) to notify the platform PM code when a device/IRQ is
>   enabled/disabled as wake up source.
>   My problem is that the SKIP_IRQ_SET_WAKE flag is set in the generic
>   driver (drivers/irqchip/irq-gic.c) and platforms cannot implement
>   irq_set_wake without changes in the common code.

So not too long ago there were irq extensions that you could add in to an irq
controller that would allow for intercepting the set wake calls.  This went away
and was replaced by the hierarchical irq design.

The way I am currently implementing the MPM for Qualcomm, I am defining the MPM
as a IRQ controller and creating relationships between the MPM and the GPIO
controller (source of irqs) and the GIC.  As irqs are set wake and cleared the
calls go up through the hierarchy and they call each irqchips functions (if you
have it setup to do that).


> 2. Stuff things into the secure monitor
>   I guess we could read the GIC registers once we enter the secure
>   monitor and do the communication with the companion core from there by
>   identifying unmasked IRQs as wake IRQs. My concern here is that it
>   might introduce additional hardcoded mappings that are much more
>   dynamic in Linux thanks to the DT description.

This could work, but you'd have to have control of the secure monitor code.  In
Qualcomm's case, that wouldn't work or couldn't because they won't change that
code.  And you'd have to have calls into the monitor to turn on/off the lines.

> 
> Does anybody have similar problems and probably already solved it?
> Any other suggestions for approaching the problem? Any preferred
> solution?

I think we have the same problem.  Can you provide more detail on the hardware
implementation of your wake irq controller?  I presume you have some set of
registers, an irq maybe, and some other stuff?  And how does it fit into the
overall architecture from a hardware perspective?

Regards,

Andy Gross
