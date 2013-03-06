From: lethal@linux-sh.org (Paul Mundt)
Date: Wed, 6 Mar 2013 10:06:16 +0900
Subject: [PATCH 1/3] clocksource: sh_cmt: Add Device Tree probing
In-Reply-To: <20130305094305.GB15661@e106331-lin.cambridge.arm.com>
References: <1362159932-18533-1-git-send-email-hechtb+renesas@gmail.com>
 <1362159932-18533-2-git-send-email-hechtb+renesas@gmail.com>
 <20130304100309.GA30747@e106331-lin.cambridge.arm.com>
 <CABYn4sxHmr5YLpK5DWxjb0hwmgXP=HbmAy+=HNX9UY6mywCWgw@mail.gmail.com>
 <20130305094305.GB15661@e106331-lin.cambridge.arm.com>
Message-ID: <20130306010615.GG14275@linux-sh.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 05, 2013 at 09:43:05AM +0000, Mark Rutland wrote:
> Hi again,
> 
> > >> diff --git a/Documentation/devicetree/bindings/timer/renesas,sh-cmt-timer.txt b/Documentation/devicetree/bindings/timer/renesas,sh-cmt-timer.txt
> > >> new file mode 100644
> > >> index 0000000..e5ad808
> > >> --- /dev/null
> > >> +++ b/Documentation/devicetree/bindings/timer/renesas,sh-cmt-timer.txt
> > >> @@ -0,0 +1,21 @@
> > >> +* Renesas SH Mobile Compare Match Timer
> > >> +
> > >> +Required properties:
> > >> +- compatible : Should be "renesas,cmt"
> > >> +- reg : Address and length of the register set for the device
> > >> +- interrupts : Timer IRQ
> > >> +- renesas,timer-device-id : The ID of the timer device
> > >> +- renesas,timer-channel-id : The channel ID of the timer device
> > >
> > > I'm not familiar with this hardware. Could you give me a basic idea of how it's
> > > structured?
> > >
> > > Does the device have a single timer that this describes, or does the device
> > > have multiple timers, and this selects which one to use?
> > 
> > The CMT timer is built into various SoCs from Renesas, often multiple
> > instances of it. Each timer instance has 6 channels. You can select if
> > they are driven by the main clock or the real time clock (the SoCs
> > include an SH core for data processing) and can use different subscale
> > modes. It features free running mode and can fire events. The clock
> > has up to 48 bits to count. It has a DMA channel and wires enabling
> > the device to be a wakeup source. Hmm don't know what to add more.
> > It's a timer - you can check for overflows, read the counter and so
> > on.
> 
> Unless I've misunderstood, couldn't Linux choose one timer to use completely
> arbitrarily?
> 
> Why do we need to describe which one to use?
> 
Many of these CPUs have multiple timer blocks (CMT, TMU, MTU2) that sit
in different power domains, so there is often a desire to prioritize one
over another, as it will determine which sleep states are available to
us. Beyond that, many of these channels have special behavioural
constraints (only certain channels being useable by the PWM block for
example, as well as mux issues (certain channels will be tied up with
functions we care less about than others).

We have traditionally registered all of the available timer channels as
platform devices, and then left it to the clocksource/event rating to
determine which to use for what. This was based on the assumption that
later on we would do some work on the clockevents layer to dynamically
allocate the other channels that weren't being used for anything, but
this never happened, and most users managed to get away with simply
adopting hrtimers instead.

Perhaps the rating is not a detail we want to expose, but we are still
going to need some facility for defining whether a given timer is
suitable for a clocksource/clockevent or not. We also can't really encode
the rating information in the driver itself, as the placement of the
block is wholly SoC dependent.
