From: icenowy@aosc.io (icenowy at aosc.io)
Date: Fri, 28 Apr 2017 02:14:58 +0800
Subject: [PATCH v5 01/10] arm64: allwinner: a64: enable RSB on A64
In-Reply-To: <20170427132805.izv6xfktlhfc4yty@lukather>
References: <20170426152023.41567-1-icenowy@aosc.io>
 <20170426152023.41567-2-icenowy@aosc.io>
 <20170427132805.izv6xfktlhfc4yty@lukather>
Message-ID: <4f910cd7ab972c1b6d93b0327833b596@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2017-04-27 21:28?Maxime Ripard ???
> On Wed, Apr 26, 2017 at 11:20:14PM +0800, Icenowy Zheng wrote:
>> Allwinner A64 have a RSB controller like the one on A23/A33 SoCs.
>> 
>> Add it and its pinmux.
>> 
>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>> Acked-by: Chen-Yu Tsai <wens@csie.org>
>> ---
>> Changes in v2:
>> - Removed bonus properties in pio node.
>> - Added Chen-Yu's ACK.
>> 
>>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 19 
>> +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>> 
>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi 
>> b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
>> index c7f669f5884f..05ec9fc5e81f 100644
>> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
>> @@ -422,6 +422,25 @@
>>  			#gpio-cells = <3>;
>>  			interrupt-controller;
>>  			#interrupt-cells = <3>;
>> +
>> +			r_rsb_pins: rsb at 0 {
>> +				pins = "PL0", "PL1";
>> +				function = "s_rsb";
>> +			};
>> +		};
>> +
>> +		r_rsb: rsb at 1f03400 {
>> +			compatible = "allwinner,sun8i-a23-rsb";
>> +			reg = <0x01f03400 0x400>;
>> +			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&r_ccu 6>;
> 
> Please use the defines here..

Linux-4.12 doesn't yet enter rc1, and the defines are still not in
Linus's tree.

Please note that I have already mentioned that this patch is necessary
to be merged into 4.12, otherwise poweroff won't work properly at 4.12 .

So I think it shouldn't still use defines.

I will fix here after 4.12-rc1 is out, along with other r_ccu
usages.

> 
>> +			clock-frequency = <3000000>;
>> +			resets = <&r_ccu 2>;
> 
> And here.
> 
> Thanks!
> Maxime
