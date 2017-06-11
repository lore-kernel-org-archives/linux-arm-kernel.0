From: icenowy@aosc.io (icenowy at aosc.io)
Date: Sun, 11 Jun 2017 14:58:47 +0800
Subject: [linux-sunxi] Re: [PATCH v2 10/11] ARM: sun8i: h3: add display
 engine pipeline for TVE
In-Reply-To: <20170607094241.65dcm42aacrn4eev@flea.lan>
References: <20170604160149.30230-1-icenowy@aosc.io>
 <20170604160149.30230-11-icenowy@aosc.io>
 <20170607094241.65dcm42aacrn4eev@flea.lan>
Message-ID: <87bf6e8c54286fd0630bd876ec0c6c56@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2017-06-07 17:42?Maxime Ripard ???
> On Mon, Jun 05, 2017 at 12:01:48AM +0800, Icenowy Zheng wrote:
>> +	soc {
>> +		display_clocks: clock at 1000000 {
>> +			compatible = "allwinner,sun8i-a83t-de2-clk";
>> +			reg = <0x01000000 0x100000>;
>> +			clocks = <&ccu CLK_BUS_DE>,
>> +				 <&ccu CLK_DE>;
>> +			clock-names = "bus",
>> +				      "mod";
>> +			resets = <&ccu RST_BUS_DE>;
>> +			#clock-cells = <1>;
>> +			#reset-cells = <1>;
>> +			assigned-clocks = <&ccu CLK_DE>;
>> +			assigned-clock-parents = <&ccu CLK_PLL_DE>;
>> +			assigned-clock-rates = <432000000>;
>> +		};
> 
> We discussed that already a few times, but there's no reason to do
> so. If you need a downstream clock at a particular rate, call
> clk_set_rate on it, period.
> 
> Whether its parent will be coming from PLL_DE or some other more
> appriopriate clock is not relevant and doesn't make any difference.

The clock framework is not so smart to deal with these infomations:
- CLK_PLL_PERIPH should always be 600MHz
- CLK_TVE should always be 216MHz
- CLK_DE (in fact CLK_MIXER{0,1}) should be larger than 300MHz (for 4K)

So we have to specify CLK_DE to be 432MHz, and then it will set
CLK_PLL_DE to this value, then the CLK_TVE can be set to 216MHz with
divider 2.

For DE there's no a real hardware block clock requirement, set it to
> =300MHz is for 4K output support.

> 
> Maxime
> 
> --
> Maxime Ripard, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
