From: richard.zhao@linaro.org (Richard Zhao)
Date: Thu, 19 Apr 2012 22:28:39 +0800
Subject: irq_to_gpio support
In-Reply-To: <201204191333.01914.arnd@arndb.de>
References: <20120419113019.GB26682@b20223-02.ap.freescale.net>
 <201204191333.01914.arnd@arndb.de>
Message-ID: <20120419142837.GA2144@richard-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 19, 2012 at 01:33:01PM +0000, Arnd Bergmann wrote:
> On Thursday 19 April 2012, Richard Zhao wrote:
> > Hi Grant & Linus
> > 
> > I saw gpio lib didn't provide irq_to_gpio support. Are we dropping it?
> > git grep irq_to_gpio still return a lot of things.
> 
> There are not that many actually if you count only the users, not the
> files that define them, and you ignore the files in drivers/gpio 
> that define their own.
> 
> drivers/ata/pata_rb532_cf.c:    gpio = irq_to_gpio(irq);
> drivers/input/touchscreen/eeti_ts.c:    return gpio_get_value(irq_to_gpio(priv->irq)) == priv->irq_active_high;
> drivers/input/touchscreen/egalax_ts.c:  int gpio = irq_to_gpio(client->irq);
> drivers/mfd/ezx-pcap.c: } while (gpio_get_value(irq_to_gpio(pcap->spi->irq)));
> drivers/pcmcia/db1xxx_ss.c:     return !gpio_get_value(irq_to_gpio(sock->insert_irq));
> drivers/power/tosa_battery.c:   pr_info("tosa_bat_gpio irq: %d\n", gpio_get_value(irq_to_gpio(irq)));
> drivers/staging/iio/accel/lis3l02dq_core.c:     if (spi->irq && gpio_is_valid(irq_to_gpio(spi->irq)) > 0) {
> drivers/staging/iio/accel/lis3l02dq_core.c:     if (spi->irq && gpio_is_valid(irq_to_gpio(spi->irq)) > 0)
> drivers/staging/iio/accel/lis3l02dq_core.c:     if (spi->irq && gpio_is_valid(irq_to_gpio(spi->irq)) > 0)
> drivers/staging/iio/accel/lis3l02dq_ring.c:             if (gpio_get_value(irq_to_gpio(st->us->irq)))
> 
> The pata_rb532_cf and db1xxx_ss drivers are only used on MIPS,
> most of the other ones are for arm/pxa and are currently broken.
> 
> > I'm looking at drivers/input/touchscreen/egalax_ts.c driver.
> > It failed to compile without irq_to_gpio. It's a i2c client device and
> > use irq line configured as gpio to wakeup touchscreen controller.
> > If we don't have irq_to_gpio, I'm afraid it has to use plat data or
> > of property to pass gpio number.
> 
> Yes, I think that is correct. The drivers should really have been
> fixed at the time when the irq_to_gpio function was removed from
> the respective platforms using those drivers, and in some cases
> this has already happened.
Thanks. I just found a patch to add egalax DT support. I'll evaluate it
and send it out.

Thanks
Richard
> 
> 	Arnd
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
