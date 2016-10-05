From: moinejf@free.fr (Jean-Francois Moine)
Date: Wed, 5 Oct 2016 12:03:03 +0200
Subject: [PATCH 07/14] ASoC: Add sun8i audio card
In-Reply-To: <CAEKpxBkUbCGJdToReQx7P+5i92doUdNeMvA5fiDACGcniY=nJg@mail.gmail.com>
References: <cover.1475571575.git.mylene.josserand@free-electrons.com>
 <cover.1475569400.git.mylene.josserand@free-electrons.com>
 <33d641ff43f0c0349cdfa2cdbbfdcdde66205596.1475571575.git.mylene.josserand@free-electrons.com>
 <CAEKpxBkUbCGJdToReQx7P+5i92doUdNeMvA5fiDACGcniY=nJg@mail.gmail.com>
Message-ID: <20161005120303.93eb05294d189e04461bb314@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 5 Oct 2016 08:04:26 +0200
Code Kipper <codekipper@gmail.com> wrote:

> > +static int sun8i_probe(struct platform_device *pdev)
> > +{
> > +       struct snd_soc_dai_link *link = &sun8i_dai_link;
> > +       struct device_node *np = pdev->dev.of_node;
> > +       int ret;
> > +
> > +       /* register the soc card */
> > +       sun8i_card.dev = &pdev->dev;
> > +
> > +       /* Retrieve the audio-codec from DT */
> > +       link->codec_of_node = of_parse_phandle(np, "allwinner,audio-codec", 0);
> > +       if (!link->codec_of_node) {
> > +               dev_err(&pdev->dev, "Missing audio codec\n");
> > +               return -EINVAL;
> > +       }
> > +
> > +       /* Retrieve DAI from DT */
> > +       link->cpu_of_node = of_parse_phandle(np, "allwinner,i2s-controller", 0);
> Now that I've spent some time trying to add my changes for the H3
> ontop of your code,  I think this file should be more generic and rely
> on the dtsi more. It's pretty A33 specific but with little effort it
> can be worked to cover all of the sun8i type drivers. I would change
> "allwinner,i2s-controller" to "allwinner,audio-dai" for starters and
> then maybe pull in some info for the dai-link from the dtsi.
> CK
	[snip]

In fact, there should be no audio card driver as proposed here:
with such a simple layout
	CPU DAI (sun4i-a10-i2s) -> CODEC DAI (sun8i-a33-codec)
the 'simple-card' does the job.

BTW, I have a I2S/PCM/TDM driver for the H3 and A83T.
But, as it works with HDMI and contains echanges with the DRM driver,
it cannot go yet to the mainline...

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
