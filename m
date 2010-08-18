From: marek.vasut@gmail.com (Marek Vasut)
Date: Wed, 18 Aug 2010 07:05:46 +0200
Subject: [PATCH 01/13] Balloon3: Disperse MFP config
In-Reply-To: <AANLkTi=3AQ6RAYSvnJ9_PYyy7mtseXGyoFaz+Km_4vd8@mail.gmail.com>
References: <1281673964-2119-1-git-send-email-marek.vasut@gmail.com>
	<AANLkTi=3AQ6RAYSvnJ9_PYyy7mtseXGyoFaz+Km_4vd8@mail.gmail.com>
Message-ID: <201008180705.46427.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne St 18. srpna 2010 06:11:51 Eric Miao napsal(a):
> On Fri, Aug 13, 2010 at 12:32 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
> > Move pin config to appropriate places and use it only if needed.
> > 
> > Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
> 
> So I suppose this is the successor patch series of the previous
> balloon3 one? Better to keep Jonathan's Ack then?

It's in the mail from 10th aug. I'll add hist ack to the patch when sending pull 
rq.
> 
> > ---
> >  arch/arm/mach-pxa/balloon3.c |  104
> > +++++++++++++++++++++++++++-------------- 1 files changed, 68
> > insertions(+), 36 deletions(-)
> > 
> > diff --git a/arch/arm/mach-pxa/balloon3.c b/arch/arm/mach-pxa/balloon3.c
> > index 9041340..7f62448 100644
> > --- a/arch/arm/mach-pxa/balloon3.c
> > +++ b/arch/arm/mach-pxa/balloon3.c
> > @@ -68,42 +68,6 @@ static unsigned long balloon3_pin_config[] __initdata
> > = {
> > 
> >        /* Reset, configured as GPIO wakeup source */
> >        GPIO1_GPIO | WAKEUP_ON_EDGE_BOTH,
> > -
> > -       /* LEDs */
> > -       GPIO9_GPIO,     /* NAND activity LED */
> > -       GPIO10_GPIO,    /* Heartbeat LED */
> > -
> > -       /* AC97 */
> > -       GPIO28_AC97_BITCLK,
> > -       GPIO29_AC97_SDATA_IN_0,
> > -       GPIO30_AC97_SDATA_OUT,
> > -       GPIO31_AC97_SYNC,
> > -       GPIO113_AC97_nRESET,
> > -       GPIO95_GPIO,
> > -
> > -       /* MMC */
> > -       GPIO32_MMC_CLK,
> > -       GPIO92_MMC_DAT_0,
> > -       GPIO109_MMC_DAT_1,
> > -       GPIO110_MMC_DAT_2,
> > -       GPIO111_MMC_DAT_3,
> > -       GPIO112_MMC_CMD,
> > -
> > -       /* USB Host */
> > -       GPIO88_USBH1_PWR,
> > -       GPIO89_USBH1_PEN,
> > -
> > -       /* PC Card */
> > -       GPIO48_nPOE,
> > -       GPIO49_nPWE,
> > -       GPIO50_nPIOR,
> > -       GPIO51_nPIOW,
> > -       GPIO85_nPCE_1,
> > -       GPIO54_nPCE_2,
> > -       GPIO79_PSKTSEL,
> > -       GPIO55_nPREG,
> > -       GPIO56_nPWAIT,
> > -       GPIO57_nIOIS16,
> >  };
> > 
> >  /***********************************************************************
> > ******* @@ -132,6 +96,34 @@ int __init parse_balloon3_features(char *arg)
> > early_param("balloon3_features", parse_balloon3_features);
> > 
> >  /***********************************************************************
> > ******* + * Compact Flash slot
> > +
> > ************************************************************************
> > ******/ +#if    defined(CONFIG_PCMCIA_PXA2XX) ||
> > defined(CONFIG_PCMCIA_PXA2XX_MODULE) +static unsigned long
> > balloon3_cf_pin_config[] __initdata = {
> > +       GPIO48_nPOE,
> > +       GPIO49_nPWE,
> > +       GPIO50_nPIOR,
> > +       GPIO51_nPIOW,
> > +       GPIO85_nPCE_1,
> > +       GPIO54_nPCE_2,
> > +       GPIO79_PSKTSEL,
> > +       GPIO55_nPREG,
> > +       GPIO56_nPWAIT,
> > +       GPIO57_nIOIS16,
> > +};
> > +
> > +static void __init balloon3_cf_init(void)
> > +{
> > +       if (!balloon3_has(BALLOON3_FEATURE_CF))
> > +               return;
> > +
> > +       pxa2xx_mfp_config(ARRAY_AND_SIZE(balloon3_cf_pin_config));
> > +}
> > +#else
> > +static inline void balloon3_cf_init(void) {}
> > +#endif
> > +
> > +/***********************************************************************
> > ******* * NOR Flash
> >  ************************************************************************
> > ******/ #if defined(CONFIG_MTD_PHYSMAP) ||
> > defined(CONFIG_MTD_PHYSMAP_MODULE) @@ -179,6 +171,15 @@ static inline
> > void balloon3_nor_init(void) {}
> > ************************************************************************
> > ******/ #if    defined(CONFIG_TOUCHSCREEN_UCB1400) || \
> >        defined(CONFIG_TOUCHSCREEN_UCB1400_MODULE)
> > +static unsigned long balloon3_ac97_pin_config[] __initdata = {
> > +       GPIO28_AC97_BITCLK,
> > +       GPIO29_AC97_SDATA_IN_0,
> > +       GPIO30_AC97_SDATA_OUT,
> > +       GPIO31_AC97_SYNC,
> > +       GPIO113_AC97_nRESET,
> > +       GPIO95_GPIO,
> > +};
> > +
> >  static struct ucb1400_pdata vpac270_ucb1400_pdata = {
> >        .irq            = IRQ_GPIO(BALLOON3_GPIO_CODEC_IRQ),
> >  };
> > @@ -197,6 +198,7 @@ static void __init balloon3_ts_init(void)
> >        if (!balloon3_has(BALLOON3_FEATURE_AUDIO))
> >                return;
> > 
> > +       pxa2xx_mfp_config(ARRAY_AND_SIZE(balloon3_ac97_pin_config));
> >        pxa_set_ac97_info(NULL);
> >        platform_device_register(&balloon3_ucb1400_device);
> >  }
> > @@ -208,6 +210,11 @@ static inline void balloon3_ts_init(void) {}
> >  * Framebuffer
> >  ************************************************************************
> > ******/ #if defined(CONFIG_FB_PXA) || defined(CONFIG_FB_PXA_MODULE)
> > +static unsigned long balloon3_lcd_pin_config[] __initdata = {
> > +       GPIOxx_LCD_TFT_16BPP,
> > +       GPIO99_GPIO,
> > +};
> > +
> >  static struct pxafb_mode_info balloon3_lcd_modes[] = {
> >        {
> >                .pixclock               = 38000,
> > @@ -242,6 +249,8 @@ static void __init balloon3_lcd_init(void)
> >        if (!balloon3_has(BALLOON3_FEATURE_TOPPOLY))
> >                return;
> > 
> > +       pxa2xx_mfp_config(ARRAY_AND_SIZE(balloon3_lcd_pin_config));
> > +
> >        ret = gpio_request(BALLOON3_GPIO_RUN_BACKLIGHT, "BKL-ON");
> >        if (ret) {
> >                pr_err("Requesting BKL-ON GPIO failed!\n");
> > @@ -271,6 +280,15 @@ static inline void balloon3_lcd_init(void) {}
> >  * SD/MMC card controller
> >  ************************************************************************
> > ******/ #if defined(CONFIG_MMC_PXA) || defined(CONFIG_MMC_PXA_MODULE)
> > +static unsigned long balloon3_mmc_pin_config[] __initdata = {
> > +       GPIO32_MMC_CLK,
> > +       GPIO92_MMC_DAT_0,
> > +       GPIO109_MMC_DAT_1,
> > +       GPIO110_MMC_DAT_2,
> > +       GPIO111_MMC_DAT_3,
> > +       GPIO112_MMC_CMD,
> > +};
> > +
> >  static struct pxamci_platform_data balloon3_mci_platform_data = {
> >        .ocr_mask               = MMC_VDD_32_33 | MMC_VDD_33_34,
> >        .gpio_card_detect       = -1,
> > @@ -281,6 +299,7 @@ static struct pxamci_platform_data
> > balloon3_mci_platform_data = {
> > 
> >  static void __init balloon3_mmc_init(void)
> >  {
> > +       pxa2xx_mfp_config(ARRAY_AND_SIZE(balloon3_mmc_pin_config));
> >        pxa_set_mci_info(&balloon3_mci_platform_data);
> >  }
> >  #else
> > @@ -339,6 +358,11 @@ static inline void balloon3_irda_init(void) {}
> >  * USB Host
> >  ************************************************************************
> > ******/ #if defined(CONFIG_USB_OHCI_HCD) ||
> > defined(CONFIG_USB_OHCI_HCD_MODULE) +static unsigned long
> > balloon3_uhc_pin_config[] __initdata = {
> > +       GPIO88_USBH1_PWR,
> > +       GPIO89_USBH1_PEN,
> > +};
> > +
> >  static struct pxaohci_platform_data balloon3_ohci_info = {
> >        .port_mode      = PMM_PERPORT_MODE,
> >        .flags          = ENABLE_PORT_ALL | POWER_CONTROL_LOW |
> > POWER_SENSE_LOW, @@ -348,6 +372,7 @@ static void __init
> > balloon3_uhc_init(void)
> >  {
> >        if (!balloon3_has(BALLOON3_FEATURE_OHCI))
> >                return;
> > +       pxa2xx_mfp_config(ARRAY_AND_SIZE(balloon3_uhc_pin_config));
> >        pxa_set_ohci_info(&balloon3_ohci_info);
> >  }
> >  #else
> > @@ -358,6 +383,11 @@ static inline void balloon3_uhc_init(void) {}
> >  * LEDs
> >  ************************************************************************
> > ******/ #if defined(CONFIG_LEDS_GPIO) || defined(CONFIG_LEDS_GPIO_MODULE)
> > +static unsigned long balloon3_led_pin_config[] __initdata = {
> > +       GPIO9_GPIO,     /* NAND activity LED */
> > +       GPIO10_GPIO,    /* Heartbeat LED */
> > +};
> > +
> >  struct gpio_led balloon3_gpio_leds[] = {
> >        {
> >                .name                   = "balloon3:green:idle",
> > @@ -436,6 +466,7 @@ static struct platform_device balloon3_pcf_leds = {
> > 
> >  static void __init balloon3_leds_init(void)
> >  {
> > +       pxa2xx_mfp_config(ARRAY_AND_SIZE(balloon3_led_pin_config));
> >        platform_device_register(&balloon3_leds);
> >        platform_device_register(&balloon3_pcf_leds);
> >  }
> > @@ -757,6 +788,7 @@ static void __init balloon3_init(void)
> >        balloon3_ts_init();
> >        balloon3_udc_init();
> >        balloon3_uhc_init();
> > +       balloon3_cf_init();
> >  }
> > 
> >  static struct map_desc balloon3_io_desc[] __initdata = {
> > --
> > 1.7.1
