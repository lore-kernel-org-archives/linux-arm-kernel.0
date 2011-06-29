From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 29 Jun 2011 10:11:49 -0700
Subject: [PATCH 1/5] ASoC: wm8731: rework power management
In-Reply-To: <ccd4b125244271af7978948689cf1dcef37bc06b.1309368631.git.nicolas.ferre@atmel.com>
References: <1309370419-22810-1-git-send-email-nicolas.ferre@atmel.com>
	<ccd4b125244271af7978948689cf1dcef37bc06b.1309368631.git.nicolas.ferre@atmel.com>
Message-ID: <20110629171148.GB10798@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 29, 2011 at 08:00:15PM +0200, Nicolas Ferre wrote:

Don't mix multiple changes into a single patch!  There's no perceptible
code overlap between these so I don't understand why you've merged them,
it just makes review harder and the changelog less descriptive.

> - preserve crystal oscillator across suspend/resume sequence:
>   enabled by default, it should be kept enabled on resume.

This isn't what your code does...

> - if codec is in active state: set the active bit at resume time.

Your changelog doesn't explain what the actual problem is here...  I can
see it by studying the diff but the changelog makes me think the change
is bad as the subsystem shuts everything down before it enters CODEC
suspend...

>  		snd_soc_write(codec, WM8731_ACTIVE, 0x0);
> -		snd_soc_write(codec, WM8731_PWR, 0xffff);
> +		/* standby: keep crystal oscillator enabled */
> +		snd_soc_write(codec, WM8731_PWR, 0x00df);

This doesn't keep the crystal oscillator enabled, this forces it on in
suspend (and without looking at the datasheet it also changes way more
than the one register bit I'd expect to be changed).  If the system
isn't using the oscillator then that's not good.

I'd expect to see a change to using snd_soc_update_bits() based on your
description, or more likely something more involved.

> @@ -533,6 +534,8 @@ static int wm8731_suspend(struct snd_soc_codec *codec, pm_message_t state)
>  static int wm8731_resume(struct snd_soc_codec *codec)
>  {
>  	wm8731_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
> +	if (codec->active)
> +		snd_soc_write(codec, WM8731_ACTIVE, 0x0001);

This should be handled as part of the bias level managemnent and cache
sync, if the disable happens in bias level management so should the
restore.
