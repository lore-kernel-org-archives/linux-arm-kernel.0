From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 28 Sep 2010 23:04:43 +0900
Subject: [PATCHv2 4/7] ARM: S5PC110: Add si470x radio device to the GONI
	board
In-Reply-To: <007401cb5f0e$3b4e5000$b1eaf000$%szyprowski@samsung.com>
References: <1284987337-15365-1-git-send-email-m.szyprowski@samsung.com>
	<1284987337-15365-5-git-send-email-m.szyprowski@samsung.com>
	<005f01cb5ee0$e16f63d0$a44e2b70$%kim@samsung.com>
	<007401cb5f0e$3b4e5000$b1eaf000$%szyprowski@samsung.com>
Message-ID: <00c101cb5f16$1c5542a0$54ffc7e0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marek Szyprowski wrote:
> 
> Hello,
> 
Hi ;-)

> On Tuesday, September 28, 2010 9:44 AM Kukjin Kim wrote:
> 
> > Marek Szyprowski wrote:
> > >
> > > Add required platform definitions for si470x radio device on Samsung
> > > Goni board.
> > >
> > > Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
> > > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> > > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > > ---
> > >  arch/arm/mach-s5pv210/Kconfig     |    2 ++
> > >  arch/arm/mach-s5pv210/mach-goni.c |   30
> > > ++++++++++++++++++++++++++++++
> > >  2 files changed, 32 insertions(+), 0 deletions(-)
> > >
> > > diff --git a/arch/arm/mach-s5pv210/Kconfig
b/arch/arm/mach-s5pv210/Kconfig
> > > index b46925b..b1f671d 100644
> > > --- a/arch/arm/mach-s5pv210/Kconfig
> > > +++ b/arch/arm/mach-s5pv210/Kconfig
> > > @@ -83,9 +83,11 @@ config MACH_GONI
> > >  	select S3C_DEV_HSMMC
> > >  	select S3C_DEV_HSMMC1
> > >  	select S3C_DEV_HSMMC2
> > > +	select S3C_DEV_I2C1
> > >  	select S5P_DEV_ONENAND
> > >  	select SAMSUNG_DEV_KEYPAD
> > >  	select S5PV210_SETUP_FB_24BPP
> > > +	select S5PV210_SETUP_I2C1
> > >  	select S5PV210_SETUP_KEYPAD
> > >  	select S5PV210_SETUP_SDHCI
> > >  	help
> > > diff --git a/arch/arm/mach-s5pv210/mach-goni.c
> > b/arch/arm/mach-s5pv210/mach-
> > > goni.c
> > > index b263f3a..5677c4d 100644
> > > --- a/arch/arm/mach-s5pv210/mach-goni.c
> > > +++ b/arch/arm/mach-s5pv210/mach-goni.c
> > > @@ -38,6 +38,7 @@
> > >  #include <plat/devs.h>
> > >  #include <plat/cpu.h>
> > >  #include <plat/fb.h>
> > > +#include <plat/iic.h>
> > >  #include <plat/keypad.h>
> > >  #include <plat/sdhci.h>
> > >
> > > @@ -200,6 +201,27 @@ static struct samsung_keypad_platdata keypad_data
> > > __initdata = {
> > >  	.cols		= 3,
> > >  };
> > >
> > > +/* Radio */
> > > +static struct i2c_board_info i2c1_devs[] __initdata = {
> > > +	{
> > > +		I2C_BOARD_INFO("si470x", 0x10),
> > > +	},
> > > +};
> > > +
> > > +static void __init goni_radio_init(void)
> > > +{
> > > +	int gpio;
> > > +
> > > +	gpio = S5PV210_GPJ2(4);			/* XMSMDATA_4 */
> > > +	gpio_request(gpio, "FM_INT");
> >
> > If returned fail?
> 
> Then there is something seriously wrong either with the platform or
machine
> startup code.
> 
> It is quite common to omit a check in the machine init code. Just take a
look
> at mach-s3c64xx/mach-smdk6410.c, smdk6410_machine_init() function. Lack of
> checks here doesn't really have ANY impact on the stability of the kernel
imho.
> 
Yeah...right now in our codes, something checked the returning of
gpio_request, and others not and the board designer already know where it is
used.

Hmm...I'm not sure which is better to us...but is it better there is
exception/error handling?
Or...is it useless code?

> > > +	s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(0xf));
> > > +	i2c1_devs[0].irq = gpio_to_irq(gpio);
> >
> > Need to sort out gpio interrupt stuff for this.
> 
> Right, forgot that this also requires interrupt support for gpio. This
> definitely shows how important the gpio interrupt patches are and how much
> is blocked because they are still no merged or even commented yet.
> 
Yes, I'm reviewing your '[PATCH 1/6] ARM: Samsung: Add common s5p gpio
interrupt support'...and not finished yet..
But I have to leave office now...it's late here...

I will continue it tomorrow morning.

> > Anyway, will check it soon.
> >
> >
> > > +
> > > +	gpio = S5PV210_GPJ2(5);			/* XMSMDATA_5 */
> > > +	gpio_request(gpio, "FM_RST");
> >
> > Same.
> >
> > > +	gpio_direction_output(gpio, 1);
> > > +}
> > > +
> > >  /* MAX8998 regulators */
> > >  #if defined(CONFIG_REGULATOR_MAX8998) ||
> > > defined(CONFIG_REGULATOR_MAX8998_MODULE)
> > >
> > > @@ -556,6 +578,7 @@ static struct platform_device *goni_devices[]
> > __initdata = {
> > >  	&s3c_device_hsmmc1,
> > >  	&s3c_device_hsmmc2,
> > >  	&samsung_device_keypad,
> > > +	&s3c_device_i2c1,
> > >  };
> > >
> > >  static void __init goni_map_io(void)
> > > @@ -567,6 +590,13 @@ static void __init goni_map_io(void)
> > >
> > >  static void __init goni_machine_init(void)
> > >  {
> > > +	/* Radio: call before I2C 1 registeration */
> > > +	goni_radio_init();
> > > +
> > > +	/* I2C1 */
> > > +	s3c_i2c1_set_platdata(NULL);
> > > +	i2c_register_board_info(1, i2c1_devs, ARRAY_SIZE(i2c1_devs));
> > > +
> > >  	/* PMIC */
> > >  	goni_pmic_init();
> > >  	i2c_register_board_info(AP_I2C_GPIO_PMIC_BUS_4,
> > > i2c_gpio_pmic_devs,
> > > --
> >
> > Others, looks ok.
> >


Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
