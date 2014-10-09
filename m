From: jingchang.lu@freescale.com (Jingchang Lu)
Date: Thu, 9 Oct 2014 07:53:47 +0000
Subject: [PATCH] serial: of-serial: add PM suspend/resume support
In-Reply-To: <542E5421.5070708@nvidia.com>
References: <1411461252-8730-1-git-send-email-jingchang.lu@freescale.com>
 <542E5421.5070708@nvidia.com>
Message-ID: <b315028a386e46dca9abd70b65210bb1@BL2PR03MB467.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>-----Original Message-----
>From: Joseph Lo [mailto:josephl at nvidia.com]
>Sent: Friday, October 03, 2014 3:46 PM
>To: Lu Jingchang-B35083; gregkh at linuxfoundation.org
>Cc: devicetree at vger.kernel.org; arnd at arndb.de; linux-
>kernel at vger.kernel.org; linux-serial at vger.kernel.org; linux-arm-
>kernel at lists.infradead.org
>Subject: Re: [PATCH] serial: of-serial: add PM suspend/resume support
>
>Hi,
>
>This patch might have a potential issue that cause system hard hung
>immediately when it accesses to registers with no clock. This could happen
>on many chips that mainline kernel supporting with the setting
>"no_console_suspend=1" during suspend time.
>
>On 09/23/2014 04:34 PM, Jingchang Lu wrote:
>> This adds PM suspend/resume support for the of-serial driver to
>> provide power management support on devices attatched to it.
>>
>> Signed-off-by: Jingchang Lu <jingchang.lu@freescale.com>
>> ---
>>   drivers/tty/serial/of_serial.c | 27 +++++++++++++++++++++++++++
>>   1 file changed, 27 insertions(+)
>>
>> diff --git a/drivers/tty/serial/of_serial.c
>> b/drivers/tty/serial/of_serial.c index 27981e2..8bc2563 100644
>> --- a/drivers/tty/serial/of_serial.c
>> +++ b/drivers/tty/serial/of_serial.c
>> @@ -240,6 +240,32 @@ static int of_platform_serial_remove(struct
>platform_device *ofdev)
>>   	return 0;
>>   }
>>
>> +#ifdef CONFIG_PM_SLEEP
>> +static int of_serial_suspend(struct device *dev) {
>> +	struct of_serial_info *info = dev_get_drvdata(dev);
>> +
>> +	serial8250_suspend_port(info->line);
>> +	if (info->clk)
>The fix would be something like this.
>	if (info->clk && console_suspend_enabled)
>
Yes, there will be, I will send a fix on this, thanks!

Best Regards,
Jingchang
