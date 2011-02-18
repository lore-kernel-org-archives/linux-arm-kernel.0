From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 18 Feb 2011 10:26:50 +0100
Subject: [PATCH 2/2] ARM i.MX23/28: Add framebuffer device support
In-Reply-To: <20110218091717.GD18085@S2100-06.ap.freescale.net>
References: <1297850199-1688-1-git-send-email-s.hauer@pengutronix.de>
	<1297850199-1688-3-git-send-email-s.hauer@pengutronix.de>
	<20110218061440.GA18085@S2100-06.ap.freescale.net>
	<20110218084625.GF24426@pengutronix.de>
	<20110218091717.GD18085@S2100-06.ap.freescale.net>
Message-ID: <20110218092650.GH24426@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 18, 2011 at 05:17:18PM +0800, Shawn Guo wrote:
> Hi Sascha,
> 
> On Fri, Feb 18, 2011 at 09:46:25AM +0100, Sascha Hauer wrote:
> > On Fri, Feb 18, 2011 at 02:14:41PM +0800, Shawn Guo wrote:
> > > On Wed, Feb 16, 2011 at 10:56:39AM +0100, Sascha Hauer wrote:
> > > > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > > > Cc: Shawn Guo <shawn.guo@freescale.com>
> > > > ---
> > > >  arch/arm/mach-mxs/clock-mx23.c             |    2 +-
> > > >  arch/arm/mach-mxs/clock-mx28.c             |    1 +
> > > >  arch/arm/mach-mxs/devices-mx23.h           |    4 ++
> > > >  arch/arm/mach-mxs/devices-mx28.h           |    4 ++
> > > >  arch/arm/mach-mxs/devices/Kconfig          |    4 ++
> > > >  arch/arm/mach-mxs/devices/Makefile         |    1 +
> > > >  arch/arm/mach-mxs/devices/platform-mxsfb.c |   46 ++++++++++++++++++++++++++++
> > > >  7 files changed, 61 insertions(+), 1 deletions(-)
> > > >  create mode 100644 arch/arm/mach-mxs/devices/platform-mxsfb.c
> > > > 
> > > > diff --git a/arch/arm/mach-mxs/clock-mx23.c b/arch/arm/mach-mxs/clock-mx23.c
> > > > index ca72a05..bfc7f27 100644
> > > > --- a/arch/arm/mach-mxs/clock-mx23.c
> > > > +++ b/arch/arm/mach-mxs/clock-mx23.c
> > > > @@ -446,7 +446,7 @@ static struct clk_lookup lookups[] = {
> > > >  	_REGISTER_CLOCK(NULL, "hclk", hbus_clk)
> > > >  	_REGISTER_CLOCK(NULL, "usb", usb_clk)
> > > >  	_REGISTER_CLOCK(NULL, "audio", audio_clk)
> > > > -	_REGISTER_CLOCK(NULL, "pwm", pwm_clk)
> > > Introducing the warning below ...
> > > 
> > > arch/arm/mach-mxs/clock-mx23.c:430: warning: ?pwm_clk? defined but not used
> > 
> > Right, it was not intended to remove the pwm here. Will fix.
> > 
> > > 
> > > > +	_REGISTER_CLOCK("imx23-fb", NULL, lcdif_clk)
> > > >  };
> > > >  
> > > >  static int clk_misc_init(void)
> > > > diff --git a/arch/arm/mach-mxs/clock-mx28.c b/arch/arm/mach-mxs/clock-mx28.c
> > > > index fd1c4c5..6a7ebcb 100644
> > > > --- a/arch/arm/mach-mxs/clock-mx28.c
> > > > +++ b/arch/arm/mach-mxs/clock-mx28.c
> > > > @@ -620,6 +620,7 @@ static struct clk_lookup lookups[] = {
> > > >  	_REGISTER_CLOCK(NULL, "pwm", pwm_clk)
> > > >  	_REGISTER_CLOCK(NULL, "lradc", lradc_clk)
> > > >  	_REGISTER_CLOCK(NULL, "spdif", spdif_clk)
> > > > +	_REGISTER_CLOCK("imx28-fb", NULL, lcdif_clk)
> > > >  };
> > > >  
> > > >  static int clk_misc_init(void)
> > > > diff --git a/arch/arm/mach-mxs/devices-mx23.h b/arch/arm/mach-mxs/devices-mx23.h
> > > > index 1256788..b9745a2 100644
> > > > --- a/arch/arm/mach-mxs/devices-mx23.h
> > > > +++ b/arch/arm/mach-mxs/devices-mx23.h
> > > > @@ -10,7 +10,11 @@
> > > >   */
> > > >  #include <mach/mx23.h>
> > > >  #include <mach/devices-common.h>
> > > > +#include <mach/fb.h>
> > > >  
> > > Why do we have mxsfb platform device code breaking the consistency
> > > that we are maintaining well so far?
> > 
> > The rule is that we include header files where we need them.
> > devices-common.h is not touched in this patch and it does not need
> > mach/fb.h, hence it is not include there.
> > 
> > > 
> > > Generally, we have this header included in devices-common.h
> > > 
> > > >  extern const struct amba_device mx23_duart_device __initconst;
> > > >  #define mx23_add_duart() \
> > > >  	mxs_add_duart(&mx23_duart_device)
> > > > +
> > > > +struct platform_device *__init mx23_add_mxsfb(
> > > > +		const struct mxsfb_platform_data *pdata);
> > > 
> > > Generally, this goes to devices-common.h
> > 
> > No, devices-common.h only declares the mxs_* functions. There is no
> > mxs_add_mxsfb in this patch which indeed would go to devices-common.h
> > 
> Well, if you break the consistency in one place, you break the
> consistency every.  If you follow the convention to add mxs_add_fb
> in platform_fb.c, declare it in devices-common.h, ..., everything
> gets consistent.  We will not have the particular and noticeable fb
> device code everywhere.
> 
> > > 
> > > I understand that "mxsfb" was picked up for the device name to
> > > reflect the driver name.  But since this is the device under mach- mxs
> > > folder, can we simply call it "fb" just like the way you name fb.h?
> > > 
> > > In this way, we have all mxs platform device naming schema aligned,
> > > auart, duart, dma, fb, fec, flexcan, mmc ...
> > 
> > I see it the other way round. mach/fb.h is too generic, I would prefer
> > mach/mxsfb.h to be able to add support for a different framebuffer
> > later. So I better change fb.h to mxsfb.h.
> > 
> I'm fine with either way, but just wondering what kind of fb later
> it is and its naming, relatively to mxsfs.

IPU...?

> 
> > > 
> > > 
> > > Generally, we have macro mxs_fb_data_entry and function mxs_add_fb
> > > in this file.  It's nothing but all about consistency.  We do not
> > > want some later coming platform device looking at this as example,
> > > and bring more inconsistency into mach-mxs platform device codes.
> > 
> > My opinion on this is that we should not use complex ## macro constructs
> > where not necessary. With a device which is only present once on the SoC
> > it is not necessary, so I skippped it. And yes, if someone is in the
> > same situation with a single device on a system, he actually should take
> > this as an example. So no, I don't agree with you.
> > 
> With a device presents on more than one SoC, it's also not necessary?

The mxsfb is present on more than one SoC. I was talking about multiple
instances of the same device on one SoC.

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
