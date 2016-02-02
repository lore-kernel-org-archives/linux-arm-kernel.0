From: jenskuske@gmail.com (Jens Kuske)
Date: Tue, 2 Feb 2016 18:40:25 +0100
Subject: [linux-sunxi] [PATCH 10/11] arm64: dts: add Allwinner A64 SoC
 .dtsi
In-Reply-To: <56B0DD67.3060802@arm.com>
References: <1454348370-3816-1-git-send-email-andre.przywara@arm.com>
 <1454348370-3816-11-git-send-email-andre.przywara@arm.com>
 <56B0D83E.5090604@gmail.com> <56B0DD67.3060802@arm.com>
Message-ID: <56B0EA09.9030107@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 02/02/16 17:46, Andre Przywara wrote:
> Hi Jens,
> 
> thanks for having such an elaborate look!
> 
> On 02/02/16 16:24, Jens Kuske wrote:
>> Hi,
>>
>> On 01/02/16 18:39, Andre Przywara wrote:
[..]
>>> +
>>> +		/* dummy clock until pll6 can be reused */
>>> +		pll8: pll8_clk {
>>> +			#clock-cells = <0>;
>>> +			compatible = "fixed-clock";
>>> +			clock-frequency = <1>;
>>> +			clock-output-names = "pll8";
>>> +		};
> 
> Since I have you (as the original author ;-) in the loop: What was again
> the reason for this dummy clock? Can't it be modelled with the existing
> clock drivers in Linux?

PLL6 driver had the output name "pll6" hardcoded, so we couldn't reuse
it for "pll8". Maxime has reworked the pll6 code in the meantime, now
pll8 can use compatible = "allwinner,sun6i-a31-pll6-clk" too:
http://www.spinics.net/lists/linux-clk/msg06242.html

