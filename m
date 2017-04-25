From: andre.przywara@arm.com (Andre Przywara)
Date: Tue, 25 Apr 2017 10:24:13 +0100
Subject: [linux-sunxi] [PATCH v4 09/10] arm64: allwinner: a64: enable
 AXP803 regulators for Pine64
In-Reply-To: <20170424160103.9447-10-icenowy@aosc.io>
References: <20170424160103.9447-1-icenowy@aosc.io>
 <20170424160103.9447-10-icenowy@aosc.io>
Message-ID: <8c7864f1-a0d7-b87f-f9d6-5201cc773609@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 24/04/17 17:01, Icenowy Zheng wrote:
> Add support of AXP803 regulators in the Pine64 device tree, in order to
> enable many future functionalities, e.g. Wi-Fi.

In general that's quite some code to just achieve some device power
plane switching, but that's another discussion, I guess ;-)

To me this patch here like a lot of churn to be duplicated in each
board's DT.
Can't we provide some sane defaults, either in axp803.dtsi or in an
extra file (allwinner-ref-axp803.dtsi?), and only overwrite them in a
board's DT if a board deviates?
Because it seems like many boards are actually based on some Allwinner
reference design and use very similar, if not identical settings.

Also one thing below ...

> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  .../arm64/boot/dts/allwinner/sun50i-a64-pine64.dts | 109 +++++++++++++++++++++
>  1 file changed, 109 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
> index 3e1b44292534..abc1879e91f2 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
> @@ -106,6 +106,115 @@
>  	};
>  };
>  
> +#include "axp803.dtsi"
> +
> +&reg_aldo1 {
> +	regulator-min-microvolt = <2800000>;
> +	regulator-max-microvolt = <2800000>;
> +	regulator-name = "vcc-csi";
> +};
> +
> +&reg_aldo2 {
> +	regulator-always-on;
> +	regulator-min-microvolt = <1800000>;
> +	regulator-max-microvolt = <3300000>;
> +	regulator-name = "vcc-pl";
> +};
> +
> +&reg_aldo3 {
> +	regulator-always-on;
> +	regulator-min-microvolt = <2700000>;
> +	regulator-max-microvolt = <3300000>;
> +	regulator-name = "vcc-pll-avcc";
> +};
> +
> +&reg_dc1sw {
> +	regulator-name = "vcc-phy";
> +};
> +
> +&reg_dcdc1 {
> +	regulator-always-on;
> +	regulator-min-microvolt = <3300000>;
> +	regulator-max-microvolt = <3300000>;
> +	regulator-name = "vcc-3v3";
> +};
> +
> +&reg_dcdc2 {
> +	regulator-always-on;
> +	regulator-min-microvolt = <1000000>;
> +	regulator-max-microvolt = <1300000>;
> +	regulator-name = "vdd-cpux";
> +};
> +
> +/* DCDC3 is polyphased with DCDC2 */
> +
> +&reg_dcdc5 {
> +	regulator-always-on;
> +	regulator-min-microvolt = <1500000>;
> +	regulator-max-microvolt = <1500000>;

On the Pine64 there is DDR3L DRAM, running at 1.35V.

Cheers,
Andre.


> +	regulator-name = "vcc-dram";
> +};
> +
> +&reg_dcdc6 {
> +	regulator-always-on;
> +	regulator-min-microvolt = <1100000>;
> +	regulator-max-microvolt = <1100000>;
> +	regulator-name = "vdd-sys";
> +};
> +
> +&reg_dldo1 {
> +	regulator-min-microvolt = <3300000>;
> +	regulator-max-microvolt = <3300000>;
> +	regulator-name = "vcc-hdmi";
> +};
> +
> +&reg_dldo2 {
> +	regulator-min-microvolt = <3300000>;
> +	regulator-max-microvolt = <3300000>;
> +	regulator-name = "vcc-mipi";
> +};
> +
> +&reg_dldo3 {
> +	regulator-min-microvolt = <3300000>;
> +	regulator-max-microvolt = <3300000>;
> +	regulator-name = "avdd-csi";
> +};
> +
> +&reg_dldo4 {
> +	regulator-min-microvolt = <3300000>;
> +	regulator-max-microvolt = <3300000>;
> +	regulator-name = "vcc-wifi";
> +};
> +
> +&reg_eldo1 {
> +	regulator-min-microvolt = <1800000>;
> +	regulator-max-microvolt = <1800000>;
> +	regulator-name = "cpvdd";
> +};
> +
> +&reg_eldo3 {
> +	regulator-min-microvolt = <1800000>;
> +	regulator-max-microvolt = <1800000>;
> +	regulator-name = "vdd-1v8-csi";
> +};
> +
> +&reg_fldo1 {
> +	regulator-min-microvolt = <1200000>;
> +	regulator-max-microvolt = <1200000>;
> +	regulator-name = "vcc-1v2-hsic";
> +};
> +
> +&reg_fldo2 {
> +	regulator-always-on;
> +	regulator-min-microvolt = <1100000>;
> +	regulator-max-microvolt = <1100000>;
> +	regulator-name = "vdd-cpus";
> +};
> +
> +&reg_rtc_ldo {
> +	regulator-name = "vcc-rtc";
> +};
> +
>  &uart0 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&uart0_pins_a>;
> 
