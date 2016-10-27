From: moinejf@free.fr (Jean-Francois Moine)
Date: Thu, 27 Oct 2016 17:13:25 +0200
Subject: [alsa-devel] [linux-sunxi] [PATCH v5 4/7] ASoC: sunxi: Add
 sun8i I2S driver
In-Reply-To: <20161024123449.npo4grdlbrj4tcsj@lukather>
References: <cover.1477142934.git.moinejf@free.fr>
 <bee315efb909c1ee8b5fe7d3aeb9a33d713cb562.1477142934.git.moinejf@free.fr>
 <CAGb2v67gDd650TJk_-oHOehnzdH2qor=36HXdPt339Ji=ToAMg@mail.gmail.com>
 <20161023094503.fbb22dd0701e3f2785828609@free.fr>
 <20161024123449.npo4grdlbrj4tcsj@lukather>
Message-ID: <20161027171325.d68baa5ff51da4921ff8b94d@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 24 Oct 2016 14:34:49 +0200
Maxime Ripard <maxime.ripard@free-electrons.com> wrote:

> Hi,
> 
> On Sun, Oct 23, 2016 at 09:45:03AM +0200, Jean-Francois Moine wrote:
> > On Sun, 23 Oct 2016 09:33:16 +0800
> > Chen-Yu Tsai <wens@csie.org> wrote:
> > 
> > > > Note: This driver is closed to the sun4i-i2s except that:
> > > > - it handles the H3
> > > 
> > > If it's close to sun4i-i2s, you should probably rework that one to support
> > > the newer SoCs.
> > > 
> > > > - it creates the sound card (with sun4i-i2s, the sound card is created
> > > >   by the CODECs)
> > > 
> > > I think this is wrong. I2S is only the DAI. You typically have a separate
> > > platform driver for the whole card, or just use simple-card.
> > 
> > An other device is not needed. The layout is simple:
> > 	I2S_controller (CPU DAI) <-> HDMI_CODEC (CODEC DAI)
> > The HDMI CODEC is supported by the HDMI video driver (only one device),
> > so, it cannot be the card device.
> > ASoC does not use the CPU DAI device (I2S_controller), so, it is
> > natural to use it to handle the card.
> 
> Still, duplicating the driver is not the solution. I agree with
> Chen-Yu that we want to leverage the driver that is already there.

Hi Maxime and Chen-Yu,

After looking at the sun4i-i2s, I found 2 solutions for re-using its
code in the DE2 HDMI context:

1) either to split the sun4i-i2s driver into common I/O functions and
   slave CPU DAI,

2) or to move the sun4i-i2s into a master CPU DAI.

(
 some explanation about 'master' and 'slave': the master is the
 component the device of which is also the sound card.
 As the sound card uses the 'drvdata' of the device, this drvdata pointer
 cannot be used by the master.
 In the actual implementations:
  - sun4i-i2s
	master:	card dev = codec dev, drvdata -> card
	slave:	i2s dev (CPU DAI), drvdata -> i2s data
  - sun8i-i2s
	master:	card dev = i2s dev (CPU DAI), drvdata -> card
	slave:	codec dev (hdmi), drvdata -> codec data (audio/video)
)

In the case 1, there is no functional change, just a source split.
The sun8i-i2s will then use the common I/O functions.

In the case 2, the CODECs using the sun4i-i2s would have to move to
slave CODEC DAI, i.e. the card is created by the sun4i-i2s code.
In the 4.9, there is only one codec (sun4i-codec), so, the change
is just to move the card creation and the use of drvdata in both
codes.

In either cases, I could not check if this changes raise some
regression on the sun4i SoCs side. Then, I'd be glad to know:
- which solution suits you?
- are you ready to do and test the needed changes at the sun4i side?

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
