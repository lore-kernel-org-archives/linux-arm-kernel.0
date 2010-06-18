From: lrg@slimlogic.co.uk (Liam Girdwood)
Date: Fri, 18 Jun 2010 11:29:24 +0100
Subject: [PATCH] ASoC: Fix overflow bug in SOC_DOUBLE_R_SX_TLV
In-Reply-To: <1276829770-31557-1-git-send-email-redhatter@gentoo.org>
References: <20100618023810.GS7759@www.longlandclan.yi.org>
	<1276829770-31557-1-git-send-email-redhatter@gentoo.org>
Message-ID: <1276856964.3054.1.camel@odin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-06-18 at 12:56 +1000, Stuart Longland wrote:
> When SX_TLV widgets are read, if the gain is set to a value below 0dB,
> the mixer control is erroniously read as being at maximum volume.
> 
> The value read out of the CODEC register is never sign-extended, and
> when the minimum value is subtracted (read; added, since the minimum is
> negative) the result is a number greater than the maximum allowed value
> for the control, and hence it saturates.
> 
> Solution: Mask the result so that it "wraps around", emulating
> sign-extension.
> 
> Signed-off-by: Stuart Longland <redhatter@gentoo.org>
> ---
>  sound/soc/soc-core.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index a82a797..0470288 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -2400,8 +2400,8 @@ int snd_soc_get_volsw_2r_sx(struct snd_kcontrol *kcontrol,
>  	int val = snd_soc_read(codec, mc->reg) & mask;
>  	int valr = snd_soc_read(codec, mc->rreg) & mask;
>  
> -	ucontrol->value.integer.value[0] = ((val & 0xff)-min);
> -	ucontrol->value.integer.value[1] = ((valr & 0xff)-min);
> +	ucontrol->value.integer.value[0] = ((val & 0xff)-min) & mask;
> +	ucontrol->value.integer.value[1] = ((valr & 0xff)-min) & mask;
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(snd_soc_get_volsw_2r_sx);

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
