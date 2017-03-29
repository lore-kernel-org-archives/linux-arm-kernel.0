From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 29 Mar 2017 14:36:38 +0200
Subject: [PATCH v7 1/7] clocksource/drivers/clksrc-evt-probe: Describe
 with the DT both the clocksource and the clockevent
In-Reply-To: <20170329104911.GC23442@leverpostej>
References: <1490197714-25415-1-git-send-email-al.kochet@gmail.com>
 <1490197714-25415-2-git-send-email-al.kochet@gmail.com>
 <20170329015146.ey5rlptzsnnynpnt@rob-hp-laptop>
 <20170329092210.GH2123@mai> <20170329104911.GC23442@leverpostej>
Message-ID: <20170329123638.GI2123@mai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 29, 2017 at 11:49:11AM +0100, Mark Rutland wrote:
> Hi,
> 
> On Wed, Mar 29, 2017 at 11:22:10AM +0200, Daniel Lezcano wrote:
> > On Tue, Mar 28, 2017 at 08:51:46PM -0500, Rob Herring wrote:
> > > On Wed, Mar 22, 2017 at 06:48:28PM +0300, Alexander Kochetkov wrote:
> > > > From: Daniel Lezcano <daniel.lezcano@linaro.org>
> > > > 
> > > > The CLOCKSOURCE_OF_DECLARE() was introduced before the
> > > > CLOCKEVENT_OF_DECLARE() and that resulted in some abuse where the
> > > > clockevent and the clocksource are both initialized in the same init
> > > > routine.
> > > > 
> > > > With the introduction of the CLOCKEVENT_OF_DECLARE(), the driver can
> > > > now split the clocksource and the clockevent init code. However, the
> > > > device tree may specify a single node, so the same node will be passed
> > > > to the clockevent/clocksource's init function, with the same base
> > > > address.
> > > > 
> > > > with this patch it is possible to specify an attribute to the timer's node to
> > > > specify if it is a clocksource or a clockevent and define two timers node.
> > > 
> > > Daniel and I discussed and agreed against this a while back. What 
> > > changed?
> > 
> > Hi Rob,
> > 
> > > > For example:
> > > > 
> > > >         timer: timer at 98400000 {
> > > >                 compatible = "moxa,moxart-timer";
> > > >                 reg = <0x98400000 0x42>;
> > > 
> > > This overlaps the next node. You can change this to 0x10, but are these 
> > > really 2 independent h/w blocks? Don't design the nodes around the 
> > > current needs of Linux.
> > 
> > Mmh, thanks for raising this. Conceptually speaking there are two (or more)
> > different entities, the clocksource and the clockevents but they share the same
> > IP block.
> 
> From the DT's PoV, this is one entity, which is the IP block.
> 
> The clocksource/clockevent concept is a Linux implementation detail. The
> DT cannot and should not be aware of that.
> 
> [...]
> 
> > > >                 interrupts = <19 1>;
> > > >                 clocks = <&coreclk>;
> > > >                 clockevent;
> > > 
> > > This is not needed. The presence of "interrupts" is enough to say use 
> > > this timer for clockevent.
> > 
> > Yes, that is true if no drivers was already taking CLOCKSOURCE_OF and
> > initializing the clockevent. The driver will pass through the clocksource_probe
> > function, check the interrupt and bail out because there is an interrupt
> > declared and assume it is a clockevent, so no initialization for the driver.
> > IOW, it is not backward compatible.
> > 
> > We need this attribute somehow in order to separate clearly a clocksource or a
> > clockevent with a new implementation.
> 
> Why? A single IP block can provide the functionality of both (though
> there are reasons that functionality may be mutually exclusive). What is
> the benefit of this split?

Hi Mark,

You can have several timers on the system and may want to use the clockevents
from one IP block and the clocksource from another IP block. For example, in
the case of a bogus clocksource.

Moreover there are some drivers with a node for a clocksource and
another one for the clockevent, and the driver is assuming the clockevent is
defined first and then the clocksource.

eg.

arch/arc/boot/dts/abilis_tb10x.dtsi:

        /* TIMER0 with interrupt for clockevent */
        timer0 {
                compatible = "snps,arc-timer";
                interrupts = <3>;
                interrupt-parent = <&intc>;
                clocks = <&cpu_clk>;
        };

        /* TIMER1 for free running clocksource */
        timer1 {
                compatible = "snps,arc-timer";
                clocks = <&cpu_clk>;
        };

drivers/clocksource/arc_timer.c:

static int __init arc_of_timer_init(struct device_node *np)
{
        static int init_count = 0;
        int ret;

        if (!init_count) {
                init_count = 1;
                ret = arc_clockevent_setup(np);
        } else {
                ret = arc_cs_setup_timer1(np);
        }

        return ret;
}

Even if that works, it is a fragile mechanism.

So the purpose of these changes is to provide a stronger timer declaration in
order to clearly split in the kernel a clocksource and a clockevent
initialization.

> > > > With this approach, we allow a mechanism to clearly define a clocksource or a
> > > > clockevent without aerobatics we can find around in some drivers:
> > > > 	timer-sp804.c, arc-timer.c, dw_apb_timer_of.c, mps2-timer.c,
> > > > 	renesas-ostm.c, time-efm32.c, time-lpc32xx.c.
> > > 
> > > These all already have bindings and work. What problem are you trying to 
> > > solve other than restructuring Linux?
> > 
> > Yes, there is already the bindings, but that force to do some hackish
> > initialization.
> 
> Here, you are forcing hackish DT changes that do not truly describe HW.
> How is that better?

So if this is hackish DT changes, then the existing DTs should be fixed, no?

> > I would like to give the opportunity to declare separately a clocksource and a
> > clockevent, in order to have full control of how this is initialized.
> 
> To me it sounds like what we need is Linux infrastructure that allows
> one to register a device as having both clockevent/clocksource
> functionality.

That was the idea. Create a macro CLOCKEVENT_OF and CLOCKSOURCE_OF both of them
calling their respective init routines. And in addition a TIMER_OF doing both
CLOCKEVENT_OF and CLOCKSOURCE_OF.

It is the DT which does not allow to do this separation.

Would be the following approach more acceptable ?

1. Replace all CLOCKSOURCE_OF by TIMER_OF (just renaming)
2. A node can have a clockevent and|or a clocksource attributes
3. The timer_probe pass a flag to the driver's init function, so this one knows
   if it should invoke the clockevent/clocksource init functions.
   No attribute defaults to clocksource|clockevent.

That would be backward compatible and will let to create drivers with clutch
activated device via DT. Also, it will give the opportunity to the existing
drivers to change consolidate their initialization routines.

> That way, we can choose to do something sane at boot time, and if the
> user really wants specific devices used in specific ways, they can
> request that.


-- 

 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
