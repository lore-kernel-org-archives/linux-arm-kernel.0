From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Tue, 10 Apr 2012 09:01:05 -0700
Subject: [PATCH] Input: eeti_ts: Mark as CONFIG_BROKEN
In-Reply-To: <20120410101047.GQ24211@n2100.arm.linux.org.uk>
References: <1333777207-4151-1-git-send-email-olof@lixom.net>
 <20120407070206.GA17623@core.coreip.homeip.net>
 <4F8089A9.6080704@raumfeld.com>
 <CAOesGMiPZ0so-ZN0HCHHhw16oPWWgfVD5t--wKSvEUtzQx94CA@mail.gmail.com>
 <20120410101047.GQ24211@n2100.arm.linux.org.uk>
Message-ID: <20120410160105.GA19927@core.coreip.homeip.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 10, 2012 at 11:10:47AM +0100, Russell King - ARM Linux wrote:
> On Sat, Apr 07, 2012 at 01:32:31PM -0700, Olof Johansson wrote:
> > Haojian, I think it was probably premature to do the multiplatform
> > change like that, since it means that a PXA-only kernel has no mapping
> > from irq_to_gpio to pxa_irq_to_gpio. Can you please address this as a
> > fix for 3.4?
> 
> Please fix ezx-pcap instead - it's broken as it currently stands by using
> irq_to_gpio(), and it's one reason why my randconfig builds on OMAP fail.
> 
> The big problem is - what does this do:
> 
>         do {
> ...
>         } while (gpio_get_value(irq_to_gpio(pcap->spi->irq)));
> 
> if pcap->spi->irq has no GPIO associated with the interrupt?  irq_to_gpio()
> probably returns some random number which might be some other GPIO in the
> system, and gpio_get_value() could oops if irq_to_gpio returns a negative
> or large positive number.  To put it another way, according to the above
> code, irq_to_gpio() must always return a valid gpio for the IRQ even if
> the IRQ doesn't have a GPIO associated with it.
> 
> This is a fine illustration of why irq_to_gpio() is just plain broken in
> its design.

OK, so we can fix eeti_ts and wacom_i2c; but what do we do with
egalax_ts.c? It reconfigures gpio as output and sens a pulse to wake the
controller from sleep. I guess we'll need platform data attached to
it...

Thanks.

-- 
Dmitry
