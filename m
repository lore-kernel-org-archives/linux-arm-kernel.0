From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Wed, 11 Mar 2015 02:03:08 +0100
Subject: [PATCH v2 5/6] watchdog: at91sam9: request the irq with
 IRQF_NO_SUSPEND
In-Reply-To: <20150310223305.GN9188@piout.net>
References: <1425287898-15093-6-git-send-email-boris.brezillon@free-electrons.com>
 <1901056.Mqyykpv3e9@vostro.rjw.lan> <20150310223305.GN9188@piout.net>
Message-ID: <2194398.CCV6AEYQ7u@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, March 10, 2015 11:33:05 PM Alexandre Belloni wrote:
> On 10/03/2015 at 23:31:52 +0100, Rafael J. Wysocki wrote :
> > On Tuesday, March 10, 2015 10:33:17 PM Alexandre Belloni wrote:
> > > Hi,
> > > 
> > > On 09/03/2015 at 15:30:01 +0100, Rafael J. Wysocki wrote :
> > > > > > > Actaully, your platform should just refuse to enter suspend-to-RAM
> > > > > > > when hw watchdog is enabled.
> > > > > > 
> > > > > > Quite likely, depending on how exactly the suspend is implemented.
> > > > > >
> > > > > 
> > > > > We've had absolutely zero complain on that. It is quite clear in the
> > > > > datasheet that failing to refresh the watchdog once started will lead to
> > > > > a reset and that it is impossible to stop.
> > > > > It is actually quite convenient to also ensure that you can actually
> > > > > wake up from suspend because that can obviously go wrong.
> > > > 
> > > > I gather then that the suspend implementation is such that touching the
> > > > watchdog periodically while suspended is not a problem.
> > > > 
> > > > Again, can you please tell me how suspend is implemented on at91?
> > > > 
> > > 
> > > It actually depends on the architecture (at91rm9200, at91sam9 or sama5)
> > > but basically, the clocks are switched off in almost all the peripheral
> > > drivers then the ram self refresh activated, the master clock is
> > > switched off using code running from SRAM and the core is then waiting
> > > for interrupt.
> > 
> > OK, so it looks like enable_irq_wake() doesn't actually affect the hardware
> > on those platforms, is that correct?
> > 
> 
> I didn't exactly look in details but apart from the wakeup from gpio
> handling (keeping the pio controller clocked in the case one of its gpio
> has wakeup enabled), I don't think it does much more. It uses
> irq_gc_set_wake().

Well, that only modifies gc->wake_active, so no hardware interactions.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
