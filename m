From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 7 Oct 2013 10:44:04 +0100
Subject: [PATCH 5/5] DRM: Armada: add support for drm tda19988 driver
In-Reply-To: <20131007111807.5e86ea6e@armhf>
References: <20131006220728.GG12758@n2100.arm.linux.org.uk>
 <E1VSwYO-0000iT-CU@rmk-PC.arm.linux.org.uk> <20131007111807.5e86ea6e@armhf>
Message-ID: <20131007094404.GI12758@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 07, 2013 at 11:18:07AM +0200, Jean-Francois Moine wrote:
> On Sun, 06 Oct 2013 23:11:56 +0100
> Russell King <rmk+kernel@arm.linux.org.uk> wrote:
> 
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > ---
> >  drivers/gpu/drm/armada/Kconfig      |    9 +++++++
> >  drivers/gpu/drm/armada/armada_drv.c |   42 +++++++++++++++++++++++++++++++++++
> >  2 files changed, 51 insertions(+), 0 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/armada/Kconfig b/drivers/gpu/drm/armada/Kconfig
> > index c7a0a94..87e62dd 100644
> > --- a/drivers/gpu/drm/armada/Kconfig
> > +++ b/drivers/gpu/drm/armada/Kconfig
> > @@ -13,3 +13,12 @@ config DRM_ARMADA
> >  	  This driver provides no built-in acceleration; acceleration is
> >  	  performed by other IP found on the SoC.  This driver provides
> >  	  kernel mode setting and buffer management to userspace.
> > +
> > +config DRM_ARMADA_TDA1998X
> > +	bool "Support TDA1998X HDMI output"
> > +	depends on DRM_ARMADA != n
> > +	depends on I2C && DRM_I2C_NXP_TDA998X = y
> > +	default y
> > +	help
> > +	  Support the TDA1998x HDMI output device found on the Solid-Run
> > +	  CuBox.
> 
> It seems we are going backwards: as the Armada based boards will soon
> move to full DT (mvebu), you are making an exception for the Cubox, so
> that there should be Cubox specific kernels. I don't like that...

*Ignored*.  You know why.

> > diff --git a/drivers/gpu/drm/armada/armada_drv.c b/drivers/gpu/drm/armada/armada_drv.c
> > index db62f1b..69517cf 100644
> > --- a/drivers/gpu/drm/armada/armada_drv.c
> > +++ b/drivers/gpu/drm/armada/armada_drv.c
> > @@ -16,6 +16,42 @@
> >  #include <drm/armada_drm.h>
> >  #include "armada_ioctlP.h"
> >  
> > +#ifdef CONFIG_DRM_ARMADA_TDA1998X
> > +#include <drm/i2c/tda998x.h>
> > +#include "armada_slave.h"
> > +
> > +static struct tda998x_encoder_params params = {
> > +	/* With 0x24, there is no translation between vp_out and int_vp
> > +	FB	LCD out	Pins	VIP	Int Vp
> > +	R:23:16	R:7:0	VPC7:0	7:0	7:0[R]
> > +	G:15:8	G:15:8	VPB7:0	23:16	23:16[G]
> > +	B:7:0	B:23:16	VPA7:0	15:8	15:8[B]
> > +	*/
> > +	.swap_a = 2,
> > +	.swap_b = 3,
> > +	.swap_c = 4,
> > +	.swap_d = 5,
> > +	.swap_e = 0,
> > +	.swap_f = 1,
> 
> I still don't agree. You don't need to invert R <-> B for the Cubox at
> the tda998x level: this may be done setting as it should be the
> CFG_GRA_SWAPRB flag of the lcd register LCD_SPU_DMA_CTRL0.

You are totally and utterly wrong there.  We need R and B presented on
their correct lanes to the TDA998x so that the Armadas YUV->RGB
conversion works.  Setting CFG_GRA_SWAPRB does not swap the YUV output
to match, neither does setting any of the other bits.

CFG_GRA_SWAPRB is all about the _graphics_ _framebuffer_ format, it's got
nothing to do at all with how the output is wired.

> > +	.audio_cfg = BIT(2),
> > +	.audio_frame[1] = 1,
> > +	.audio_format = AFMT_SPDIF,
> > +	.audio_sample_rate = 44100,
> 
> These values are rather mysterious!

Also I'm going to ignore this comment, because quite honestly, I think
this is worthless.  You haven't investigated how the TDA998x actually
gets setup by Rabeeh.
