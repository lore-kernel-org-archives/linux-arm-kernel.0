From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Tue, 26 Jan 2010 20:30:53 -0500
Subject: [PATCH 03/10] ARM: LPC32XX: core architecture files
In-Reply-To: <20100127010335.GH9153@trinity.fluff.org>
References: <1264551591.6528.6@usb10132>
	<20100127010335.GH9153@trinity.fluff.org>
Message-ID: <BD79186B4FD85F4B8E60E381CAEE1909020E9428@mi8nycmail19.Mi8.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, January 26, 2010 6:04 PM, Ben Dooks wrote:

Just a couple comments...

>> +static int lpc32xx_gpio_dir_in_none(struct gpio_chip *chip,
>> +	unsigned pin)
>> +{
>> +	return -EINVAL;
>> +}
> does gpiolib do this for you already?

If the direction_input() or get() methods are not defined the gpiolib
function gpio_direction_input() will return -EINVAL.  So for output
only gpio_chip's just don't define those callbacks.

Similar for input only gpio_chip's.  If the set() or direction_output()
methods are not defined, gpiolib will return -EINVAL.

>> +static void lpc32xx_gpo_set_value(struct gpio_chip *chip, unsigned pin,
>> +	int value)
>> +{
>> +	struct lpc32xx_gpio_chip *group = to_lpc32xx_gpio(chip);
>> +
>> +	if (pin < chip->ngpio)
>> +		__set_gpo_level_p3(group, pin, value);
>> +}
>
> I thought gpiolib would enforce 'if (pin < chip->ngpio)'

Generally yes. gpio_direction_input() and gpio_direction_output() check to
make sure the 'pin' is in the 'chip' and return -EINVAL if it's not.  The
gpio_{set/get}_value() functions don't check, but since each gpio is
associated with a specific gpio_desc the extra check's in this file are
probably overkill.

Regards,
Hartley
