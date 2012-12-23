From: mikedunn@newsguy.com (Mike Dunn)
Date: Sun, 23 Dec 2012 06:59:17 -0800
Subject: [PATCH 1/3] ARM: pxa: palmtreo: fix lcd initialization on treo680
In-Reply-To: <201212230418.51035.marex@denx.de>
References: <1356204719-3317-1-git-send-email-mikedunn@newsguy.com>
 <1356204719-3317-2-git-send-email-mikedunn@newsguy.com>
 <201212230418.51035.marex@denx.de>
Message-ID: <50D71C45.7030501@newsguy.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/22/2012 07:18 PM, Marek Vasut wrote:
> Dear Mike Dunn,
> 
> I think you should Cc Haojian (done)


Yes thanks you Marek, and my aplogies Haojian.  Actually I was negligent on the
CC's of all these patches.  When I repost, I'll expand the CC list.

[...]


> I think I have a spare device somewhere around. I might get it available to you 
> somehow eventually -- but that'll need some further discussion. Let's postpone 
> it for now.


I plan to start checking ebay soon.  The Treos seemed widely available last I
checked (at least the 680), and fairly cheap.

[...]


>> The need for this patch is not evident when Linux is loaded from PalmOS,
>> because at that point the lcd-related gpios have already been configured. 
>> But when booting the kernel by other means, this patch is required unless
>> the bootloader has performed the necessary initialializations.
> 
> You mean U-Boot ? Makes sense.


Well my u-boot port does initialize the lcd.  But generally, it shouldn't be
assumed.  I discovered the need for this when I loaded the kernel with the
emulator.  It's actually the secondary program loader that does the
initialization (when it displays the Palm logo).


> [...]
> 
>>  static void __init treo680_init(void)
>>  {
>>  	pxa2xx_mfp_config(ARRAY_AND_SIZE(treo680_pin_config));
>>  	palmphone_common_init();
>> +	treo680_lcd_init();
> 
> I think you want to do treo680_gpio_configure() kind of thing and then call 
> palm27x_lcd_init() from here.


I'm not 100% sure, but I think that the lcd controller has to be initialized
while the gpios are driven high, then after that, driving one of them low turns
the lcd on.  This is why palm27x_lcd_init() is called from within
treo680_lcd_init().  But yes, it could be cleaner if the hardware permits.  I'll
experiment some more.


> Even better of course would be to integrate this kind of GPIO fiddling with the 
> backlight subsystem, so the LCD can be properly powered down when going LPM.


Yes, this needs to be cleaned up.  The label "lcd power" is thrown around too
much, sometimes when actually referring to the backlight.  And power management
is another whole effort.  I'm hoping to be able to take things step by step.

[...]

Thanks for having a look Marek.  I'll see if the gpio initialization can be
separated from the lcd initialization.

MIke
