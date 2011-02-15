From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 15 Feb 2011 23:40:17 +0800
Subject: [PATCH] Clean up set_pxa_fb_info
In-Reply-To: <AANLkTi=VL8NT=ieuFRZNuU=H5Oyq5ARvB6Cd-_kuufPn@mail.gmail.com>
References: <20110206115254.GA13084@n2100.arm.linux.org.uk>
	<20110213103510.GA4799@n2100.arm.linux.org.uk>
	<AANLkTi=VL8NT=ieuFRZNuU=H5Oyq5ARvB6Cd-_kuufPn@mail.gmail.com>
Message-ID: <AANLkTi=T_diU0_x9wQ67d4cRfQY6U3aUyYKeUnNjQgC3@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>> -void set_pxa_fb_info(struct pxafb_mach_info *hard_pxa_fb_info);
>>> -void set_pxa_fb_parent(struct device *parent_dev);
>>> +void pxa_set_fb_info(struct pxafb_mach_info *hard_pxa_fb_info);

I think your original intention is:

+void pxa_set_fb_info(struct device *, struct pxafb_mach_info *);

I've amend the changes.

>>> ?unsigned long pxafb_get_hsync_time(struct device *dev);
>>>
>>> ?extern int pxafb_smart_queue(struct fb_info *info, uint16_t *cmds, int);
>>> diff --git a/arch/arm/mach-pxa/littleton.c b/arch/arm/mach-pxa/littleton.c
>>> index ccb7bfa..4b2c45f 100644
>>> --- a/arch/arm/mach-pxa/littleton.c
>>> +++ b/arch/arm/mach-pxa/littleton.c
>>> @@ -185,7 +185,7 @@ static struct pxafb_mach_info littleton_lcd_info = {
>>>
>>> ?static void littleton_init_lcd(void)
>>> ?{
>>> - ? ? set_pxa_fb_info(&littleton_lcd_info);
>>> + ? ? pxa_set_fb_info(NULL, &littleton_lcd_info);
>>> ?}
>>> ?#else
>>> ?static inline void littleton_init_lcd(void) {};
>>> diff --git a/arch/arm/mach-pxa/lpd270.c b/arch/arm/mach-pxa/lpd270.c
>>> index c9a3e77..8aebc58 100644
>>> --- a/arch/arm/mach-pxa/lpd270.c
>>> +++ b/arch/arm/mach-pxa/lpd270.c
>>> @@ -480,7 +480,7 @@ static void __init lpd270_init(void)
>>> ? ? ? pxa_set_ac97_info(NULL);
>>>
>>> ? ? ? if (lpd270_lcd_to_use != NULL)
>>> - ? ? ? ? ? ? set_pxa_fb_info(lpd270_lcd_to_use);
>>> + ? ? ? ? ? ? pxa_set_fb_info(NULL, lpd270_lcd_to_use);
>>>
>>> ? ? ? pxa_set_ohci_info(&lpd270_ohci_platform_data);
>>> ?}
>>> diff --git a/arch/arm/mach-pxa/lubbock.c b/arch/arm/mach-pxa/lubbock.c
>>> index dca20de..12a2a56 100644
>>> --- a/arch/arm/mach-pxa/lubbock.c
>>> +++ b/arch/arm/mach-pxa/lubbock.c
>>> @@ -521,7 +521,7 @@ static void __init lubbock_init(void)
>>>
>>> ? ? ? clk_add_alias("SA1111_CLK", NULL, "GPIO11_CLK", NULL);
>>> ? ? ? pxa_set_udc_info(&udc_info);
>>> - ? ? set_pxa_fb_info(&sharp_lm8v31);
>>> + ? ? pxa_set_fb_info(NULL, &sharp_lm8v31);
>>> ? ? ? pxa_set_mci_info(&lubbock_mci_platform_data);
>>> ? ? ? pxa_set_ficp_info(&lubbock_ficp_platform_data);
>>> ? ? ? pxa_set_ac97_info(NULL);
>>> diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
>>> index 41198f0..ad70264 100644
>>> --- a/arch/arm/mach-pxa/magician.c
>>> +++ b/arch/arm/mach-pxa/magician.c
>>> @@ -757,7 +757,7 @@ static void __init magician_init(void)
>>> ? ? ? ? ? ? ? gpio_direction_output(GPIO104_MAGICIAN_LCD_POWER_1, 0);
>>> ? ? ? ? ? ? ? gpio_direction_output(GPIO105_MAGICIAN_LCD_POWER_2, 0);
>>> ? ? ? ? ? ? ? gpio_direction_output(GPIO106_MAGICIAN_LCD_POWER_3, 0);
>>> - ? ? ? ? ? ? set_pxa_fb_info(lcd_select ? &samsung_info : &toppoly_info);
>>> + ? ? ? ? ? ? pxa_set_fb_info(NULL, lcd_select ? &samsung_info : &toppoly_info);
>>> ? ? ? } else
>>> ? ? ? ? ? ? ? pr_err("LCD detection: CPLD mapping failed\n");
>>> ?}
>>> diff --git a/arch/arm/mach-pxa/mainstone.c b/arch/arm/mach-pxa/mainstone.c
>>> index d4b6f23..a58f522 100644
>>> --- a/arch/arm/mach-pxa/mainstone.c
>>> +++ b/arch/arm/mach-pxa/mainstone.c
>>> @@ -592,7 +592,7 @@ static void __init mainstone_init(void)
>>> ? ? ? else
>>> ? ? ? ? ? ? ? mainstone_pxafb_info.modes = &toshiba_ltm035a776c_mode;
>>>
>>> - ? ? set_pxa_fb_info(&mainstone_pxafb_info);
>>> + ? ? pxa_set_fb_info(NULL, &mainstone_pxafb_info);
>>> ? ? ? mainstone_backlight_register();
>>>
>>> ? ? ? pxa_set_mci_info(&mainstone_mci_platform_data);
>>> diff --git a/arch/arm/mach-pxa/mioa701.c b/arch/arm/mach-pxa/mioa701.c
>>> index faafea3..18e05b1 100644
>>> --- a/arch/arm/mach-pxa/mioa701.c
>>> +++ b/arch/arm/mach-pxa/mioa701.c
>>> @@ -795,7 +795,7 @@ static void __init mioa701_machine_init(void)
>>> ? ? ? pxa_set_stuart_info(NULL);
>>> ? ? ? mio_gpio_request(ARRAY_AND_SIZE(global_gpios));
>>> ? ? ? bootstrap_init();
>>> - ? ? set_pxa_fb_info(&mioa701_pxafb_info);
>>> + ? ? pxa_set_fb_info(NULL, &mioa701_pxafb_info);
>>> ? ? ? pxa_set_mci_info(&mioa701_mci_info);
>>> ? ? ? pxa_set_keypad_info(&mioa701_keypad_info);
>>> ? ? ? pxa_set_udc_info(&mioa701_udc_info);
>>> diff --git a/arch/arm/mach-pxa/palm27x.c b/arch/arm/mach-pxa/palm27x.c
>>> index 405b92a..4f26d78 100644
>>> --- a/arch/arm/mach-pxa/palm27x.c
>>> +++ b/arch/arm/mach-pxa/palm27x.c
>>> @@ -159,7 +159,7 @@ void __init palm27x_lcd_init(int power, struct pxafb_mode_info *mode)
>>> ? ? ? ? ? ? ? palm27x_lcd_screen.pxafb_lcd_power = palm27x_lcd_ctl;
>>> ? ? ? }
>>>
>>> - ? ? set_pxa_fb_info(&palm27x_lcd_screen);
>>> + ? ? pxa_set_fb_info(NULL, &palm27x_lcd_screen);
>>> ?}
>>> ?#endif
>>>
>>> diff --git a/arch/arm/mach-pxa/palmtc.c b/arch/arm/mach-pxa/palmtc.c
>>> index a09a237..fb06bd0 100644
>>> --- a/arch/arm/mach-pxa/palmtc.c
>>> +++ b/arch/arm/mach-pxa/palmtc.c
>>> @@ -507,7 +507,7 @@ static struct pxafb_mach_info palmtc_lcd_screen = {
>>>
>>> ?static void __init palmtc_lcd_init(void)
>>> ?{
>>> - ? ? set_pxa_fb_info(&palmtc_lcd_screen);
>>> + ? ? pxa_set_fb_info(NULL, &palmtc_lcd_screen);
>>> ?}
>>> ?#else
>>> ?static inline void palmtc_lcd_init(void) {}
>>> diff --git a/arch/arm/mach-pxa/palmte2.c b/arch/arm/mach-pxa/palmte2.c
>>> index 3f25014..7fdf099 100644
>>> --- a/arch/arm/mach-pxa/palmte2.c
>>> +++ b/arch/arm/mach-pxa/palmte2.c
>>> @@ -363,7 +363,7 @@ static void __init palmte2_init(void)
>>> ? ? ? pxa_set_btuart_info(NULL);
>>> ? ? ? pxa_set_stuart_info(NULL);
>>>
>>> - ? ? set_pxa_fb_info(&palmte2_lcd_screen);
>>> + ? ? pxa_set_fb_info(NULL, &palmte2_lcd_screen);
>>> ? ? ? pxa_set_mci_info(&palmte2_mci_platform_data);
>>> ? ? ? palmte2_udc_init();
>>> ? ? ? pxa_set_ac97_info(&palmte2_ac97_pdata);
>>> diff --git a/arch/arm/mach-pxa/pcm990-baseboard.c b/arch/arm/mach-pxa/pcm990-baseboard.c
>>> index 90820fa..c1a6448 100644
>>> --- a/arch/arm/mach-pxa/pcm990-baseboard.c
>>> +++ b/arch/arm/mach-pxa/pcm990-baseboard.c
>>> @@ -515,7 +515,7 @@ void __init pcm990_baseboard_init(void)
>>> ? ? ? pcm990_init_irq();
>>>
>>> ?#ifndef CONFIG_PCM990_DISPLAY_NONE
>>> - ? ? set_pxa_fb_info(&pcm990_fbinfo);
>>> + ? ? pxa_set_fb_info(NULL, &pcm990_fbinfo);
>>> ?#endif
>>> ? ? ? platform_device_register(&pcm990_backlight_device);
>>>
>>> diff --git a/arch/arm/mach-pxa/poodle.c b/arch/arm/mach-pxa/poodle.c
>>> index 4f0ff1a..be68ec5 100644
>>> --- a/arch/arm/mach-pxa/poodle.c
>>> +++ b/arch/arm/mach-pxa/poodle.c
>>> @@ -445,8 +445,7 @@ static void __init poodle_init(void)
>>> ? ? ? if (ret)
>>> ? ? ? ? ? ? ? pr_warning("poodle: Unable to register LoCoMo device\n");
>>>
>>> - ? ? set_pxa_fb_parent(&poodle_locomo_device.dev);
>>> - ? ? set_pxa_fb_info(&poodle_fb_info);
>>> + ? ? pxa_set_fb_info(&poodle_locomo_device.dev, &poodle_fb_info);
>>> ? ? ? pxa_set_udc_info(&udc_info);
>>> ? ? ? pxa_set_mci_info(&poodle_mci_platform_data);
>>> ? ? ? pxa_set_ficp_info(&poodle_ficp_platform_data);
>>> diff --git a/arch/arm/mach-pxa/raumfeld.c b/arch/arm/mach-pxa/raumfeld.c
>>> index 8361151..d9a5791 100644
>>> --- a/arch/arm/mach-pxa/raumfeld.c
>>> +++ b/arch/arm/mach-pxa/raumfeld.c
>>> @@ -597,7 +597,7 @@ static void __init raumfeld_lcd_init(void)
>>> ?{
>>> ? ? ? int ret;
>>>
>>> - ? ? set_pxa_fb_info(&raumfeld_sharp_lcd_info);
>>> + ? ? pxa_set_fb_info(NULL, &raumfeld_sharp_lcd_info);
>>>
>>> ? ? ? /* Earlier devices had the backlight regulator controlled
>>> ? ? ? ?* via PWM, later versions use another controller for that */
>>> diff --git a/arch/arm/mach-pxa/saar.c b/arch/arm/mach-pxa/saar.c
>>> index c1ca8cb..dd0118f 100644
>>> --- a/arch/arm/mach-pxa/saar.c
>>> +++ b/arch/arm/mach-pxa/saar.c
>>> @@ -473,7 +473,7 @@ static struct pxafb_mach_info saar_lcd_info = {
>>>
>>> ?static void __init saar_init_lcd(void)
>>> ?{
>>> - ? ? set_pxa_fb_info(&saar_lcd_info);
>>> + ? ? pxa_set_fb_info(NULL, &saar_lcd_info);
>>> ?}
>>> ?#else
>>> ?static inline void saar_init_lcd(void) {}
>>> diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
>>> index b49a2c2..e646b6d 100644
>>> --- a/arch/arm/mach-pxa/spitz.c
>>> +++ b/arch/arm/mach-pxa/spitz.c
>>> @@ -725,7 +725,7 @@ static struct pxafb_mach_info spitz_pxafb_info = {
>>>
>>> ?static void __init spitz_lcd_init(void)
>>> ?{
>>> - ? ? set_pxa_fb_info(&spitz_pxafb_info);
>>> + ? ? pxa_set_fb_info(NULL, &spitz_pxafb_info);
>>> ?}
>>> ?#else
>>> ?static inline void spitz_lcd_init(void) {}
>>> diff --git a/arch/arm/mach-pxa/tavorevb.c b/arch/arm/mach-pxa/tavorevb.c
>>> index 9cecf83..53d4a47 100644
>>> --- a/arch/arm/mach-pxa/tavorevb.c
>>> +++ b/arch/arm/mach-pxa/tavorevb.c
>>> @@ -466,7 +466,7 @@ static void __init tavorevb_init_lcd(void)
>>> ?{
>>> ? ? ? platform_device_register(&tavorevb_backlight_devices[0]);
>>> ? ? ? platform_device_register(&tavorevb_backlight_devices[1]);
>>> - ? ? set_pxa_fb_info(&tavorevb_lcd_info);
>>> + ? ? pxa_set_fb_info(NULL, &tavorevb_lcd_info);
>>> ?}
>>> ?#else
>>> ?static inline void tavorevb_init_lcd(void) {}
>>> diff --git a/arch/arm/mach-pxa/trizeps4.c b/arch/arm/mach-pxa/trizeps4.c
>>> index 423261d..fa510fd 100644
>>> --- a/arch/arm/mach-pxa/trizeps4.c
>>> +++ b/arch/arm/mach-pxa/trizeps4.c
>>> @@ -516,9 +516,9 @@ static void __init trizeps4_init(void)
>>> ? ? ? pxa_set_stuart_info(NULL);
>>>
>>> ? ? ? if (0) ?/* dont know how to determine LCD */
>>> - ? ? ? ? ? ? set_pxa_fb_info(&sharp_lcd);
>>> + ? ? ? ? ? ? pxa_set_fb_info(NULL, &sharp_lcd);
>>> ? ? ? else
>>> - ? ? ? ? ? ? set_pxa_fb_info(&toshiba_lcd);
>>> + ? ? ? ? ? ? pxa_set_fb_info(NULL, &toshiba_lcd);
>>>
>>> ? ? ? pxa_set_mci_info(&trizeps4_mci_platform_data);
>>> ?#ifndef STATUS_LEDS_ON_STUART_PINS
>>> diff --git a/arch/arm/mach-pxa/viper.c b/arch/arm/mach-pxa/viper.c
>>> index 49eeeab..53b2495 100644
>>> --- a/arch/arm/mach-pxa/viper.c
>>> +++ b/arch/arm/mach-pxa/viper.c
>>> @@ -932,7 +932,7 @@ static void __init viper_init(void)
>>> ? ? ? /* Wake-up serial console */
>>> ? ? ? viper_init_serial_gpio();
>>>
>>> - ? ? set_pxa_fb_info(&fb_info);
>>> + ? ? pxa_set_fb_info(NULL, &fb_info);
>>>
>>> ? ? ? /* v1 hardware cannot use the datacs line */
>>> ? ? ? version = viper_hw_version();
>>> diff --git a/arch/arm/mach-pxa/vpac270.c b/arch/arm/mach-pxa/vpac270.c
>>> index b9b5797..a46f8d1 100644
>>> --- a/arch/arm/mach-pxa/vpac270.c
>>> +++ b/arch/arm/mach-pxa/vpac270.c
>>> @@ -573,7 +573,7 @@ static void __init vpac270_lcd_init(void)
>>> ? ? ? }
>>>
>>> ? ? ? vpac270_lcd_screen.pxafb_lcd_power = vpac270_lcd_power;
>>> - ? ? set_pxa_fb_info(&vpac270_lcd_screen);
>>> + ? ? pxa_set_fb_info(NULL, &vpac270_lcd_screen);
>>> ? ? ? return;
>>>
>>> ?err2:
>>> diff --git a/arch/arm/mach-pxa/z2.c b/arch/arm/mach-pxa/z2.c
>>> index a323e07..084c724 100644
>>> --- a/arch/arm/mach-pxa/z2.c
>>> +++ b/arch/arm/mach-pxa/z2.c
>>> @@ -272,7 +272,7 @@ static struct pxafb_mach_info z2_lcd_screen = {
>>>
>>> ?static void __init z2_lcd_init(void)
>>> ?{
>>> - ? ? set_pxa_fb_info(&z2_lcd_screen);
>>> + ? ? pxa_set_fb_info(NULL, &z2_lcd_screen);
>>> ?}
>>> ?#else
>>> ?static inline void z2_lcd_init(void) {}
>>> diff --git a/arch/arm/mach-pxa/zeus.c b/arch/arm/mach-pxa/zeus.c
>>> index f4b053b..3db0ba4 100644
>>> --- a/arch/arm/mach-pxa/zeus.c
>>> +++ b/arch/arm/mach-pxa/zeus.c
>>> @@ -847,7 +847,7 @@ static void __init zeus_init(void)
>>> ? ? ? if (zeus_setup_fb_gpios())
>>> ? ? ? ? ? ? ? pr_err("Failed to setup fb gpios\n");
>>> ? ? ? else
>>> - ? ? ? ? ? ? set_pxa_fb_info(&zeus_fb_info);
>>> + ? ? ? ? ? ? pxa_set_fb_info(NULL, &zeus_fb_info);
>>>
>>> ? ? ? pxa_set_mci_info(&zeus_mci_platform_data);
>>> ? ? ? pxa_set_udc_info(&zeus_udc_info);
>>> diff --git a/arch/arm/mach-pxa/zylonite.c b/arch/arm/mach-pxa/zylonite.c
>>> index a4c784a..5821185 100644
>>> --- a/arch/arm/mach-pxa/zylonite.c
>>> +++ b/arch/arm/mach-pxa/zylonite.c
>>> @@ -208,7 +208,7 @@ static void __init zylonite_init_lcd(void)
>>> ? ? ? platform_device_register(&zylonite_backlight_device);
>>>
>>> ? ? ? if (lcd_id & 0x20) {
>>> - ? ? ? ? ? ? set_pxa_fb_info(&zylonite_sharp_lcd_info);
>>> + ? ? ? ? ? ? pxa_set_fb_info(NULL, &zylonite_sharp_lcd_info);
>>> ? ? ? ? ? ? ? return;
>>> ? ? ? }
>>>
>>> @@ -220,7 +220,7 @@ static void __init zylonite_init_lcd(void)
>>> ? ? ? else
>>> ? ? ? ? ? ? ? zylonite_toshiba_lcd_info.modes = &toshiba_ltm04c380k_mode;
>>>
>>> - ? ? set_pxa_fb_info(&zylonite_toshiba_lcd_info);
>>> + ? ? pxa_set_fb_info(NULL, &zylonite_toshiba_lcd_info);
>>> ?}
>>> ?#else
>>> ?static inline void zylonite_init_lcd(void) {}
>>>
>>> _______________________________________________
>>> linux-arm-kernel mailing list
>>> linux-arm-kernel at lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
>
