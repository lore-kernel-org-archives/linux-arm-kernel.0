From: moinejf@free.fr (Jean-Francois Moine)
Date: Mon, 7 Oct 2013 12:48:20 +0200
Subject: [PATCH 5/5] DRM: Armada: add support for drm tda19988 driver
In-Reply-To: <20131007094404.GI12758@n2100.arm.linux.org.uk>
References: <20131006220728.GG12758@n2100.arm.linux.org.uk>
 <E1VSwYO-0000iT-CU@rmk-PC.arm.linux.org.uk>
 <20131007111807.5e86ea6e@armhf>
 <20131007094404.GI12758@n2100.arm.linux.org.uk>
Message-ID: <20131007124820.2189a4c3@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 7 Oct 2013 10:44:04 +0100
Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> On Mon, Oct 07, 2013 at 11:18:07AM +0200, Jean-Francois Moine wrote:
	[snip]
> > It seems we are going backwards: as the Armada based boards will soon
> > move to full DT (mvebu), you are making an exception for the Cubox, so
> > that there should be Cubox specific kernels. I don't like that...
> 
> *Ignored*.  You know why.

Sorry. I don't see why. May you explain again?

> > > diff --git a/drivers/gpu/drm/armada/armada_drv.c b/drivers/gpu/drm/armada/armada_drv.c
	[snip]
> > > +static struct tda998x_encoder_params params = {
> > > +	/* With 0x24, there is no translation between vp_out and int_vp
> > > +	FB	LCD out	Pins	VIP	Int Vp
> > > +	R:23:16	R:7:0	VPC7:0	7:0	7:0[R]
> > > +	G:15:8	G:15:8	VPB7:0	23:16	23:16[G]
> > > +	B:7:0	B:23:16	VPA7:0	15:8	15:8[B]
> > > +	*/
> > > +	.swap_a = 2,
> > > +	.swap_b = 3,
> > > +	.swap_c = 4,
> > > +	.swap_d = 5,
> > > +	.swap_e = 0,
> > > +	.swap_f = 1,
> > 
> > I still don't agree. You don't need to invert R <-> B for the Cubox at
> > the tda998x level: this may be done setting as it should be the
> > CFG_GRA_SWAPRB flag of the lcd register LCD_SPU_DMA_CTRL0.
> 
> You are totally and utterly wrong there.  We need R and B presented on
> their correct lanes to the TDA998x so that the Armadas YUV->RGB
> conversion works.  Setting CFG_GRA_SWAPRB does not swap the YUV output
> to match, neither does setting any of the other bits.
> 
> CFG_GRA_SWAPRB is all about the _graphics_ _framebuffer_ format, it's got
> nothing to do at all with how the output is wired.

Then, may you explain why you must swap R/B on simple RGB output?

>From your [PATCH 2/5] DRM: Armada: Add Armada DRM driver:

+	FMT(RGB888,	888PACK,	CFG_SWAPRB);
+	FMT(BGR888,	888PACK,	0);

+	FMT(YUYV,	422PACK,	CFG_YUV2RGB | CFG_SWAPYU | CFG_SWAPUV);

> > > +	.audio_cfg = BIT(2),
> > > +	.audio_frame[1] = 1,
> > > +	.audio_format = AFMT_SPDIF,
> > > +	.audio_sample_rate = 44100,
> > 
> > These values are rather mysterious!
> 
> Also I'm going to ignore this comment, because quite honestly, I think
> this is worthless.  You haven't investigated how the TDA998x actually
> gets setup by Rabeeh.

Rabeeh did the most he could to have a working Cubox. He used bad
written drivers and he had not the time to think about how the drivers
could be enhanced.

Here is a small story about i2s/spdif: once, I set the tda998x to use
the spdif input, and at this time, I was using the dummy codec.
This codec accepts the format 32_LE, as does the audio device, but the
output cannot go to spdif. Result: no hdmi sound.

Should we restrict the hdmi transmitter to spdif (thus 'no 32 bits
stream') or to i2s (thus 'no compressed stream') only, or accept both
i2s and spdif and allow a full range of supported audio streams?

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
+
