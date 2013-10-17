From: b42378@freescale.com (Nicolin Chen)
Date: Thu, 17 Oct 2013 17:56:20 +0800
Subject: [PATCHv1 5/8] ASoC: sgtl5000: Revise the bugs about the sgt15000
 codec.
In-Reply-To: <1382000477-17304-6-git-send-email-Li.Xiubo@freescale.com>
References: <1382000477-17304-1-git-send-email-Li.Xiubo@freescale.com>
 <1382000477-17304-6-git-send-email-Li.Xiubo@freescale.com>
Message-ID: <20131017095619.GA27044@MrMyself>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Oct 17, 2013 at 05:01:14PM +0800, Xiubo Li wrote:
> When the CONFIG_REGULATOR is disabled there will be some warnings
> printed out.

A little confused by the title. But after looking at the comments,
is the patch just gonna add some debug info for the case when the
CONFIG_REGULATOR's been un-selected? 

Well first, I think at least the title should be more explicit.
And second, the necessity of this patch might just a little...
if CONFIG_REGULATOR is required to power it up, why not turn it on.

> 
> Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
> ---
>  sound/soc/codecs/sgtl5000.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
> index 1f4093f..4e2e4c9 100644
> --- a/sound/soc/codecs/sgtl5000.c
> +++ b/sound/soc/codecs/sgtl5000.c
> @@ -883,14 +883,19 @@ static int ldo_regulator_register(struct snd_soc_codec *codec,
>  				struct regulator_init_data *init_data,
>  				int voltage)
>  {
> +#ifdef CONFIG_SND_SOC_FSL_SGTL5000

Why there's FSL_SGTL5000 here? Not supposed to be CONFIG_REGULATOR?

> +	return 0;
> +#else
>  	dev_err(codec->dev, "this setup needs regulator support in the kernel\n");
>  	return -EINVAL;
> +#endif
>  }
>  
>  static int ldo_regulator_remove(struct snd_soc_codec *codec)
>  {
>  	return 0;
>  }
> +

I don't think it's fair to add a meaningless line. It doesn't make any sense
according to the title and comments.

>  #endif
>  
>  /*
> @@ -1137,6 +1142,7 @@ static int sgtl5000_resume(struct snd_soc_codec *codec)
>  #define sgtl5000_resume  NULL
>  #endif	/* CONFIG_SUSPEND */
>  
> +#ifdef CONFIG_REGULATOR

The inline regulator-related functions are already have REGULATOR dependency.
Is that necessary to put an additional one here?

>  /*
>   * sgtl5000 has 3 internal power supplies:
>   * 1. VAG, normally set to vdda/2
> @@ -1269,6 +1275,7 @@ static int sgtl5000_set_power_regs(struct snd_soc_codec *codec)
>  
>  	return 0;
>  }
> +#endif
>  
>  static int sgtl5000_replace_vddd_with_ldo(struct snd_soc_codec *codec)
>  {
> @@ -1370,6 +1377,7 @@ err_regulator_free:
>  				sgtl5000->supplies);
>  	if (external_vddd)
>  		ldo_regulator_remove(codec);
> +

Pls drop this.

>  	return ret;
>  
>  }
> @@ -1391,11 +1399,12 @@ static int sgtl5000_probe(struct snd_soc_codec *codec)
>  	if (ret)
>  		return ret;
>  
> +#ifdef CONFIG_REGULATOR
>  	/* power up sgtl5000 */
>  	ret = sgtl5000_set_power_regs(codec);
>  	if (ret)
>  		goto err;
> -
> +#endif
>  	/* enable small pop, introduce 400ms delay in turning off */
>  	snd_soc_update_bits(codec, SGTL5000_CHIP_REF_CTRL,
>  				SGTL5000_SMALL_POP,
> @@ -1446,6 +1455,7 @@ err:
>  						sgtl5000->supplies);
>  	regulator_bulk_free(ARRAY_SIZE(sgtl5000->supplies),
>  				sgtl5000->supplies);
> +

Ditto

>  	ldo_regulator_remove(codec);
>  
>  	return ret;
> @@ -1461,6 +1471,7 @@ static int sgtl5000_remove(struct snd_soc_codec *codec)
>  						sgtl5000->supplies);
>  	regulator_bulk_free(ARRAY_SIZE(sgtl5000->supplies),
>  				sgtl5000->supplies);
> +

Ditto 

Best regards,
Nicolin Chen

>  	ldo_regulator_remove(codec);
>  
>  	return 0;
> -- 
> 1.8.0
> 
