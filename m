From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 7 Oct 2013 12:09:02 +0100
Subject: [PATCH 5/5] DRM: Armada: add support for drm tda19988 driver
In-Reply-To: <20131007124820.2189a4c3@armhf>
References: <20131006220728.GG12758@n2100.arm.linux.org.uk>
 <E1VSwYO-0000iT-CU@rmk-PC.arm.linux.org.uk> <20131007111807.5e86ea6e@armhf>
 <20131007094404.GI12758@n2100.arm.linux.org.uk>
 <20131007124820.2189a4c3@armhf>
Message-ID: <20131007110902.GL12758@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 07, 2013 at 12:48:20PM +0200, Jean-Francois Moine wrote:
> On Mon, 7 Oct 2013 10:44:04 +0100
> Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> 
> > On Mon, Oct 07, 2013 at 11:18:07AM +0200, Jean-Francois Moine wrote:
> 	[snip]
> > > It seems we are going backwards: as the Armada based boards will soon
> > > move to full DT (mvebu), you are making an exception for the Cubox, so
> > > that there should be Cubox specific kernels. I don't like that...
> > 
> > *Ignored*.  You know why.
> 
> Sorry. I don't see why. May you explain again?

I don't run DT because DT lacks most of the features I require on the
cubox.  Therefore I can't develop for DT.  Simple.

> > > > diff --git a/drivers/gpu/drm/armada/armada_drv.c b/drivers/gpu/drm/armada/armada_drv.c
> 	[snip]
> > > > +static struct tda998x_encoder_params params = {
> > > > +	/* With 0x24, there is no translation between vp_out and int_vp
> > > > +	FB	LCD out	Pins	VIP	Int Vp
> > > > +	R:23:16	R:7:0	VPC7:0	7:0	7:0[R]
> > > > +	G:15:8	G:15:8	VPB7:0	23:16	23:16[G]
> > > > +	B:7:0	B:23:16	VPA7:0	15:8	15:8[B]
> > > > +	*/
> > > > +	.swap_a = 2,
> > > > +	.swap_b = 3,
> > > > +	.swap_c = 4,
> > > > +	.swap_d = 5,
> > > > +	.swap_e = 0,
> > > > +	.swap_f = 1,
> > > 
> > > I still don't agree. You don't need to invert R <-> B for the Cubox at
> > > the tda998x level: this may be done setting as it should be the
> > > CFG_GRA_SWAPRB flag of the lcd register LCD_SPU_DMA_CTRL0.
> > 
> > You are totally and utterly wrong there.  We need R and B presented on
> > their correct lanes to the TDA998x so that the Armadas YUV->RGB
> > conversion works.  Setting CFG_GRA_SWAPRB does not swap the YUV output
> > to match, neither does setting any of the other bits.
> > 
> > CFG_GRA_SWAPRB is all about the _graphics_ _framebuffer_ format, it's got
> > nothing to do at all with how the output is wired.
> 
> Then, may you explain why you must swap R/B on simple RGB output?
> 
> From your [PATCH 2/5] DRM: Armada: Add Armada DRM driver:
> 
> +	FMT(RGB888,	888PACK,	CFG_SWAPRB);
> +	FMT(BGR888,	888PACK,	0);

I think I explained above.  This is to do with the *graphics* *framebuffer*
*format* in *memory*.  This has nothing to do with how the hardware is
wired up.

With no swapping, the 888 format is defined by the documentation to be:

	[7:0] = red
	[15:8] = green
	[23:16] = blue

Now, if you look this up in the drm_fourcc.h header file, this corresponds
with this entry:

#define DRM_FORMAT_BGR888       fourcc_code('B', 'G', '2', '4') /* [23:0] B:G:R little endian */

Hence, this is the BGR888 format with no swapping.  Therefore, my second
line is correct.

With CFG_SWAPRB set, the format in hardware becomes:

	[7:0] = blue
	[15:8] = green
	[23:16] = red

Again, if you look this up in the drm_fourcc.h header, you get:

#define DRM_FORMAT_RGB888       fourcc_code('R', 'G', '2', '4') /* [23:0] R:G:B little endian */

So, the two entries you quote above are 100% correct.

> +	FMT(YUYV,	422PACK,	CFG_YUV2RGB | CFG_SWAPYU | CFG_SWAPUV);

Where is the RGB swap there?  Again, this is to do with swapping the
format to match the hardware.  Please read the documentation on the
framebuffer formats.

The native 422PACK format is:
	[7:0] = U
	[15:8] = Y0
	[23:16] = V
	[31:24] = Y1

and we need to set both CFG_SWAPYU and CFG_SWAPUV to get this to be:
	[7:0] = V
	[15:8] = Y1
	[23:16] = U
	[31:24] = Y0

which is what the YUYV format wants.

> Rabeeh did the most he could to have a working Cubox. He used bad
> written drivers and he had not the time to think about how the drivers
> could be enhanced.

What does I2S give us in terms of "enhancement" which SPDIF does not,
remembering that audio is transmitted over HDMI in a format which closely
resembles SPDIF (but with a 28-bit subframe size.)

> Here is a small story about i2s/spdif: once, I set the tda998x to use
> the spdif input, and at this time, I was using the dummy codec.
> This codec accepts the format 32_LE, as does the audio device, but the
> output cannot go to spdif. Result: no hdmi sound.

How ASoC works in this regard is that the capabilities are the _union_ of
the codec and the cpu DAIs.

The SPDIF transmitter codec supports 16, 20 and 24 bits per sample but not
32.  Quite simply, that's because the SPDIF format does not allow 32-bits
per sample.  Therefore, 32_LE is not available for use with audio output,
and userspace must convert down to something which the hardware does
support.

"Because I2S can support 32-bit audio" is a poor reason, because you can't
pass 32-bit audio via HDMI due to a subframe being limited to 28 bits - up
to 24 bits for the sample and 4 bits of control/status information.
