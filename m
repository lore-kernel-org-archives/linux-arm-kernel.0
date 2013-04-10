From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 10 Apr 2013 23:44:52 +0200
Subject: [PATCH 3/5] gpio/omap: Add DT support to GPIO driver
In-Reply-To: <5165CB9D.1090202@wwwdotorg.org>
References: <1329321854-24490-1-git-send-email-b-cousson@ti.com>
 <CACRpkdYbs4-uudpRUY8e+7icYYkZrfM0kReP3pLL5DMiURJ4dg@mail.gmail.com>
 <5165CB9D.1090202@wwwdotorg.org>
Message-ID: <1580096.AHFBPvEqBp@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 10 April 2013 14:29:17 Stephen Warren wrote:
> 
> > If the information is there, whether to convert from IRQ to GPIO
> > or from GPIO to IRQ is a technicality and any order should be
> > feasible in some way?
> 
> There isn't always a unique 1:1 mapping between GPIOs and IRQs. Put
> another way, a single GPIO would likely only ever trigger a single IRQ,
> but a single IRQ might easily be triggered by any number of GPIOs. This
> is exactly why the function irq_to_gpio() isn't something one should use
> any more.

More importantly, most irqs don't have any GPIO associated with them
at all. The interface made some sense for simple platforms that had
a linear range of GPIO IRQs, but that also isn't true these days,
with arbitrary IRQ domains.

> I think there was an effort to outright remove the API,
> although it doesn't look like that's entirely complete yet.

It's essentially complete. There are a few remnants in areas of the kernel
that we don't like to look at:

* The blackfin architecture provides the interface and uses it in the
  pata_rb532_cf driver.

* MIPS provides it on a few older platforms, and it's used on the alchemy
  pcmcia driver.

* avr32, m68k, sh and unicore32 provide the interface but don't use it.

* On ARM, the interface is provided on iop, gemini, ixp4xx, ks8695
  and w90x900.  None of these use it, and they rarely see any patches
  at all these days.

* ARM/davinci provides a stub but always return -ENOSYS.

* One driver for PXA (tosa_battery) still uses this interface, but PXA stopped
  providing it long ago.

	Arnd
