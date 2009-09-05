From: ben-linux@fluff.org (Ben Dooks)
Date: Sat, 5 Sep 2009 15:49:43 +0100
Subject: [PATCH 12/12] [ARM][S3C6410] Add support gpio function for keypad
	device
In-Reply-To: <00b301ca2e33$048252e0$0d86f8a0$%yang@samsung.com>
References: <00ab01ca2e2d$1b52fcf0$51f8f6d0$%yang@samsung.com>
	<00b301ca2e33$048252e0$0d86f8a0$%yang@samsung.com>
Message-ID: <20090905144943.GR25153@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 05, 2009 at 11:13:18PM +0900, Jinsung Yang wrote:
> Hi,
> I'm sorry for using a little non-English word (my name) when sending 12
> patches.
> That caused by wrong e-mail client setting, already fixed now :)

Ok, please wait for first pass review before reposting.
 
> Best Regards
> --
> Jinsung, Yang <jsgood.yang@samsung.com>
> AP Development Team
> System LSI, Semiconductor Business
> SAMSUNG Electronics Co., LTD
> 
> 
> > -----Original Message-----
> > From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-
> > kernel-bounces at lists.infradead.org] On Behalf Of ???
> > Sent: Saturday, September 05, 2009 10:31 PM
> > To: ben-linux at fluff.org
> > Cc: ???/AP???(SYS.LSI)/E3(??)/????; linux-arm-
> > kernel at lists.infradead.org
> > Subject: [PATCH 12/12] [ARM][S3C6410] Add support gpio function for keypad
> > device
> > 
> > This patch includes machine specific gpio function for keypad device
> > which can be changed by platform hardware. The gpio function is
> > related with keypad platform info such as rows and columns of
> > those matrix.
> > 
> > Signed-off-by: Jinsung Yang <jsgood.yang@samsung.com>
> > Signed-off-by: Kyeongil Kim <ki0351.kim@samsung.com>
> > ---
> >  arch/arm/mach-s3c6410/mach-smdk6410.c |   23 +++++++++++++++++++++++
> >  1 files changed, 23 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/mach-s3c6410/mach-smdk6410.c b/arch/arm/mach-
> > s3c6410/mach-smdk6410.c
> > index 95e130d..f297c26 100644
> > --- a/arch/arm/mach-s3c6410/mach-smdk6410.c
> > +++ b/arch/arm/mach-s3c6410/mach-smdk6410.c
> > @@ -347,6 +347,28 @@ static struct s3c_platform_keypad keypad_data
> > __initdata = {
> >  	.delay = 50,
> >  };
> > 
> > +static void s3c_keypad_cfg_gpio(int rows, int columns)
> > +{
> > +	unsigned int gpio;
> > +	unsigned int end;
> > +
> > +	end = S3C64XX_GPK(8 + rows);
> > +
> > +	/* Set all the necessary GPK pins to special-function 0 */
> > +	for (gpio = S3C64XX_GPK(8); gpio < end; gpio++) {
> > +		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(3));
> > +		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
> > +	}
> > +
> > +	end = S3C64XX_GPL(0 + columns);
> > +
> > +	/* Set all the necessary GPK pins to special-function 0 */
> > +	for (gpio = S3C64XX_GPL(0); gpio < end; gpio++) {
> > +		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(3));
> > +		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
> > +	}
> > +}
> > +
> >  static void __init smdk6410_map_io(void)
> >  {
> >  	u32 tmp;
> > @@ -382,6 +404,7 @@ static void __init smdk6410_machine_init(void)
> >  	i2c_register_board_info(1, i2c_devs1, ARRAY_SIZE(i2c_devs1));
> > 
> >  	s3c_keypad_set_platdata(&keypad_data);
> > +	s3c_keypad_cfg_gpio(keypad_data.nr_rows, keypad_data.nr_cols);
> > 
> >  	platform_add_devices(smdk6410_devices,
> > ARRAY_SIZE(smdk6410_devices));
> >  }
> > --
> > 1.6.2.5
> > 
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
