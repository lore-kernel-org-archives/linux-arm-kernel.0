From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 6 Dec 2011 10:55:03 +0000
Subject: [PATCH] ata: Don't use NO_IRQ in pata_of_platform driver
In-Reply-To: <20111206093000.GA2274@linaro.org>
References: <CA+55aFwekNWz+V4440f=2iu_BfOxSg0NjVogv4cZZDFbJBNoAQ@mail.gmail.com>
 <1322867573.11728.22.camel@pasglop>
 <20111205161157.GA27550@localhost.localdomain>
 <alpine.LFD.2.02.1112051236350.2357@xanadu.home>
 <20111205180253.GB29812@localhost.localdomain>
 <alpine.LFD.2.02.1112051310150.2357@xanadu.home> <4EDD1897.4030208@gmail.com>
 <20111205202125.GA32592@oksana.dev.rtsoft.ru> <4EDD2DE1.1050606@gmail.com>
 <20111206093000.GA2274@linaro.org>
Message-ID: <20111206105503.GO14542@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 06, 2011 at 09:30:00AM +0000, Dave Martin wrote:
> Do we expect there to be any platform drivers which are shared between
> legacy platforms and newer DT-ised platforms?
> 
> Those drivers would be pain points since they would need to understand
> both conventions.
> 
> So far as I can see, only boards which are not DT-ised, which do not use
> DT-ised drivers and which do not use drivers which use interrupts and
> are either used by DT-ised boards or by arches with a non-zero NO_IRQ
> could safely carry on using a non-zero NO_IRQ.  Tracking down exactly
> which boards and drivers this applies to could be hard.  We could have a
> CONFIG_NO_IRQ and make them depend on it, but we still have to find that
> list of boards and drivers in the first place.

You're digging too deeply into this.

Drivers which need to know whether an IRQ is valid need to know this if
they wish to do something different for 'this device doesn't have an IRQ
wired'.  These are the drivers which have problems because of the -1 vs
0 thing.

That is different from 'this is an invalid IRQ number', which is what
you find out when you call request_irq().

So please, stop thinking 'we need to convert drivers to check for <= 0'.
We don't.  We just need to make sure that we're not passing a zero IRQ
number to any driver.

On platforms where IRQ0 is special like x86, request_irq() will fail
with -EBUSY on drivers which don't care (or other kind of refusal to
initialize), and will cause 'polling mode' with the 8250 driver.

So, all that we need to do is to ensure that all the IRQ chip stuff is
fixed up so that IRQ0 is only used for the same purpose as x86 - the
PIC timer on systems with an ISA 8253 timer.  Everything else should
not pass IRQ0 outside core platform code.
