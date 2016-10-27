From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 27 Oct 2016 22:01:49 +0200
Subject: [alsa-devel] [linux-sunxi] [PATCH v5 4/7] ASoC: sunxi: Add sun8i
 I2S driver
In-Reply-To: <20161027171325.d68baa5ff51da4921ff8b94d@free.fr>
References: <cover.1477142934.git.moinejf@free.fr>
 <bee315efb909c1ee8b5fe7d3aeb9a33d713cb562.1477142934.git.moinejf@free.fr>
 <CAGb2v67gDd650TJk_-oHOehnzdH2qor=36HXdPt339Ji=ToAMg@mail.gmail.com>
 <20161023094503.fbb22dd0701e3f2785828609@free.fr>
 <20161024123449.npo4grdlbrj4tcsj@lukather>
 <20161027171325.d68baa5ff51da4921ff8b94d@free.fr>
Message-ID: <20161027200149.jxc4ey4u4qbylrln@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 27, 2016 at 05:13:25PM +0200, Jean-Francois Moine wrote:
> On Mon, 24 Oct 2016 14:34:49 +0200
> Maxime Ripard <maxime.ripard@free-electrons.com> wrote:
> 
> > Hi,
> > 
> > On Sun, Oct 23, 2016 at 09:45:03AM +0200, Jean-Francois Moine wrote:
> > > On Sun, 23 Oct 2016 09:33:16 +0800
> > > Chen-Yu Tsai <wens@csie.org> wrote:
> > > 
> > > > > Note: This driver is closed to the sun4i-i2s except that:
> > > > > - it handles the H3
> > > > 
> > > > If it's close to sun4i-i2s, you should probably rework that one to support
> > > > the newer SoCs.
> > > > 
> > > > > - it creates the sound card (with sun4i-i2s, the sound card is created
> > > > >   by the CODECs)
> > > > 
> > > > I think this is wrong. I2S is only the DAI. You typically have a separate
> > > > platform driver for the whole card, or just use simple-card.
> > > 
> > > An other device is not needed. The layout is simple:
> > > 	I2S_controller (CPU DAI) <-> HDMI_CODEC (CODEC DAI)
> > > The HDMI CODEC is supported by the HDMI video driver (only one device),
> > > so, it cannot be the card device.
> > > ASoC does not use the CPU DAI device (I2S_controller), so, it is
> > > natural to use it to handle the card.
> > 
> > Still, duplicating the driver is not the solution. I agree with
> > Chen-Yu that we want to leverage the driver that is already there.
> 
> Hi Maxime and Chen-Yu,
> 
> After looking at the sun4i-i2s, I found 2 solutions for re-using its
> code in the DE2 HDMI context:
> 
> 1) either to split the sun4i-i2s driver into common I/O functions and
>    slave CPU DAI,
> 
> 2) or to move the sun4i-i2s into a master CPU DAI.
> 
> (
>  some explanation about 'master' and 'slave': the master is the
>  component the device of which is also the sound card.
>  As the sound card uses the 'drvdata' of the device, this drvdata pointer
>  cannot be used by the master.
>  In the actual implementations:
>   - sun4i-i2s
> 	master:	card dev = codec dev, drvdata -> card
> 	slave:	i2s dev (CPU DAI), drvdata -> i2s data
>   - sun8i-i2s
> 	master:	card dev = i2s dev (CPU DAI), drvdata -> card
> 	slave:	codec dev (hdmi), drvdata -> codec data (audio/video)
> )
> 
> In the case 1, there is no functional change, just a source split.
> The sun8i-i2s will then use the common I/O functions.
> 
> In the case 2, the CODECs using the sun4i-i2s would have to move to
> slave CODEC DAI, i.e. the card is created by the sun4i-i2s code.
> In the 4.9, there is only one codec (sun4i-codec), so, the change
> is just to move the card creation and the use of drvdata in both
> codes.

I think you're mistaken. sun4i-codec has nothing to do with the I2S
driver. It's a driver for the (poorly named) Allwinner's Audio Codec
which features it's own DAI and Codec directly into the SoC.

The DAI being different from the I2S one.

However, we want to use any codec driver with the i2s driver,
including those in sound/soc/codecs, and we already have drivers for
them.

So I'm not sure either solution is a good one. Why not just make the
HDMI part a codec itself, and use the i2s driver as the CPU DAI, like
any other codec?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161027/7681c7e9/attachment.sig>
