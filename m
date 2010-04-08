From: jakob.viketoft@bitsim.com (Jakob Viketoft)
Date: Thu, 08 Apr 2010 16:35:35 +0200
Subject: AC97 problems with pxa...
In-Reply-To: <20100408141247.GE30647@rakim.wolfsonmicro.main>
References: <4BBBACBE.7040505@bitsim.com>	<201004070950.37809.marek.vasut@gmail.com>	<4BBC5254.7040200@bitsim.com>	<20100407095449.GA13576@rakim.wolfsonmicro.main>	<4BBD9F28.9080804@bitsim.com>	<20100408095415.GC6303@rakim.wolfsonmicro.main>	<4BBDD480.8020708@bitsim.com>	<20100408134946.GD30647@rakim.wolfsonmicro.main>	<4BBDE2BD.6000708@bitsim.com>
	<20100408141247.GE30647@rakim.wolfsonmicro.main>
Message-ID: <4BBDE9B7.8080502@bitsim.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Mark Brown wrote:
> On Thu, Apr 08, 2010 at 04:05:49PM +0200, Jakob Viketoft wrote:
> 
>> The log output with kobject listed (do you need more info?)
> 
>> kobject: 'colibri270-v2-asoc' (c3c20bc0): kobject_add_internal:
>> parent: 'drivers', set: 'drivers'
>> kobject: 'colibri270-v2-asoc' (c3c20bc0): kobject_uevent_env
>> kobject: 'colibri270-v2-asoc' (c3c20bc0): fill_kobj_path: path =
>> '/bus/platform/drivers/colibri270-v2-asoc'
>> ALSA device list:
>>   No soundcards found.
> 
> So you've registered a driver for someting called 'collabri270-v2-asoc'
> - what is that?  This doesn't seem to correspond to the code you
> previously posted and there's no soc-audio anywhere here...
> 

I had moved the platform_add_devices call in the board init file while 
tracking. Moving it back up a few lines in the code make my machine 
driver pop up as the sound card. Is this the correct behaviour? As 
suggested I have added the asoc device to my machine driver to look more 
like the palmtx is doing things. Does this mean I'm down to finding the 
right setting with amixer to get things running? New debug output:

