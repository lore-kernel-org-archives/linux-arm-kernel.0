From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 31 Jan 2014 14:45:05 +0100
Subject: [PATCH v5 13/14] ARM: sun4i: dts: Add ahci / sata support
In-Reply-To: <1390417489-5354-14-git-send-email-hdegoede@redhat.com>
References: <1390417489-5354-1-git-send-email-hdegoede@redhat.com>
 <1390417489-5354-14-git-send-email-hdegoede@redhat.com>
Message-ID: <20140131134505.GG2950@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hans,

On Wed, Jan 22, 2014 at 08:04:48PM +0100, Hans de Goede wrote:
> From: Oliver Schinagl <oliver@schinagl.nl>
> 
> This patch adds sunxi sata support to A10 boards that have such a connector.
> Some boards also feature a regulator via a GPIO and support for this is also
> added.
> 
> Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  arch/arm/boot/dts/sun4i-a10-a1000.dts      |  4 ++++
>  arch/arm/boot/dts/sun4i-a10-cubieboard.dts |  6 +++++
>  arch/arm/boot/dts/sun4i-a10.dtsi           |  8 +++++++
>  arch/arm/boot/dts/sunxi-ahci-reg.dtsi      | 38 ++++++++++++++++++++++++++++++

I'm still half convinced about this at the moment, given the number of
platforms we support, we can always change it back if things become too messy.

>  4 files changed, 56 insertions(+)
>  create mode 100644 arch/arm/boot/dts/sunxi-ahci-reg.dtsi
> 
> diff --git a/arch/arm/boot/dts/sun4i-a10-a1000.dts b/arch/arm/boot/dts/sun4i-a10-a1000.dts
> index aef8207..3fb7305 100644
> --- a/arch/arm/boot/dts/sun4i-a10-a1000.dts
> +++ b/arch/arm/boot/dts/sun4i-a10-a1000.dts
> @@ -48,6 +48,10 @@
>  			status = "okay";
>  		};
>  
> +		ahci: sata at 01c18000 {
> +			status = "okay";
> +		};
> +
>  		pinctrl at 01c20800 {
>  			mmc0_cd_pin_a1000: mmc0_cd_pin at 0 {
>  				allwinner,pins = "PH1";
> diff --git a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
> index f50fb2b..6ae1110 100644
> --- a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
> +++ b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
> @@ -12,6 +12,7 @@
>  
>  /dts-v1/;
>  /include/ "sun4i-a10.dtsi"
> +/include/ "sunxi-ahci-reg.dtsi"
>  
>  / {
>  	model = "Cubietech Cubieboard";
> @@ -51,6 +52,11 @@
>  			status = "okay";
>  		};
>  
> +		ahci: sata at 01c18000 {
> +			target-supply = <&reg_ahci_5v>;
> +			status = "okay";
> +		};
> +
>  		pinctrl at 01c20800 {
>  			mmc0_cd_pin_cubieboard: mmc0_cd_pin at 0 {
>  				allwinner,pins = "PH1";
> diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
> index 4736dd2..198dcda 100644
> --- a/arch/arm/boot/dts/sun4i-a10.dtsi
> +++ b/arch/arm/boot/dts/sun4i-a10.dtsi
> @@ -331,6 +331,14 @@
>  			status = "disabled";
>  		};
>  
> +		ahci: sata at 01c18000 {
> +			compatible = "allwinner,sun4i-a10-ahci";

To be consistent with the rest of the sun4i devices compatible, It
should be sun4i-ahci.

However, since these devices don't use the same compatible pattern as
their own machine compatible, and are consisent with the rest of the
compatibles for the other SoCs, we can probably make this a go to
transition progressively to this pattern.

I'll cook up some patches for the other devices.

> +			reg = <0x01c18000 0x1000>;
> +			interrupts = <56>;
> +			clocks = <&pll6 0>, <&ahb_gates 25>;
> +			status = "disabled";
> +		};
> +
>  		intc: interrupt-controller at 01c20400 {
>  			compatible = "allwinner,sun4i-ic";
>  			reg = <0x01c20400 0x400>;
> diff --git a/arch/arm/boot/dts/sunxi-ahci-reg.dtsi b/arch/arm/boot/dts/sunxi-ahci-reg.dtsi
> new file mode 100644
> index 0000000..955b197
> --- /dev/null
> +++ b/arch/arm/boot/dts/sunxi-ahci-reg.dtsi
> @@ -0,0 +1,38 @@
> +/*
> + * sunxi boards sata target power supply common code
> + *
> + * Copyright 2014 - Hans de Goede <hdegoede@redhat.com>
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
> +/ {
> +	soc at 01c00000 {
> +		ahci_pwr_pin_a: ahci_pwr_pin at 0 {
> +			allwinner,pins = "PB8";
> +			allwinner,function = "gpio_out";
> +			allwinner,drive = <0>;
> +			allwinner,pull = <0>;
> +		};

This should be under the pinctrl node.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140131/4caca1fa/attachment.sig>
