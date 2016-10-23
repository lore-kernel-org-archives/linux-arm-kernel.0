From: moinejf@free.fr (Jean-Francois Moine)
Date: Sun, 23 Oct 2016 09:45:03 +0200
Subject: [linux-sunxi] [PATCH v5 4/7] ASoC: sunxi: Add sun8i I2S driver
In-Reply-To: <CAGb2v67gDd650TJk_-oHOehnzdH2qor=36HXdPt339Ji=ToAMg@mail.gmail.com>
References: <cover.1477142934.git.moinejf@free.fr>
 <bee315efb909c1ee8b5fe7d3aeb9a33d713cb562.1477142934.git.moinejf@free.fr>
 <CAGb2v67gDd650TJk_-oHOehnzdH2qor=36HXdPt339Ji=ToAMg@mail.gmail.com>
Message-ID: <20161023094503.fbb22dd0701e3f2785828609@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 23 Oct 2016 09:33:16 +0800
Chen-Yu Tsai <wens@csie.org> wrote:

> > Note: This driver is closed to the sun4i-i2s except that:
> > - it handles the H3
> 
> If it's close to sun4i-i2s, you should probably rework that one to support
> the newer SoCs.
> 
> > - it creates the sound card (with sun4i-i2s, the sound card is created
> >   by the CODECs)
> 
> I think this is wrong. I2S is only the DAI. You typically have a separate
> platform driver for the whole card, or just use simple-card.

An other device is not needed. The layout is simple:
	I2S_controller (CPU DAI) <-> HDMI_CODEC (CODEC DAI)
The HDMI CODEC is supported by the HDMI video driver (only one device),
so, it cannot be the card device.
ASoC does not use the CPU DAI device (I2S_controller), so, it is
natural to use it to handle the card.
Otherwise, the simple-card asks for a node definition in the DT and
this node is a pure Linux software entity. On the other side, the
simple-graph-card from Kuninori is not useful for this simple case.

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
