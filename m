From: robherring2@gmail.com (Rob Herring)
Date: Wed, 11 Jul 2012 12:37:46 -0500
Subject: [PATCH v3] clocksource: dw_apb_timer: Add common DTS glue for
 dw_apb_timer
In-Reply-To: <20120711162058.GA28067@elf.ucw.cz>
References: <1342023144-13945-1-git-send-email-dinguyen@altera.com>
 <20120711162058.GA28067@elf.ucw.cz>
Message-ID: <4FFDB9EA.3000902@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/11/2012 11:20 AM, Pavel Machek wrote:
> Hi!
> 
>> Make a common device tree glue for clocksource/dw_apb_timer.
>> Move mach-picoxcell/time.c to be a generic device tree application
>> of the dw_apb_timer.
>>
>> Configure mach-picoxcell to use the dw_apb_timer_of device tree
>> implementation in drivers/clocksource.
>>
>> Signed-off-by: Pavel Machek <pavel@denx.de>
>> Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
>> Acked-by: Jamie Iles <jamie@jamieiles.com>
> 
> Ok, this is getting complex.
> 
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/rtc/dw-apb.txt
>> @@ -0,0 +1,24 @@
>> +* Designware APB timer
>> +
>> +Required properties:
>> +- compatible: "snps,dw-apb-timer-sp" or "snps,dw-apb-timer-osc"
>> +- reg: physical base address of the controller and length of memory mapped
>> +  region.
>> +- interrupts: IRQ line for the timer.
>> +- clock-frequency: The frequency in HZ of the timer.
> 
> I know device-tree maintainers requested -freq -> -frequency,
>> --- a/arch/arm/mach-picoxcell/time.c
>> +++ b/drivers/clocksource/dw_apb_timer_of.c
> 
> But then this will need updating to accept "-frequency",
> 
>> -static const struct of_device_id picoxcell_timer_ids[] __initconst = {
>> +static const struct of_device_id osctimer_ids[] __initconst = {
>>  	{ .compatible = "picochip,pc3x2-timer" },
>> +	{ .compatible = "snps,dw-apb-timer-osc" },
>>  	{},
>>  };
> 
> and dts will need to be updated, anyway, so we could update
> "picochip,pc3x2-timer" -> "snps,dw-apb-timer-osc" as well, right?
> 
> Alternatively, we could just keep using "-freq"....
> 
> Or am I overlooking something?

If picoxcell is already using "-freq", then yes, you'll have to keep it
for compatibility. You have to assume that a dtb cannot be changed.

Rob
