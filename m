From: weber@corscience.de (Thomas Weber)
Date: Thu, 20 Jan 2011 09:46:12 +0100
Subject: [PATCHv4 3/4] OMAP3: Devkit8000: Check return value of
	gpio_request
In-Reply-To: <4D36D7DC.4020705@ru.mvista.com>
References: <1295425166-25540-1-git-send-email-weber@corscience.de>
	<1295425166-25540-4-git-send-email-weber@corscience.de>
	<4D36D7DC.4020705@ru.mvista.com>
Message-ID: <4D37F654.70405@corscience.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,
Am 19.01.2011 13:23, schrieb Sergei Shtylyov:
> Hello.
>
> On 19-01-2011 11:19, Thomas Weber wrote:
>
>> The return value of gpio_request is ignored.
>> This patch adds the check of the return value of gpio_request.
>
>> Signed-off-by: Thomas Weber<weber@corscience.de>
>> ---
>>   arch/arm/mach-omap2/board-devkit8000.c |   16 ++++++++++++++--
>>   1 files changed, 14 insertions(+), 2 deletions(-)
>
>> diff --git a/arch/arm/mach-omap2/board-devkit8000.c
>> b/arch/arm/mach-omap2/board-devkit8000.c
>> index 9fb416b..4ddd81c 100644
>> --- a/arch/arm/mach-omap2/board-devkit8000.c
>> +++ b/arch/arm/mach-omap2/board-devkit8000.c
> [...]
>> @@ -244,13 +246,23 @@ static int devkit8000_twl_gpio_setup(struct
>> device *dev,
>>
>>       /* TWL4030_GPIO_MAX + 0 is "LCD_PWREN" (out, active high) */
>>       devkit8000_lcd_device.reset_gpio = gpio + TWL4030_GPIO_MAX + 0;
>> -    gpio_request(devkit8000_lcd_device.reset_gpio, "LCD_PWREN");
>> +    ret = gpio_request(devkit8000_lcd_device.reset_gpio, "LCD_PWREN");
>> +    if (ret < 0) {
>> +        printk(KERN_ERR "Failed to request GPIO for LCD_PWRN\n");
>> +        return ret;
>> +    }
>> +
>>       /* Disable until needed */
>>       gpio_direction_output(devkit8000_lcd_device.reset_gpio, 0);
>>
>>       /* gpio + 7 is "DVI_PD" (out, active low) */
>>       devkit8000_dvi_device.reset_gpio = gpio + 7;
>> -    gpio_request(devkit8000_dvi_device.reset_gpio, "DVI PowerDown");
>> +    ret = gpio_request(devkit8000_dvi_device.reset_gpio, "DVI
>> PowerDown");
>> +    if (ret < 0) {
>> +        printk(KERN_ERR "Failed to request GPIO for DVI PowerDown\n");
>
>    You forgot to call:
>
>         gpio_free(devkit8000_lcd_device.reset_gpio);
>
Couldn't I use lcd without dvi?
And shouldn't the gpio then be set to -EINVAL for the gpio_is_valid()
check in enable_lcd()/disable_lcd() and enable_dvi()/disable_dvi()?

Thomas
>> +        return ret;
>> +    }
>> +
>>       /* Disable until needed */
>>       gpio_direction_output(devkit8000_dvi_device.reset_gpio, 0);
>
> WBR, Sergei
> -- 
>
