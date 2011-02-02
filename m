From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Wed, 2 Feb 2011 10:45:13 -0600
Subject: [PATCH] EDB93xx: Add support for CS4271 CODEC on EDB93xx boards
In-Reply-To: <1296643688.1504.23.camel@r60e>
References: <1296603653.1504.9.camel@r60e>
	<0D753D10438DA54287A00B027084269764CEF59B2B@AUSP01VMBX24.collaborationhost.net>
	<1296643688.1504.23.camel@r60e>
Message-ID: <0D753D10438DA54287A00B027084269764CEFD45AD@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, February 02, 2011 3:48 AM, Alexander Sverdlin wrote:
>
> Dear Hartley, Dear Mark,
>
> On Tue, 2011-02-01 at 18:02 -0600, H Hartley Sweeten wrote:
>>> +static int edb93xx_cs4271_hw_setup(struct spi_device *spi)
>>> +{
>>> +	int gpio_nreset;
>>> +	int err;
>>> +
>>> +	if (machine_is_edb9301() || machine_is_edb9302()) {
>>> +		gpio_nreset = EP93XX_GPIO_LINE_EGPIO1;
>>
>> Are you planning on removing gpio_nreset and gpio_disable from struct
>> cs4271_platform_data?  If not, you should just setup the gpio mapping
>> in edb93xx_register_spi before you actually register the spi_board_info.
>> Then this function and the following two can just do something like the
>> following and not worry about the if ... else if ... etc.
>
> Initially I had GPIO code in machine driver, but during the
> conversations in alsa-devel list it has been moved to CODEC driver:
> http://mailman.alsa-project.org/pipermail/alsa-devel/2010-October/032358.html
> 
> I'm really confused now, where should it be? If I will init
> cs4271_platform_data with GPIO values, CODEC driver will manage it.
> Otherwise CODEC driver should be rewritten without GPIO support and I
> can add it to platform code.
> 
> Mark Brown, could you please comment on this, as I've moved GPIO things
> to CODEC part based on your review.

The chip-select request/configuration needs to be done before loading the
driver so that the spi subsystem can actually select the chip.  Also, some
spi master drivers might not even use a 'gpio' for the chip-select.  They
might have dedicated pins that are used.

For the reset, again a gpio might not actually be used.  The systems reset
signal might be directly connected to the codec.

Regardless, the cs4271 codec driver isn't doing anything with the gpios
except in the probe function.  And all it's does there is request and
configure them, drive the chip-select gpio low (permenatly enabing it),
and then toggles the reset line to reset the codec.

It appears to me that none of this should be in the codec driver itself.  It's
really platform specific and serves no use in the driver.  The <sound/cs4271.h>
header should just be removed.  Let the platform deal with the non-generic
configuration and setup of the gpio's.

Regards,
Hartley
