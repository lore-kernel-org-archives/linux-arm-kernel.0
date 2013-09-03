From: b42378@freescale.com (Nicolin Chen)
Date: Tue, 3 Sep 2013 10:04:42 +0800
Subject: [PATCH v2] ARM: imx6qdl-wandboard: Add spdif support
In-Reply-To: <1378170062-30518-1-git-send-email-festevam@gmail.com>
References: <1378170062-30518-1-git-send-email-festevam@gmail.com>
Message-ID: <20130903020441.GB2846@MrMyself>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This looks fine to me except extra one blank lines after pinctrl_spdif_3.

On Mon, Sep 02, 2013 at 10:01:02PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
> I can see the spdif card getting probed. When I run 'aplay the spdif
> light turns on, but I cannot test it due to the lack of spdif equipment at the
> moment.
> 
> Changes since v1:
> - Fix the identation level os spdif node
> - Remove unneeded blank lines
> 
>  arch/arm/boot/dts/imx6qdl-wandboard.dtsi | 13 +++++++++++++
>  arch/arm/boot/dts/imx6qdl.dtsi           | 22 ++++++++++++++++++++++
>  2 files changed, 35 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-wandboard.dtsi b/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
> index b462080..df42d3c 100644
> --- a/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
> @@ -43,6 +43,13 @@
>  		mux-int-port = <1>;
>  		mux-ext-port = <3>;
>  	};
> +
> +	sound-spdif {
> +		compatible = "fsl,imx-audio-spdif";
> +		model = "imx-spdif";
> +		spdif-controller = <&spdif>;
> +		spdif-out;
> +	};
>  };
>  
>  &audmux {
> @@ -93,6 +100,12 @@
>  	status = "okay";
>  };
>  
> +&spdif {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_spdif_3>;
> +	status = "okay";
> +};
> +
>  &ssi1 {
>  	fsl,mode = "i2s-slave";
>  	status = "okay";
> diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
> index ccd55c2..d06c059 100644
> --- a/arch/arm/boot/dts/imx6qdl.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl.dtsi
> @@ -136,8 +136,23 @@
>  				ranges;
>  
>  				spdif: spdif at 02004000 {
> +					compatible = "fsl,imx35-spdif";
>  					reg = <0x02004000 0x4000>;
>  					interrupts = <0 52 0x04>;
> +					dmas = <&sdma 14 18 0>,
> +					       <&sdma 15 18 0>;
> +					dma-names = "rx", "tx";
> +					clocks = <&clks 197>, <&clks 3>,
> +						 <&clks 197>, <&clks 107>,
> +						 <&clks 0>,   <&clks 118>,
> +						 <&clks 62>,  <&clks 139>,
> +						 <&clks 0>;
> +					clock-names = "core",  "rxtx0",
> +						      "rxtx1", "rxtx2",
> +						      "rxtx3", "rxtx4",
> +						      "rxtx5", "rxtx6",
> +						      "rxtx7";
> +					status = "disabled";
>  				};
>  
>  				ecspi1: ecspi at 02008000 {
> @@ -1010,6 +1025,13 @@
>  							MX6QDL_PAD_GPIO_17__SPDIF_OUT 0x1b0b0
>  						>;
>  					};

> +
> +					pinctrl_spdif_3: spdifgrp-3 {
> +						fsl,pins = <
> +							MX6QDL_PAD_ENET_RXD0__SPDIF_OUT 0x1b0b0
> +						>;
> +					};
> +

This one. But I guess not a big deal, maybe Shawn can help to drop this :)

Thank you.
Nicolin Chen

>  				};
>  
>  				uart1 {
> -- 
> 1.8.1.2
> 
> 
