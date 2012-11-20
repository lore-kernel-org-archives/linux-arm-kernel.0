From: chlrbgh0@gmail.com (Kyuho Choi)
Date: Tue, 20 Nov 2012 13:29:56 +0900
Subject: [PATCH] ARM: EXYNOS: Add support for ORIGEN4QUAD board
In-Reply-To: <50AB0048.60302@linaro.org>
References: <1353345846-31355-1-git-send-email-kh.choi@insignal.co.kr>
 <50AB0048.60302@linaro.org>
Message-ID: <CAP2JTQLOGMy+S0vd1yzQR4B5B_Z7B26D=VSbEXn=85T+ekt+2A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for your interest. :)

2012/11/20 Tushar Behera <tushar.behera@linaro.org>

> On 11/19/2012 10:54 PM, chlrbgh0 at gmail.com wrote:
> > From: Kyuho Choi <kh.choi@insignal.co.kr>
> >
> > This patch add support for Insignal ORIGEN4QUAD board.
> > ORIGEN4QUAD board based on Samsung Exynos4412 SoC.
> >
> > Signed-off-by: Kyuho Choi <kh.choi@insignal.co.kr>
> > ---
> >  arch/arm/mach-exynos/Kconfig       |    1 +
> >  arch/arm/mach-exynos/mach-origen.c |   74
> +++++++++++++++++++++++++++--------
> >  2 files changed, 58 insertions(+), 17 deletions(-)
> >
>
> Since Origen and Origen4Quad boards have different peripherals
> (different pmic chip, touch/audio on different I2C bus etc.), how do you
> plan to add them to mach-origen.c?
>
> As your mentioned, PMIC setup code will be added for Origen4Quad board.

IMHO, Origen and Origen4Quad board has differential form SoC type.
Thus I modified machine initial code from "mach-origen.c" source. It
separate Origenboard and Origen4Quad board from SoC type.

- Common initialize features(Origen and Origen4Quad shared features)
- Origenboard dependant features
- Origen4Quad board dependant features

So, code to initialize the peripherals will be added to each area.

