From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 20 Jul 2016 08:28:35 +0200 (CEST)
Subject: SOC-specific action for irq_set_wake
In-Reply-To: <20160719181804.GX3847@xsjsorenbubuntu>
References: <20160719181804.GX3847@xsjsorenbubuntu>
Message-ID: <alpine.DEB.2.11.1607200759230.3564@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 19 Jul 2016, S?ren Brinkmann wrote:
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
> 
> My ideas were:
> 1. Use the irq_chip irq_set_wake function
>   My thought was to implement the irq_set_wake function in a
>   SOC-specific way (could even be generic and call some notifier chain or

Don't even think about notifier chains.

>   similar) to notify the platform PM code when a device/IRQ is
>   enabled/disabled as wake up source.
>   My problem is that the SKIP_IRQ_SET_WAKE flag is set in the generic
>   driver (drivers/irqchip/irq-gic.c) and platforms cannot implement
>   irq_set_wake without changes in the common code.

So and because it requires changes in the common code you think aboiut
notifiers and other absurdities. Come on, common code is not a sacred cow. It
can be modified and if you need for your particular platform that
SKIP_IRQ_SET_WAKE is cleared, then there are a gazillion of sane ways to do
that.

Thanks,

	tglx
