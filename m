From: jhovold@gmail.com (Johan Hovold)
Date: Mon, 11 Mar 2013 11:02:43 +0100
Subject: [rtc-linux] [PATCH 3/3] ARM: at91: fix hanged boot
In-Reply-To: <20130308160258.GD4590@game.jcrosoft.org>
References: <1362747103-21445-1-git-send-email-jhovold@gmail.com>
 <1362747103-21445-4-git-send-email-jhovold@gmail.com>
 <20130308160258.GD4590@game.jcrosoft.org>
Message-ID: <20130311100243.GD8797@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 08, 2013 at 05:02:58PM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 13:51 Fri 08 Mar     , Johan Hovold wrote:
> > Make sure the RTC and RTT-interrupts are masked at boot by adding a new
> > SOC-initialiser and helpers functions.
> > 
> > This fixes hanged boot on all AT91 SOCs but RM9200, for example, after a
> > reset during an RTC-update or if an RTC or RTT-alarm goes off after a
> > non-clean shutdown.
> > 
> > The RTC and RTT-peripherals are powered by backup power (VDDBU) (on all
> > AT91 SOCs but RM9200) and are not reset on wake-up, user, watchdog or
> > software reset. This means that their interrupts may be enabled during
> > early boot if, for example, they where not disabled during a previous
> > shutdown (e.g. due to a buggy driver or a non-clean shutdown such as a
> > user reset). Furthermore, an RTC or RTT-alarm may also be active.
> > 
> > The RTC and RTT-interrupts use the shared system-interrupt line, and if
> > an interrupt occurs before a handler (e.g. RTC-driver) has been
> > installed this leads to the system interrupt being disabled and prevents
> > the system from booting.
> > 
> > Note that when boot hangs due to an early RTC or RTT-interrupt, the only
> > way to get the system to start again is to remove the backup power (e.g.
> > battery) or to disable the interrupt manually from the bootloader. In
> > particular, a user reset is not sufficient.
> > 
> > Tested on at91sam9263 and at91sam9g45.
> > 
> > Signed-off-by: Johan Hovold <jhovold@gmail.com>
> > ---
> >  arch/arm/mach-at91/at91rm9200.c               |  9 ++++++++
> >  arch/arm/mach-at91/at91sam9260.c              |  6 ++++++
> >  arch/arm/mach-at91/at91sam9261.c              |  6 ++++++
> >  arch/arm/mach-at91/at91sam9263.c              |  7 ++++++
> >  arch/arm/mach-at91/at91sam9g45.c              |  7 ++++++
> >  arch/arm/mach-at91/at91sam9n12.c              |  6 ++++++
> >  arch/arm/mach-at91/at91sam9rl.c               |  7 ++++++
> >  arch/arm/mach-at91/at91sam9x5.c               |  6 ++++++
> >  arch/arm/mach-at91/generic.h                  |  2 ++
> >  arch/arm/mach-at91/include/mach/at91sam9n12.h |  5 +++++
> >  arch/arm/mach-at91/include/mach/at91sam9x5.h  |  5 +++++
> nack for DT probe te address via DT

Fair enough. I'll respin and add proper DT-support. 

> >  arch/arm/mach-at91/setup.c                    | 31 +++++++++++++++++++++++++++
> >  arch/arm/mach-at91/soc.h                      |  1 +
> >  13 files changed, 98 insertions(+)
> 
> at boot time we can disable all the irq as we need none of them

Yes, but all but the VDDBU-powered-peripheral ones will already have
been disabled at reset. If a buggy bootloader enables something it
should not, then the bootloader should be fixed.

> > diff --git a/arch/arm/mach-at91/at91rm9200.c b/arch/arm/mach-at91/at91rm9200.c
> > index 7aeb473..4651ebb 100644
> > --- a/arch/arm/mach-at91/at91rm9200.c
> > +++ b/arch/arm/mach-at91/at91rm9200.c
> > @@ -325,6 +325,14 @@ static void __init at91rm9200_ioremap_registers(void)
> >  	at91_ioremap_ramc(0, AT91RM9200_BASE_MC, 256);
> >  }
> >  
> > +static void __init at91rm9200_sysirq_mask(void)
> > +{
> > +	/*
> > +	 * No need to mask any system interrupts as the RM9200 has no backup
> > +	 * power and resets all system peripherals at every reset.
> > +	 */
> > +}
> no need drop it

Ok.

Thanks,
Johan

> > +
> >  static void __init at91rm9200_initialize(void)
> >  {
> >  	arm_pm_idle = at91rm9200_idle;
> > @@ -387,5 +395,6 @@ AT91_SOC_START(rm9200)
> >  	.default_irq_priority = at91rm9200_default_irq_priority,
> >  	.ioremap_registers = at91rm9200_ioremap_registers,
> >  	.register_clocks = at91rm9200_register_clocks,
> > +	.sysirq_mask = at91rm9200_sysirq_mask,
> >  	.init = at91rm9200_initialize,
> >  AT91_SOC_END
