From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 06 Jan 2012 14:36:42 +0100
Subject: [PATCH v3] ARM: at91: pit add DT support
In-Reply-To: <4F05D2F3.40704@gmail.com>
References: <1325771308-19770-1-git-send-email-nicolas.ferre@atmel.com>
 <1325784348-29481-1-git-send-email-nicolas.ferre@atmel.com>
 <4F05D2F3.40704@gmail.com>
Message-ID: <4F06F8EA.30104@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/05/2012 05:42 PM, Rob Herring :
> On 01/05/2012 11:25 AM, Nicolas Ferre wrote:
>> From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
>>
>> Retreive registers address and IRQ from device tree entry. Fall back
>> to built-in values if an error occurs.
>>
>> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
>> [nicolas.ferre at atmel.com: change error path and interrupts property handling]
>> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>> ---
>> v3: - use irq_of_parse_and_map() for handling irq numbers specified by DT.
>>       Correction proposed by Jamie Iles.
>>
>> v2: - new specification of irq numbers in DT (due to modification of AIC code)
>>     - new error path in of_at91sam926x_pit_init()
>>     - fall back to built-in values if an error occurs
>>     - use of of_property_read_u32() to get irq property
>>
>>  .../devicetree/bindings/arm/atmel-at91.txt         |    8 +++
>>  arch/arm/boot/dts/at91sam9g20.dtsi                 |    5 ++
>>  arch/arm/boot/dts/at91sam9g45.dtsi                 |    6 ++
>>  arch/arm/mach-at91/at91sam926x_time.c              |   53 +++++++++++++++++++-
>>  4 files changed, 70 insertions(+), 2 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/arm/atmel-at91.txt

[..]

>> --- a/arch/arm/mach-at91/at91sam926x_time.c
>> +++ b/arch/arm/mach-at91/at91sam926x_time.c

[..]

>>  void __init at91sam926x_ioremap_pit(u32 addr)
>>  {
>> +	if (!of_at91sam926x_pit_init())
>> +		return;
> 
> This seems backwards to me. I don't have the ioremap changes in my tree,
> but shouldn't the caller of at91sam926x_ioremap_pit be changed to
> something like this:
> 
> 	if (of_at91sam926x_pit_init() < 0)
> 		at91sam926x_ioremap_pit(addr);

Yes, you are right, it will be more readable the other way around.

I repost another revision now.

> Otherwise,
> Acked-by: Rob Herring <rob.herring@calxeda.com>

Thanks for your review.

Best regards,
-- 
Nicolas Ferre
