From: alex@digriz.org.uk (Alexander Clouter)
Date: Sat, 15 May 2010 17:52:32 +0100
Subject: [patch 6/6] kirkwood: Add audio support to openrd?client platforms
References: <20100515152958.899927802@mandriva.com>
	<20100515153131.221491641@mandriva.com>
Message-ID: <g303c7-3er.ln1@chipmunk.wormnet.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

apatard at mandriva.com wrote:
> +
> +static int openrd_client_hw_params(struct snd_pcm_substream *substream,
> +               struct snd_pcm_hw_params *params)
> +{
> +       struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +       struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
> +       struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
> +       int ret;
> +       unsigned int freq, fmt;
> +
> +       fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBM_CFM;
> +       ret = snd_soc_dai_set_fmt(cpu_dai, fmt);
> +       if (ret < 0)
> +               return ret;
> +
> +       ret = snd_soc_dai_set_fmt(codec_dai, fmt);
> +       if (ret < 0)
> +               return ret;
> +
> +       switch (params_rate(params)) {
> +       default:
> +       case 44100:
> +               freq = 11289600;
> +               break;
> +       case 48000:
> +               freq = 12288000;
> +               break;
> +       case 96000:
> +               freq = 24576000;
> +               break;
> +       }
> +
> +       return snd_soc_dai_set_sysclk(codec_dai, 0, freq, SND_SOC_CLOCK_IN);
> +
>
The switch() could be replaced with a 'freq = params_rate(params) * 
256'.

Cheers

-- 
Alexander Clouter
.sigmonster says: NOBODY EXPECTS THE SPANISH INQUISITION!