kobject: 'soc-audio' (c3c27680): kobject_add_internal: parent: 
'drivers', set: 'drivers'
kobject: 'soc-audio' (c3c27680): kobject_uevent_env
kobject: 'soc-audio' (c3c27680): fill_kobj_path: path = 
'/bus/platform/drivers/soc-audio'
Registered platform 'pxa2xx-audio'
kobject: 'pxa2xx-ac97' (c3c27620): kobject_add_internal: parent: 
'drivers', set: 'drivers'
Probed pxa2xx_ac97, trying to register DAI
Registered DAI 'pxa2xx-ac97'
Registered DAI 'pxa2xx-ac97-aux'
Registered DAI 'pxa2xx-ac97-mic'
kobject: 'pxa2xx-ac97' (c3c27620): kobject_uevent_env
kobject: 'pxa2xx-ac97' (c3c27620): fill_kobj_path: path = 
'/bus/platform/drivers/pxa2xx-ac97'
kobject: 'colibri270-v2-asoc' (c3c275c0): kobject_add_internal: parent: 
'drivers', set: 'drivers'
kobject: 'soc-audio' (c3c19a90): kobject_add_internal: parent: 
'platform', set: 'devices'
kobject: 'soc-audio' (c3c19a90): kobject_uevent_env
kobject: 'soc-audio' (c3c19a90): fill_kobj_path: path = 
'/devices/platform/soc-audio'
soc-audio soc-audio: All components present, instantiating
WM9711/WM9712 SoC Audio Codec 0.4
asoc: AC97 HiFi <-> pxa2xx-ac97 mapping ok
asoc: AC97 Aux <-> pxa2xx-ac97-aux mapping ok
pxa2xx_ac97_try_cold_reset: cold reset timeout (GSR=0x44)
WM9712: Power standby
dapm: WM9712: configuring unknown pin PC_BEEP
kobject: 'pcmC0D1p' (c3c19848): kobject_add_internal: parent: 'sound', 
set: 'devices'
kobject: 'pcmC0D1p' (c3c19848): kobject_uevent_env
kobject: 'pcmC0D1p' (c3c19848): fill_kobj_path: path = 
'/class/sound/pcmC0D1p'
kobject: 'soc-audio' (c3c19a90): fill_kobj_path: path = 
'/devices/platform/soc-audio'
kobject: 'pcmC0D0p' (c3c19788): kobject_add_internal: parent: 'sound', 
set: 'devices'
kobject: 'pcmC0D0p' (c3c19788): kobject_uevent_env
kobject: 'pcmC0D0p' (c3c19788): fill_kobj_path: path = 
'/class/sound/pcmC0D0p'
kobject: 'soc-audio' (c3c19a90): fill_kobj_path: path = 
'/devices/platform/soc-audio'
kobject: 'pcmC0D0c' (c3c196c8): kobject_add_internal: parent: 'sound', 
set: 'devices'
kobject: 'pcmC0D0c' (c3c196c8): kobject_uevent_env
kobject: 'pcmC0D0c' (c3c196c8): fill_kobj_path: path = 
'/class/sound/pcmC0D0c'
kobject: 'soc-audio' (c3c19a90): fill_kobj_path: path = 
'/devices/platform/soc-audio'
object: 'controlC0' (c3c19608): kobject_add_internal: parent: 'sound', 
set: 'devices'
kobject: 'controlC0' (c3c19608): kobject_uevent_env
kobject: 'controlC0' (c3c19608): fill_kobj_path: path = 
'/class/sound/controlC0'
kobject: 'soc-audio' (c3c19a90): fill_kobj_path: path = 
'/devices/platform/soc-audio'
kobject: '0-0:WM9712' (c3c291ac): kobject_add_internal: parent: 
'soc-audio', set: 'devices'
kobject: '0-0:WM9712' (c3c291ac): kobject_uevent_env
kobject: '0-0:WM9712' (c3c291ac): fill_kobj_path: path = 
'/devices/platform/soc-audio/0-0:WM9712'
soc-audio soc-audio: Registered card 'Colibri 270 v2'
kobject: 'colibri270-v2-asoc' (c3c275c0): kobject_uevent_env
kobject: 'colibri270-v2-asoc' (c3c275c0): fill_kobj_path: path = 
'/bus/platform/drivers/colibri270-v2-asoc'
ALSA device list:
   #0: Colibri 270 v2 (WM9712)

Posting the updated machine driver code for completeness:
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

static int colibri270_v2_asoc_probe(struct platform_device *pdev)
{
	int ret;

	if (!machine_is_colibri())
		return -ENODEV;

	colibri270_v2_snd_device = platform_device_alloc("soc-audio", -1);
	if (!colibri270_v2_snd_device)
		return -ENOMEM;

	platform_set_drvdata(colibri270_v2_snd_device,
			&colibri270_v2_snd_devdata);
	colibri270_v2_snd_devdata.dev = &colibri270_v2_snd_device->dev;
	ret = platform_device_add(colibri270_v2_snd_device);

	if (!ret)
		return 0;

	platform_device_put(colibri270_v2_snd_device);

	return ret;
}

static int __devexit colibri270_v2_asoc_remove(struct platform_device *pdev)
{
	platform_device_unregister(colibri270_v2_snd_device);
	return 0;
}

static struct platform_driver colibri270_v2_wm9712_driver = {
	.probe		= colibri270_v2_asoc_probe,
	.remove		= __devexit_p(colibri270_v2_asoc_remove),
	.driver		= {
		.name		= "colibri270-v2-asoc",
		.owner		= THIS_MODULE,
	},
};

static int __init colibri270_v2_init(void)
{
	platform_driver_register(&colibri270_v2_wm9712_driver);
}

static void __exit colibri270_v2_exit(void)
{
	platform_driver_unregister(&colibri270_v2_wm9712_driver);
}

module_init(colibri270_v2_init);
module_exit(colibri270_v2_exit);

/* Module information */
MODULE_AUTHOR("Jakob Viketoft");
MODULE_DESCRIPTION("ALSA SoC Toradex Colibri 270 v2");
MODULE_LICENSE("GPL");

> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
