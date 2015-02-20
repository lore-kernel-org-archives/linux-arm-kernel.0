From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Fri, 20 Feb 2015 15:53:47 +0100
Subject: [PATCH v4 3/5] irqchip: Add DT binding doc for the virtual irq
 demuxer chip
In-Reply-To: <20150220142208.GJ13659@leverpostej>
References: <1422527620-8308-1-git-send-email-boris.brezillon@free-electrons.com>
 <2437801.56xPyk3atd@vostro.rjw.lan>
 <20150211151237.GN9154@leverpostej>
 <1487331.cgC9j5u0aF@vostro.rjw.lan>
 <20150211155720.GQ9154@leverpostej>
 <20150211171515.55d5066f@bbrezillon>
 <20150211163231.GR9154@leverpostej>
 <20150211173823.30c42c6a@bbrezillon>
 <20150220142208.GJ13659@leverpostej>
Message-ID: <20150220155347.1477b02d@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Fri, 20 Feb 2015 14:22:08 +0000
Mark Rutland <mark.rutland@arm.com> wrote:

> Hi Boris,
> 
> On Wed, Feb 11, 2015 at 04:38:23PM +0000, Boris Brezillon wrote:
> 
> [...]
> 
> > For the list of impacted drivers, you can have a look at this series [1]
> > (patches 2 to 5), and I'll take care of the testing part once every one
> > has agreed on the solution ;-).
> > 
> > [1]https://lkml.org/lkml/2014/12/15/552
> 
> Looking at those:
> 
> * The pmc looks like it could be a valid use of the new flag. It also
>   seems to function as an irqchip.
>   
>   Do any of its child IRQs need to be handled during the suspend-resume
>   cycle? If so using IRQF_NO_SUSPEND would seem to be valid.

No they don't, they are used for clock activation only, and thus should
be disabled on suspend.

> 
> * atmel_serial seems to be intended to be used as a wakeup device (given
>   it calls device_set_wakeup_enable). Therefore it needs to call
>   enable_irq_wake, and when it does so it can share an IRQ with other
>   interrupts, just not IRQF_NO_SUSPEND interrupts.

I'll have a look, but AFAIR serial core already taking care of that.

>   
>   None of the approaches thus far can fix the fundamental mismatch
>   between wakeup interrupts and IRQF_NO_SUSPEND interrupts.
> 
> * Similarly, rtc-at91rm9200 and rtc-at91sam9 are intended to be used as 
>   wakeup devices. They call enable_irq_wake (though don't bother
>   checking the return value). They can share an IRQ with other
>   interrupts, just not IRQF_NO_SUSPEND interrupts.

Yep.

> 
> * at91sam9_wdt seems to be fundamentally incompatible with suspend. If
>   the watchdog cannot be disabled, and you need to handle it during
>   suspend, then it needs to be a wakeup interrupt, not an
>   IRQF_NO_SUSPEND interrupt.

You forgot the PIT timer, which is the one in cause here (no other
drivers are specifying this IRQF_NO_SUSPEND flag), and, as you already
know, a timer sets the IRQF_NO_SUSPEND flag.

> 
> As far as I can see, the flag or virtual irqchip approaches only help
> the PMC case, and even then might not be necessary. All the others seem
> to be relying on guarantees the genirq layer don't provide, and fixing
> that would mean moving them further from IRQF_NO_SUSPEND.

I don't know what you're trying to prove here, but I never said my goal
was to set IRQF_NO_SUSPEND flags on existing at91 drivers ?
The problem here, is that all those IPs are sharing the irq line with a
timer which sets IRQF_NO_SUSPEND.

I just want to be able to share an irq line with a timer and other
devices that do not set IRQF_NO_SUSPEND.
Could we focus on that ?

Best Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
