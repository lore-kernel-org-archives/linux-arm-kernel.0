From: zengzm.kernel@gmail.com (Zeng Zhaoming)
Date: Wed, 28 Mar 2012 18:11:17 +0800
Subject: [alsa-devel] [PATCH] ASoC: sgtl5000: fix power on/off of MIC bias
In-Reply-To: <7FE21149F4667147B645348EC605788514EDFF@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1332919833-9641-1-git-send-email-shawn.guo@linaro.org>
 <7FE21149F4667147B645348EC605788514EDFF@039-SN2MPN1-011.039d.mgd.msft.net>
Message-ID: <20120328101117.GA2940@zzm-ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 2012-03-28 09:52:15, Dong Aisheng-B29396 wrote:
> > -----Original Message-----
> > From: alsa-devel-bounces at alsa-project.org [mailto:alsa-devel-
> > bounces at alsa-project.org] On Behalf Of Shawn Guo
> > Sent: Wednesday, March 28, 2012 3:31 PM
> > To: alsa-devel at alsa-project.org
> > Cc: Xu Lionel-R63889; Mark Brown; Zeng at alsa-project.org; Zhaoming; Shawn
> > Guo; Xu Lionel-R63889; linux-arm-kernel at lists.infradead.org
> > Subject: [alsa-devel] [PATCH] ASoC: sgtl5000: fix power on/off of MIC
> > bias
> > 
> > From: Lionel Xu <Lionel.Xu@freescale.com>
> > 
> > There is no sound in the recorded wav, to enable recording, the VAG
> > should be powered up, and the mic bias resistor should be set up with
> > proper value.
> > 
> > Signed-off-by: Lionel Xu <lionel.xu@freescale.com>
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > Cc: Zeng Zhaoming <zengzm.kernel@gmail.com>
> > ---
> >  sound/soc/codecs/sgtl5000.c |   14 +++++++++++---
> >  1 files changed, 11 insertions(+), 3 deletions(-)
> > 
> > diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
> > index d192626..a24299c 100644
> > --- a/sound/soc/codecs/sgtl5000.c
> > +++ b/sound/soc/codecs/sgtl5000.c
> > @@ -132,11 +132,18 @@ static int mic_bias_event(struct
> > snd_soc_dapm_widget *w,
> >  		snd_soc_update_bits(w->codec, SGTL5000_CHIP_MIC_CTRL,
> >  				SGTL5000_BIAS_R_MASK,
> >  				SGTL5000_BIAS_R_4k << SGTL5000_BIAS_R_SHIFT);
> > +
> > +		snd_soc_update_bits(w->codec, SGTL5000_CHIP_ANA_POWER,
> > +				SGTL5000_VAG_POWERUP, SGTL5000_VAG_POWERUP);
> Did you test line-in record?
> IIRC for line-in record, it may also need VAG_POWER up.
> Then only enable VAG_POWER for mic_bias_event may not be sufficient.
> Will verify it latter when I'm free.
> 
Yes, if mic bias needs VAG powerup, LINE-IN capture has the same issue.
But I remember Line-out test passed in mx28, it there any defect I ignored?

Thanks.
Zeng Zhaoming

> Regards
> Dong Aisheng
> 
> >  		break;
> > 
> >  	case SND_SOC_DAPM_PRE_PMD:
> >  		snd_soc_update_bits(w->codec, SGTL5000_CHIP_MIC_CTRL,
> > -				SGTL5000_BIAS_R_MASK, 0);
> > +				SGTL5000_BIAS_R_MASK,
> > +				SGTL5000_BIAS_R_off << SGTL5000_BIAS_R_SHIFT);
> > +
> > +		snd_soc_update_bits(w->codec, SGTL5000_CHIP_ANA_POWER,
> > +				SGTL5000_VAG_POWERUP, 0);
> >  		break;
> >  	}
> >  	return 0;
> > @@ -197,7 +204,7 @@ static const struct snd_soc_dapm_widget
> > sgtl5000_dapm_widgets[] = {
> >  	SND_SOC_DAPM_OUTPUT("HP_OUT"),
> >  	SND_SOC_DAPM_OUTPUT("LINE_OUT"),
> > 
> > -	SND_SOC_DAPM_MICBIAS_E("Mic Bias", SGTL5000_CHIP_MIC_CTRL, 8, 0,
> > +	SND_SOC_DAPM_MICBIAS_E("Mic Bias", SND_SOC_NOPM, 0, 0,
> >  				mic_bias_event,
> >  				SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
> > 
> > @@ -229,7 +236,8 @@ static const struct snd_soc_dapm_widget
> > sgtl5000_dapm_widgets[] = {
> >  /* routes for sgtl5000 */
> >  static const struct snd_soc_dapm_route sgtl5000_dapm_routes[] = {
> >  	{"Capture Mux", "LINE_IN", "LINE_IN"},	/* line_in --> adc_mux */
> > -	{"Capture Mux", "MIC_IN", "MIC_IN"},	/* mic_in --> adc_mux */
> > +	{"Mic Bias", NULL, "MIC_IN"},		/* mic_in --> mic bias */
> > +	{"Capture Mux", "MIC_IN", "Mic Bias"},	/* mic bias --> adc_mux
> > */
> > 
> >  	{"ADC", NULL, "Capture Mux"},		/* adc_mux --> adc */
> >  	{"AIFOUT", NULL, "ADC"},		/* adc --> i2s_out */
> > --
> > 1.7.4.1
> > 
> > 
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel at alsa-project.org
> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
