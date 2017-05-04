From: han.xu@nxp.com (Han Xu)
Date: Thu, 4 May 2017 22:59:52 +0000
Subject: [PATCH v2 4/5] ARM: dts: imx7: add GPMI NAND
In-Reply-To: <48b5c543e713f9597b67a39a51ffd521@agner.ch>
References: <20170422012338.4635-1-stefan@agner.ch>
 <20170422012338.4635-5-stefan@agner.ch>
 <c66ca9c8-2a9f-8938-7a70-7f9dfe763457@nxp.com>
 <48b5c543e713f9597b67a39a51ffd521@agner.ch>
Message-ID: <8f039bb6-9bc3-349a-cfe8-727e4caf41de@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 05/04/2017 04:50 PM, Stefan Agner wrote:
> On 2017-05-04 12:13, Han Xu wrote:
>> On 04/21/2017 08:23 PM, Stefan Agner wrote:
>>> Add i.MX 7 GPMI NAND module.
>>>
>>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>>> ---
>>>    arch/arm/boot/dts/imx7s.dtsi | 31 +++++++++++++++++++++++++++++++
>>>    1 file changed, 31 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
>>> index 843eb379e1ea..9645257638d4 100644
>>> --- a/arch/arm/boot/dts/imx7s.dtsi
>>> +++ b/arch/arm/boot/dts/imx7s.dtsi
>>> @@ -995,5 +995,36 @@
>>>    				status = "disabled";
>>>    			};
>>>    		};
>>> +
>>> +		dma_apbh: dma-apbh at 33000000 {
>>> +			compatible = "fsl,imx7d-dma-apbh", "fsl,imx28-dma-apbh";
>>> +			reg = <0x33000000 0x2000>;
>>> +			interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
>>> +				     <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
>>> +				     <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
>>> +				     <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
>>> +			interrupt-names = "gpmi0", "gpmi1", "gpmi2", "gpmi3";
>>> +			#dma-cells = <1>;
>>> +			dma-channels = <4>;
>>> +			clocks = <&clks IMX7D_NAND_USDHC_BUS_ROOT_CLK>,
>>> +				<&clks IMX7D_NAND_ROOT_CLK>;
>>> +			clock-names = "dma_apbh_bch", "dma_apbh_io";
>>> +		};
>> Do you need some patches to enable all clks for APBH DMA? Refer to
>> https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatchwork.ozlabs.org%2Fpatch%2F551967%2F&data=01%7C01%7Chan.xu%40nxp.com%7C98493f7e475341dbf67008d49337b441%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0&sdata=FH9k%2FC4VcVCeyidkRgUJ5Ahu4%2B%2FlDAjXVwO0DY7XMhA%3D&reserved=0
>>
> Oh I see, with the current code and this device tree we actually only
> enable the first clock... But it seems to work in practice...
>
> What is interesting, the chapter 5.2.5 System Clocks only describes
> APBHDMA, and no GPMI module.
>
> Chapter 9.4 about APBH-Bridge-DMA bridge only specifies "hclk" as clock
> sources.
>
> When looking at the table in chapter 5.2.5, hclk is
> NAND_USDHC_BUS_CLK_ROOT
>
> Module    Syste Module Clock   Clock Root
> APBHDMA   apbhdma.hclk         NAND_USDHC_BUS_CLK_ROOT
>   
> So my guess is that the actual DMA controller should work fine with
> IMX7D_NAND_USDHC_BUS_ROOT_CLK only. It is only the GPMI module which
> needs the NAND_ROOT_CLK. My guess is since the APBHDMA controller is
> only used for GPMI these days, it has been combined in one module in the
> table in chapter 5.2.5.
>
> So we could actually only specify:
>
> clocks = <&clks IMX7D_NAND_USDHC_BUS_ROOT_CLK>;
>
> Tested with this and NAND seems to work fine.
>
> Also tested accessing APBHDMA register in U-Boot with
> IMX7D_NAND_ROOT_CLK disabled, it worked fine.
>
> What do you think? Should we go with this?
>
> This probably even saves power since GPMI's runtime clock management
> disables IMX7D_NAND_ROOT_CLK when NAND is idle (according to the
> nand_root_clk counter in clk_summary and the root clock register at
> 0x3038AA00).

It also surprised me how it can work on your side, I remember we made 
the code change for some purpose, please give me some time I can check 
if the doc is wrong.

> --
> Stefan
>
>>> +
>>> +		gpmi: gpmi-nand at 33002000{
>>> +			compatible = "fsl,imx7d-gpmi-nand";
>>> +			#address-cells = <1>;
>>> +			#size-cells = <1>;
>>> +			reg = <0x33002000 0x2000>, <0x33004000 0x4000>;
>>> +			reg-names = "gpmi-nand", "bch";
>>> +			interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
>>> +			interrupt-names = "bch";
>>> +			clocks = <&clks IMX7D_NAND_ROOT_CLK>,
>>> +				<&clks IMX7D_NAND_USDHC_BUS_ROOT_CLK>;
>>> +			clock-names = "gpmi_io", "gpmi_bch_apb";
>>> +			dmas = <&dma_apbh 0>;
>>> +			dma-names = "rx-tx";
>>> +			status = "disabled";
>>> +		};
>>>    	};
>>>    };
