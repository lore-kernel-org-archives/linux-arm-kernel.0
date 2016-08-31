From: dannym@scratchpost.org (Danny Milosavljevic)
Date: Wed, 31 Aug 2016 09:40:44 +0200
Subject: [linux-sunxi] Re: [PATCH v9 2/2] Add mixer controls: Line-In,
 FM-In, Mic 2, Capture Source, Differential Line-In.
In-Reply-To: <CAGb2v64zA3iSOe7ku=pF0RhJkvErxt_tbPWG4H8D6r5UEUJAMQ@mail.gmail.com>
References: <20160830054403.7878-1-dannym@scratchpost.org>
 <20160830054403.7878-3-dannym@scratchpost.org>
 <CAGb2v64zA3iSOe7ku=pF0RhJkvErxt_tbPWG4H8D6r5UEUJAMQ@mail.gmail.com>
Message-ID: <20160831094044.1c3227d6@scratchpost.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> And what about microphone bias?

Would this be OK?

static int sun4i_codec_handle_mic_bias_event(struct snd_soc_dapm_widget *w,
                                             struct snd_kcontrol *k, int event)
{
        struct sun4i_codec *scodec = snd_soc_card_get_drvdata(w->dapm->card);
        if (SND_SOC_DAPM_EVENT_ON(event))
                regmap_update_bits(scodec->regmap,
                                   SUN4I_CODEC_ADC_ACTL,
                                   BIT(SUN4I_CODEC_ADC_ACTL_VMICEN),
                                   BIT(SUN4I_CODEC_ADC_ACTL_VMICEN));
        else
                regmap_update_bits(scodec->regmap,
                                   SUN4I_CODEC_ADC_ACTL,
                                   BIT(SUN4I_CODEC_ADC_ACTL_VMICEN),
                                   0);
}

static const struct snd_soc_dapm_widget sun4i_codec_codec_dapm_widgets[] = {
...
        SND_SOC_DAPM_MIC("Mic1", sun4i_codec_handle_mic_bias_event),
        SND_SOC_DAPM_MIC("Mic2", sun4i_codec_handle_mic_bias_event),

Do I then remove

         SND_SOC_DAPM_SUPPLY("VMIC", SUN4I_CODEC_ADC_ACTL,
                            SUN4I_CODEC_ADC_ACTL_VMICEN, 0, NULL, 0),

completely? What about the routes?
