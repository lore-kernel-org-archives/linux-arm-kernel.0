From: andy.gross@linaro.org (Andy Gross)
Date: Wed, 20 Jul 2016 08:28:23 -0500
Subject: SOC-specific action for irq_set_wake
In-Reply-To: <20160720131606.GJ3847@xsjsorenbubuntu>
References: <20160719181804.GX3847@xsjsorenbubuntu>
 <20160719224713.GA13533@hector.attlocal.net>
 <20160719233440.GG3847@xsjsorenbubuntu> <578F338C.40309@arm.com>
 <20160720131606.GJ3847@xsjsorenbubuntu>
Message-ID: <20160720132823.GA6775@hector.attlocal.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 20, 2016 at 06:16:06AM -0700, S?ren Brinkmann wrote:
> Hi Marc,
> 
> On Wed, 2016-07-20 at 09:17:16 +0100, Marc Zyngier wrote:
> > On 20/07/16 00:34, S?ren Brinkmann wrote:
> > > Hi Andy,
> > > 
> > > On Tue, 2016-07-19 at 17:47:13 -0500, Andy Gross wrote:
> > >> On Tue, Jul 19, 2016 at 11:18:04AM -0700, S?ren Brinkmann wrote:
> > >>> Hi,
> > >>>
> > >>> we are working on the PM solution for Zynq MPSOC and ran into some
> > >>> problem when setting the wake source.
> > >>>
> > >>> The situation is that when the A53 is in suspend, the GIC(v2) may be
> > >>> powered down. In that state a companion core is handling wake
> > >>> events/IRQs, but we expect the OS/Linux to notify the companion core
> > >>> about what device/IRQ is a wake up source. Hence, my idea was to capture
> > >>> enabling/disabling wake IRQs in our platform PM code and then
> > >>> communicate with the FW as needed during suspend operations. The problem
> > >>> is: I don't see a good way to notify the platform code about these
> > >>> events.
> > >>
> > >> On Qualcomm platforms there is something similar.  When the system is power
> > >> collapsed, the GIC loses context and can no longer handle/generate IRQs.  There
> > >> is a separate block called the MPM that provides some registers that the user
> > >> can program.  These registers allow for up to 64 wake IRQs, each of which can
> > >> map to either a GPIO pin or an GIC IRQ.  The MPM also has a timer that can
> > >> generate a wake IRQ so that the system can wake up and maintain the time.
> > > 
> > > We have a full companion core running firmware. As in your case,
> > > we can use any IRQ source and some additional IOs as wake event. So,
> > > it's fundamentally very similar. Main difference is probably the
> > > interface. In our case, we have some platform-specific FW interfaces
> > > that we need to call. Basically, Linux doing an SMC call and then the
> > > secure monitor handling the rest. And for that we may also have to do
> > > some additional mapping of the IRQ number to something the FW interface
> > > understands.
> > > 
> > >>
> > >>>
> > >>> My ideas were:
> > >>> 1. Use the irq_chip irq_set_wake function
> > >>>   My thought was to implement the irq_set_wake function in a
> > >>>   SOC-specific way (could even be generic and call some notifier chain or
> > >>>   similar) to notify the platform PM code when a device/IRQ is
> > >>>   enabled/disabled as wake up source.
> > >>>   My problem is that the SKIP_IRQ_SET_WAKE flag is set in the generic
> > >>>   driver (drivers/irqchip/irq-gic.c) and platforms cannot implement
> > >>>   irq_set_wake without changes in the common code.
> > >>
> > >> So not too long ago there were irq extensions that you could add in to an irq
> > >> controller that would allow for intercepting the set wake calls.  This went away
> > >> and was replaced by the hierarchical irq design.
> > > 
> > > Yeah, I though I remembered that and wanted to use it now and was slightly
> > > disappointed when I couldn't find the code anymore.
> > 
> > It was slaughtered for a good reason: It was unmaintainable, had
> > horrible performance issues, wasn't described in any of DT or ACPI, and
> > didn't fit any of the core code idioms. It has been replaced by
> > something we that is supported in the code code and that is working for
> > all current users of the GIC that have similar requirements to yours.
> > 
> > >> The way I am currently implementing the MPM for Qualcomm, I am defining the MPM
> > >> as a IRQ controller and creating relationships between the MPM and the GPIO
> > >> controller (source of irqs) and the GIC.  As irqs are set wake and cleared the
> > >> calls go up through the hierarchy and they call each irqchips functions (if you
> > >> have it setup to do that).
> > > 
> > > I suspected that some sort of dummy interrupt controller might be one
> > > way to do it. I was hoping to find a simpler way, but maybe this is the
> > > way to go. One concern could be that this might require adding something
> > > into the DT that doesn't really exist.
> > 
> > It is not "dummy". It drives an actual piece of HW (the wake up
> > interrupts) and a piece of ****ware (the secure monitor side). And since
> > when the DT has become something that we cannot change? Last time I
> > checked, people were still adding 20 new bindings per merge window.
> 
> I'm not afraid of changing the DT. But the described hierarchy etc.
> would not reflect the actual HW implementation. I'm generally fine with
> exploring this route.
> 
> > 
> > > 
> > >>
> > >>
> > >>> 2. Stuff things into the secure monitor
> > >>>   I guess we could read the GIC registers once we enter the secure
> > >>>   monitor and do the communication with the companion core from there by
> > >>>   identifying unmasked IRQs as wake IRQs. My concern here is that it
> > >>>   might introduce additional hardcoded mappings that are much more
> > >>>   dynamic in Linux thanks to the DT description.
> > >>
> > >> This could work, but you'd have to have control of the secure monitor code.  In
> > >> Qualcomm's case, that wouldn't work or couldn't because they won't change that
> > >> code.  And you'd have to have calls into the monitor to turn on/off the lines.
> > > 
> > > We fully control our secure monitor. That should not be an issue for us.
> > > What do you mean we'd need to call into the monitor? Linux masks all wake
> > > IRQs when going into suspend. Everything unmasked should be a wake IRQ,
> > > or am I missing something? I thought we could simply read the
> > > enable/disable status of all IRQs in the secure monitor suspend path and
> > > do the needed communication with the companion core.

