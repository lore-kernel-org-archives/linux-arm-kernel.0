From: lars@metafoo.de (Lars-Peter Clausen)
Date: Tue, 13 Jan 2015 10:47:02 +0100
Subject: [PATCH v2] ASoC: wm8904: fix runtime warning
In-Reply-To: <1421141643-30105-1-git-send-email-voice.shen@atmel.com>
References: <1421141643-30105-1-git-send-email-voice.shen@atmel.com>
Message-ID: <54B4E996.80403@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/13/2015 10:34 AM, Bo Shen wrote:
[...]
>
> -	{ "AIFOUTL", "Left",  "ADCL" },
> -	{ "AIFOUTL", "Right", "ADCR" },
> -	{ "AIFOUTR", "Left",  "ADCL" },
> -	{ "AIFOUTR", "Right", "ADCR" },
> +	{ "AIFOUTL Mux", "Left", "ADCL" },
> +	{ "AIFOUTL Mux", "Right", "ADCR" },
> +	{ "AIFOUTR Mux", "Left", "ADCL" },
> +	{ "AIFOUTR Mux", "Right", "ADCR" },
> +
> +	{ "AIFOUTL", NULL, "AIFOUTL Mux" },
> +	{ "AIFOUTR", NULL, "AIFOUTR Mux" },
>

This looks ok.

>   	{ "ADCL", NULL, "CLK_DSP" },
>   	{ "ADCL", NULL, "Left Capture PGA" },
> @@ -1089,14 +1092,20 @@ static const struct snd_soc_dapm_route adc_intercon[] = {
>   };
>
>   static const struct snd_soc_dapm_route dac_intercon[] = {
> -	{ "DACL", "Right", "AIFINR" },
> -	{ "DACL", "Left",  "AIFINL" },
> +	{ "DACL", NULL, "AIFINL" },
> +	{ "DACL", NULL, "AIFINR" },
>   	{ "DACL", NULL, "CLK_DSP" },
>
> -	{ "DACR", "Right", "AIFINR" },
> -	{ "DACR", "Left",  "AIFINL" },
> +	{ "DACR", NULL, "AIFINL" },
> +	{ "DACR", NULL, "AIFINR" },
>   	{ "DACR", NULL, "CLK_DSP" },
>
> +	{ "DACL Mux", "Left", "DACL" },
> +	{ "DACL Mux", "Right", "DACR" },
> +
> +	{ "DACR Mux", "Left", "DACL" },
> +	{ "DACR Mux", "Right", "DACR" },
> +

But this should probably be

 > +	{ "DACL Mux", "Left", "AIFINL" },
 > +	{ "DACL Mux", "Right", "AIFINR" },
 > +
 > +	{ "DACR Mux", "Left", "AIFINL" },
 > +	{ "DACR Mux", "Right", "AIFINR" },
 > +
 > +	{ "DACL", NULL, "DACL Mux" },
 > +	{ "DACR", NULL, "DACR Mux" },
