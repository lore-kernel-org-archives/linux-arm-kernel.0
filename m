From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 26 Jan 2010 10:19:21 +0000
Subject: [PATCH 3/3] ARM: SMDK64XX: Enable AC97 device
In-Reply-To: <1264485101-13782-3-git-send-email-jassisinghbrar@gmail.com>
References: <1264485101-13782-1-git-send-email-jassisinghbrar@gmail.com>
	<1264485101-13782-2-git-send-email-jassisinghbrar@gmail.com>
	<1264485101-13782-3-git-send-email-jassisinghbrar@gmail.com>
Message-ID: <20100126101921.GE15759@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 26, 2010 at 02:51:41PM +0900, jassisinghbrar at gmail.com wrote:
> From: Jassi Brar <jassi.brar@samsung.com>
> 
> Implementing basic support for Playback/Capture by SMDK's AC97
> controller with WM9713 codec, this patch adds the ALSA machine
> driver for AC97 device.

Might be better to split this into an arch/arm patch and a sound/soc
patch - they don't appear to depend on each other so it'd ease merging.

> +static int smdk_hifi_hw_params(struct snd_pcm_substream *substream,
> +				struct snd_pcm_hw_params *params)
> +{
> +	/* CAPTURE - Stereo LineIn
> +	 * Currently there is no other way to change ACLink-In slots
> +	 * of Wm9713, so we make do with this call.
> +	 */
> +	/* Slots-3,4*/
> +	soc_ac97_ops.write(NULL, 0x5c, 0);
> +
> +	return 0;
> +}

This one needs a bit more explanation - why are you changing the AC97
slot?  Is this a general problem with the S3C AC97 controller?  It'd
also be better to use the symbolic register name rather than a number.
