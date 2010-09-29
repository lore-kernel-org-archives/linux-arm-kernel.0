From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 29 Sep 2010 07:28:30 +0200
Subject: [PATCHv2 4/7] ARM: S5PC110: Add si470x radio device to the GONI
	board
In-Reply-To: <00c101cb5f16$1c5542a0$54ffc7e0$%kim@samsung.com>
References: <1284987337-15365-1-git-send-email-m.szyprowski@samsung.com>
	<1284987337-15365-5-git-send-email-m.szyprowski@samsung.com>
	<005f01cb5ee0$e16f63d0$a44e2b70$%kim@samsung.com>
	<007401cb5f0e$3b4e5000$b1eaf000$%szyprowski@samsung.com>
	<00c101cb5f16$1c5542a0$54ffc7e0$%kim@samsung.com>
Message-ID: <00b601cb5f97$2a304ce0$7e90e6a0$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tuesday, September 28, 2010 4:05 PM Kukjin Kim wrote:

> > On Tuesday, September 28, 2010 9:44 AM Kukjin Kim wrote:
> >
> > > Marek Szyprowski wrote:
> > > >
> > > > Add required platform definitions for si470x radio device on Samsung
> > > > Goni board.
> > > >
> > > > Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
> > > > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> > > > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > > > ---
> > > >  arch/arm/mach-s5pv210/Kconfig     |    2 ++
> > > >  arch/arm/mach-s5pv210/mach-goni.c |   30
> > > > ++++++++++++++++++++++++++++++
> > > >  2 files changed, 32 insertions(+), 0 deletions(-)
> > > >
> > > > diff --git a/arch/arm/mach-s5pv210/Kconfig
> b/arch/arm/mach-s5pv210/Kconfig
> > > > index b46925b..b1f671d 100644
> > > > --- a/arch/arm/mach-s5pv210/Kconfig
> > > > +++ b/arch/arm/mach-s5pv210/Kconfig
> > > > @@ -83,9 +83,11 @@ config MACH_GONI
> > > >  	select S3C_DEV_HSMMC
> > > >  	select S3C_DEV_HSMMC1
> > > >  	select S3C_DEV_HSMMC2
> > > > +	select S3C_DEV_I2C1
> > > >  	select S5P_DEV_ONENAND
> > > >  	select SAMSUNG_DEV_KEYPAD
> > > >  	select S5PV210_SETUP_FB_24BPP
> > > > +	select S5PV210_SETUP_I2C1
> > > >  	select S5PV210_SETUP_KEYPAD
> > > >  	select S5PV210_SETUP_SDHCI
> > > >  	help
> > > > diff --git a/arch/arm/mach-s5pv210/mach-goni.c
> > > b/arch/arm/mach-s5pv210/mach-
> > > > goni.c
> > > > index b263f3a..5677c4d 100644
> > > > --- a/arch/arm/mach-s5pv210/mach-goni.c
> > > > +++ b/arch/arm/mach-s5pv210/mach-goni.c
> > > > @@ -38,6 +38,7 @@
> > > >  #include <plat/devs.h>
> > > >  #include <plat/cpu.h>
> > > >  #include <plat/fb.h>
> > > > +#include <plat/iic.h>
> > > >  #include <plat/keypad.h>
> > > >  #include <plat/sdhci.h>
> > > >
> > > > @@ -200,6 +201,27 @@ static struct samsung_keypad_platdata keypad_data
> > > > __initdata = {
> > > >  	.cols		= 3,
> > > >  };
> > > >
> > > > +/* Radio */
> > > > +static struct i2c_board_info i2c1_devs[] __initdata = {
> > > > +	{
> > > > +		I2C_BOARD_INFO("si470x", 0x10),
> > > > +	},
> > > > +};
> > > > +
> > > > +static void __init goni_radio_init(void)
> > > > +{
> > > > +	int gpio;
> > > > +
> > > > +	gpio = S5PV210_GPJ2(4);			/* XMSMDATA_4 */
> > > > +	gpio_request(gpio, "FM_INT");
> > >
> > > If returned fail?
> >
> > Then there is something seriously wrong either with the platform or
> machine
> > startup code.
> >
> > It is quite common to omit a check in the machine init code. Just take a
> look
> > at mach-s3c64xx/mach-smdk6410.c, smdk6410_machine_init() function. Lack of
> > checks here doesn't really have ANY impact on the stability of the kernel
> imho.
> >
> Yeah...right now in our codes, something checked the returning of
> gpio_request, and others not and the board designer already know where it is
> used.
> 
> Hmm...I'm not sure which is better to us...but is it better there is
> exception/error handling?
> Or...is it useless code?

IMHO such code is useless. If requesting a gpio fails then the kernel will throw
an ops or warning on the first use of that gpio pin, so the board designer will
know that something is really wrong there.

Best regards
--
Marek Szyprowski
Samsung Poland R&D Center
