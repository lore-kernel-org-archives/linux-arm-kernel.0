From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 9 Feb 2016 23:25:33 +0300
Subject: [PATCH 5/5] ARM: dts: r8a7794 add sound support
In-Reply-To: <20160209195054.GA14008@verge.net.au>
References: <4253511.vvGjIdOnb6@wasted.cogentembedded.com>
 <2179456.HznTXDfKhZ@wasted.cogentembedded.com>
 <20160209195054.GA14008@verge.net.au>
Message-ID: <56BA4B3D.1030301@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 02/09/2016 10:50 PM, Simon Horman wrote:

>> Define the generic R8A7794 part of  the sound device node.
>> This sound device  is a complex one and comprises the Audio Clock Generator
>> (ADG), Sampling Rate Converter Unit (SCU), Serial Sound Interface [Unit]
>> (SSI[U]), and Audio DMAC-Peripheral-Peripheral.
>> It is up  to the board file to enable the device.
>>
>> This patch is based on the R8A7791 sound work by Kuninori Morimoto.
>>
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>>
>> ---
>>   arch/arm/boot/dts/r8a7794.dtsi |  171 +++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 171 insertions(+)
>>
>> Index: renesas/arch/arm/boot/dts/r8a7794.dtsi
>> ===================================================================
>> --- renesas.orig/arch/arm/boot/dts/r8a7794.dtsi
>> +++ renesas/arch/arm/boot/dts/r8a7794.dtsi
>> @@ -1309,4 +1309,175 @@
>>   		#iommu-cells = <1>;
>>   		status = "disabled";
>>   	};
>> +
>> +	rcar_sound: sound at ec500000 {
>> +		/*
>> +		 * #sound-dai-cells is required
>> +		 *
>> +		 * Single DAI : #sound-dai-cells = <0>;         <&rcar_sound>;
>> +		 * Multi  DAI : #sound-dai-cells = <1>;         <&rcar_sound N>;
>> +		 */
>> +		compatible = "renesas,rcar_sound-r8a7794",
>> +			     "renesas,rcar_sound-gen2";
>> +		reg =	<0 0xec500000 0 0x1000>, /* SCU */
>> +			<0 0xec5a0000 0 0x100>,  /* ADG */
>> +			<0 0xec540000 0 0x1000>, /* SSIU */
>> +			<0 0xec541000 0 0x280>,  /* SSI */
>> +			<0 0xec740000 0 0x200>;  /* Audio DMAC peri peri */
>> +		reg-names = "scu", "adg", "ssiu", "ssi", "audmapp";
>> +
>> +		clocks = <&mstp10_clks R8A7794_CLK_SSI_ALL>,
>> +			 <&mstp10_clks R8A7794_CLK_SSI9>,
>> +			 <&mstp10_clks R8A7794_CLK_SSI8>,
>> +			 <&mstp10_clks R8A7794_CLK_SSI7>,
>> +			 <&mstp10_clks R8A7794_CLK_SSI6>,
>> +			 <&mstp10_clks R8A7794_CLK_SSI5>,
>> +			 <&mstp10_clks R8A7794_CLK_SSI4>,
>> +			 <&mstp10_clks R8A7794_CLK_SSI3>,
>> +			 <&mstp10_clks R8A7794_CLK_SSI2>,
>> +			 <&mstp10_clks R8A7794_CLK_SSI1>,
>> +			 <&mstp10_clks R8A7794_CLK_SSI0>,
>> +			 <&mstp10_clks R8A7794_CLK_SCU_SRC9>,
>> +			 <&mstp10_clks R8A7794_CLK_SCU_SRC8>,
>> +			 <&mstp10_clks R8A7794_CLK_SCU_SRC7>,
>> +			 <&mstp10_clks R8A7794_CLK_SCU_SRC6>,
>> +			 <&mstp10_clks R8A7794_CLK_SCU_SRC5>,
>> +			 <&mstp10_clks R8A7794_CLK_SCU_SRC4>,
>> +			 <&mstp10_clks R8A7794_CLK_SCU_SRC3>,
>> +			 <&mstp10_clks R8A7794_CLK_SCU_SRC2>,
>> +			 <&mstp10_clks R8A7794_CLK_SCU_SRC1>,
>> +			 <&mstp10_clks R8A7794_CLK_SCU_SRC0>,
>> +			 <&mstp10_clks R8A7794_CLK_SCU_CTU0_MIX0>,
>> +			 <&mstp10_clks R8A7794_CLK_SCU_CTU1_MIX1>,
>> +			 <&mstp10_clks R8A7794_CLK_SCU_CTU0_MIX0>,
>> +			 <&mstp10_clks R8A7794_CLK_SCU_CTU1_MIX1>,
>> +			 <&mstp10_clks R8A7794_CLK_SCU_DVC0>,
>> +			 <&mstp10_clks R8A7794_CLK_SCU_DVC1>,
>> +			 <&audio_clka>, <&audio_clkb>, <&audio_clkc>,
>> +			 <&m2_clk>;
>> +		clock-names = "ssi-all",
>> +			      "ssi.9", "ssi.8", "ssi.7", "ssi.6", "ssi.5",
>> +			      "ssi.4", "ssi.3", "ssi.2", "ssi.1", "ssi.0",
>> +			      "src.9", "src.8", "src.7", "src.6", "src.5",
>> +			      "src.4", "src.3", "src.2", "src.1", "src.0",
>> +			      "clk_a", "clk_b", "clk_c", "clk_i";
>> +		power-domains = <&cpg_clocks>;
>> +
>> +		status = "disabled";
>> +		rcar_sound,src {
>> +			src0: src at 0 {
>> +				interrupts = <GIC_SPI 352 IRQ_TYPE_LEVEL_HIGH>;
>> +				dmas = <&audma0 0x85>, <&audma0 0x9a>;
>> +				dma-names = "rx", "tx";
>> +			};
>> +			src1: src at 1 {
>> +				interrupts = <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>;
>> +				dmas = <&audma0 0x87>, <&audma0 0x9c>;
>> +				dma-names = "rx", "tx";
>> +			};
>> +			src2: src at 2 {
>> +				interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
>> +				dmas = <&audma0 0x89>, <&audma0 0x9e>;
>> +				dma-names = "rx", "tx";
>> +			};
>> +			src3: src at 3 {
>> +				interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
>> +				dmas = <&audma0 0x8b>, <&audma0 0xa0>;
>> +				dma-names = "rx", "tx";
>> +			};
>> +			src4: src at 4 {
>> +				interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
>> +				dmas = <&audma0 0x8d>, <&audma0 0xb0>;
>> +				dma-names = "rx", "tx";
>> +			};
>> +			src5: src at 5 {
>> +				interrupts = <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
>> +				dmas = <&audma0 0x8f>, <&audma0 0xb2>;
>> +				dma-names = "rx", "tx";
>> +			};
>> +			src6: src at 6 {
>> +				interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
>> +				dmas = <&audma0 0x91>, <&audma0 0xb4>;
>> +				dma-names = "rx", "tx";
>> +			};
>> +			src7: src at 7 {
>> +				interrupts = <GIC_SPI 359 IRQ_TYPE_LEVEL_HIGH>;
>> +				dmas = <&audma0 0x93>, <&audma0 0xb6>;
>> +				dma-names = "rx", "tx";
>> +			};
>> +			src8: src at 8 {
>> +				interrupts = <GIC_SPI 360 IRQ_TYPE_LEVEL_HIGH>;
>> +				dmas = <&audma0 0x95>, <&audma0 0xb8>;
>> +				dma-names = "rx", "tx";
>> +			};
>> +			src9: src at 9 {
>> +				interrupts = <GIC_SPI 361 IRQ_TYPE_LEVEL_HIGH>;
>> +				dmas = <&audma0 0x97>, <&audma0 0xba>;
>> +				dma-names = "rx", "tx";
>> +			};
>> +		};

> My reading of the documentation is that src0, 7, 8 and 9 are not
> present on the r8a7794. I am referring to Figure 38.1b or r1.02 of
> the R-Car Gen2 User's Manual.

    Indeed, thank you for the timely comment (I'm working on the series 
respin)! However, table 7A.12 still lists the SRC0/7/8/9 clocks for R8A7794, 
table 11.1 still lists SRC0/7/8/9 interrupts for R8A7794, and table 43.4 still 
lists SRC0/7/8/9 MID+RID for R8A7794 -- go figure...

> [snip]

MBR, Sergei
