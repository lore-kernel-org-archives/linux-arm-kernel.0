From: jingchang.lu@freescale.com (Jingchang Lu)
Date: Wed, 27 Aug 2014 02:19:10 +0000
Subject: [RESEND] clk: ppc-corenet: Add Freescale ARM-based platforms
 CLK_OF_DECLARE support
In-Reply-To: <1409093463.6510.92.camel@snotra.buserror.net>
References: <1408700096-25415-1-git-send-email-jingchang.lu@freescale.com>
 <1409093463.6510.92.camel@snotra.buserror.net>
Message-ID: <164af7b3be3747a0be3fe3a6cf83d3b1@BL2PR03MB467.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>-----Original Message-----
>From: Wood Scott-B07421
>Sent: Wednesday, August 27, 2014 6:51 AM
>To: Lu Jingchang-B35083
>Cc: mturquette at linaro.org; linuxppc-dev at lists.ozlabs.org; linux-
>kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org
>Subject: Re: [RESEND] clk: ppc-corenet: Add Freescale ARM-based platforms
>CLK_OF_DECLARE support
>
>On Fri, 2014-08-22 at 17:34 +0800, Jingchang Lu wrote:
>> Signed-off-by: Jingchang Lu <jingchang.lu@freescale.com>
>> ---
>>  drivers/clk/Kconfig           | 7 ++++---
>>  drivers/clk/clk-ppc-corenet.c | 5 +++++
>>  2 files changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
>> index cfd3af7..8784704 100644
>> --- a/drivers/clk/Kconfig
>> +++ b/drivers/clk/Kconfig
>> @@ -82,11 +82,12 @@ config COMMON_CLK_AXI_CLKGEN
>>  	  FPGAs. It is commonly used in Analog Devices' reference designs.
>>
>>  config CLK_PPC_CORENET
>> -	bool "Clock driver for PowerPC corenet platforms"
>> -	depends on PPC_E500MC && OF
>> +	bool "Clock driver for PowerPC corenet and compatible ARM-based
>platforms"
>> +	depends on (PPC_E500MC || ARM) && OF
>
>Should the symbol and driver be renamed to something like CLK_FSL_QORIQ?
>
This name is better for sharing on ARM and PowerPC, I will rename them. Thanks.

>> diff --git a/drivers/clk/clk-ppc-corenet.c b/drivers/clk/clk-ppc-
>corenet.c
>> index 8e58edf..7692cac 100644
>> --- a/drivers/clk/clk-ppc-corenet.c
>> +++ b/drivers/clk/clk-ppc-corenet.c
>> @@ -305,3 +305,8 @@ static int __init ppc_corenet_clk_init(void)
>>  	return platform_driver_register(&ppc_corenet_clk_driver);
>>  }
>>  subsys_initcall(ppc_corenet_clk_init);
>> +
>> +CLK_OF_DECLARE(ppc_core_pll_v1, "fsl,qoriq-core-pll-1.0",
>core_pll_init);
>> +CLK_OF_DECLARE(ppc_core_pll_v2, "fsl,qoriq-core-pll-2.0",
>core_pll_init);
>> +CLK_OF_DECLARE(ppc_core_mux_v1, "fsl,qoriq-core-mux-1.0",
>core_mux_init);
>> +CLK_OF_DECLARE(ppc_core_mux_v2, "fsl,qoriq-core-mux-2.0",
>core_mux_init);
>
>What does this do that the existing platform driver and match table
>don't?  Why is it needed for ARM when PPC didn't need it?
>
>-Scott
>
Common clk init on ARM platform is initialized earlier via of_clk_init() instead of
driver probe method, the of_clk_init will walk a __clk_of_table to init each clk provider
in the table, the CLK_OF_DECLARE() macro puts a supported clk in the __clk_of_table for
it initializing on starup, and the clk system has added some common clk such as "fixed-clk"
to this table already.
So here I add our specific clk init declaration to consist this framework, and the driver
probe function will not be needed on ARM.



Best Regards,
Jingchang
