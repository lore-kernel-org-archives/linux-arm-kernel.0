From: olof@lixom.net (Olof Johansson)
Date: Thu, 15 Aug 2013 23:15:00 -0700
Subject: [GIT PULL] ARM: mvebu: driver changes for v3.12
In-Reply-To: <20130814185945.GC13964@titan.lakedaemon.net>
References: <20130814185945.GC13964@titan.lakedaemon.net>
Message-ID: <20130816061500.GE7035@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Aug 14, 2013 at 02:59:45PM -0400, Jason Cooper wrote:
> Arnd, Olof,
> 
> This rather long branch adds the MBus devicetree binding and converts
> everything over to using it.  It's been in -next over a week and should
> be pretty stable.
> 
> Note:  There is a merge conflict with arm-soc/for-next, I've attached the
> resolution after the summary.

Pulled into next/soc.


> diff --cc arch/arm/boot/dts/kirkwood.dtsi
> index 70f414d,1d6921d..6489b98
> --- a/arch/arm/boot/dts/kirkwood.dtsi
> +++ b/arch/arm/boot/dts/kirkwood.dtsi
> @@@ -47,11 -30,30 +40,35 @@@
>   		#address-cells = <1>;
>   		#size-cells = <1>;
>   
> + 		timer: timer at 20300 {
> + 			compatible = "marvell,orion-timer";
> + 			reg = <0x20300 0x20>;
> + 			interrupt-parent = <&bridge_intc>;
> + 			interrupts = <1>, <2>;
> + 			clocks = <&core_clk 0>;
> + 		};
> + 
> + 		intc: main-interrupt-ctrl at 20200 {
> + 			compatible = "marvell,orion-intc";
> + 			interrupt-controller;
> + 			#interrupt-cells = <1>;
> + 			reg = <0x20200 0x10>, <0x20210 0x10>;
> + 		};
> + 
> + 		bridge_intc: bridge-interrupt-ctrl at 20110 {
> + 			compatible = "marvell,orion-bridge-intc";
> + 			interrupt-controller;
> + 			#interrupt-cells = <1>;
> + 			reg = <0x20110 0x8>;
> + 			interrupts = <1>;
> + 			marvell,#interrupts = <6>;
> + 		};
> + 
>  +		mbusc: mbus-controller at 20000 {
>  +			compatible = "marvell,mbus-controller";
>  +			reg = <0x20000 0x80>, <0x1500 0x20>;
>  +		};
>  +
>   		core_clk: core-clocks at 10030 {
>   			compatible = "marvell,kirkwood-core-clock";
>   			reg = <0x10030 0x4>;

This file is a real mess. :( Nothing is sorted properly under the ocp/ bus.
It's common to sort by memory address. Or I'd even take alphabetically if
there was a good reason to do so. Just some order of some kind.

That would have avoided the conflicts this time around, since it seems that
devices are added in completely random order here, but adjacent. If they'd been
spaced out, git would have handled it nicely on its own.


-Olof
