From: marek.vasut@gmail.com (Marek Vasut)
Date: Tue, 24 Aug 2010 16:01:12 +0200
Subject: [PATCH 3/3] h1940: implement mmc_power function
In-Reply-To: <201008241700.31513.anarsoul@gmail.com>
References: <1282230003-2020-1-git-send-email-anarsoul@gmail.com>
	<201008241552.42856.marek.vasut@gmail.com>
	<201008241700.31513.anarsoul@gmail.com>
Message-ID: <201008241601.12355.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne ?t 24. srpna 2010 16:00:26 Vasily Khoruzhick napsal(a):
> ? ????????? ?? 24 ??????? 2010 16:52:42 ????? Marek Vasut ???????:
> > Dne ?t 19. srpna 2010 17:00:03 Vasily Khoruzhick napsal(a):
> > > Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> > > ---
> > > 
> > >  arch/arm/mach-s3c2410/include/mach/h1940-latch.h |    2 +-
> > >  arch/arm/mach-s3c2410/mach-h1940.c               |   23
> > > 
> > > +++++++++++++++++++-- 2 files changed, 21 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/arch/arm/mach-s3c2410/include/mach/h1940-latch.h
> > > b/arch/arm/mach-s3c2410/include/mach/h1940-latch.h index
> > > 73586f2..ef7d8cf 100644
> > > --- a/arch/arm/mach-s3c2410/include/mach/h1940-latch.h
> > > +++ b/arch/arm/mach-s3c2410/include/mach/h1940-latch.h
> > > @@ -35,7 +35,7 @@
> > > 
> > >  #define H1940_LATCH_AUDIO_POWER		H1940_LATCH_GPIO(9)
> > >  #define H1940_LATCH_SM803_ENABLE	H1940_LATCH_GPIO(10)
> > >  #define H1940_LATCH_LCD_P4		H1940_LATCH_GPIO(11)
> > > 
> > > -#define H1940_LATCH_CPUQ5		H1940_LATCH_GPIO(12)
> > > +#define H1940_LATCH_SD_POWER		H1940_LATCH_GPIO(12)
> > > 
> > >  #define H1940_LATCH_BLUETOOTH_POWER	H1940_LATCH_GPIO(13)
> > >  #define H1940_LATCH_LED_GREEN		H1940_LATCH_GPIO(14)
> > >  #define H1940_LATCH_LED_FLASH		H1940_LATCH_GPIO(15)
> > > 
> > > diff --git a/arch/arm/mach-s3c2410/mach-h1940.c
> > > b/arch/arm/mach-s3c2410/mach-h1940.c index 9717790..c1ccc8e 100644
> > > --- a/arch/arm/mach-s3c2410/mach-h1940.c
> > > +++ b/arch/arm/mach-s3c2410/mach-h1940.c
> > > @@ -116,8 +116,7 @@ static unsigned int latch_state =
> > > H1940_LATCH_BIT(H1940_LATCH_LCD_P4) |
> > > H1940_LATCH_BIT(H1940_LATCH_LCD_P1)			|
> > > 
> > >  	H1940_LATCH_BIT(H1940_LATCH_LCD_P2)			|
> > >  	H1940_LATCH_BIT(H1940_LATCH_LCD_P3)			|
> > > 
> > > -	H1940_LATCH_BIT(H1940_LATCH_MAX1698_nSHUTDOWN)   |
> > > -	H1940_LATCH_BIT(H1940_LATCH_CPUQ5);
> > > +	H1940_LATCH_BIT(H1940_LATCH_MAX1698_nSHUTDOWN);
> > > 
> > >  static void h1940_latch_control(unsigned int clear, unsigned int set)
> > >  {
> > > 
> > > @@ -259,10 +258,25 @@ static struct platform_device
> > > h1940_device_bluetooth = { .id               = -1,
> > > 
> > >  };
> > > 
> > > +static void h1940_set_mmc_power(unsigned char power_mode, unsigned
> > > short vdd) +{
> > > +	switch (power_mode) {
> > > +	case MMC_POWER_OFF:
> > > +		gpio_set_value(H1940_LATCH_SD_POWER, 0);
> > > +		break;
> > > +	case MMC_POWER_UP:
> > > +	case MMC_POWER_ON:
> > > +		gpio_set_value(H1940_LATCH_SD_POWER, 1);
> > > +		break;
> > > +	default:
> > > +		break;
> > > +	};
> > > +}
> > > +
> > > 
> > >  static struct s3c24xx_mci_pdata h1940_mmc_cfg __initdata = {
> > >  
> > >  	.gpio_detect   = S3C2410_GPF(5),
> > >  	.gpio_wprotect = S3C2410_GPH(8),
> > > 
> > > -	.set_power     = NULL,
> > > +	.set_power     = h1940_set_mmc_power,
> > > 
> > >  	.ocr_avail     = MMC_VDD_32_33,
> > >  
> > >  };
> > 
> > Can't you implement gpio_power into the s3c24xx mmc driver ? Then you can
> > fix mach-n30 too.
> 
> Well, I'm happy with callback. However, maybe it worth to replace set_power
> callback with regulator.
> 
> > > @@ -402,6 +416,9 @@ static void __init h1940_init(void)
> > > 
> > >  	gpio_request(H1940_LATCH_USB_DP, "USB pullup");
> > >  	gpio_direction_output(H1940_LATCH_USB_DP, 0);
> > > 
> > > +	gpio_request(H1940_LATCH_SD_POWER, "SD power");
> > > +	gpio_direction_output(H1940_LATCH_SD_POWER, 0);
> > 
> > Please handle possible return values here !
> 
> Ok, I suppose WARN_ON will be enought?

pr_err() and don't probe the device for which you couldn't request GPIO.

Cheers
