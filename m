From: icenowy@aosc.io (icenowy at aosc.io)
Date: Wed, 17 May 2017 17:32:15 +0800
Subject: [PATCH v7 11/13] ARM: sun8i: v3s: add device nodes for DE2
 display pipeline
In-Reply-To: <45e3b368b80fb74f33b18afcc3f783c5@aosc.io>
References: <20170514163045.40366-1-icenowy@aosc.io>
 <20170514163045.40366-12-icenowy@aosc.io>
 <20170515092400.nzxmocrdqgt4u476@flea.home>
 <45e3b368b80fb74f33b18afcc3f783c5@aosc.io>
Message-ID: <8c191ed093f97c60a1c758cc219ea63b@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2017-05-17 17:27?icenowy at aosc.io ???
> ? 2017-05-15 17:24?Maxime Ripard ???
>> On Mon, May 15, 2017 at 12:30:43AM +0800, Icenowy Zheng wrote:
>>> +		de2_clocks: clock at 1000000 {
>> 
>> display_clocks would be better there, we don't have to dissociate de1
>> with de2
> 
> How about de_clocks ? (See A80 DTSI)

Oh I regretted... de here indicates "de1".

display_clocks is better.

> 
>> 
>>> +			compatible = "allwinner,sun8i-v3s-de2-clk";
>>> +			reg = <0x01000000 0x100000>;
>>> +			clocks = <&ccu CLK_DE>,
>>> +				 <&ccu CLK_BUS_DE>;
>>> +			clock-names = "mod",
>>> +				      "bus";
>>> +			resets = <&ccu RST_BUS_DE>;
>>> +			#clock-cells = <1>;
>>> +			#reset-cells = <1>;
>>> +		};
>>> +
>>> +		de2_mixer0: mixer at 1100000 {
>> 
>> and mixer0 here is enough too.
>> 
>> Is there several of them? Why not just use mixer if there's only one?
> 
> Nope, here it's tagged 0 only for consistency with other SoCs.
> 
>> 
>>> +			compatible = "allwinner,sun8i-v3s-de2-mixer";
>>> +			reg = <0x01100000 0x100000>;
>>> +			clocks = <&de2_clocks CLK_MIXER0>,
>>> +				 <&de2_clocks CLK_BUS_MIXER0>;
>>> +			clock-names = "mod",
>>> +				      "bus";
>>> +			resets = <&de2_clocks RST_MIXER0>;
>>> +			assigned-clocks = <&de2_clocks CLK_MIXER0>;
>>> +			assigned-clock-rates = <150000000>;
>>> +
>>> +			ports {
>>> +				#address-cells = <1>;
>>> +				#size-cells = <0>;
>>> +
>>> +				mixer0_out: port at 1 {
>>> +					#address-cells = <1>;
>>> +					#size-cells = <0>;
>>> +					reg = <1>;
>>> +
>>> +					mixer0_out_tcon0: endpoint at 0 {
>>> +						reg = <0>;
>>> +						remote-endpoint = <&tcon0_in_mixer0>;
>>> +					};
>>> +				};
>>> +			};
>>> +		};
>>> +
>>> +		tcon0: lcd-controller at 1c0c000 {
>>> +			compatible = "allwinner,sun8i-v3s-tcon";
>>> +			reg = <0x01c0c000 0x1000>;
>>> +			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
>>> +			clocks = <&ccu CLK_BUS_TCON0>,
>>> +				 <&ccu CLK_TCON0>;
>>> +			clock-names = "ahb",
>>> +				      "tcon-ch0";
>>> +			clock-output-names = "tcon-pixel-clock";
>>> +			resets = <&ccu RST_BUS_TCON0>;
>>> +			reset-names = "lcd";
>>> +			status = "disabled";
>>> +
>>> +			ports {
>>> +				#address-cells = <1>;
>>> +				#size-cells = <0>;
>>> +
>>> +				tcon0_in: port at 0 {
>>> +					#address-cells = <1>;
>>> +					#size-cells = <0>;
>>> +					reg = <0>;
>>> +
>>> +					tcon0_in_mixer0: endpoint at 0 {
>>> +						reg = <0>;
>>> +						remote-endpoint = <&mixer0_out_tcon0>;
>>> +					};
>>> +				};
>>> +
>>> +				tcon0_out: port at 1 {
>>> +					#address-cells = <1>;
>>> +					#size-cells = <0>;
>>> +					reg = <1>;
>>> +				};
>>> +			};
>>> +		};
>>> +
>>> +
>> 
>> You have an extra new line here.
>> 
>> Maxime
