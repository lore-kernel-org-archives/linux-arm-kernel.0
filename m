From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 13 Oct 2014 11:32:20 +0100
Subject: [RFC 4/7] ARM: dts: add support for Vybrid running on Cortex-M4
In-Reply-To: <b3dd902655e9cc4496170a05a907fcce5a687427.1413136383.git.stefan@agner.ch>
References: <cover.1413136383.git.stefan@agner.ch>
 <b3dd902655e9cc4496170a05a907fcce5a687427.1413136383.git.stefan@agner.ch>
Message-ID: <20141013103219.GE14739@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 12, 2014 at 07:13:58PM +0100, Stefan Agner wrote:
> This adds an initial device tree to run Linux on the Cortex-M4 on
> Vybrid.
> 
> HACK: Because we include armv7-m.dtsi, the soc node happens to
> be before the clock node. This is a problem for vf610-clk.c, which
> tries to optain the fixed clocks defined in the clock nodes. But
> because clock drivers are initialized sequencially, and we do not
> have support for deferred probing, the clock initialization fails
> horrible.
> Move the armv7-m.dtsi include to the bottom to temporarily work
> work around this...
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
> Maybe a dummy soc entry in armv7-m.dtsi also helps here. But a
> hack as well. Is it common acceptable that the kernel depends
> on DTS order?

The kernel should not depend on DTS ordering. We should sort out
deferred probing if there is an issue with it.

[...]

> +	clocks {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		sxosc {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <32768>;
> +		};
> +
> +		fxosc {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <24000000>;
> +		};
> +	};

Please get rid of the clocks node and put these under the root node.
There is nothing special about clocks, and the kernel in no way handles
a clocks node specially.

> +
> +	soc {
> +		aips0: aips-bus at 40000000 {
> +			compatible = "fsl,aips-bus", "simple-bus";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			reg = <0x40000000 0x70000>;

Out of curiosity, given that this can be driven as a simple-bus, what do
the aips bus registers allow to be configured?

Thanks,
Mark.
