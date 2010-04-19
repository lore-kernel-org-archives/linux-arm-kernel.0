From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Mon, 19 Apr 2010 12:04:30 -0500
Subject: [spi-devel-general] [PATCH v3 0/2] spi: driver for Cirrus
	EP93xx SPI controller
In-Reply-To: <20100417045913.GA19534@gw.healthdatacare.com>
References: <cover.1271156934.git.mika.westerberg@iki.fi>
	<0D753D10438DA54287A00B0270842697636D710785@AUSP01VMBX24.collaborationhost.net>
	<20100417045913.GA19534@gw.healthdatacare.com>
Message-ID: <0D753D10438DA54287A00B0270842697636D78D9CF@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, April 16, 2010 9:59 PM, Mika Westerberg wrote:
> On Fri, Apr 16, 2010 at 01:28:05PM -0500, H Hartley Sweeten wrote:
>> 
>> I finally was able to get this working on my system.  Not sure what the issue
>> was earlier.
>
> Great :)
>
>> The only thing I don't like right off hand is the chip select handling.
>> 
>> The way it currently is done you are limited to using only the built-in GPIO's
>> of the EP93xx.  This prohibits a system from using an external i2c/spi/etc.
>> gpio expander to provide more chip selects.  And if a platform is not setup
>> correctly, the BUG_ON in cs_to_gpio in your example for the tx72xx is pretty
>> nasty.
>
> Yes the example was just a hack.
>
> However, I'm not sure what you mean by limited only to built-in GPIOs? Currently
> the driver does:
>
>        info->cs_control(spi->chip_select, value, info->data);
>
> when it wants to assert/deassert the chip select. I don't see how this is
> limited to built-in GPIOs only (maybe I'm missing something). Now it is in
> responsibility of platform board files to allocate necessary chipselect lines,
> and translate 'spi->chip_select' and 'value' to something meaningful.

The way you are currently handling the chip select limits you to the built-in
GPIO's because the 'gpio_request' happens early in the platform init before any
external gpio expanders might be available.

The best example is if your first SPI device is actually a GPIO expander that
is chip selected by a built-in GPIO.  This GPIO expander is then used to provide
the chip selects for additional SPI devices on the bus.

>> Ryan and I worked out a runtime setup/cleanup for the spi device chip selects
>> in the spi driver I have in my tree.  I will take a look at it and see how
>> much trouble it will be to implement in your driver.
>
> Ok.

I have a patch almost working.

Have you had time to implement any of the changes that Grant Likely proposed?
One of them dealt with the ep93xx_spi_{de}select_device functions.  Before I
post my proposed changes I would like to make sure it is based on your most
current code.

BTW, my patch will also handle Martin Guy's issue with using a null chip select.
Actually, the chip-select isn't really null since the SFRMOUT line is still
asserted (active-low) during any SPI transfer but the effect is still the same.

>> Anyway, now that I have your driver functioning I will be able to actually
>> provide some feedback to you.
>
> That sounds good.

Regards,
Hartley
