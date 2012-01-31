From: armlinux@emagii.com (ARM Linux)
Date: Tue, 31 Jan 2012 12:08:41 +0100
Subject: [PATCH 3/3] ARM: at91/tc/clocksource: Add 32 bit variant to Timer
 Counter
In-Reply-To: <20120128183101.GE2501@ponder.secretlab.ca>
References: <a311afe3c46da62f7a1e82d2fa933e24ad4eef7e.1326995849.git.nicolas.ferre@atmel.com>
 <d1105b63fce5787a4717ca92ad35397923078e99.1326995849.git.nicolas.ferre@atmel.com>
 <20120128183101.GE2501@ponder.secretlab.ca>
Message-ID: <4F27CBB9.3030409@emagii.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012-01-28 19:31, Grant Likely skrev:
> On Thu, Jan 19, 2012 at 07:05:12PM +0100, Nicolas Ferre wrote:
>> Some SoC have a 32 bit variant of Timer Counter Blocks. We do not
>> need the chaining of two 16 bit counters anymore for them.
>>
>> The SoC nature is deduced from the device tree "compatible" string.
>> For non-device-tree configurations, backward compatibility is maintained
>> by using the default 16 bit counter configuration.
>>
>> This patch addresses both the atmel_tclib and its user: tcb_clksrc
>> clocksource.
>>
>> Signed-off-by: Nicolas Ferre<nicolas.ferre@atmel.com>
> Looks reasonable to me.  One comment below, but otherwise:
>
> Acked-by: Grant Likely<grant.likely@secretlab.ca>
>
>>   static const struct of_device_id atmel_tcb_dt_ids[] = {
>>   	{
>>   		.compatible = "atmel,at91rm9200-tcb",
>> +		.data =&tcb_rm9200_config,
>> +	}, {
>> +		.compatible = "atmel,at91sam9x5-tcb",
>> +		.data =&tcb_sam9x5_config,
>>   	}, {
>>   		/* sentinel */
>>   	}
> Using wildcards ('x') in compatible values is strongly discouraged.
> Use specific device names instead.  You never know when a vendor may
> introduce another part number that fits with the wildcard, but isn't
> actually compatible.
The SAM9x5 is a family of chips based on the same silicon.
* SAM9G15
* SAM9G25
* SAM9G35
* SAM9X25
* SAM9X35

I don't think 'x' is a wildcard, it is part of the name of the family.


There is another chip
* AT91SAM9G45
which is not a sam9x5 chip, even if it would fit, if the 'x' was a wildcard.

BR
ulf at emagii.com


> Use the exact device name(s) and newer devices can claim compatibility
> with the old in the .dts file.
>
> g.
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
