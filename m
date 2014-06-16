From: d-gerlach@ti.com (Dave Gerlach)
Date: Mon, 16 Jun 2014 15:19:02 -0500
Subject: [PATCH] ARM: OMAP2+: hwmod: Change hardreset soc_ops for AM43XX
In-Reply-To: <alpine.DEB.2.02.1406160441150.26773@utopia.booyaka.com>
References: <1402347553-26029-1-git-send-email-d-gerlach@ti.com>
 <alpine.DEB.2.02.1406160441150.26773@utopia.booyaka.com>
Message-ID: <539F5136.60605@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Paul,

On 06/15/2014 11:43 PM, Paul Walmsley wrote:
> Dave,
>
> On Mon, 9 Jun 2014, Dave Gerlach wrote:
>
>> am43xx reset register layout is more similar to am33xx than omap4 so
>> use the am33xx functions for hwmod hardreset soc_ops rather than the
>> currently used omap4 functions. Without this, assert_hardreset and
>> deassert_hardreset will not work on am43xx.
>>
>> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
>> ---
>>   arch/arm/mach-omap2/omap_hwmod.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
>> index 66c60fe..1c0885b 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod.c
>> @@ -4251,9 +4251,9 @@ void __init omap_hwmod_init(void)
>>   		soc_ops.enable_module = _omap4_enable_module;
>>   		soc_ops.disable_module = _omap4_disable_module;
>>   		soc_ops.wait_target_ready = _omap4_wait_target_ready;
>> -		soc_ops.assert_hardreset = _omap4_assert_hardreset;
>> -		soc_ops.deassert_hardreset = _omap4_deassert_hardreset;
>> -		soc_ops.is_hardreset_asserted = _omap4_is_hardreset_asserted;
>> +		soc_ops.assert_hardreset = _am33xx_assert_hardreset;
>> +		soc_ops.deassert_hardreset = _am33xx_deassert_hardreset;
>> +		soc_ops.is_hardreset_asserted = _am33xx_is_hardreset_asserted;
>>   		soc_ops.init_clkdm = _init_clkdm;
>>   	} else if (soc_is_am33xx()) {
>>   		soc_ops.enable_module = _am33xx_enable_module;
>
> Should AM43XX be using the _am33xx_{enable,disable}_module and
> wait_target_ready functions?

AM43xx has been using the _omap4_{enable,disable}_module functions 
without issue. Nothing is currently using the hardreset ops for am43xx 
which is why it went unnoticed but I saw the issue when I tried to use 
them for the wkup_m3 hwmod and they failed during internal development.

With that said, am43xx clockdomains have prcm_partition defined as part 
of their data which is only used by the _omap4_{enable,disable}_module 
functions and not the _am33xx functions so as the current configuration 
stands the _omap4 variants are the right choice.

Regards,
Dave

>
>
> - Paul
>
