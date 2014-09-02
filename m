From: Li.Xiubo@freescale.com (Li.Xiubo at freescale.com)
Date: Tue, 2 Sep 2014 09:15:54 +0000
Subject: [alsa-devel] [PATCHv1 1/7] ASoC: simple-card: Merge single and
 muti	DAI link code.
In-Reply-To: <87tx4rzszx.wl%kuninori.morimoto.gx@gmail.com>
References: <1409545781-20530-1-git-send-email-Li.Xiubo@freescale.com>
 <1409545781-20530-2-git-send-email-Li.Xiubo@freescale.com>
 <87tx4rzszx.wl%kuninori.morimoto.gx@gmail.com>
Message-ID: <6ebdb2b0dcec46ef95084d2fc578b7b8@BY2PR0301MB0613.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kuninori-san

This patch series will break the old DTs, and I will follow Mark's
Advice to maintain compatibility with the old DTs.

I will send another version, please help me to review it. And I will also
split the update patch series to many small ones.

Thanks very much,

BRs
Xiubo

> -----Original Message-----
> From: Kuninori Morimoto [mailto:kuninori.morimoto.gx at gmail.com]
> Sent: Monday, September 01, 2014 3:43 PM
> To: Xiubo Li-B47053
> Cc: broonie at kernel.org; lgirdwood at gmail.com; perex at perex.cz; tiwai at suse.de;
> kuninori.morimoto.gx at renesas.com; moinejf at free.fr; andrew at lunn.ch;
> jsarha at ti.com; devicetree at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; linux-sh at vger.kernel.org; alsa-devel at alsa-
> project.org; Guo Shawn-R65073; Nicolin Chen; linux-kernel at vger.kernel.org
> Subject: Re: [alsa-devel] [PATCHv1 1/7] ASoC: simple-card: Merge single and
> muti DAI link code.
> 
> 
> Hi Xiubo
> 
> Thank you for your patch.
> This clean-up is very nice for me.
> But, I have 1 small comment
> 
> >  asoc_simple_card_sub_parse_of(struct device_node *np,
> >  			      struct asoc_simple_dai *dai,
> >  			      struct device_node **p_node,
> > -			      const char **name)
> > +			      const char **name,
> > +			      unsigned int *daifmt)
> >  {
> >  	struct device_node *node;
> >  	struct clk *clk;
> >  	u32 val;
> >  	int ret;
> >
> > +	if (!daifmt)
> > +		return -EINVAL;
> > +
> > +	/*
> > +	 * Parse format, bitclock-inversion and frame-inversion
> > +	 * for DAI each device.
> > +	 */
> > +	*daifmt = snd_soc_of_parse_daifmt(np, NULL, NULL, NULL);
> > +	*daifmt &= ~(SND_SOC_DAIFMT_MASTER_MASK | SND_SOC_DAIFMT_FORMAT_MASK);
> (snip)
> >  	ret = asoc_simple_card_sub_parse_of(np, &dai_props->cpu_dai,
> >  					    &dai_link->cpu_of_node,
> > -					    &dai_link->cpu_dai_name);
> > +					    &dai_link->cpu_dai_name,
> > +					    &daifmt);
> (snip)
> > +	dai_props->cpu_dai.fmt |= daifmt;
> (snip)
> >  	ret = asoc_simple_card_sub_parse_of(np, &dai_props->codec_dai,
> >  					    &dai_link->codec_of_node,
> > -					    &dai_link->codec_dai_name);
> > +					    &dai_link->codec_dai_name,
> > +					    &daifmt);
> (snip)
> > +	dai_props->codec_dai.fmt |= daifmt;
> 
> These are using
> 
>       asoc_simple_card_sub_parse_of(np, &dai_props->cpu_dai, xxx)
>       asoc_simple_card_sub_parse_of(np, &dai_props->codec_dai, xxx)
> 
> I guess, asoc_simple_card_sub_parse_of() can update
> below inside function
> 
> 	dai_props->cpu_dai.fmt |= daifmt;
> 	dai_props->codec_dai.fmt |= daifmt;
> 
> 
> Best regards
> ---
> Kuninori Morimoto