>
> > diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
> > index bb3b09a..0b8ccd3 100644
> > --- a/arch/arm/mach-exynos/Kconfig
> > +++ b/arch/arm/mach-exynos/Kconfig
> > @@ -324,6 +324,7 @@ config MACH_NURI
> >  config MACH_ORIGEN
> >       bool "ORIGEN"
> >       select CPU_EXYNOS4210
> > +     select SOC_EXYNOS4412
> >       select EXYNOS4_DEV_USB_OHCI
> >       select EXYNOS4_SETUP_FIMD0
> >       select EXYNOS4_SETUP_SDHCI
> > diff --git a/arch/arm/mach-exynos/mach-origen.c
> b/arch/arm/mach-exynos/mach-origen.c
> > index e6f4191..2839724 100644
> > --- a/arch/arm/mach-exynos/mach-origen.c
> > +++ b/arch/arm/mach-exynos/mach-origen.c
> > @@ -1,6 +1,6 @@
> >  /* linux/arch/arm/mach-exynos4/mach-origen.c
> >   *
> > - * Copyright (c) 2011 Insignal Co., Ltd.
> > + * Copyright (c) 2011-2012 Insignal Co., Ltd.
> >   *           http://www.insignal.co.kr/
> >   *
> >   * This program is free software; you can redistribute it and/or modify
> > @@ -771,19 +771,36 @@ static void __init origen_reserve(void)
> >       s5p_mfc_reserve_mem(0x43000000, 8 << 20, 0x51000000, 8 << 20);
> >  }
> >
> > -static void __init origen_machine_init(void)
> > +static int __init origen4quad_i2c_init(void)
> >  {
> > -     origen_power_init();
> > +     /*
> > +      * Origen4Quad has weaknees drive strength in i2c channel 3.
> > +      * thus here setup i2c3's drvstr for Origen4Quad.
> > +      */
> > +     s5p_gpio_set_drvstr(EXYNOS4_GPA1(2), 3);
> > +     s5p_gpio_set_drvstr(EXYNOS4_GPA1(3), 3);
> > +     return 0;
> > +}
> >
> > -     s3c_i2c0_set_platdata(NULL);
> > -     i2c_register_board_info(0, i2c0_devs, ARRAY_SIZE(i2c0_devs));
> > +static int __init origen4quad_usb_init(void)
> > +{
> > +     /* USB HUB controller's hub reset pin setup for Origen4Quad. */
> > +     gpio_request(EXYNOS4_GPX3(5), "GPX3");
> > +     gpio_direction_output(EXYNOS4_GPX3(5), 1);
> > +     gpio_set_value(EXYNOS4_GPX3(5), S3C_GPIO_PULL_UP);
> > +     gpio_free(EXYNOS4_GPX3(5));
> > +     return 0;
> > +}
> >
> > +static void __init origen_machine_init(void)
> > +{
> >       /*
> > -      * Since sdhci instance 2 can contain a bootable media,
> > -      * sdhci instance 0 is registered after instance 2.
> > +      * Common initialize code for ORIGEN and Origen4Quad.
> >        */
> > +     s3c_i2c0_set_platdata(NULL);
> > +     i2c_register_board_info(0, i2c0_devs, ARRAY_SIZE(i2c0_devs));
> > +
> >       s3c_sdhci2_set_platdata(&origen_hsmmc2_pdata);
> > -     s3c_sdhci0_set_platdata(&origen_hsmmc0_pdata);
> >
> >       origen_ehci_init();
> >       origen_ohci_init();
> > @@ -793,22 +810,45 @@ static void __init origen_machine_init(void)
> >       s5p_i2c_hdmiphy_set_platdata(NULL);
> >       s5p_hdmi_set_platdata(&hdmiphy_info, NULL, 0);
> >
> > -#ifdef CONFIG_DRM_EXYNOS
> > -     s5p_device_fimd0.dev.platform_data = &drm_fimd_pdata;
> > -     exynos4_fimd0_gpio_setup_24bpp();
> > -#else
> > -     s5p_fimd0_set_platdata(&origen_lcd_pdata);
> > -#endif
> > +     pwm_add_table(origen_pwm_lookup, ARRAY_SIZE(origen_pwm_lookup));
> >
> >       platform_add_devices(origen_devices, ARRAY_SIZE(origen_devices));
> >
> > -     pwm_add_table(origen_pwm_lookup, ARRAY_SIZE(origen_pwm_lookup));
> > -     samsung_bl_set(&origen_bl_gpio_info, &origen_bl_data);
> > +     if (!soc_is_exynos4210()) {
> > +             /*
> > +              * In case of soc_is_4210(),
> > +              * Machine initialize for Origen.
> > +              */
> >
> > -     origen_bt_setup();
> > +             origen_power_init();
> > +
> > +             /*
> > +              * Since sdhci instance 2 can contain a bootable media,
> > +              * sdhci instance 0 is registered after instance 2.
> > +              */
> > +             s3c_sdhci0_set_platdata(&origen_hsmmc0_pdata);
> > +
> > +#ifdef CONFIG_DRM_EXYNOS
> > +             s5p_device_fimd0.dev.platform_data = &drm_fimd_pdata;
> > +             exynos4_fimd0_gpio_setup_24bpp();
> > +#else
> > +             s5p_fimd0_set_platdata(&origen_lcd_pdata);
> > +#endif
> > +             samsung_bl_set(&origen_bl_gpio_info, &origen_bl_data);
> > +
> > +             origen_bt_setup();
> > +     } else{
> > +             /*
> > +              * In case of soc_is_4412(),
> > +              * Machine initialize for Origen4Quad.
> > +              */
> > +             origen4quad_i2c_init();
> > +             origen4quad_usb_init();
> > +     }
> >  }
> >
> >  MACHINE_START(ORIGEN, "ORIGEN")
> > +     /* Maintainer: Kyuho Choi <kh.choi@insignal.co.kr> */
> >       /* Maintainer: JeongHyeon Kim <jhkim@insignal.co.kr> */
> >       .atag_offset    = 0x100,
> >       .smp            = smp_ops(exynos_smp_ops),
> >
>
>
> --
> Tushar Behera
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121120/bc359c4c/attachment-0001.html>
