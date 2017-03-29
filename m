From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 29 Mar 2017 11:22:10 +0200
Subject: [PATCH v7 1/7] clocksource/drivers/clksrc-evt-probe: Describe
 with the DT both the clocksource and the clockevent
In-Reply-To: <20170329015146.ey5rlptzsnnynpnt@rob-hp-laptop>
References: <1490197714-25415-1-git-send-email-al.kochet@gmail.com>
 <1490197714-25415-2-git-send-email-al.kochet@gmail.com>
 <20170329015146.ey5rlptzsnnynpnt@rob-hp-laptop>
Message-ID: <20170329092210.GH2123@mai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 28, 2017 at 08:51:46PM -0500, Rob Herring wrote:
> On Wed, Mar 22, 2017 at 06:48:28PM +0300, Alexander Kochetkov wrote:
> > From: Daniel Lezcano <daniel.lezcano@linaro.org>
> > 
> > The CLOCKSOURCE_OF_DECLARE() was introduced before the
> > CLOCKEVENT_OF_DECLARE() and that resulted in some abuse where the
> > clockevent and the clocksource are both initialized in the same init
> > routine.
> > 
> > With the introduction of the CLOCKEVENT_OF_DECLARE(), the driver can
> > now split the clocksource and the clockevent init code. However, the
> > device tree may specify a single node, so the same node will be passed
> > to the clockevent/clocksource's init function, with the same base
> > address.
> > 
> > with this patch it is possible to specify an attribute to the timer's node to
> > specify if it is a clocksource or a clockevent and define two timers node.
> 
> Daniel and I discussed and agreed against this a while back. What 
> changed?

Hi Rob,

> > For example:
> > 
> >         timer: timer at 98400000 {
> >                 compatible = "moxa,moxart-timer";
> >                 reg = <0x98400000 0x42>;
> 
> This overlaps the next node. You can change this to 0x10, but are these 
> really 2 independent h/w blocks? Don't design the nodes around the 
> current needs of Linux.

Mmh, thanks for raising this. Conceptually speaking there are two (or more)
different entities, the clocksource and the clockevents but they share the same
IP block.

In the driver timer-sp804.c there is a fragile mechanism with the timer
counting assuming the timers are declared in a specific order in the DT
(integratorcp.dts). There are multiple nodes, which are IIUC overlapping like
what you are describing.

I'm a bit puzzled with how this should be done.

Do you have a suggestion ?

> >                 interrupts = <19 1>;
> >                 clocks = <&coreclk>;
> >                 clockevent;
> 
> This is not needed. The presence of "interrupts" is enough to say use 
> this timer for clockevent.

Yes, that is true if no drivers was already taking CLOCKSOURCE_OF and
initializing the clockevent. The driver will pass through the clocksource_probe
function, check the interrupt and bail out because there is an interrupt
declared and assume it is a clockevent, so no initialization for the driver.
IOW, it is not backward compatible.

We need this attribute somehow in order to separate clearly a clocksource or a
clockevent with a new implementation.
 
> >         };
> > 
> >         timer: timer at 98400010 {
> >                 compatible = "moxa,moxart-timer";
> >                 reg = <0x98400010 0x42>;
> >                 clocks = <&coreclk>;
> >                 clocksource;
> 
> Likewise.
> 
> >         };
> > 
> > With this approach, we allow a mechanism to clearly define a clocksource or a
> > clockevent without aerobatics we can find around in some drivers:
> > 	timer-sp804.c, arc-timer.c, dw_apb_timer_of.c, mps2-timer.c,
> > 	renesas-ostm.c, time-efm32.c, time-lpc32xx.c.
> 
> These all already have bindings and work. What problem are you trying to 
> solve other than restructuring Linux?

Yes, there is already the bindings, but that force to do some hackish
initialization.

I would like to give the opportunity to declare separately a clocksource and a
clockevent, in order to have full control of how this is initialized.
 
