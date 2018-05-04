From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 4 May 2018 16:27:34 +0800
Subject: [PATCH] ARM: dts: imx6sx-sabreauto: add egalax touch screen
 support
In-Reply-To: <1524813650-19241-1-git-send-email-Anson.Huang@nxp.com>
References: <1524813650-19241-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <20180504082733.GC3443@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 27, 2018 at 03:20:50PM +0800, Anson Huang wrote:
> From: Haibo Chen <haibo.chen@nxp.com>
> 
> Add egalax touch screen support on i2c2 bus.
> 
> Signed-off-by: Haibo Chen <haibo.chen@freescale.com>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> this patch is based on patch (ARM: dts: imx6sx-sabreauto: add debug LED support) I sent out for review.
>  arch/arm/boot/dts/imx6sx-sabreauto.dts | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6sx-sabreauto.dts b/arch/arm/boot/dts/imx6sx-sabreauto.dts
> index 6b94f24..2f6e474 100644
> --- a/arch/arm/boot/dts/imx6sx-sabreauto.dts
> +++ b/arch/arm/boot/dts/imx6sx-sabreauto.dts
> @@ -131,6 +131,12 @@
>  &iomuxc {
>  	imx6x-sabreauto {
>  
> +		pinctrl_egalax_int: egalax_intgrp {

General recommendation: use hyphen instead of underscore in the node
node.

> +			fsl,pins = <
> +				MX6SX_PAD_SD4_RESET_B__GPIO6_IO_22      0x80000000
> +			>;
> +		};
> +
>  		pinctrl_led: ledgrp {
>  			fsl,pins = <
>  				MX6SX_PAD_CSI_PIXCLK__GPIO1_IO_24 0x17059
> @@ -274,6 +280,16 @@
>  	pinctrl-0 = <&pinctrl_i2c2_1>;
>  	status = "okay";
>  
> +	egalax_ts at 04 {

Use generic node name - touchscreen, as recommended by Devicetree
Specification, and drop leading zeros in unit-address.

Shawn

> +		compatible = "eeti,egalax_ts";
> +		reg = <0x04>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_egalax_int>;
> +		interrupt-parent = <&gpio6>;
> +		interrupts = <22 IRQ_TYPE_EDGE_FALLING>;
> +		wakeup-gpios = <&gpio6 22 GPIO_ACTIVE_HIGH>;
> +	};
> +
>  	max7322: gpio at 68 {
>  		compatible = "maxim,max7322";
>  		reg = <0x68>;
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
