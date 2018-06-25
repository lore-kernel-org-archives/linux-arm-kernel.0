From: icenowy@aosc.io (Icenowy Zheng)
Date: Mon, 25 Jun 2018 23:59:37 +0800
Subject: [PATCH v2 3/7] bus: add bus driver for accessing Allwinner A64 DE2
In-Reply-To: <20180625155805.kds7bl3cburblwv6@flea>
References: <20180622124540.56203-1-icenowy@aosc.io>
 <20180622124540.56203-2-icenowy@aosc.io>
 <20180625155805.kds7bl3cburblwv6@flea>
Message-ID: <4DFADAD6-3E17-425F-8B03-CAC4402BF14F@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2018?6?25? GMT+08:00 ??11:58:05, Maxime Ripard <maxime.ripard@bootlin.com> ??:
>On Fri, Jun 22, 2018 at 08:45:36PM +0800, Icenowy Zheng wrote:
>> The "Display Engine 2.0" (usually called DE2) on the Allwinner A64
>SoC
>> is different from the ones on other Allwinner SoCs. It requires a
>SRAM
>> region to be claimed, otherwise all DE2 subblocks won't be
>accessible.
>> 
>> Add a bus driver for the Allwinner A64 DE2 part which claims the SRAM
>> region when probing.
>> 
>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>> ---
>> No changes since v1.
>> 
>>  drivers/bus/Kconfig      | 10 ++++++++
>>  drivers/bus/Makefile     |  1 +
>>  drivers/bus/sun50i-de2.c | 49
>++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 60 insertions(+)
>>  create mode 100644 drivers/bus/sun50i-de2.c
>> 
>> diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
>> index d1c0b60e9326..1851112ccc29 100644
>> --- a/drivers/bus/Kconfig
>> +++ b/drivers/bus/Kconfig
>> @@ -103,6 +103,16 @@ config SIMPLE_PM_BUS
>>  	  Controller (BSC, sometimes called "LBSC within Bus Bridge", or
>>  	  "External Bus Interface") as found on several Renesas ARM SoCs.
>>  
>> +config SUN50I_DE2_BUS
>> +	bool "Allwinner A64 DE2 Bus Driver"
>> +	  default ARM64
>> +	  depends on ARCH_SUNXI
>> +	  select SUNXI_SRAM
>> +	  help
>
>The alignment here should be one tab.
>
>> +static int sun50i_de2_bus_probe(struct platform_device *pdev)
>> +{
>> +	struct device_node *np = pdev->dev.of_node;
>> +	int ret;
>> +
>> +	ret = sunxi_sram_claim(&pdev->dev);
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "Error couldn't map SRAM to device\n");
>> +		return ret;
>> +	}
>> +
>> +	if (np)
>> +		of_platform_populate(np, NULL, NULL, &pdev->dev);
>
>Why do you need to test np here?

Oh thanks. Currently it's only probeable via dt.

>
>Maxime
