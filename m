From: marex@denx.de (Marek Vasut)
Date: Sun, 23 Dec 2012 04:18:49 +0100
Subject: [PATCH 1/3] ARM: pxa: palmtreo: fix lcd initialization on treo680
In-Reply-To: <1356204719-3317-2-git-send-email-mikedunn@newsguy.com>
References: <1356204719-3317-1-git-send-email-mikedunn@newsguy.com>
 <1356204719-3317-2-git-send-email-mikedunn@newsguy.com>
Message-ID: <201212230418.51035.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Mike Dunn,

I think you should Cc Haojian (done)

> This patch gets the LCD working on my Palm Treo680.  Changing the Palm
> Centro code is avoided (I don't have a Centro for testing at the moment),
> but some initialization is shuffled around a bit.

I think I have a spare device somewhere around. I might get it available to you 
somehow eventually -- but that'll need some further discussion. Let's postpone 
it for now.

> This basically adds some code that manages the three gpios that interface
> to the lcd on the Treo 680.  The precise role of each gpio in the hardware
> architecture is not entirely clear to me; this patch is the result of
> trial-and-error and observing how the PalmOS code initializes the lcd.

Yay, good old times ;-)

> The need for this patch is not evident when Linux is loaded from PalmOS,
> because at that point the lcd-related gpios have already been configured. 
> But when booting the kernel by other means, this patch is required unless
> the bootloader has performed the necessary initialializations.

You mean U-Boot ? Makes sense.
[...]

>  static void __init treo680_init(void)
>  {
>  	pxa2xx_mfp_config(ARRAY_AND_SIZE(treo680_pin_config));
>  	palmphone_common_init();
> +	treo680_lcd_init();

I think you want to do treo680_gpio_configure() kind of thing and then call 
palm27x_lcd_init() from here.

Even better of course would be to integrate this kind of GPIO fiddling with the 
backlight subsystem, so the LCD can be properly powered down when going LPM.

>  	palm27x_mmc_init(GPIO_NR_TREO_SD_DETECT_N, GPIO_NR_TREO680_SD_READONLY,
>  			GPIO_NR_TREO680_SD_POWER, 0);
>  }
> @@ -438,6 +488,7 @@ static void __init centro_init(void)
>  {
>  	pxa2xx_mfp_config(ARRAY_AND_SIZE(centro685_pin_config));
>  	palmphone_common_init();
> +	palm27x_lcd_init(GPIO_NR_TREO_BL_POWER, &palm_320x320_new_lcd_mode);
>  	palm27x_mmc_init(GPIO_NR_TREO_SD_DETECT_N, -1,
>  			GPIO_NR_CENTRO_SD_POWER, 1);
>  }

Best regards,
Marek Vasut
