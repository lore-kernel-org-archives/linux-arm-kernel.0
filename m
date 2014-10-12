From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 12 Oct 2014 20:56:56 +0200
Subject: [RFC 4/7] ARM: dts: add support for Vybrid running on Cortex-M4
In-Reply-To: <b3dd902655e9cc4496170a05a907fcce5a687427.1413136383.git.stefan@agner.ch>
References: <cover.1413136383.git.stefan@agner.ch>
 <b3dd902655e9cc4496170a05a907fcce5a687427.1413136383.git.stefan@agner.ch>
Message-ID: <2195665.D7cJPYcoOh@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 12 October 2014 20:13:58 Stefan Agner wrote:
> This adds an initial device tree to run Linux on the Cortex-M4 on
> Vybrid.
> 
> HACK: Because we include armv7-m.dtsi, the soc node happens to
> be before the clock node. This is a problem for vf610-clk.c, which
> tries to optain the fixed clocks defined in the clock nodes. But
> because clock drivers are initialized sequencially, and we do not
> have support for deferred probing, the clock initialization fails
> horrible.

I thought that was fixed recently.

> Move the armv7-m.dtsi include to the bottom to temporarily work
> work around this...
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
> Maybe a dummy soc entry in armv7-m.dtsi also helps here. But a
> hack as well. Is it common acceptable that the kernel depends
> on DTS order?

Generally speaking, the kernel should not rely on the order of
nodes in the dtb.

> diff --git a/arch/arm/boot/dts/vf610m4.dts b/arch/arm/boot/dts/vf610m4.dts
> new file mode 100644
> index 0000000..61488fe
> --- /dev/null
> +++ b/arch/arm/boot/dts/vf610m4.dts
> @@ -0,0 +1,144 @@
> +/*
> + * Device tree for VF610 Cortex-M4 support
> + */
> +
> +/dts-v1/;
> +#include "skeleton.dtsi"
> +#include "vf610-pinfunc.h"
> +#include <dt-bindings/clock/vf610-clock.h>
> +
> +/ {
> +	model = "VF610 Cortex-M4";
> +	compatible = "fsl,vf610m4";
> +
> +	chosen {
> +		bootargs = "console=ttyLP0,115200 ignore_loglevel ihash_entries=64 dhash_entries=64 earlyprintk clk_ignore_unused init=/linuxrc root=/dev/mmcblk0p2 rootwait";
> +	};
> +
> +	memory {
> +		reg = <0x88000000 0x2000000>;
> +	};
> +
> +	aliases {
> +		serial0 = &uart2;
> +	};

All of these are board specific, the common way to handle this is to make
a vf610m4.dtsi file and include that from a v6610m4-myboard.dts file
which sets the properties.

The command line should actually be set by the boot loader.

Also, it would be good to make the uart driver handle the early console
setup through the stdout-path property.

> +
> +	soc {
> +		aips0: aips-bus at 40000000 {
> +			compatible = "fsl,aips-bus", "simple-bus";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			reg = <0x40000000 0x70000>;
> +			ranges;
> +
> +/*
> +			uart0: serial at 40027000 {
> +				compatible = "fsl,vf610-lpuart";
> +				reg = <0x40027000 0x1000>;
> +				interrupts = <61>;
> +				clocks = <&clks VF610_CLK_UART0>;
> +				clock-names = "ipg";
> +				status = "okay";
> +			};
> +
> +			uart1: serial at 40028000 {
> +				compatible = "fsl,vf610-lpuart";
> +				reg = <0x40028000 0x1000>;
> +				interrupts = <62>;
> +				clocks = <&clks VF610_CLK_UART1>;
> +				clock-names = "ipg";
> +				status = "okay";
> +			};
> +*/

Don't comment out nodes, just make them as 'status="disabled"'.

For any peripherals that are accessible to both the m4 and the a5
core, it might be nice to put them into a shared .dtsi file.

	Arnd
