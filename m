From: marek.vasut@gmail.com (Marek Vasut)
Date: Wed, 7 Apr 2010 21:08:08 +0200
Subject: AC97 problems with pxa...
In-Reply-To: <4BBC4CD7.7010606@bitsim.com>
References: <4BBBACBE.7040505@bitsim.com>
	<p2nf17812d71004061909qb3c18439gf38073e39f1b4035@mail.gmail.com>
	<4BBC4CD7.7010606@bitsim.com>
Message-ID: <201004072108.08444.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne St 7. dubna 2010 11:13:59 Jakob Viketoft napsal(a):
> I'm including the source code for the machine driver inline here, but
> not as a patch as it's not in patch state yet. It's really quite basic.
> Adding a printk (with KERN_ERR) in the colibri270_v2_ac97_init function
> doesn't show up in dmesg and that makes me believe it's never entered.
> The snd_soc_dapm_nc_pin calls doesn't seem to have an effect either...
> 
> Regards,
> 
> 	/Jakob

Hi, first, please keep the CC consistent.
> 
> -----------

...

> 
> static int colibri270_v2_ac97_init(struct snd_soc_codec *codec)
> {
> 	/* Unused inputs */
> 	snd_soc_dapm_nc_pin(codec, "MIC2");
> 	snd_soc_dapm_nc_pin(codec, "PHONE");
> 	snd_soc_dapm_nc_pin(codec, "PC_BEEP");
> 
> 	/* Unused outputs */
> 	snd_soc_dapm_nc_pin(codec, "LOUT2");
> 	snd_soc_dapm_nc_pin(codec, "ROUT2");
> 	snd_soc_dapm_nc_pin(codec, "OUT3");
> 	snd_soc_dapm_nc_pin(codec, "MONOOUT");
> 
> 	snd_soc_dapm_sync(codec);

Check retval here ?
> 
> 	return 0;
> }

...

> static void __exit colibri270_v2_exit(void)
> {
> 	platform_device_unregister(colibri270_v2_snd_device);
> }
> 
> module_init(colibri270_v2_init);
> module_exit(colibri270_v2_exit);

Maybe take a look at palm27x.c, it's registered as a platform_device there (and 
imo fits better the model).

Mark, what do you think? Correct me as I might be wrong here.
> 
> /* Module information */
> MODULE_AUTHOR("Jakob Viketoft");
> MODULE_DESCRIPTION("ALSA SoC Toradex Colibri 270 v2");
> MODULE_LICENSE("GPL");
> 
> Eric Miao wrote:
> > On Wed, Apr 7, 2010 at 5:50 AM, Jakob Viketoft
> >
> > <jakob.viketoft@bitsim.com> wrote:
> >> Hello!
> >>
> >> I'm trying to add sound support to a Toradex Colibri 270 v2 card, but
> >> have run into some strangeness which I don't quite understand. The v2 of
> >> this card uses the WM9712 codec and I've written a machine driver to tie
> >> the codec and the pxa2xx-ac97 driver together. I'm using the 2.6.33.1
> >> kernel and my machine driver is a simplified version of the tosa driver
> >> (no power management or headphone jack logic). However, I get two
> >> problems: 1. Internal clock and headphone output is turned off in the
> >> AC97_POWERDOWN register and I can't see where to (properly) turn it on,
> >> neither in kernel space or in userland. No-one else using this codec
> >> seem to be doing it.
> >> 2. The init function defined in my snd_soc_card struct doesn't seem to
> >> get called, resulting in way too many mixer settings (I have a number of
> >> snd_soc_dapm_nc_pin calls) with alsa, but might it also have something
> >> to do with problem 1?
> >>
> >> When explicitly writing 0 (the ugly way) to the AC97_POWERDOWN register
> >> I get perfect sound output, but I would like to do it the right way.
> >>
> >> Two error reports from the dmesg output that might be relevant:
> >> * pxa2xx_ac97_try_cold_reset: cold reset timeout (GSR=0x44)
> >> * Error: Driver 'pxa2xx-ac97' is already registered, aborting...
> >>
> >> The AC97 interface is added in the machine initialization through the
> >> pxa_set_ac97_info() in the same way as tosa and many others and this
> >> could explain the second error message...
> >>
> >> Any insight would be appreciated!
> >
> > Better if you could come up with a patch or source code for analysis.
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
