From: subhasish@mistralsolutions.com (Subhasish Ghosh)
Date: Tue, 22 Feb 2011 14:48:13 +0530
Subject: [PATCH v2 12/13] da850: pruss SUART platform specific additions.
In-Reply-To: <4D55860E.3090908@mvista.com>
References: <1297435892-28278-1-git-send-email-subhasish@mistralsolutions.com>
	<1297435892-28278-13-git-send-email-subhasish@mistralsolutions.com>
	<4D55860E.3090908@mvista.com>
Message-ID: <B2D7D72494BB443F80DA08E22323999B@subhasishg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I could not follow your recommendations clearly, are you suggesting this:

int __init da8xx_register_pruss(struct da8xx_pruss_devices *pruss_device)
{
#ifdef CONFIG_SERIAL_PRUSS_SUART_MODULE
        int ret;

        ret = clk_add_alias(NULL, "da8xx_pruss_uart.1",
                            NULL, &da850_mcasp_device.dev);
        if (ret < 0)
                return ret;
#endif
        da8xx_pruss_dev.dev.platform_data = pruss_device;
        return platform_device_register(&da8xx_pruss_dev);
}

--------------------------------------------------
From: "Sergei Shtylyov" <sshtylyov@mvista.com>
Sent: Saturday, February 12, 2011 12:25 AM
To: "Subhasish Ghosh" <subhasish@mistralsolutions.com>
Cc: <davinci-linux-open-source@linux.davincidsp.com>; 
<sachi@mistralsolutions.com>; "Russell King" <linux@arm.linux.org.uk>; 
"Kevin Hilman" <khilman@deeprootsystems.com>; <nsekhar@ti.com>; "open list" 
<linux-kernel@vger.kernel.org>; <m-watkins@ti.com>; 
<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 12/13] da850: pruss SUART platform specific 
additions.

> Subhasish Ghosh wrote:
>
>> This patch adds the McASP clock alias.
>> The alias is used by the pruss suart driver
>> for enabling the McASP PSC.
>
>> Signed-off-by: Subhasish Ghosh <subhasish@mistralsolutions.com>
> [...]
>
>> diff --git a/arch/arm/mach-davinci/devices-da8xx.c 
>> b/arch/arm/mach-davinci/devices-da8xx.c
>> index e15de72..f1cf605 100644
>> --- a/arch/arm/mach-davinci/devices-da8xx.c
>> +++ b/arch/arm/mach-davinci/devices-da8xx.c
>> @@ -560,7 +560,18 @@ struct platform_device da8xx_pruss_dev = {
>>  int __init da8xx_register_pruss(struct da8xx_pruss_devices 
>> *pruss_device)
>>  {
>> +#ifdef CONFIG_SERIAL_PRUSS_SUART_MODULE
>
>    #ifdef's in the function body are generally fromned upon.
>
>> + int ret;
>> +#endif
>> +
>
>    This line should have been inside #ifdef...
>
>>  da8xx_pruss_dev.dev.platform_data = pruss_device;
>> +
>> +#ifdef CONFIG_SERIAL_PRUSS_SUART_MODULE
>
>    Why not do it before assigning the platform data and avoid extra 
> #ifdef?
>
>> + ret = clk_add_alias(NULL, "da8xx_pruss_uart.1",
>> + NULL, &da850_mcasp_device.dev);
>
>    This line should be indented more to the right.
>
>> + if (ret < 0)
>> + return ret;
>> +#endif
>
> WBR, Sergei 
