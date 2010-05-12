From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 12 May 2010 07:54:50 +0200
Subject: [PATCH 06/16] ARM: Samsung: move S5PC100 support from plat-s5pc1xx
	to plat-s5p framework
In-Reply-To: <001801caf195$da9e9ed0$8fdbdc70$%kim@samsung.com>
References: <1270190944-21644-1-git-send-email-m.szyprowski@samsung.com>
	<1270190944-21644-7-git-send-email-m.szyprowski@samsung.com>
	<001801caf195$da9e9ed0$8fdbdc70$%kim@samsung.com>
Message-ID: <002b01caf197$a48bedf0$eda3c9d0$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wednesday, May 12, 2010 7:42 AM Kukjin Kim wrote:

> Marek Szyprowski wrote:
> >
> > This patch moves S5PC100 SoC support to plat-s5p framework. Only cpu,
> clocks
> > and basic interrupts are supported. Other peripherals will be moved by
> separate
> > patches.
> >
> > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> > ---
> >  arch/arm/Kconfig                                   |    9 +-
> >  arch/arm/Makefile                                  |    3 +-
> >  arch/arm/mach-s5pc100/Kconfig                      |   23 +---
> >  arch/arm/mach-s5pc100/Makefile                     |    8 +-
> >  arch/arm/mach-s5pc100/cpu.c                        |   65 ++++-----
> >  arch/arm/mach-s5pc100/include/mach/debug-macro.S   |    6 +-
> >  arch/arm/mach-s5pc100/include/mach/entry-macro.S   |    8 +-
> >  arch/arm/mach-s5pc100/include/mach/irqs.h          |   99 ++++++++++++-
> >  arch/arm/mach-s5pc100/include/mach/map.h           |  151
> ++++---------------
> >  arch/arm/mach-s5pc100/include/mach/regs-clock.h    |    7 +-
> >  arch/arm/mach-s5pc100/include/mach/regs-irq.h      |    5 -
> >  arch/arm/mach-s5pc100/include/mach/system.h        |    7 +-
> >  arch/arm/mach-s5pc100/include/mach/tick.h          |    4 +-
> >  .../s5pc100-init.c => mach-s5pc100/init.c}         |    5 +-
> >  arch/arm/mach-s5pc100/mach-smdkc100.c              |   19 ++--
> >  arch/arm/mach-s5pc100/setup-i2c0.c                 |   25 ++++
> >  arch/arm/plat-s5p/Kconfig                          |    2 +-
> >  arch/arm/plat-s5p/cpu.c                            |   10 ++
> >  arch/arm/plat-s5p/include/plat/s5pc100.h           |   33 +++++
> >  arch/arm/plat-samsung/Kconfig                      |    2 +-
> >  20 files changed, 267 insertions(+), 224 deletions(-)

> ...

> > diff --git a/arch/arm/mach-s5pc100/cpu.c b/arch/arm/mach-s5pc100/cpu.c
> > index d79e757..7d65b61 100644
> > --- a/arch/arm/mach-s5pc100/cpu.c
> > +++ b/arch/arm/mach-s5pc100/cpu.c

> ...

