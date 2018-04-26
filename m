From: andre.przywara@arm.com (Andre Przywara)
Date: Thu, 26 Apr 2018 17:46:26 +0100
Subject: [linux-sunxi] [PATCH 3/3] arm64: allwinner: h6: enable MMC0/2 on
 Pine H64
In-Reply-To: <20180426140728.43155-4-icenowy@aosc.io>
References: <20180426140728.43155-1-icenowy@aosc.io>
 <20180426140728.43155-4-icenowy@aosc.io>
Message-ID: <03cc2e8c-4a35-3fb4-b408-fd8d4ba3e407@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 26/04/18 15:07, Icenowy Zheng wrote:
> The Pine H64 board have a MicroSD slot connected to MMC0 controller of
> the H6 SoC and a eMMC slot connected to MMC2.
> 
> Enable them in the device tree.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  .../boot/dts/allwinner/sun50i-h6-pine-h64.dts      | 32 ++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
> index d36de5eb81f3..78b1cd54687c 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
> @@ -20,6 +20,38 @@
>  	chosen {
>  		stdout-path = "serial0:115200n8";
>  	};
> +
> +	reg_vcc3v3: vcc3v3 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc3v3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +	};
> +
> +	reg_vcc1v8: vcc1v8 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc1v8";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +	};
> +};
> +
> +&mmc0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mmc0_pins>;
> +	vmmc-supply = <&reg_vcc3v3>;

So this is actually CLDO1 on the AXP, correct?


> +	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;
> +	status = "okay";
> +};
> +
> +&mmc2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mmc2_pins>;
> +	vmmc-supply = <&reg_vcc3v3>;
> +	vqmmc-supply = <&reg_vcc1v8>;

And this is BLDO2?

I am just asking because I want to avoid running into the same problem
as with the A64 before: that future DTs become incompatible with older
kernels, because we change the power supply to point to the AXP
regulators, which this kernel does not support yet.

It looks like there are more users of those power rails, so we could
keep those supplies connected to these fixed regulators here, even with
AXP-805 support in the kernel.

Or we keep this back until we get proper AXP support in the kernel? I
guess it's quite close to the existing PMICs, so it might be more a
copy&paste exercise to support the AXP-805?

But apart from this this looks correct to me.

Cheers,
Andre.

> +	non-removable;
> +	cap-mmc-hw-reset;
> +	status = "okay";
>  };
>  
>  &uart0 {
> 
