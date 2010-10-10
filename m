From: marek.vasut@gmail.com (Marek Vasut)
Date: Sun, 10 Oct 2010 04:04:30 +0200
Subject: [PATCH 12/13] ARM: pxa: Add gpio-leds and vibrator support to
	PalmTC
In-Reply-To: <AANLkTikHhNW_zuB4aK61Bt8FD3d_V7H6k9PPpsPgCS9X@mail.gmail.com>
References: <1286663971-15634-1-git-send-email-marek.vasut@gmail.com>
	<1286663971-15634-12-git-send-email-marek.vasut@gmail.com>
	<AANLkTikHhNW_zuB4aK61Bt8FD3d_V7H6k9PPpsPgCS9X@mail.gmail.com>
Message-ID: <201010100404.30467.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne Ne 10. ??jna 2010 02:34:48 Haojian Zhuang napsal(a):
> On Sun, Oct 10, 2010 at 6:39 AM, Marek Vasut <marek.vasut@gmail.com> wrote:
> > Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
> > ---
> >  arch/arm/mach-pxa/palmtc.c |   41
> > +++++++++++++++++++++++++++++++++++++++++ 1 files changed, 41
> > insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/mach-pxa/palmtc.c b/arch/arm/mach-pxa/palmtc.c
> > index 8fbd8e0..c299a97 100644
> > --- a/arch/arm/mach-pxa/palmtc.c
> > +++ b/arch/arm/mach-pxa/palmtc.c
> > @@ -390,6 +390,46 @@ static inline void palmtc_ts_init(void) {}
> >  #endif
> > 
> >  /***********************************************************************
> > ******* + * LEDs
> > +
> > ************************************************************************
> > ******/ +#if defined(CONFIG_LEDS_GPIO) ||
> > defined(CONFIG_LEDS_GPIO_MODULE) +struct gpio_led palmtc_gpio_leds[] = {
> > +{
> > +       .name                   = "palmtc:green:user",
> > +       .default_trigger        = "none",
> > +       .gpio                   = GPIO_NR_PALMTC_LED_POWER,
> > +       .active_low             = 1,
> > +}, {
> > +       .name                   = "palmtc:vibra:vibra",
> > +       .default_trigger        = "none",
> > +       .gpio                   = GPIO_NR_PALMTC_VIBRA_POWER,
> > +       .active_low             = 1,
> > +}
> 
> Do you need to use a tab before contents in structure?

I dunno if checkpatch warns about it, but I'm used to it and it looks better.
> 
> > +
> > +};
> > +
> > +static struct gpio_led_platform_data palmtc_gpio_led_info = {
> > +       .leds           = palmtc_gpio_leds,
> > +       .num_leds       = ARRAY_SIZE(palmtc_gpio_leds),
> > +};
> > +
> > +static struct platform_device palmtc_leds = {
> > +       .name   = "leds-gpio",
> > +       .id     = -1,
> > +       .dev    = {
> > +               .platform_data  = &palmtc_gpio_led_info,
> > +       }
> > +};
> > +
> > +static void __init palmtc_leds_init(void)
> > +{
> > +       platform_device_register(&palmtc_leds);
> > +}
> > +#else
> > +static inline void palmtc_leds_init(void) {}
> > +#endif
> > +
> > +/***********************************************************************
> > ******* * NOR Flash
> >  ************************************************************************
> > ******/ #if defined(CONFIG_MTD_PHYSMAP) ||
> > defined(CONFIG_MTD_PHYSMAP_MODULE) @@ -502,6 +542,7 @@ static void
> > __init palmtc_init(void)
> >        palmtc_ts_init();
> >        palmtc_nor_init();
> >        palmtc_lcd_init();
> > +       palmtc_leds_init();
> >  };
> > 
> >  MACHINE_START(PALMTC, "Palm Tungsten|C")
> > --
> > 1.7.1
