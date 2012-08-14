From: tiwai@suse.de (Takashi Iwai)
Date: Tue, 14 Aug 2012 14:17:15 +0200
Subject: [alsa-devel] [PATCH 03/22] ASoC: ab8500: Inform SoC Core that
 we	have our own I/O arrangements
In-Reply-To: <1344527268-5964-4-git-send-email-lee.jones@linaro.org>
References: <1344527268-5964-1-git-send-email-lee.jones@linaro.org>
 <1344527268-5964-4-git-send-email-lee.jones@linaro.org>
Message-ID: <s5h7gt1u0qc.wl%tiwai@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At Thu,  9 Aug 2012 16:47:29 +0100,
Lee Jones wrote:
> 
> If codec->control_data is not populated SoC Core assumes we want to
> use regmap, which fails catastrophically, as we don't have one:
> 
> Unable to handle kernel NULL pointer dereference at virtual address 00000080
> pgd = c0004000
> [00000080] *pgd=00000000
> Internal error: Oops: 17 [#1] PREEMPT SMP ARM
> Modules linked in:
> CPU: 1    Not tainted  (3.5.0-rc6-00884-g0b2419e-dirty #130)
> PC is at regmap_read+0x10/0x5c
> LR is at hw_read+0x80/0x90
> pc : [<c01a91b8>]    lr : [<c0216804>]    psr: 60000013
> 
> CC: alsa-devel at alsa-project.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

This was already fixed in ASoC core on Linus tree...


Takashi

> ---
>  sound/soc/codecs/ab8500-codec.c |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/sound/soc/codecs/ab8500-codec.c b/sound/soc/codecs/ab8500-codec.c
> index 3c79592..23b4018 100644
> --- a/sound/soc/codecs/ab8500-codec.c
> +++ b/sound/soc/codecs/ab8500-codec.c
> @@ -2406,6 +2406,10 @@ static int ab8500_codec_probe(struct snd_soc_codec *codec)
>  
>  	/* Setup AB8500 according to board-settings */
>  	pdata = (struct ab8500_platform_data *)dev_get_platdata(dev->parent);
> +
> +	/* Inform SoC Core that we have our own I/O arrangements. */
> +	codec->control_data = (void *)true;
> +
>  	status = ab8500_audio_setup_mics(codec, &pdata->codec->amics);
>  	if (status < 0) {
>  		pr_err("%s: Failed to setup mics (%d)!\n", __func__, status);
> -- 
> 1.7.9.5
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel at alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
