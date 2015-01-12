From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 12 Jan 2015 10:06:03 +0100
Subject: [PATCH v3 4/9] ARM: dts: sun7i: cubieboard2: add axp209
 regulator nodes
In-Reply-To: <1421037249-28461-5-git-send-email-wens@csie.org>
References: <1421037249-28461-1-git-send-email-wens@csie.org>
 <1421037249-28461-5-git-send-email-wens@csie.org>
Message-ID: <20150112090603.GE4891@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chen-Yu,

On Mon, Jan 12, 2015 at 12:34:04PM +0800, Chen-Yu Tsai wrote:
> This patch adds the regulator nodes for the axp209 by including
> the axp209 dtsi. As the inputs of these regulators are from the
> axp209's PS output, which is basically just a mux over the 2
> inputs, it is considered to be unregulated. Thus we do not provide
> input supply properties for them.
> 
> The regulator names and constraints are based on the board
> schematics and the SoC datasheet.
> 
> DCDC2 is used as the cpu power supply. This patch also references
> it from the cpu node.
> 
> Also get rid of axp209 properties already set in axp209.dtsi.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
> 
> changes since v2
> 
>     none
> 
> changes since v1:
> 
>     - Use preprocessor include for axp209.dtsi
>     - Remove incorrectly squashed axp209.dtsi patch
> 
> ---
>  arch/arm/boot/dts/sun7i-a20-cubieboard2.dts | 35 +++++++++++++++++++++++++----
>  1 file changed, 31 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
> index 18fc5db9c976..ec1fc2c8b3e3 100644
> --- a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
> @@ -88,13 +88,9 @@
>  			status = "okay";
>  
>  			axp209: pmic at 34 {
> -				compatible = "x-powers,axp209";
>  				reg = <0x34>;
>  				interrupt-parent = <&nmi_intc>;
>  				interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
> -
> -				interrupt-controller;
> -				#interrupt-cells = <1>;
>  			};
>  		};
>  
> @@ -145,3 +141,34 @@
>  		status = "okay";
>  	};
>  };
> +
> +#include "axp209.dtsi"
> +
> +&cpu0 {
> +	cpu-supply = <&reg_dcdc2>;
> +};
> +
> +&reg_dcdc2 {
> +	regulator-always-on;
> +	regulator-min-microvolt = <1000000>;
> +	regulator-max-microvolt = <1450000>;
> +	regulator-name = "vdd-cpu";
> +};
> +
> +&reg_dcdc3 {
> +	regulator-always-on;
> +	regulator-min-microvolt = <1000000>;
> +	regulator-max-microvolt = <1400000>;
> +	regulator-name = "vdd-int-dll";
> +};
> +
> +&reg_ldo1 {
> +	regulator-name = "vdd-rtc";
> +};
> +
> +&reg_ldo2 {
> +	regulator-always-on;
> +	regulator-min-microvolt = <3000000>;
> +	regulator-max-microvolt = <3000000>;
> +	regulator-name = "avcc";
> +};

How do reg_vcc3v3 and the other reg used in this DT (ahci, USB) fit
into that?

Eventually, I think we would be able to remove
sunxi-common-regulators.dtsi, or at least, expose the proper regulator
hierarchy.

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
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150112/dc3ee794/attachment-0001.sig>
