From: jakob.viketoft@bitsim.com (Jakob Viketoft)
Date: Tue, 06 Apr 2010 23:50:54 +0200
Subject: AC97 problems with pxa...
Message-ID: <4BBBACBE.7040505@bitsim.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

I'm trying to add sound support to a Toradex Colibri 270 v2 card, but
have run into some strangeness which I don't quite understand. The v2 of
this card uses the WM9712 codec and I've written a machine driver to tie
the codec and the pxa2xx-ac97 driver together. I'm using the 2.6.33.1
kernel and my machine driver is a simplified version of the tosa driver
(no power management or headphone jack logic). However, I get two problems:
1. Internal clock and headphone output is turned off in the
AC97_POWERDOWN register and I can't see where to (properly) turn it on,
neither in kernel space or in userland. No-one else using this codec
seem to be doing it.
2. The init function defined in my snd_soc_card struct doesn't seem to
get called, resulting in way too many mixer settings (I have a number of
snd_soc_dapm_nc_pin calls) with alsa, but might it also have something
to do with problem 1?

When explicitly writing 0 (the ugly way) to the AC97_POWERDOWN register
I get perfect sound output, but I would like to do it the right way.

Two error reports from the dmesg output that might be relevant:
* pxa2xx_ac97_try_cold_reset: cold reset timeout (GSR=0x44)
* Error: Driver 'pxa2xx-ac97' is already registered, aborting...

The AC97 interface is added in the machine initialization through the
pxa_set_ac97_info() in the same way as tosa and many others and this
could explain the second error message...

Any insight would be appreciated!

Regards,

	/Jakob
