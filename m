From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 30 May 2013 11:36:14 +0800
Subject: [RFC 3/3] SPI: imx: Using dynamic count of chipselects provided
 by of_spi_register_master
In-Reply-To: <1369847430-10799-3-git-send-email-shc_work@mail.ru>
References: <20130529144909.GT3660@sirena.org.uk>
 <1369847430-10799-1-git-send-email-shc_work@mail.ru>
 <1369847430-10799-3-git-send-email-shc_work@mail.ru>
Message-ID: <20130530033612.GE1875@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 29, 2013 at 09:10:30PM +0400, Alexander Shiyan wrote:
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  .../devicetree/bindings/spi/fsl-imx-cspi.txt       |  2 -
>  arch/arm/boot/dts/imx27-apf27dev.dts               |  2 -
>  arch/arm/boot/dts/imx51-apf51dev.dts               |  2 -
>  arch/arm/boot/dts/imx51-babbage.dts                |  1 -
>  arch/arm/boot/dts/imx53-evk.dts                    |  1 -
>  arch/arm/boot/dts/imx53-smd.dts                    |  1 -
>  arch/arm/boot/dts/imx53-tqma53.dtsi                |  2 -
>  arch/arm/boot/dts/imx6q-sabrelite.dts              |  1 -
>  drivers/spi/spi-imx.c                              | 51 ++++++++++------------
>  9 files changed, 22 insertions(+), 41 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt b/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
> index 4256a6d..069592d 100644
> --- a/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
> +++ b/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
> @@ -5,7 +5,6 @@ Required properties:
>  - compatible : Should be "fsl,<soc>-cspi" or "fsl,<soc>-ecspi"
>  - reg : Offset and length of the register set for the device
>  - interrupts : Should contain CSPI/eCSPI interrupt
> -- fsl,spi-num-chipselects : Contains the number of the chipselect
>  - cs-gpios : Specifies the gpio pins to be used for chipselects.
>  
>  Example:
> @@ -16,7 +15,6 @@ ecspi at 70010000 {
>  	compatible = "fsl,imx51-ecspi";
>  	reg = <0x70010000 0x4000>;
>  	interrupts = <36>;
> -	fsl,spi-num-chipselects = <2>;
>  	cs-gpios = <&gpio3 24 0>, /* GPIO3_24 */
>  		   <&gpio3 25 0>; /* GPIO3_25 */
>  };
> diff --git a/arch/arm/boot/dts/imx27-apf27dev.dts b/arch/arm/boot/dts/imx27-apf27dev.dts
> index 66b8e1c..6e71949 100644
> --- a/arch/arm/boot/dts/imx27-apf27dev.dts
> +++ b/arch/arm/boot/dts/imx27-apf27dev.dts
> @@ -38,13 +38,11 @@
>  };
>  
>  &cspi1 {
> -	fsl,spi-num-chipselects = <1>;
>  	cs-gpios = <&gpio4 28 1>;
>  	status = "okay";
>  };
>  
>  &cspi2 {
> -	fsl,spi-num-chipselects = <3>;
>  	cs-gpios = <&gpio4 21 1>, <&gpio4 27 1>,
>  			<&gpio2 17 1>;
>  	status = "okay";
> diff --git a/arch/arm/boot/dts/imx51-apf51dev.dts b/arch/arm/boot/dts/imx51-apf51dev.dts
> index 123fe84..557b616 100644
> --- a/arch/arm/boot/dts/imx51-apf51dev.dts
> +++ b/arch/arm/boot/dts/imx51-apf51dev.dts
> @@ -40,7 +40,6 @@
>  &ecspi1 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_ecspi1_1>;
> -	fsl,spi-num-chipselects = <2>;
>  	cs-gpios = <&gpio4 24 0>, <&gpio4 25 0>;
>  	status = "okay";
>  };
> @@ -48,7 +47,6 @@
>  &ecspi2 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_ecspi2_1>;
> -	fsl,spi-num-chipselects = <2>;
>  	cs-gpios = <&gpio3 28 1>, <&gpio3 27 1>;
>  	status = "okay";
>  };
> diff --git a/arch/arm/boot/dts/imx51-babbage.dts b/arch/arm/boot/dts/imx51-babbage.dts
> index 6dd9486..0a6c443 100644
> --- a/arch/arm/boot/dts/imx51-babbage.dts
> +++ b/arch/arm/boot/dts/imx51-babbage.dts
> @@ -89,7 +89,6 @@
>  &ecspi1 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_ecspi1_1>;
> -	fsl,spi-num-chipselects = <2>;
>  	cs-gpios = <&gpio4 24 0>, <&gpio4 25 0>;
>  	status = "okay";
>  
> diff --git a/arch/arm/boot/dts/imx53-evk.dts b/arch/arm/boot/dts/imx53-evk.dts
> index 801fda7..6a9b1e7 100644
> --- a/arch/arm/boot/dts/imx53-evk.dts
> +++ b/arch/arm/boot/dts/imx53-evk.dts
> @@ -43,7 +43,6 @@
>  &ecspi1 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_ecspi1_1>;
> -	fsl,spi-num-chipselects = <2>;
>  	cs-gpios = <&gpio2 30 0>, <&gpio3 19 0>;
>  	status = "okay";
>  
> diff --git a/arch/arm/boot/dts/imx53-smd.dts b/arch/arm/boot/dts/imx53-smd.dts
> index a9b6e10..6d86ae8 100644
> --- a/arch/arm/boot/dts/imx53-smd.dts
> +++ b/arch/arm/boot/dts/imx53-smd.dts
> @@ -63,7 +63,6 @@
>  &ecspi1 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_ecspi1_1>;
> -	fsl,spi-num-chipselects = <2>;
>  	cs-gpios = <&gpio2 30 0>, <&gpio3 19 0>;
>  	status = "okay";
>  
> diff --git a/arch/arm/boot/dts/imx53-tqma53.dtsi b/arch/arm/boot/dts/imx53-tqma53.dtsi
> index 38bed3e..bd5a024 100644
> --- a/arch/arm/boot/dts/imx53-tqma53.dtsi
> +++ b/arch/arm/boot/dts/imx53-tqma53.dtsi
> @@ -50,7 +50,6 @@
>  &ecspi1 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_ecspi1_1>;
> -	fsl,spi-num-chipselects = <4>;
>  	cs-gpios = <&gpio2 30 0>, <&gpio3 19 0>,
>  		   <&gpio3 24 0>, <&gpio3 25 0>;
>  	status = "disabled";
> @@ -133,7 +132,6 @@
>  &cspi {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_cspi_1>;
> -	fsl,spi-num-chipselects = <3>;
>  	cs-gpios = <&gpio1 18 0>, <&gpio1 19 0>,
>  		   <&gpio1 21 0>;
>  	status = "disabled";
> diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dts
> index 6a00066..a47647d 100644
> --- a/arch/arm/boot/dts/imx6q-sabrelite.dts
> +++ b/arch/arm/boot/dts/imx6q-sabrelite.dts
> @@ -66,7 +66,6 @@
>  };
>  
>  &ecspi1 {
> -	fsl,spi-num-chipselects = <1>;
>  	cs-gpios = <&gpio3 19 0>;
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_ecspi1_1>;
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index 3a11b20..5384a42 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -761,53 +761,46 @@ static int spi_imx_probe(struct platform_device *pdev)
>  	struct spi_imx_data *spi_imx;
>  	struct resource *res;
>  	struct pinctrl *pinctrl;
> -	int i, irq, ret, num_cs;
> +	int i, irq, ret;
>  
>  	if (!np && !mxc_platform_info) {
>  		dev_err(&pdev->dev, "can't get the platform data\n");
>  		return -EINVAL;
>  	}
>  
> -	ret = of_property_read_u32(np, "fsl,spi-num-chipselects", &num_cs);
> -	if (ret < 0) {
> -		if (mxc_platform_info)
> -			num_cs = mxc_platform_info->num_chipselect;
> -		else
> -			return ret;
> -	}
> -
>  	master = spi_alloc_master(&pdev->dev, sizeof(struct spi_imx_data));
>  	if (!master)
>  		return -ENOMEM;
>  
> -	master->cs_gpios = devm_kzalloc(&pdev->dev, sizeof(int) * num_cs,
> -					GFP_KERNEL);
> -	if (!master->cs_gpios) {
> -		ret = -ENOMEM;
> -		goto out_master_free;
> +	if (!np && mxc_platform_info) {
> +		master->num_chipselect = mxc_platform_info->num_chipselect;
> +
> +		master->cs_gpios = devm_kzalloc(&pdev->dev, sizeof(int) *
> +						master->num_chipselect,
> +						GFP_KERNEL);
> +		if (!master->cs_gpios) {
> +			ret = -ENOMEM;
> +			goto out_master_free;
> +		}
> +
> +		for (i = 0; i < master->num_chipselect; i++) {
> +			master->cs_gpios[i] = mxc_platform_info->chipselect[i];
> +			ret = devm_gpio_request(&pdev->dev, master->cs_gpios[i],
> +						DRIVER_NAME);
> +			if (ret) {
> +				dev_err(&pdev->dev, "can't get cs gpio %i\n",
> +					master->cs_gpios[i]);
> +				goto out_gpio_free;
> +			}
> +		}
>  	}
>  
>  	platform_set_drvdata(pdev, master);
>  
>  	master->bus_num = pdev->id;
> -	master->num_chipselect = num_cs;
>  
>  	spi_imx = spi_master_get_devdata(master);
>  	spi_imx->bitbang.master = spi_master_get(master);
> -
> -	for (i = 0; i < master->num_chipselect; i++) {
> -		int cs_gpio = of_get_named_gpio(np, "cs-gpios", i);
> -		if (!gpio_is_valid(cs_gpio) && mxc_platform_info)
> -			cs_gpio = mxc_platform_info->chipselect[i];
> -
> -		master->cs_gpios[i] = cs_gpio;
> -		ret = devm_gpio_request(&pdev->dev, cs_gpio, DRIVER_NAME);

It seems that of_spi_register_master() does not request gpio, right?

Shawn

> -		if (ret) {
> -			dev_err(&pdev->dev, "can't get cs gpio %i\n", cs_gpio);
> -			goto out_gpio_free;
> -		}
> -	}
> -
>  	spi_imx->bitbang.chipselect = spi_imx_chipselect;
>  	spi_imx->bitbang.setup_transfer = spi_imx_setupxfer;
>  	spi_imx->bitbang.txrx_bufs = spi_imx_transfer;
> -- 
> 1.8.1.5
> 
