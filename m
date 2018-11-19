From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 19 Nov 2018 09:59:07 +0100
Subject: [PATCH] ARM64: dts: meson-gxbb-wetek: fix hwmon temperature
 sensor output
In-Reply-To: <1542601348-3469-1-git-send-email-christianshewitt@gmail.com>
References: <1542601348-3469-1-git-send-email-christianshewitt@gmail.com>
Message-ID: <d4baee43-d666-0268-30e9-694a8355d5b9@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


On 19/11/2018 05:22, Christian Hewitt wrote:
> Add &saradc and supporting vddio_ao18 nodes to fix hwmon temperature
> readings on the WeTek Hub and Play2 devices. Without these nodes the
> temp is reported as 4294967295 degrees C.
> 
> Thanks to Martin Blumenstingl for assisting debug and the winning
> guess at what was missing.

It's a good workaround, but the real solution is that we should instead
add the CLKID_SAR_ADC* clock in the scpi_sensors node and update
the driver to keep these clocks enabled.

We hit the same issue as the clk_div2/3 which should be kept enabled
by the SCPI scpi_dvfs driver.

Neil

> 
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
> index 70325b2..dd12e02 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
> @@ -59,6 +59,13 @@
>  		regulator-max-microvolt = <3300000>;
>  	};
>  
> +	vddio_ao18: regulator-vddio_ao18 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VDDIO_AO18";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +	};
> +
>  	vcc_3v3: regulator-vcc_3v3 {
>  		compatible = "regulator-fixed";
>  		regulator-name = "VCC_3V3";
> @@ -173,6 +180,11 @@
>  	clock-names = "clkin0";
>  };
>  
> +&saradc {
> +	status = "okay";
> +	vref-supply = <&vddio_ao18>;
> +};
> +
>  /* Wireless SDIO Module */
>  &sd_emmc_a {
>  	status = "okay";
> 
