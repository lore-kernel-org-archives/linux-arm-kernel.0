From: chanho.min@lge.com (Chanho Min)
Date: Thu, 18 Sep 2014 16:24:15 +0900
Subject: [PATCH v2] ARM: timer-sp: ensure interrupt is cleared
 at	sp804_of_init
In-Reply-To: <20140917115758.GQ12361@n2100.arm.linux.org.uk>
References: <1410953686-15072-1-git-send-email-chanho.min@lge.com>
 <20140917115758.GQ12361@n2100.arm.linux.org.uk>
Message-ID: <002c01cfd311$8d3e0330$a7ba0990$@min@lge.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
> Sent: Wednesday, September 17, 2014 8:58 PM
> To: Chanho Min
> Cc: Stephen Boyd; Michael Opdenacker; Linus Walleij; linux-arm-kernel at lists.infradead.org; linux-
> kernel at vger.kernel.org; Jongsung Kim
> Subject: Re: [PATCH v2] ARM: timer-sp: ensure interrupt is cleared at sp804_of_init
> 
> On Wed, Sep 17, 2014 at 08:34:46PM +0900, Chanho Min wrote:
> > sp804 may not be added to the tick device if the higher device is
> > already registered. In this case, If pending interrupt is existed
> > (usually It will be passed from the boot loader), inetrrupt is occured
> > without event_handler then it cause kernel panic. So Interrupts
> > should be cleared before clockevent is registered.
> >
> > Changes since v1:
> >  - Move to sp804_of_init
> >  - Clear TIMER2 interrupt
> >  - Update commit log
> >
> > Signed-off-by: Chanho Min <chanho.min@lge.com>
> > ---
> >  arch/arm/common/timer-sp.c |    4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/arch/arm/common/timer-sp.c b/arch/arm/common/timer-sp.c
> > index fd6bff0..e3cc08e 100644
> > --- a/arch/arm/common/timer-sp.c
> > +++ b/arch/arm/common/timer-sp.c
> > @@ -226,6 +226,10 @@ static void __init sp804_of_init(struct device_node *np)
> >  	writel(0, base + TIMER_CTRL);
> >  	writel(0, base + TIMER_2_BASE + TIMER_CTRL);
> >
> > +	/* Ensure interrupt is cleared */
> > +	writel(1, base + TIMER_INTCLR);
> > +	writel(1, base + TIMER_2_BASE + TIMER_INTCLR);
> 
> NAK.
> 
> This is really not necessary for two reasons, and incorrect for a third
> reason:
> 
> 1. If the control register is cleared, interrupts are disabled.  When
>    interrupts are disabled, the IRQ line from the timer module is
>    deasserted irrespective of the internal interrupt state of the timer.
> 

Even if the control register is cleared and interrupts are disabled,
It is not harmful before timer is enabled but It is rather harmful
if interrupt is asserted before timer up. My patch just ensure interrupt
is cleared before timer up

> 2. We only enable the interrupt when we set the timer up to run in either
>    periodic or one-shot modes.  If the timer is not used, the interrupt
>    remains masked.
> 
In our test, setup_irq enables the interrupt irrespective of the timer up/down.

> 3. Even if this was necessary (which it isn't), only doing this in the
>    sp804_of_init() path is wrong - there are other initialisation paths
>    in this code, and there's no reason why one should have a different
>    behaviour to the others.

So Can another approach be acceptable as bellows?

diff --git a/arch/arm/common/timer-sp.c b/arch/arm/common/timer-sp.c
index fd6bff0..4aed813 100644
--- a/arch/arm/common/timer-sp.c
+++ b/arch/arm/common/timer-sp.c
@@ -121,8 +121,8 @@ static irqreturn_t sp804_timer_interrupt(int irq, void *dev_id)
 
        /* clear the interrupt */
        writel(1, clkevt_base + TIMER_INTCLR);
-
-       evt->event_handler(evt);
+       if(evt->event_handler)
+               evt->event_handler(evt);
 
        return IRQ_HANDLED;
 }

> If you've found this by running the kernel with QEMU, then it's probably
> a QEMU bug if it raises an interrupt during the above code.
> 
> --
> FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
> according to speedtest.net.

Chaho
