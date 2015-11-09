From: afd@ti.com (Andrew F. Davis)
Date: Mon, 9 Nov 2015 15:23:22 -0600
Subject: [PATCH] power: bq27xxx_battery: Revert "Remove unneeded
 dependency in Kconfig"
In-Reply-To: <10870776.N30IekZOBt@wuerfel>
References: <3819790.E2ziFviWmU@wuerfel> <5640D02D.6040601@ti.com>
 <10870776.N30IekZOBt@wuerfel>
Message-ID: <56410ECA.7050109@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/09/2015 02:51 PM, Arnd Bergmann wrote:
> On Monday 09 November 2015 10:56:13 Andrew F. Davis wrote:
>> On 11/09/2015 07:50 AM, Arnd Bergmann wrote:
>> Nothing enabled by BATTERY_BQ27XXX depends on I2C, this workaround is not
>> correct as it prevents BATTERY_BQ27XXX from being built-in when I2C is a
>> module, there is no reason for this limitation.
>>
>> The undefined references are caused by BATTERY_BQ27XXX being built-in AND
>> its I2C functionality being enabled (BATTERY_BQ27XXX_I2C) while I2C is a
>> module. Reorganizing this driver is being discussed anyway, but in the
>> meantime a more correct fix would be along the lines of:
>>
>> diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
>> index 6de6ec2..d1d32f9 100644
>> --- a/drivers/power/Kconfig
>> +++ b/drivers/power/Kconfig
>> @@ -167,6 +167,7 @@ config BATTERY_BQ27XXX_I2C
>>           bool "BQ27xxx I2C support"
>>           depends on BATTERY_BQ27XXX
>>           depends on I2C
>> +       depends on !(I2C=m && BATTERY_BQ27XXX=y)
>>           default y
>>           help
>>             Say Y here to enable support for batteries with BQ27xxx (I2C) chips.
>
> That works too, there is just very little difference in the end here,
> and it's easier to revert an patch that only introduces a regression
> than to do a different hack, especially if it's going to be reworked
> soon anyway.
>
> Do you want to submit the above as a fixup to your other patch or
> should we just do the revert? It would be good to get one of the two
> into -rc1.
>

I can just submit this fix, it would probably be better for the short term
until the rework is done.

Andrew
