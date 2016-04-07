From: pc.liao@mediatek.com (PC Liao)
Date: Thu, 7 Apr 2016 18:03:50 +0800
Subject: [PATCH v3] ASoC: mediatek: Add second I2S on mt8173-rt5650
 machine driver
In-Reply-To: <57062D4C.5020905@gmail.com>
References: <1460014517-20359-1-git-send-email-pc.liao@mediatek.com>
 <57062D4C.5020905@gmail.com>
Message-ID: <1460023430.9948.8.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Matthias,

On Thu, 2016-04-07 at 17:50 +0800, Matthias Brugger wrote:
> 
> On 07/04/16 09:35, PC Liao wrote:
> > diff --git a/sound/soc/mediatek/mt8173-rt5650.c b/sound/soc/mediatek/mt8173-rt5650.c
> > index bb09bb1..9f56df9 100644
> > --- a/sound/soc/mediatek/mt8173-rt5650.c
> > +++ b/sound/soc/mediatek/mt8173-rt5650.c
> > @@ -85,12 +85,26 @@ static int mt8173_rt5650_init(struct snd_soc_pcm_runtime *runtime)
> >   {
> >   	struct snd_soc_card *card = runtime->card;
> >   	struct snd_soc_codec *codec = runtime->codec_dais[0]->codec;
> > +	const char *codec_dai_capture = runtime->codec_dais[1]->name;
> >   	int ret;
> >
> >   	rt5645_sel_asrc_clk_src(codec,
> > -				RT5645_DA_STEREO_FILTER |
> > -				RT5645_AD_STEREO_FILTER,
> > -				RT5645_CLK_SEL_I2S1_ASRC);
> > +					RT5645_DA_STEREO_FILTER,
> > +					RT5645_CLK_SEL_I2S1_ASRC);
> > +
> > +	if (!strcmp(codec_dai_capture, "rt5645-aif1")) {
> > +		rt5645_sel_asrc_clk_src(codec,
> > +					RT5645_AD_STEREO_FILTER,
> > +					RT5645_CLK_SEL_I2S1_ASRC);
> > +	} else if (!strcmp(codec_dai_capture, "rt5645-aif2")) {
> > +		rt5645_sel_asrc_clk_src(codec,
> > +					RT5645_AD_STEREO_FILTER,
> > +					RT5645_CLK_SEL_I2S2_ASRC);
> > +	} else {
> > +		dev_err(card->dev, "Can't get the right codec dai\n");
> > +		return -EINVAL;
> 
> For compatibility issues we should enable RT5645_CLK_SEL_I2S1_ASRC as 
> default. BTW in the old version you enabled DA and AD filter while in 
> the new version you just enable AD filter. What is the reason for that?
> 
> Regards,
> Matthias

Thanks for comment.
I separate rt5645_sel_asrc_clk_src function into two parts.
I have and enable DA filter for I2S1 first.
Then, I use codec_dai_capture to determine which I2S AD filter I need.
Thanks!
