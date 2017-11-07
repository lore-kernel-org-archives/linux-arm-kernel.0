From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 7 Nov 2017 12:05:39 +0100
Subject: [PATCH 1/1] add mali r6p2 dt node
In-Reply-To: <1510049010-5758-1-git-send-email-giulio.benetti@micronovasrl.com>
References: <1510049010-5758-1-git-send-email-giulio.benetti@micronovasrl.com>
Message-ID: <20171107110539.3wrm6uu6ohh6dnuy@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Nov 07, 2017 at 11:03:30AM +0100, Giulio Benetti wrote:
> This patch adds device tree mali node compatible with r6p2 utgard kernel driver 
> provided by ARM and patched by maxime ripard on his github.
> 
> It can be easily used in target.dts with:
> 
> &mali {
> 	status = "okay";
> }
> 
> then loading mali.ko in user space.
> 
> Best regards
> Giulio Benetti
> Micronova srl

Again, you should have a proper commit log here.

Moreover, the DT binding itself doesn't have a dependency on the mali
driver version. This is just a description of the hardware so you
shouldn't mention it.

And there's no need for the status = "okay" in the board DTS, since
you don't disable it in your patch.

> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
> ---
>  arch/arm/boot/dts/sun7i-a20.dtsi | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
> index 228c368..e402596 100644
> --- a/arch/arm/boot/dts/sun7i-a20.dtsi
> +++ b/arch/arm/boot/dts/sun7i-a20.dtsi
> @@ -1216,6 +1216,33 @@
>  			#size-cells = <0>;
>  		};
>  
> +		mali: gpu at 1c40000 {
> +			compatible = "allwinner,sun8i-a23-mali",

This doesn't make any sense. The A23 went out later, and...

> +				     "allwinner,sun7i-a20-mali", "arm,mali-400";

You're actually using the proper compatible already.

> +			reg = <0x01c40000 0x10000>;
> +			interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "gp",
> +					  "gpmmu",
> +					  "pp0",
> +					  "ppmmu0",
> +					  "pp1",
> +					  "ppmmu1",
> +					  "pmu";
> +			clocks = <&ccu CLK_AHB_GPU>, <&ccu CLK_GPU>;
> +			clock-names = "bus", "core";
> +			resets = <&ccu RST_GPU>;
> +			#cooling-cells = <2>;

This isn't needed unless you're using thermal throttling, but in this
case you would also need to add the OPPs.

> +
> +			assigned-clocks = <&ccu CLK_GPU>;
> +			assigned-clock-rates = <381000000>;

And this should be in the driver instead.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171107/f8c0bcd9/attachment-0001.sig>
