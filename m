From: jiri.prchal@aksignal.cz (=?UTF-8?B?UHJjaGFsIEppxZnDrQ==?=)
Date: Tue, 26 Jun 2012 11:01:42 +0200
Subject: [PATCH V2] ASoC: tlv320aic3x: Fix codec pll configure bug
In-Reply-To: <1340690623-18177-1-git-send-email-gururaja.hebbar@ti.com>
References: <1340690623-18177-1-git-send-email-gururaja.hebbar@ti.com>
Message-ID: <4FE97A76.5070105@aksignal.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gururaja,
shouldn't be better to use:

snd_soc_update_bits(codec, AIC3X_PLL_PROGA_REG, PLLP_MASK, pll_p);

instead of "read mask write" ?
Even at this place you don't need to keep rest of register (PLL_Q and PLL_enable), so yust writing is OK.

snd_soc_write(codec, AIC3X_PLL_PROGA_REG, pll_p << PLLP_SHIFT);


Dne 26.6.2012 08:03, Hebbar, Gururaja napsal(a):
> In sound/soc/codecs/tlv320aic3x.c
>
>          data = snd_soc_read(codec, AIC3X_PLL_PROGA_REG);
>          snd_soc_write(codec, AIC3X_PLL_PROGA_REG,
>                        data | (pll_p<<  PLLP_SHIFT));
>
> In the above code, pll-p value is OR'ed with previous value without
> clearing it. Bug is not seen if pll-p value doesn't change across
> Sampling frequency.
>
> However on some platforms (like AM335x EVM-SK), pll-p may have different
> values across different sampling frequencies. In such case, above code
> configures the pll with a wrong value.
> Because of this bug, when a audio stream is played with pll value
> different from previous stream, audio is heard as differently.
>
> Signed-off-by: Hebbar, Gururaja<gururaja.hebbar@ti.com>
> ---
> chnages in V2:
> 	modify subject to indicate ASOC and codec as tlv320aic3x
>
>   sound/soc/codecs/tlv320aic3x.c |    2 +-
>   sound/soc/codecs/tlv320aic3x.h |    1 +
>   2 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
> index d0dbac1..8c1977b 100644
> --- a/sound/soc/codecs/tlv320aic3x.c
> +++ b/sound/soc/codecs/tlv320aic3x.c
> @@ -963,7 +963,7 @@ static int aic3x_hw_params(struct snd_pcm_substream *substream,
>   	}
>
>   found:
> -	data = snd_soc_read(codec, AIC3X_PLL_PROGA_REG);
> +	data = snd_soc_read(codec, AIC3X_PLL_PROGA_REG)&  ~PLLP_MASK;
>   	snd_soc_write(codec, AIC3X_PLL_PROGA_REG,
>   		      data | (pll_p<<  PLLP_SHIFT));
>   	snd_soc_write(codec, AIC3X_OVRF_STATUS_AND_PLLR_REG,
> diff --git a/sound/soc/codecs/tlv320aic3x.h b/sound/soc/codecs/tlv320aic3x.h
> index 06a1978..16d9999 100644
> --- a/sound/soc/codecs/tlv320aic3x.h
> +++ b/sound/soc/codecs/tlv320aic3x.h
> @@ -166,6 +166,7 @@
>
>   /* PLL registers bitfields */
>   #define PLLP_SHIFT		0
> +#define PLLP_MASK		7
>   #define PLLQ_SHIFT		3
>   #define PLLR_SHIFT		0
>   #define PLLJ_SHIFT		2
