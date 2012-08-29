From: vsu@altlinux.ru (Sergey Vlasov)
Date: Wed, 29 Aug 2012 10:25:34 +0400
Subject: [alsa-devel] [PATCH V2 1/6] ASoC: davinci: davinci-pcm does not
 need to be a plaform_driver
In-Reply-To: <1346074004-22172-2-git-send-email-gururaja.hebbar@ti.com>
References: <1346074004-22172-1-git-send-email-gururaja.hebbar@ti.com>
 <1346074004-22172-2-git-send-email-gururaja.hebbar@ti.com>
Message-ID: <20120829062534.GB11919@newmaster.mivlgu.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 27, 2012 at 06:56:39PM +0530, Hebbar, Gururaja wrote:
> Same as the commit 518de86 (ASoC: tegra: register 'platform' from DAIs,
> get rid of pdev). It makes davinci-pcm not a platform_driver but helper
> to register "platform", so that the platform_device for davinci-pcm can
> be saved completely.
> 
> Signed-off-by: Hebbar, Gururaja <gururaja.hebbar@ti.com>
> ---
> Changes from V1:
> 	- New Commit. Instanciate seudo-device (davinci-pcm) directly from DAI
> 	  driver rather than having a separate virtual-device registered
> 
> :100644 100644 c80c20a... 4b37e2a... M	sound/soc/davinci/davinci-evm.c
> :100644 100644 0a74b95... 407df72... M	sound/soc/davinci/davinci-i2s.c
> :100644 100644 6a2c54c... 34ee2f1... M	sound/soc/davinci/davinci-mcasp.c
> :100644 100644 97d77b2... 4b70828... M	sound/soc/davinci/davinci-pcm.c
> :100644 100644 c0d6c9b... 5e55164... M	sound/soc/davinci/davinci-pcm.h
> :100644 100644 f71175b... 5be65aa... M	sound/soc/davinci/davinci-sffsdr.c
> :100644 100644 da030ff... 07bde2e... M	sound/soc/davinci/davinci-vcif.c
>  sound/soc/davinci/davinci-evm.c    |   15 ++++++++-------
>  sound/soc/davinci/davinci-i2s.c    |   10 ++++++++++
>  sound/soc/davinci/davinci-mcasp.c  |   10 ++++++++++
>  sound/soc/davinci/davinci-pcm.c    |   23 ++++++-----------------
>  sound/soc/davinci/davinci-pcm.h    |    3 +++
>  sound/soc/davinci/davinci-sffsdr.c |    2 +-
>  sound/soc/davinci/davinci-vcif.c   |    8 ++++++++
>  7 files changed, 46 insertions(+), 25 deletions(-)
> 
> diff --git a/sound/soc/davinci/davinci-evm.c b/sound/soc/davinci/davinci-evm.c
> index c80c20a..4b37e2a 100644
> --- a/sound/soc/davinci/davinci-evm.c
> +++ b/sound/soc/davinci/davinci-evm.c
> @@ -159,7 +159,7 @@ static struct snd_soc_dai_link dm6446_evm_dai = {
>  	.cpu_dai_name = "davinci-mcbsp",
>  	.codec_dai_name = "tlv320aic3x-hifi",
>  	.codec_name = "tlv320aic3x-codec.1-001b",
> -	.platform_name = "davinci-pcm-audio",
> +	.platform_name = "davinci-mcbsp",
>  	.init = evm_aic3x_init,
>  	.ops = &evm_ops,
>  };
> @@ -170,7 +170,7 @@ static struct snd_soc_dai_link dm355_evm_dai = {
>  	.cpu_dai_name = "davinci-mcbsp.1",
>  	.codec_dai_name = "tlv320aic3x-hifi",
>  	.codec_name = "tlv320aic3x-codec.1-001b",
> -	.platform_name = "davinci-pcm-audio",
> +	.platform_name = "davinci-mcbsp.1",
>  	.init = evm_aic3x_init,
>  	.ops = &evm_ops,
>  };
> @@ -184,14 +184,15 @@ static struct snd_soc_dai_link dm365_evm_dai = {
>  	.init = evm_aic3x_init,
>  	.codec_name = "tlv320aic3x-codec.1-0018",
>  	.ops = &evm_ops,
> +	.platform_name = "davinci-mcbsp",
>  #elif defined(CONFIG_SND_DM365_VOICE_CODEC)
>  	.name = "Voice Codec - CQ93VC",
>  	.stream_name = "CQ93",
>  	.cpu_dai_name = "davinci-vcif",
>  	.codec_dai_name = "cq93vc-hifi",
>  	.codec_name = "cq93vc-codec",
> +	.platform_name = "avinci-vcif",

Typo?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 190 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120829/7710c2b8/attachment.sig>
