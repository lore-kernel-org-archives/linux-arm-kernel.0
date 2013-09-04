From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 04 Sep 2013 18:38:12 +0400
Subject: [PATCH] pwm: pxa: add device tree support to pwm driver
In-Reply-To: <5227425E.7030806@newsguy.com>
References: <1378236233-15637-1-git-send-email-mikedunn@newsguy.com>
 <201309040020.55029.marex@denx.de> <5227425E.7030806@newsguy.com>
Message-ID: <522745D4.3030601@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 04-09-2013 18:23, Mike Dunn wrote:

>>> +#ifdef CONFIG_OF
>>> +/* use the platform_device id table for OF match table data */
>>> +static struct of_device_id pwm_of_match[] = {
>>> +	{ .compatible = "marvell,pxa25x-pwm", .data = &pwm_id_table[0] },
>>> +	{ .compatible = "marvell,pxa27x-pwm", .data = &pwm_id_table[1] },
>>> +	{ .compatible = "marvell,pxa168-pwm", .data = &pwm_id_table[2] },
>>> +	{ .compatible = "marvell,pxa910-pwm", .data = &pwm_id_table[3] },
>>> +	{ }
>>> +};
>>> +MODULE_DEVICE_TABLE(of, pwm_of_match);

>> Are PXA2xx and PXA3xx PWM impleemntations not all the same ? If so, why not just
>> stick with pxa25x-pwm only for all of the CPUs (aka. the lowest CPU model). Then
>> the table would have but a single entry.

> I'm just echoing the existing platform_device_id table...

> static const struct platform_device_id pwm_id_table[] = {
> 	/*   PWM    has_secondary_pwm? */
> 	{ "pxa25x-pwm", 0 },
> 	{ "pxa27x-pwm", HAS_SECONDARY_PWM },
> 	{ "pxa168-pwm", 0 },
> 	{ "pxa910-pwm", 0 },
> 	{ },
> };
> MODULE_DEVICE_TABLE(platform, pwm_id_table);

    Unlike 'struct platform_device_id', the "compatible" property can't have 
wildcards such as "pxa25x-pwm". You should choose one model (which e.g. was 
produced first in the PXA25x series) and use that.

> Mike

WBR, Sergei
