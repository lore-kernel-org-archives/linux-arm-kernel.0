From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Mon, 19 Apr 2010 13:11:48 -0500
Subject: [spi-devel-general] [PATCH v3 0/2] spi: driver for Cirrus
	EP93xx SPI controller
In-Reply-To: <20100419174446.GH19534@gw.healthdatacare.com>
References: <cover.1271156934.git.mika.westerberg@iki.fi>
	<0D753D10438DA54287A00B0270842697636D710785@AUSP01VMBX24.collaborationhost.net>
	<20100417045913.GA19534@gw.healthdatacare.com>
	<0D753D10438DA54287A00B0270842697636D78D9CF@AUSP01VMBX24.collaborationhost.net>
	<20100419174446.GH19534@gw.healthdatacare.com>
Message-ID: <0D753D10438DA54287A00B0270842697636D78DBC6@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, April 19, 2010 10:45 AM, Mika Westerberg wrote:
> On Mon, Apr 19, 2010 at 12:04:30PM -0500, H Hartley Sweeten wrote:
>> On Friday, April 16, 2010 9:59 PM, Mika Westerberg wrote:
>...
>>> when it wants to assert/deassert the chip select. I don't see how this is
>>> limited to built-in GPIOs only (maybe I'm missing something). Now it is in
>>> responsibility of platform board files to allocate necessary chipselect lines,
>>> and translate 'spi->chip_select' and 'value' to something meaningful.
>> 
>> The way you are currently handling the chip select limits you to the built-in
>> GPIO's because the 'gpio_request' happens early in the platform init before any
>> external gpio expanders might be available.
>> 
>> The best example is if your first SPI device is actually a GPIO expander that
>> is chip selected by a built-in GPIO.  This GPIO expander is then used to provide
>> the chip selects for additional SPI devices on the bus.
>
> Ok.. got it. I didn't consider that one.

I didn't originally either... Ryan pointed it out. ;-)

>>>> Ryan and I worked out a runtime setup/cleanup for the spi device chip selects
>>>> in the spi driver I have in my tree.  I will take a look at it and see how
>>>> much trouble it will be to implement in your driver.
>>>
>>> Ok.
>>
>> I have a patch almost working.
>> 
>> Have you had time to implement any of the changes that Grant Likely proposed?
>
> Mostly yes. I'm still considering whether I should drop the polling mode.

If interrupt support works well, and it seems to, the polling mode is really not
needed.  I would say drop it.

>> One of them dealt with the ep93xx_spi_{de}select_device functions.  Before I
>> post my proposed changes I would like to make sure it is based on your most
>> current code.
>
> I changed chipselect functions to be something like (espi->cs_control is copied
> from info structure):
>
>        if (espi->cs_control)
>                espi->cs_control(spi->chip_select, !!(spi->mode & SPI_CS_HIGH),
>                                 espi->cs_data);
>
> I'm not exactly sure whether this is what Grant meant, however.

I think you meant 'info->data' not 'espi->cs_data'.

Anyway, I think that is basically what Grant meant.  But, I would change the
cs_control to:

void (*cs_control)(struct spi_device *spi, int value);

The 'chip_select' can be extracted in the cs_control function directly from the
'spi' data.  And, I can't see a real use for the 'info->data' field, your current 
patchset doesn't use that field anyway.

>> BTW, my patch will also handle Martin Guy's issue with using a null chip select.
>
> Yeah. I also have that fixed.
>
> Do you want me to send next revision so that you can base your proposed changes
> on top of that or how to proceed?

When you have all the other comments covered please resubmit the patchset.  I will
base my proposed changes on that.

>> Actually, the chip-select isn't really null since the SFRMOUT line is still
>> asserted (active-low) during any SPI transfer but the effect is still the same.
>
> Too bad that SFRMOUT cannot be used as GPIO, we could then use it as proper
> software controlled chipselect ;)

Probably limited foresight from the Cirrus people...  They must have assumed that
only one SPI device would be connected to the ep93xx.  Actually, the edb93xx
designs use the SFRMOUT to gate the GPIO chip select to the device.

Also, remember that the ep39xx SSP peripheral can be used in three different modes.
For Motorola SPI and National Semiconductor Microwire formats the SFRMOUT is basically
an active-low chip select.  But for Texas Instruments synchronous serial frame format
the pin is pulsed for one serial clock period prior to the transmission of each frame.

Regards,
Hartley
