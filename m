From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 14 Jun 2013 14:21:49 +0800
Subject: [PATCH 6/9] ARM: dtsi: imx6qdl-sabresd: Add WM8962 CODEC support
In-Reply-To: <d77dd407188926f61c787eb307dd142cf0b37e1b.1371123426.git.b42378@freescale.com>
References: <cover.1371123426.git.b42378@freescale.com>
 <d77dd407188926f61c787eb307dd142cf0b37e1b.1371123426.git.b42378@freescale.com>
Message-ID: <20130614062147.GC20513@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 13, 2013 at 07:51:01PM +0800, Nicolin Chen wrote:
> Add WM8962 CODEC support and enable its parent I2C bus.
> 
> Signed-off-by: Nicolin Chen <b42378@freescale.com>
> ---
>  arch/arm/boot/dts/imx6qdl-sabresd.dtsi |   29 +++++++++++++++++++++++++++++
>  1 files changed, 29 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> index 13af158..4ee2413 100644
> --- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> @@ -92,3 +92,32 @@
>  	wp-gpios = <&gpio2 1 0>;
>  	status = "okay";
>  };
> +
> +&i2c1 {

The node should be sorted in label name, so I moved it to right after
"&fec".

> +	status = "okay";

We generally have it as the last property of a node, so I moved
it to ...

> +	clock-frequency = <100000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c1_2>;

... here.

> +
> +	codec: wm8962 at 1a {
> +		compatible = "wlf,wm8962";
> +		reg = <0x1a>;
> +		clocks = <&clks 169>;
> +		DCVDD-supply = <&reg_audio>;	/* 1.8v */
> +		DBVDD-supply = <&reg_audio>;	/* 1.8v */
> +		AVDD-supply = <&reg_audio>;	/* 1.8v */
> +		CPVDD-supply = <&reg_audio>;	/* 1.8v */
> +		MICVDD-supply = <&reg_audio>;	/* 3.3v */
> +		PLLVDD-supply = <&reg_audio>;	/* 1.8v */
> +		SPKVDD1-supply = <&reg_audio>;	/* 4.2v */
> +		SPKVDD2-supply = <&reg_audio>;	/* 4.2v */

You comment these supplies with different voltages but they are actually
pointing to the same fixed regulator.

Shawn

> +		gpio-cfg = <
> +			0x0000 /* 0:Default */
> +			0x0000 /* 1:Default */
> +			0x0013 /* 2:FN_DMICCLK */
> +			0x0000 /* 3:Default */
> +			0x8014 /* 4:FN_DMICCDAT */
> +			0x0000 /* 5:Default */
> +		>;
> +       };
> +};
> -- 
> 1.7.1
> 
> 
