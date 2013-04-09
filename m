From: dt.tangr@gmail.com (Daniel Tang)
Date: Tue, 9 Apr 2013 15:59:52 +1000
Subject: [RFC PATCH arm: initial TI-Nspire support]
In-Reply-To: <op.wu8k5pwqu7prd4@fabians-laptop.fritz.box>
References: <6FE4B33E-A503-4A75-AEED-831CB2C06D83@gmail.com>
 <4B3FD561-84FC-40CD-B747-13851692D673@gmail.com>
 <521DFDFC-7E9E-47EA-ACDA-C91BBDC8454E@gmail.com>
 <201304072323.42173.arnd@arndb.de>
 <896CB251-17FC-4327-BA4E-A8FD9ED1BEC7@gmail.com>
 <op.wu8k5pwqu7prd4@fabians-laptop.fritz.box>
Message-ID: <29D8E742-C870-45AE-B102-13A477AE6419@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 09/04/2013, at 5:16 AM, Fabian Vogt <fabian@ritter-vogt.de> wrote:

> The latest kernel it seems to get stuck at
> console_lock() in register_framebuffer (drivers/video/fbmem.c:1655)
> if the LCD-controller is enabled. (Early printk and serial console works fine)
> CONFIG_NO_HZ is not activated, it works completely.
> Could this be a kernel bug or is this an issue with our timer configuration?

Even with the CONFIG_NO_HZ option disabled, I've found that probing of our LCD hardware sometimes still fail with an error of -2.

Depending on how I arrange the device tree or the contents of the boot arguments or, as said, the CONFIG_NO_HZ option, I get different behaviours ranging from: 
 * Getting a -2 error during device probe (possibly due to a clock not being found).
 * LCD hardware is found but boot hangs right after the driver is initialised.
 * LCD hardware is apparently initialised correctly and text appears onscreen but user mode init hangs and I never get to a shell prompt.

This smells of a race condition that occurs before the clcd driver even gets to initialise. Some bug in our timer code? A OF or console bug perhaps? Though, I'm a bit hesitant to blame it on a kernel subsystem bug until it's clear that our code isn't at fault.

Any suggestions?
