From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Mon, 21 Oct 2013 10:11:17 +0200
Subject: [PATCHv1 5/8] ASoC: sgtl5000: Revise the bugs about the
 sgt15000 codec.
In-Reply-To: <1DD289F6464F0949A2FCA5AA6DC23F82866756@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1382000477-17304-1-git-send-email-Li.Xiubo@freescale.com>
 <1382000477-17304-6-git-send-email-Li.Xiubo@freescale.com>
 <20131017121721.43e1b34b@ipc1.ka-ro>
 <1DD289F6464F0949A2FCA5AA6DC23F82866756@039-SN2MPN1-013.039d.mgd.msft.net>
Message-ID: <20131021101117.5c0c71aa@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> > > diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
> > > index 1f4093f..4e2e4c9 100644
> > > --- a/sound/soc/codecs/sgtl5000.c
> > > +++ b/sound/soc/codecs/sgtl5000.c
> > > @@ -883,14 +883,19 @@ static int ldo_regulator_register(struct
> > snd_soc_codec *codec,
> > >  				struct regulator_init_data *init_data,
> > >  				int voltage)
> > >  {
> > > +#ifdef CONFIG_SND_SOC_FSL_SGTL5000
> > > +	return 0;
> > > +#else
> > >  	dev_err(codec->dev, "this setup needs regulator support in the
> > kernel\n");
> > >  	return -EINVAL;
> > > +#endif
> > >
> > This looks wrong to me, as this will disable the error for unsolicited
> > platforms in a multi arch kernel!
> > 
> 
> The CONFIG_SND_SOC_FSL_SGTL5000 micro will be renamed to CONFIG_SND_SOC_FSL_SGTL5000_VF610.
> In VF610, there has not Power Manager Module, so whether the CONFIG_REGULATOR is enable or 
> Disabled, there will always some errors booting...
> 
Yes, but you are altering code that may be run on a different machine
than VF610 in a multiarch kernel! You should have a RUNTIME check for
the machine type if you need to do machine type specific stuff.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
