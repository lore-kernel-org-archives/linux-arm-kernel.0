From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 13 Nov 2012 17:30:33 +0900
Subject: [PATCH v5 2/3] ASoC: atmel-ssc-dai: register dai and pcm directly
In-Reply-To: <1352706028-750-3-git-send-email-voice.shen@atmel.com>
References: <1352706028-750-1-git-send-email-voice.shen@atmel.com>
 <1352706028-750-3-git-send-email-voice.shen@atmel.com>
Message-ID: <20121113083031.GP18224@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 12, 2012 at 03:40:26PM +0800, Bo Shen wrote:

>  static struct platform_device sam9g20ek_audio_device = {
>  	.name   = "at91sam9g20ek-audio",
> -	.id     = -1,
> +	.id     = 0,
>  };

Why are you changing this?  Single devices are supposed to specify -1 as
their id.

>  static int atmel_ssc_startup(struct snd_pcm_substream *substream,
>  			     struct snd_soc_dai *dai)
>  {
> -	struct atmel_ssc_info *ssc_p = &ssc_info[dai->id];
> +	struct atmel_ssc_info *ssc_p = &ssc_info;

This seems like a very big step backwards, there's now a single global
variable for the ssc_info which presumably means there can be only one
SSC active in the system at once.  That's changing a lot more than just
the registration...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121113/c38c8800/attachment.sig>
