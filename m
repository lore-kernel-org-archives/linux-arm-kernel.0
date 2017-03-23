From: huziji@marvell.com (Ziji Hu)
Date: Thu, 23 Mar 2017 13:32:23 +0800
Subject: [EXT] Re: [PATCH v6 07/14] dt: bindings: Add bindings for Marvell
 Xenon SD Host Controller
In-Reply-To: <CAPDyKFrmb51cTR7B5S0JkmACH0=bw9+28RmWnjwWkuiT7N4wVw@mail.gmail.com>
References: <cover.ff78bebe0384f650a51e5e6f0f1dca6e7894b53b.1487091464.git-series.gregory.clement@free-electrons.com>
 <3a4ce2fd25ed812482b0fc96f50dd305c8f40fe9.1487091464.git-series.gregory.clement@free-electrons.com>
 <CAPDyKFrmb51cTR7B5S0JkmACH0=bw9+28RmWnjwWkuiT7N4wVw@mail.gmail.com>
Message-ID: <c3c97ce1-4aaa-4e85-d2c3-275f5247c0cc@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ulf,

On 2017/3/15 20:48, Ulf Hansson wrote:
> [...]
> 
>> +
>> +Example:
>> +- For eMMC:
>> +
>> +       sdhci at aa0000 {
>> +               compatible = "marvell,armada-ap806-sdhci";
>> +               reg = <0xaa0000 0x1000>;
>> +               interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>
>> +               clocks = <&emmc_clk>;
>> +               clock-names = "core";
>> +               bus-width = <4>;
>> +               marvell,xenon-phy-slow-mode;
>> +               marvell,xenon-tun-count = <11>;
> 
> There's no vmmc-supply here.
> 
> How do you control power to the eMMC card?
> 

	Sorry for the delayed reply.
	Just confirmed with the engineers.

	It seems that there is a regulator.
	I will ask for a complete node example.

>> +
>> +               #address-cells = <1>;
>> +               #size-cells = <0>;
>> +               apm_mmccard: mmccard at 0 {
>> +                       compatible = "mmc-card";
>> +                       reg = <0>;
>> +               };
>> +       };
>> +
>> +- For SD/SDIO:
>> +
>> +       sdhci at ab0000 {
>> +               compatible = "marvell,armada-cp110-sdhci";
>> +               reg = <0xab0000 0x1000>;
>> +               interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>
>> +               vqmmc-supply = <&sd_regulator>;
> 
> I guess you know vqmmc is for the I/O voltage.
> 
> Again, how do you power the SD/SDIO card? No vmmc?

	The vmmc-supply regulator does exist according to the engineer.
	I will ask them to provide a complete one.

> 
>> +               clocks = <&sdclk>;
>> +               clock-names = "core";
>> +               bus-width = <4>;
>> +               marvell,xenon-tun-count = <9>;
>> +       };
>> +
>> +- For eMMC with compatible "marvell,armada-3700-sdhci":
>> +
>> +       sdhci at aa0000 {
>> +               compatible = "marvell,armada-3700-sdhci";
>> +               reg = <0xaa0000 0x1000>,
>> +                     <phy_addr 0x4>;
>> +               interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>
>> +               clocks = <&emmcclk>;
>> +               clock-names = "core";
>> +               bus-width = <8>;
>> +               mmc-ddr-1_8v;
>> +               mmc-hs400-1_8v;
> 
> Again, no vmmc?
> 

	The engineer told me the power to eMMC card is fixed on this platform.
	They don't implement a specific regulator for eMMC core power.

>> +
>> +               marvell,pad-type = "fixed-1-8v";
>> +
>> +               #address-cells = <1>;
>> +               #size-cells = <0>;
>> +               mmccard: mmccard at 0 {
>> +                       compatible = "mmc-card";
>> +                       reg = <0>;
>> +               };
>> +       };
>> +
>> +- For SD/SDIO with compatible "marvell,armada-3700-sdhci":
>> +
>> +       sdhci at ab0000 {
>> +               compatible = "marvell,armada-3700-sdhci";
>> +               reg = <0xab0000 0x1000>,
>> +                     <phy_addr 0x4>;
>> +               interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>
>> +               vqmmc-supply = <&sd_regulator>;
> 
> Again, no vmmc?
> 
	
	It seems that the core power to SD is also fixed.

>> +               clocks = <&sdclk>;
>> +               clock-names = "core";
>> +               bus-width = <4>;
>> +
>> +               marvell,pad-type = "sd";
>> +       };
>> --
>> git-series 0.9.1
> 
> 
> Kind regards
> Uffe
> 
