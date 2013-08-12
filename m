From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 12 Aug 2013 16:08:37 +0800
Subject: [PATCH] ARM: dts: imx27-phytec-phycore-rdk: Add DT nodes for
 camera module
In-Reply-To: <1376117398-19080-1-git-send-email-shc_work@mail.ru>
References: <1376117398-19080-1-git-send-email-shc_work@mail.ru>
Message-ID: <20130812080835.GH25061@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 10, 2013 at 10:49:58AM +0400, Alexander Shiyan wrote:
> This patch adds PCA9536 device on first I2C bus (this device is
> used on camera addon module to enable CSI bus muxing) and GPIO to
> enable camera interface for Phytec PCM-970 RDK.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts | 31 ++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts b/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
> index 0fc6551..e93c968 100644
> --- a/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
> +++ b/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
> @@ -12,6 +12,25 @@
>  / {
>  	model = "Phytec pcm970";
>  	compatible = "phytec,imx27-pcm970", "phytec,imx27-pcm038", "fsl,imx27";
> +
> +	cameramux: fixedregulator at 0 {

Generally, we only have @num on node name when there is "reg" property
for the node.

> +		compatible = "regulator-fixed";
> +		regulator-name = "CAM_MUX";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		enable-active-high;
> +		gpio = <&camgpio 0 0>;
> +		vin-supply = <&csi_en>;

I do not quite understand the use case here.  You have a supply for this
fixed regulator?  And what will you do about this vin-supply?  The fixed
regulator will get and enable this vin-supply?

> +	};
> +
> +	csi_en: fixedregulator at 1 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "CSI_EN";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpio = <&gpio2 24 0>;
> +		vin-supply = <&vcam_reg>;

Ditto

Shawn

> +	};
>  };
>  
>  &cspi1 {
> @@ -19,6 +38,18 @@
>  	cs-gpios = <&gpio4 28 0>, <&gpio4 27 0>;
>  };
>  
> +&i2c1 {
> +	clock-frequency = <400000>;
> +	status = "okay";
> +
> +	camgpio: pca9536 at 41 {
> +		compatible = "nxp,pca9536";
> +		reg = <0x41>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +	};
> +};
> +
>  &sdhci2 {
>  	bus-width = <4>;
>  	cd-gpios = <&gpio3 29 0>;
> -- 
> 1.8.1.5
> 
