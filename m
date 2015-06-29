From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 29 Jun 2015 14:46:51 +0200
Subject: [PATCH 1/3] ARM: at91/soc: add basic support for new sama5d2 SoC
In-Reply-To: <20150618152105.GK27492@piout.net>
References: <cover.1434632966.git.nicolas.ferre@atmel.com>
 <fe6d862c640a3708e80c0cc4c694ab5d9079060b.1434632966.git.nicolas.ferre@atmel.com>
 <20150618152105.GK27492@piout.net>
Message-ID: <55913E3B.6060009@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 18/06/2015 17:21, Alexandre Belloni a ?crit :
> Hi,
> 
> On 18/06/2015 at 15:18:28 +0200, Nicolas Ferre wrote :
>> diff --git a/Documentation/arm/Atmel/README b/Documentation/arm/Atmel/README
>> index c53a19b4aab2..6650a8ffaa64 100644
>> --- a/Documentation/arm/Atmel/README
>> +++ b/Documentation/arm/Atmel/README
>> @@ -90,6 +90,12 @@ the Atmel website: http://www.atmel.com.
>>          + Datasheet
>>            http://www.atmel.com/Images/Atmel-11238-32-bit-Cortex-A5-Microcontroller-SAMA5D4_Datasheet.pdf
>>  
>> +    * ARM Cortex-A5 + NEON based SoCs
>> +      - sama5d2 family
>> +        - sama5d27
>> +        + Datasheet
>> +          Coming soon
> 
> Shouldn't that go directly before or after the sama5d4 family ?

This is "after" sama5d4: I sorted this file according to SoC release
date whereas I sorted the other entries in alpa-numerial order (sama5d2
placed before sama5d3).

Is it what you answered?

>> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
>> index f1b157971366..140228d033c2 100644
>> --- a/arch/arm/Kconfig.debug
>> +++ b/arch/arm/Kconfig.debug
>> @@ -141,6 +141,12 @@ choice
>>  		depends on ARCH_AT91
>>  		depends on SOC_SAMA5
>>  
>> +	config AT91_DEBUG_LL_DBGU3
>> +		bool "Kernel low-level debugging on sama5d2"
>> +		select DEBUG_AT91_UART
>> +		depends on ARCH_AT91
>> +		depends on SOC_SAMA5
>> +
> 
> I think that at some point we'll have to kill those AT91_DEBUG_LL_*
> which are actually board specific and not soc specific. I already have a
> patch for that that I need to rebase.

Ok, it could definitively simplify the last weird bits of our
sub-architecture ;-)


>> diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
>> index 43ec794d1057..e53780a28605 100644
>> --- a/arch/arm/mach-at91/Kconfig
>> +++ b/arch/arm/mach-at91/Kconfig
>> @@ -8,6 +8,18 @@ menuconfig ARCH_AT91
>>  	select SOC_BUS
>>  
>>  if ARCH_AT91
>> +config SOC_SAMA5D2
>> +	bool "SAMA5D2 family" if ARCH_MULTI_V7
>> +	select SOC_SAMA5
>> +	select CACHE_L2X0
>> +	select HAVE_FB_ATMEL
>> +	select HAVE_AT91_UTMI
>> +	select HAVE_AT91_USB_CLK
>> +	select HAVE_AT91_H32MX
>> +	select HAVE_AT91_GENERATED
> 
> Seeing that, I think HAVE_AT91_GENERATED should include CLK somewhere in
> the name as this is only related to clocks.

Absolutely, I changed it to HAVE_AT91_GENERATED_CLK which is somehow
better. Also changed in my "generated clock" series sent to Boris.

Thanks for your review. Bye,
-- 
Nicolas Ferre