>
>>> +
>>> +		cpu: cpu_clk at 01c20050 {
>>> +			#clock-cells = <0>;
>>> +			compatible = "allwinner,sun4i-a10-cpu-clk";
>>> +			reg = <0x01c20050 0x4>;
>>> +			clocks = <&osc32k>, <&osc24M>, <&pll1>, <&pll1>;
>>> +			clock-output-names = "cpu";
>>> +			critical-clocks = <0>;
>>> +		};
>>> +
>>> +		axi: axi_clk at 01c20050 {
>>> +			#clock-cells = <0>;
>>> +			compatible = "allwinner,sun4i-a10-axi-clk";
>>> +			reg = <0x01c20050 0x4>;
>>> +			clocks = <&cpu>;
>>> +			clock-output-names = "axi";
>>> +		};
>>> +
>>> +		ahb1: ahb1_clk at 01c20054 {
>>> +			#clock-cells = <0>;
>>> +			compatible = "allwinner,sun6i-a31-ahb1-clk";
>>> +			reg = <0x01c20054 0x4>;
>>> +			clocks = <&osc32k>, <&osc24M>, <&axi>, <&pll6 0>;
>>> +			clock-output-names = "ahb1";
>>> +		};
>>> +
>>> +		ahb2: ahb2_clk at 01c2005c {
>>> +			#clock-cells = <0>;
>>> +			compatible = "allwinner,sun8i-h3-ahb2-clk";
>>> +			reg = <0x01c2005c 0x4>;
>>> +			clocks = <&ahb1>, <&pll6d2>;
>>> +			clock-output-names = "ahb2";
>>> +		};
>>> +
>>> +		apb1: apb1_clk at 01c20054 {
>>> +			#clock-cells = <0>;
>>> +			compatible = "allwinner,sun4i-a10-apb0-clk";
>>> +			reg = <0x01c20054 0x4>;
>>> +			clocks = <&ahb1>;
>>> +			clock-output-names = "apb1";
>>> +		};
>>> +
>>> +		apb2: apb2_clk at 01c20058 {
>>> +			#clock-cells = <0>;
>>> +			compatible = "allwinner,sun4i-a10-apb1-clk";
>>> +			reg = <0x01c20058 0x4>;
>>> +			clocks = <&osc32k>, <&osc24M>, <&pll6 1>, <&pll6 1>;
>>> +			clock-output-names = "apb2";
>>> +		};
>>> +
>>> +		bus_gates: clk at 01c20060 {
>>> +			#clock-cells = <1>;
>>> +			compatible = "allwinner,a64-bus-gates-clk",
>>> +				     "allwinner,sunxi-multi-bus-gates-clk";
>>> +			reg = <0x01c20060 0x14>;
>>> +			ahb1_parent {
>>> +				clocks = <&ahb1>;
>>> +				clock-indices = <1>, <5>,
>>> +						<6>, <8>,
>>> +						<9>, <10>,
>>> +						<13>, <14>,
>>> +						<18>, <19>,
>>> +						<20>, <21>,
>>> +						<23>, <24>,
>>> +						<25>, <28>,
>>> +						<32>, <35>,
>>> +						<36>, <37>,
>>> +						<40>, <43>,
>>> +						<44>, <52>,
>>> +						<53>, <54>,
>>> +						<135>;
>>> +				clock-output-names = "bus_mipidsi", "bus_ce",
>>> +						"bus_dma", "bus_mmc0",
>>> +						"bus_mmc1", "bus_mmc2",
>>> +						"bus_nand", "bus_sdram",
>>> +						"bus_ts", "bus_hstimer",
>>> +						"bus_spi0", "bus_spi1",
>>> +						"bus_otg", "bus_otg_ehci0",
>>> +						"bus_ehci0", "bus_otg_ohci0",
>>> +						"bus_ve", "bus_lcd0",
>>> +						"bus_lcd1", "bus_deint",
>>> +						"bus_csi", "bus_hdmi",
>>> +						"bus_de", "bus_gpu",
>>> +						"bus_msgbox", "bus_spinlock",
>>> +						"bus_dbg";
>>> +			};
>>> +			ahb2_parent {
>>> +				clocks = <&ahb2>;
>>> +				clock-indices = <17>, <29>;
>>> +				clock-output-names = "bus_gmac", "bus_ohci0";
>>> +			};
>>> +			apb1_parent {
>>> +				clocks = <&apb1>;
>>> +				clock-indices = <64>, <65>,
>>> +						<69>, <72>,
>>> +						<76>, <77>,
>>> +						<78>;
>>> +				clock-output-names = "bus_codec", "bus_spdif",
>>> +						"bus_pio", "bus_ths",
>>> +						"bus_i2s0", "bus_i2s1",
>>> +						"bus_i2s2";
>>> +			};
>>> +			abp2_parent {
>>> +				clocks = <&apb2>;
>>> +				clock-indices = <96>, <97>,
>>> +						<98>, <101>,
>>> +						<112>, <113>,
>>> +						<114>, <115>,
>>> +						<116>;
>>> +				clock-output-names = "bus_i2c0", "bus_i2c1",
>>> +						"bus_i2c2", "bus_scr",
>>> +						"bus_uart0", "bus_uart1",
>>> +						"bus_uart2", "bus_uart3",
>>> +						"bus_uart4";
>>> +			};
>>> +		};
>>> +
>>> +		mmc0_clk: clk at 01c20088 {
>>> +			#clock-cells = <1>;
>>> +			compatible = "allwinner,sun4i-a10-mmc-clk";
>>
>> The A64 MMC clocks don't seem to be fully compatible to A10. The output
>> and sample phase control has been moved to the MMC module itself.
>> The dividers are the same, but the additional special "outputs" are gone.
> 
> So from comparing the H3 and the A64 datasheet I see that this is one of
> the rare deviations of the A64 from the H3?

Yeah, looks like this is new in A64, probably because it supports even
higher card speeds now.

> 
>>> +			reg = <0x01c20088 0x4>;
>>> +			clocks = <&osc24M>, <&pll6 0>, <&pll8>;
>>
>> Parents are PLL6(2x) and PLL8(2x) according to manual.
> 
> Indeed, thanks for pointing this out! So do we need a proper pll8 clock?

The dummy would still work, but it is easy to add a real pll8 now with
Maximes work.

> 
>>
>>> +			clock-output-names = "mmc0",
>>> +					     "mmc0_output",
>>> +					     "mmc0_sample";
>>> +		};
>>> +
>>> +		mmc1_clk: clk at 01c2008c {
>>> +			#clock-cells = <1>;
>>> +			compatible = "allwinner,sun4i-a10-mmc-clk";
>>> +			reg = <0x01c2008c 0x4>;
>>> +			clocks = <&osc24M>, <&pll6 0>, <&pll8>;
>>> +			clock-output-names = "mmc1",
>>> +					     "mmc1_output",
>>> +					     "mmc1_sample";
>>> +		};
>>> +
>>> +		mmc2_clk: clk at 01c20090 {
>>> +			#clock-cells = <1>;
>>> +			compatible = "allwinner,sun4i-a10-mmc-clk";
>>> +			reg = <0x01c20090 0x4>;
>>> +			clocks = <&osc24M>, <&pll6 0>, <&pll8>;
>>> +			clock-output-names = "mmc2",
>>> +					     "mmc2_output",
>>> +					     "mmc2_sample";
>>> +		};
>>> +	};
>>> +
>>> +	regulators {
>>> +		reg_vcc3v3: vcc3v3 {
>>> +			compatible = "regulator-fixed";
>>> +			regulator-name = "vcc3v3";
>>> +			regulator-min-microvolt = <3300000>;
>>> +			regulator-max-microvolt = <3300000>;
>>> +		};
>>> +	};
>>> +
>>> +	soc {
>>> +		compatible = "simple-bus";
>>> +		#address-cells = <1>;
>>> +		#size-cells = <1>;
>>> +		ranges;
>>> +
>>> +		mmc0: mmc at 01c0f000 {
>>> +			compatible = "allwinner,sun5i-a13-mmc";
>>> +			reg = <0x01c0f000 0x1000>;
>>> +			clocks = <&bus_gates 8>,
>>> +				 <&mmc0_clk 0>,
>>
>> Consequently, the MMC driver now has to control the output/sample phase
>> with registers 0x140-0x148 instead of
>>> +				 <&mmc0_clk 1>,
>>> +				 <&mmc0_clk 2>;
> 
> OK, good point. I was just briefly browsing over the register
> descriptions and missed that.
> So it looks like I need to change the driver. Interestingly it seems to
> work anyways ...

I don't know, maybe it has sane defaults or is only relevant at higher
clock speeds. Or Allwinners u-boot already set it.

> 
>> And there seems to be some new clock divider somewhere which I haven't
>> found in the manual yet. The clock measured at the CLK pin is always
>> half the expected rate (even with 24MHz as MMC clock parent, so no
>> PLL6*2 problem).
> 
> Mmh, I heard about that mysterious clock doubling / halving already. Was
> that actually causing any issues?

Since it uses PLL6 * 2 now and seems to divide that by 2 somewhere
nothing has changed in the end. One could argue that pll6 * 2 is wrong,
but by testing with osc24MHz parent (in u-boot) it can be seen that the
clockrate is only half of what is expected.

Disclaimer: I don't know much about mmc, so maybe I've missed something
obvious. I only did some frequency measurements on H3 vs A64 hardware
when Siarhei asked about that in irc and now I wonder about the results.

Jens