> > @@ -73,35 +77,27 @@ static void s5pc100_idle(void)
> >  void __init s5pc100_map_io(void)
> >  {
> >  	iotable_init(s5pc100_iodesc, ARRAY_SIZE(s5pc100_iodesc));
> > -
> > -	/* initialise device information early */
> > -	s5pc100_default_sdhci0();
> > -	s5pc100_default_sdhci1();
> > -	s5pc100_default_sdhci2();
> > -
> > -	/* the i2c devices are directly compatible with s3c2440 */
> > -	s3c_i2c0_setname("s3c2440-i2c");
> > -	s3c_i2c1_setname("s3c2440-i2c");
> >  }
> >
> >  void __init s5pc100_init_clocks(int xtal)
> >  {
> > -	printk(KERN_DEBUG "%s: initialising clocks\n", __func__);
> > +	printk(KERN_DEBUG "%s: initializing clocks\n", __func__);
> > +
> >  	s3c24xx_register_baseclocks(xtal);
> > -	s5pc1xx_register_clocks();
> > +	s5p_register_clocks(xtal);
> >  	s5pc100_register_clocks();
> >  	s5pc100_setup_clocks();
> >  }
> >
> >  void __init s5pc100_init_irq(void)
> >  {
> > -	u32 vic_valid[] = {~0, ~0, ~0};
> > +	u32 vic[] = {~0, ~0, ~0};
> >
> >  	/* VIC0, VIC1, and VIC2 are fully populated. */
> > -	s5pc1xx_init_irq(vic_valid, ARRAY_SIZE(vic_valid));
> > +	s5p_init_irq(vic, ARRAY_SIZE(vic));
> >  }
> >
> > -struct sysdev_class s5pc100_sysclass = {
> > +static struct sysdev_class s5pc100_sysclass = {
> >  	.name	= "s5pc100-core",
> >  };
> 
> No need to add static attribute for other driver.

Is there any reason to keep this global? It is not used anywhere
else and just pollutes the kernel name space.

> ...

> > diff --git a/arch/arm/mach-s5pc100/include/mach/debug-macro.S
> b/arch/arm/mach-
> > s5pc100/include/mach/debug-macro.S
> > index e181f57..70e02e9 100644
> > --- a/arch/arm/mach-s5pc100/include/mach/debug-macro.S
> > +++ b/arch/arm/mach-s5pc100/include/mach/debug-macro.S
> > @@ -22,12 +22,14 @@
> >  	 * aligned and add in the offset when we load the value here.
> >  	 */
> >
> > -	.macro addruart, rx, tmp
> > +	.macro addruart, rx, rtmp
> >  		mrc	p15, 0, \rx, c1, c0
> >  		tst	\rx, #1
> >  		ldreq	\rx, = S3C_PA_UART
> > -		ldrne	\rx, = (S3C_VA_UART + S3C_PA_UART & 0xfffff)
> > +		ldrne	\rx, = S3C_VA_UART
> > +#if CONFIG_DEBUG_S3C_UART != 0
> >  		add	\rx, \rx, #(0x400 * CONFIG_DEBUG_S3C_UART)
> > +#endif
> >  	.endm
> >
> >  /* include the reset of the code which will do the work, we're only
> > diff --git a/arch/arm/mach-s5pc100/include/mach/entry-macro.S
> b/arch/arm/mach-
> > s5pc100/include/mach/entry-macro.S
> > index 6713193..ba76af0 100644
> > --- a/arch/arm/mach-s5pc100/include/mach/entry-macro.S
> > +++ b/arch/arm/mach-s5pc100/include/mach/entry-macro.S
> 
> How about changing S5PC100 from S5PC1XX the header in this entry-macro.S

I must have missed that. I will check again if there are any S5PC1XX references
left.

> > diff --git a/arch/arm/mach-s5pc100/mach-smdkc100.c b/arch/arm/mach-
> > s5pc100/mach-smdkc100.c
> > index ae3c52c..8dec25f 100644
> > --- a/arch/arm/mach-s5pc100/mach-smdkc100.c
> > +++ b/arch/arm/mach-s5pc100/mach-smdkc100.c
> > @@ -34,8 +34,6 @@
> >  #include <asm/mach-types.h>
> >
> >  #include <plat/regs-serial.h>
> > -#include <plat/gpio-cfg.h>
> > -#include <plat/regs-gpio.h>
> >
> >  #include <plat/clock.h>
> >  #include <plat/devs.h>
> 
> There are definitions like UCON for UART in this file.
> But those are not used.

Well, right, I will fix this.

> > @@ -79,6 +77,7 @@ static struct s3c2410_uartcfg smdkc100_uartcfgs[]
> __initdata
> > = {
> >  	},
> >  };
> >
> > +#if 0
> 
> #if 0?

I had to disable that part of code to make it compile. It is enabled later
in separate patch when the relevant functionality got moved from plat-s5pc1xx
to mach-s5pc100.

> >  /* I2C0 */
> >  static struct i2c_board_info i2c_devs0[] __initdata = {
> >  };
> > @@ -140,10 +139,10 @@ static struct s3c_fb_platdata smdkc100_lcd_pdata
> > __initdata = {
> >  	.vidcon1	= VIDCON1_INV_HSYNC | VIDCON1_INV_VSYNC,
> >  	.setup_gpio	= s5pc100_fb_gpio_setup_24bpp,
> >  };
> > -
> > -static struct map_desc smdkc100_iodesc[] = {};
> > +#endif
> >
> >  static struct platform_device *smdkc100_devices[] __initdata = {
> > +#if 0
> 
> ?

Same as above. I just didn't want to remove code in one patch and add it
a few patches later.

> ...

Best regards
--
Marek Szyprowski
Samsung Poland R&D Center
