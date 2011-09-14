From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 14 Sep 2011 10:23:06 -0300
Subject: [PATCH] ARM: mach-mxs/mx28evk: Only register devices if their
	GPIO requests succeeded
In-Reply-To: <20110914065501.GR28624@pengutronix.de>
References: <1315945519-15178-1-git-send-email-festevam@gmail.com>
	<20110914065501.GR28624@pengutronix.de>
Message-ID: <CAOMZO5CWVwZ60z1WbA4Ctm8YRQkYQc5yXXZD9Z3DBWh39gv2yw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/9/14 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> Hello,
>
> On Tue, Sep 13, 2011 at 05:25:19PM -0300, Fabio Estevam wrote:
>> Currently framebuffer and MMC devices are registered even if their associated
>> GPIO pins fail to be requested.
> Is this a real or only theoretic problem? (For me (or later Sascha) to
> judge if it should go in before 3.2.)

I haven't seen this to happen, but it is the safe thing to do here.

I think this can wait 3.2 cycle.

>
>> diff --git a/arch/arm/mach-mxs/mach-mx28evk.c b/arch/arm/mach-mxs/mach-mx28evk.c
>> index 3f86e7a..e5c66a2 100644
>> --- a/arch/arm/mach-mxs/mach-mx28evk.c
>> +++ b/arch/arm/mach-mxs/mach-mx28evk.c
>> @@ -353,7 +353,7 @@ static struct mxs_mmc_platform_data mx28evk_mmc_pdata[] __initdata = {
>>
>> ?static void __init mx28evk_init(void)
>> ?{
>> - ? ? int ret;
>> + ? ? int ret, gpio_lcd_error;
>>
>> ? ? ? mxs_iomux_setup_multiple_pads(mx28evk_pads, ARRAY_SIZE(mx28evk_pads));
>>
>> @@ -378,18 +378,23 @@ static void __init mx28evk_init(void)
>> ? ? ? }
>>
>> ? ? ? ret = gpio_request_one(MX28EVK_LCD_ENABLE, GPIOF_DIR_OUT, "lcd-enable");
>> - ? ? if (ret)
>> + ? ? if (ret) {
>> ? ? ? ? ? ? ? pr_warn("failed to request gpio lcd-enable: %d\n", ret);
>> + ? ? ? ? ? ? gpio_lcd_error = 1;
>> + ? ? }
>> ? ? ? else
>> ? ? ? ? ? ? ? gpio_set_value(MX28EVK_LCD_ENABLE, 1);
>>
>> ? ? ? ret = gpio_request_one(MX28EVK_BL_ENABLE, GPIOF_DIR_OUT, "bl-enable");
>> - ? ? if (ret)
>> + ? ? if (ret) {
>> ? ? ? ? ? ? ? pr_warn("failed to request gpio bl-enable: %d\n", ret);
>> + ? ? ? ? ? ? gpio_lcd_error = 1;
>> + ? ? }
>> ? ? ? else
>> ? ? ? ? ? ? ? gpio_set_value(MX28EVK_BL_ENABLE, 1);
> If it's not important which gpio failed, you can do:
>
> ? ? ? ?ret = gpio_request_array(...)
> ? ? ? ?if (ret)
> ? ? ? ? ? ? ? ?pr_warn("failed to request gpio for lcd\n");
> ? ? ? ?else
> ? ? ? ? ? ? ? ?mx28_add_mxsfb(&mx28evk_mxsfb_pdata);
>
> (Apart from the different message this differs in semantic when the 2nd
> request fails. With my suggestion the first gpio is freed then which
> seems cleaner.) I don't care much though.

Ok, looks better. I did like you suggested in v2.

Regards,

Fabio Estevam