I was thinking of scm calls or whatnot, but it actually makes more sense for the
monitor to just to all of it at suspend time.  That makes it transparent to
Linux.

> > 
> > That's also a possibility. If you do that, you really have to wonder why
> > you're not implementing this as part of PSCI, because it seems a bit
> > silly to have two interfaces for the same thing.
> 
> Absolutely, that was my thinking. The suspend path is implemented using PSCI and
> we could potentially add this in there. I never said it wouldn't be part
> of the PSCI implementation.
> 
> > 
> > > 
> > >>
> > >>>
> > >>> Does anybody have similar problems and probably already solved it?
> > >>> Any other suggestions for approaching the problem? Any preferred
> > >>> solution?
> > >>
> > >> I think we have the same problem.  Can you provide more detail on the hardware
> > >> implementation of your wake irq controller?  I presume you have some set of
> > >> registers, an irq maybe, and some other stuff?  And how does it fit into the
> > >> overall architecture from a hardware perspective?
> > > 
> > > We have essentially a whole second interrupt controller. All IRQs are
> > > connected to the A53 GIC and this second interrupt controller that is
> > > controlled by the companion core. The companion core is supposed to be
> > > informed about what source the A53 needs to wake up on and will program
> > > this second IRQ controller, etc.
> > 
> > So your "special case" is exactly like everyone else's. Implement it as
> > a hierarchical chip on top of the GIC, just like Tegra, OMAP, iMX6,
> > Exynos and a few others. Unless you implement PSCI.
> 
> I didn't really think that our case is unique. I was just looking for
> some pointers into the right direction as the extension mechanism that I
> remembered disappeared and I haven't been following the development
> closely enough to just know what alternatives are available.
> So, you say the approach of letting the secure monitor infer the wake
> IRQ by reading the GIC config is preferred over handling it as
> hierarchical chip within Linux?

If you can do it in PSCI, that makes things much simpler.  I don't think he is
saying it's preferred.  Just choose the solution that makes sense for you.


Regards,

Andy
