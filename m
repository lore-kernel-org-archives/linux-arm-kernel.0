From: noodles@earth.li (Jonathan McDowell)
Date: Fri, 6 Aug 2010 20:52:18 +0100
Subject: [PATCH 07/11] [ARM] pxa/balloon3: Machine file cleanup
In-Reply-To: <201008060949.29366.marek.vasut@gmail.com>
References: <1280920933-3820-1-git-send-email-marek.vasut@gmail.com>
	<1280920933-3820-7-git-send-email-marek.vasut@gmail.com>
	<20100805232506.GQ9577@earth.li>
	<201008060949.29366.marek.vasut@gmail.com>
Message-ID: <20100806195218.GU9577@earth.li>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 06, 2010 at 09:49:29AM +0200, Marek Vasut wrote:
> Dne P? 6. srpna 2010 01:25:06 Jonathan McDowell napsal(a):
> > On Wed, Aug 04, 2010 at 01:22:09PM +0200, Marek Vasut wrote:
> > > Modularize components of the Balloon3 board.
> > 
> > NAK.
> > 
> > That's not what a large portion of this patch does.
> 
> Oh, really ?

A large portion of it removes setting the MFPs based on the board
capabilities. That's a different piece of work to making the various
components modular.

> > You have put all of the pin definitions into balloon3_pin_config and
> > negated the work that was done to ensure that a single kernel could
> > run on different variants of the balloon3.
> 
> I have only this one, but read on.

I suspect you have a similar board to me; a double sided board fairly
well populated (sound, CF, USB host + slave, LCD). The Lightwriter, for
example, is a single sided board using fewer peripherals. The CUED
variant I believe is different again for their needs.

> > If a feature isn't configured on the board you shouldn't configure
> > the MFPs for that feature.
> 
> That's not true. You should configure them as inputs. The big plan (in
> another patch) is to do this the same way colibri270 is done (balloon3
> baseboard + expansion boards).

I don't have a copy of the PXA reference to hand, so I'm happy to accept
best practise is to set unused pins to be inputs. However the changes in
this patch don't do this and may end up setting some pins that are used
for something else to an unexpected output.

I'm failing to understand the motivation for these changes, especially
if you have a plan to later do more appropriate cleanup.

> > > Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
> > > ---
> > > 
> > >  arch/arm/mach-pxa/balloon3.c |  354
> > >  +++++++++++++++++++++++++++--------------- 1 files changed, 231
> > >  insertions(+), 123 deletions(-)
> > > 
> > > diff --git a/arch/arm/mach-pxa/balloon3.c b/arch/arm/mach-pxa/balloon3.c
> > > index 8adb87a..572525c 100644
> > > --- a/arch/arm/mach-pxa/balloon3.c
> > > +++ b/arch/arm/mach-pxa/balloon3.c
> > > @@ -22,6 +22,7 @@
> > > 
> > >  #include <linux/fb.h>
> > >  #include <linux/gpio.h>
> > >  #include <linux/ioport.h>
> > > 
> > > +#include <linux/ucb1400.h>
> > > 
> > >  #include <linux/mtd/mtd.h>
> > >  #include <linux/mtd/partitions.h>
> > >  #include <linux/types.h>
> > > 
> > > @@ -61,35 +62,136 @@ static unsigned long balloon3_pin_config[]
> > > __initdata = {
> > > 
> > >  	GPIO44_BTUART_CTS,
> > >  	GPIO45_BTUART_RTS,
> > > 
> > > -	/* Wakeup GPIO */
> > > +	/* Reset, configured as GPIO wakeup source */
> > > 
> > >  	GPIO1_GPIO | WAKEUP_ON_EDGE_BOTH,
> > > 
> > > -	/* NAND & IDLE LED GPIOs */
> > > -	GPIO9_GPIO,
> > > -	GPIO10_GPIO,
> > > -};
> > > +	/* LEDs */
> > > +	GPIO9_GPIO,	/* NAND activity LED */
> > > +	GPIO10_GPIO,	/* Heartbeat LED */
> > > 
> > > -/***********************************************************************
> > > ******* - * Audio and Touchscreen
> > > -
> > > ************************************************************************
> > > ******/ -static unsigned long balloon3_ac97_pin_config[] = {
> > > +	/* AC97 */
> > > 
> > >  	GPIO28_AC97_BITCLK,
> > >  	GPIO29_AC97_SDATA_IN_0,
> > >  	GPIO30_AC97_SDATA_OUT,
> > >  	GPIO31_AC97_SYNC,
> > >  	GPIO113_AC97_nRESET,
> > > 
> > > +	GPIO95_GPIO,
> > > +
> > > +	/* MMC */
> > > +	GPIO32_MMC_CLK,
> > > +	GPIO92_MMC_DAT_0,
> > > +	GPIO109_MMC_DAT_1,
> > > +	GPIO110_MMC_DAT_2,
> > > +	GPIO111_MMC_DAT_3,
> > > +	GPIO112_MMC_CMD,
> > > +
> > > +	/* USB Host */
> > > +	GPIO88_USBH1_PWR,
> > > +	GPIO89_USBH1_PEN,
> > > 
> > >  };
> > 
> > J.

J.

-- 
Avoid GOTOs completely if you can keep the program readable.
