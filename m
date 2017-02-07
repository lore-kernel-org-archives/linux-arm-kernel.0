From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 7 Feb 2017 12:09:50 +0100
Subject: [PATCH v2 3/3] gpiolib: Add GPIO initialization
In-Reply-To: <1440920686-6892-4-git-send-email-mpa@pengutronix.de>
References: <1440920686-6892-1-git-send-email-mpa@pengutronix.de>
 <1440920686-6892-4-git-send-email-mpa@pengutronix.de>
Message-ID: <20170207110950.zy5pzo2hq6hrvmr5@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

(Markus left Pengutronix, so I dropped his non-working address from the
recipients and pick up his discussion.)

as far as I see, this topic isn't closed yet. I want something similar,
maybe even a bit more than this patch achieves:

Some gpios should get a fixed direction. If such a gpio is configured as
output, a value should be specified. This is already working today with
gpio-hogs.

Now additionally I want to initialize some gpios but allow them to be
grabbed later. IMHO there are the following new cases:

It should be possible to:

 a) change the value of a gpio initially configured as output
 b) change the direction of a gpio initially configured as output
 c) change the direction of a gpio initially configured as input

IMHO the dts should describe which case should be applied to a given
gpio.

Is it a valid assumption that a gpio that can change direction is also
allowed to change value when configured as output? I assume this in the
following discussion, some details need to change if this shouldn't be
implied. (I think we need a d) then, not sure how this should look
though.)

I'd suggest the following description for these cases:

 a)
 	/*
	 * initially configured as low output. Consumer can do
	 * gpio_set_value(..., 1); but not gpio_direction_input(...);
	 */
 	nodename {
		gpio-hog;
		gpios = <...>;
		output-low-init;
	};

 b)
 	/*
	 * initially configured as low output. Consumer can do
	 * gpio_set_value(..., 1); and gpio_direction_input(...);
	 */
 	nodename {
		gpio-hog;
		gpios = <...>;
		output-init-low;
	};

 c)
 	/*
	 * initially configured as input. Consumer can do
	 * gpio_direction_output(..., ...) and then set the value
	 * freely.
	 */
	 nodename {
	 	gpio-hog;
		gpios = <...>;
		input-init;
	};

I don't like that "output-low-init" and "output-init-low" are so
similar, so if someone suggests a better naming scheme, that would be
great.

Does the idea (maybe apart from the naming) look good in general and/or
compared to Markus' suggestion?

(For those not having Markus' suggestion in mind any more. There we
could use "gpio-initval" instead of "gpio-hog" and then this had the
semantic of b) or c) using "input", "output-low" and "output-high". a)
wasn't possible to formalize.)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
