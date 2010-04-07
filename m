From: jakob.viketoft@bitsim.com (Jakob Viketoft)
Date: Wed, 07 Apr 2010 11:37:24 +0200
Subject: AC97 problems with pxa...
In-Reply-To: <201004070950.37809.marek.vasut@gmail.com>
References: <4BBBACBE.7040505@bitsim.com>
	<201004070950.37809.marek.vasut@gmail.com>
Message-ID: <4BBC5254.7040200@bitsim.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Do you mean mixing the AC97 non-asoc and asoc drivers or the drivers for 
the WM9712? I can't see the possibility of mixing anything for the 
WM9712, but I'm unsure of the distinction between the different AC97 pieces.

The only source code difference I can see is that the palmtx is adding a 
platform_driver in sound/soc/pxa/palm27x.c and a platform_device in 
arch/arm/mach-pxa/palmtx.c. But I haven't seen this in any of the 
"reference" drivers I looked at (mentioned in documentation), like 
spitz.c and corgi.c (which doesn't use ac97) but neither in tosa.c.

Should this make a difference? My module init function gets called, it's 
just the snd_soc_dai_link[0].init function that doesn't.

Regards,

	/Jakob

Marek Vasut wrote:
> Dne ?t 6. dubna 2010 23:50:54 Jakob Viketoft napsal(a):
>> Hello!
>>
>> I'm trying to add sound support to a Toradex Colibri 270 v2 card, but
>> have run into some strangeness which I don't quite understand. The v2 of
>> this card uses the WM9712 codec and I've written a machine driver to tie
>> the codec and the pxa2xx-ac97 driver together. I'm using the 2.6.33.1
>> kernel and my machine driver is a simplified version of the tosa driver
>> (no power management or headphone jack logic). However, I get two problems:
>> 1. Internal clock and headphone output is turned off in the
>> AC97_POWERDOWN register and I can't see where to (properly) turn it on,
>> neither in kernel space or in userland. No-one else using this codec
>> seem to be doing it.
>> 2. The init function defined in my snd_soc_card struct doesn't seem to
>> get called, resulting in way too many mixer settings (I have a number of
>> snd_soc_dapm_nc_pin calls) with alsa, but might it also have something
>> to do with problem 1?
>>
>> When explicitly writing 0 (the ugly way) to the AC97_POWERDOWN register
>> I get perfect sound output, but I would like to do it the right way.
>>
>> Two error reports from the dmesg output that might be relevant:
>> * pxa2xx_ac97_try_cold_reset: cold reset timeout (GSR=0x44)
>> * Error: Driver 'pxa2xx-ac97' is already registered, aborting...
>>
> 
> Aren't you mixing ASoC driver with non-ASoC driver? Check how this is done on 
> the palmtx for example (and the pxa27x.c asoc driver)
> 
>> The AC97 interface is added in the machine initialization through the
>> pxa_set_ac97_info() in the same way as tosa and many others and this
>> could explain the second error message...
>>
>> Any insight would be appreciated!
>>
>> Regards,
>>
>> 	/Jakob
>>
>>
> 
> CC Mark Brown
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
> 
