From: jakob.viketoft@bitsim.com (Jakob Viketoft)
Date: Wed, 07 Apr 2010 11:13:59 +0200
Subject: AC97 problems with pxa...
In-Reply-To: <p2nf17812d71004061909qb3c18439gf38073e39f1b4035@mail.gmail.com>
References: <4BBBACBE.7040505@bitsim.com>
	<p2nf17812d71004061909qb3c18439gf38073e39f1b4035@mail.gmail.com>
Message-ID: <4BBC4CD7.7010606@bitsim.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I'm including the source code for the machine driver inline here, but 
not as a patch as it's not in patch state yet. It's really quite basic. 
Adding a printk (with KERN_ERR) in the colibri270_v2_ac97_init function 
doesn't show up in dmesg and that makes me believe it's never entered. 
The snd_soc_dapm_nc_pin calls doesn't seem to have an effect either...

Regards,

	/Jakob

-----------

/*
  * SoC audio driver for Toradex Colibri 270 v2
  *
  * Copyright 2010 BitSim AB
  *
  * Author: Jakob Viketoft <javi@bitsim.com>
  *
  * Copied from tosa.c:
  * Copyright 2005 Wolfson Microelectronics PLC.
  * Copyright 2005 Openedhand Ltd.
  *
  * Authors: Liam Girdwood <lrg@slimlogic.co.uk>
  *          Richard Purdie <richard@openedhand.com>
  *
  *  This program is free software; you can redistribute  it and/or 
modify it
  *  under  the terms of  the GNU General  Public License as published 
by the
  *  Free Software Foundation;  either version 2 of the  License, or (at 
your
  *  option) any later version.
  *
  */

#include <linux/module.h>
#include <linux/moduleparam.h>
#include <linux/device.h>
#include <linux/gpio.h>

#include <sound/core.h>
#include <sound/pcm.h>
#include <sound/soc.h>
#include <sound/soc-dapm.h>

#include <asm/mach-types.h>
#include <mach/audio.h>

#include "../codecs/wm9712.h"
#include "pxa2xx-pcm.h"
#include "pxa2xx-ac97.h"

static struct snd_soc_card colibri270_v2;

static int colibri270_v2_ac97_init(struct snd_soc_codec *codec)
{
	/* Unused inputs */
	snd_soc_dapm_nc_pin(codec, "MIC2");
	snd_soc_dapm_nc_pin(codec, "PHONE");
	snd_soc_dapm_nc_pin(codec, "PC_BEEP");

	/* Unused outputs */
	snd_soc_dapm_nc_pin(codec, "LOUT2");
	snd_soc_dapm_nc_pin(codec, "ROUT2");
	snd_soc_dapm_nc_pin(codec, "OUT3");
	snd_soc_dapm_nc_pin(codec, "MONOOUT");

	snd_soc_dapm_sync(codec);

	return 0;
}

static struct snd_soc_dai_link colibri270_v2_dai[] = {
{
	.name = "AC97",
	.stream_name = "AC97 HiFi",
	.cpu_dai = &pxa_ac97_dai[PXA2XX_DAI_AC97_HIFI],
	.codec_dai = &wm9712_dai[WM9712_DAI_AC97_HIFI],
	.init = colibri270_v2_ac97_init,
},
{
	.name = "AC97 Aux",
	.stream_name = "AC97 Aux",
	.cpu_dai = &pxa_ac97_dai[PXA2XX_DAI_AC97_AUX],
	.codec_dai = &wm9712_dai[WM9712_DAI_AC97_AUX],
},
};

static struct snd_soc_card colibri270_v2 = {
	.name = "Colibri 270 v2",
	.platform = &pxa2xx_soc_platform,
	.dai_link = colibri270_v2_dai,
	.num_links = ARRAY_SIZE(colibri270_v2_dai),
};

static struct snd_soc_device colibri270_v2_snd_devdata = {
	.card = &colibri270_v2,
	.codec_dev = &soc_codec_dev_wm9712,
};

static struct platform_device *colibri270_v2_snd_device;

static int __init colibri270_v2_init(void)
{
	int ret;

	if (!machine_is_colibri())
		return -ENODEV;

	colibri270_v2_snd_device = platform_device_alloc("soc-audio", -1);
	if (!colibri270_v2_snd_device) {
		ret = -ENOMEM;
		goto err_alloc;
	}

	platform_set_drvdata(colibri270_v2_snd_device,
			&colibri270_v2_snd_devdata);
	colibri270_v2_snd_devdata.dev = &colibri270_v2_snd_device->dev;
	ret = platform_device_add(colibri270_v2_snd_device);

	if (!ret)
		return 0;

	platform_device_put(colibri270_v2_snd_device);

err_alloc:
	return ret;
}

static void __exit colibri270_v2_exit(void)
{
	platform_device_unregister(colibri270_v2_snd_device);
}

module_init(colibri270_v2_init);
module_exit(colibri270_v2_exit);

/* Module information */
MODULE_AUTHOR("Jakob Viketoft");
MODULE_DESCRIPTION("ALSA SoC Toradex Colibri 270 v2");
MODULE_LICENSE("GPL");

Eric Miao wrote:
> On Wed, Apr 7, 2010 at 5:50 AM, Jakob Viketoft
> <jakob.viketoft@bitsim.com> wrote:
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
>> The AC97 interface is added in the machine initialization through the
>> pxa_set_ac97_info() in the same way as tosa and many others and this
>> could explain the second error message...
>>
>> Any insight would be appreciated!
>>
> 
> Better if you could come up with a patch or source code for analysis.
> 
