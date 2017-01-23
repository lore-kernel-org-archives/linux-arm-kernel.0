From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 23 Jan 2017 15:15:37 +0800
Subject: [PATCH v2 2/3] ARM: dts: udoo_neo: Add Wifi support
In-Reply-To: <1484843405-14892-2-git-send-email-breno.lima@nxp.com>
References: <1484843405-14892-1-git-send-email-breno.lima@nxp.com>
 <1484843405-14892-2-git-send-email-breno.lima@nxp.com>
Message-ID: <20170123071536.GI5662@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 19, 2017 at 02:30:04PM -0200, Breno Lima wrote:
> Udoo Neo has a TI WL1831 Wifi chip connected to the USDHC3 port.
> 
> Add support for it.
> 
> Signed-off-by: Breno Lima <breno.lima@nxp.com>
> ---
> Changes since v1:
> - Newly introduced in this series
> 
>  arch/arm/boot/dts/imx6sx-udoo-neo.dtsi | 45 ++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6sx-udoo-neo.dtsi b/arch/arm/boot/dts/imx6sx-udoo-neo.dtsi
> index e9d0596..6787a83 100644
> --- a/arch/arm/boot/dts/imx6sx-udoo-neo.dtsi
> +++ b/arch/arm/boot/dts/imx6sx-udoo-neo.dtsi
> @@ -97,6 +97,16 @@
>  		gpio = <&gpio4 12 GPIO_ACTIVE_HIGH>;
>  		enable-active-high;
>  	};
> +
> +	reg_wlan: regulator-wlan {
> +		compatible = "regulator-fixed";
> +		regulator-name = "wlan-en-regulator";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		gpio = <&gpio2 12 GPIO_ACTIVE_HIGH>;
> +		startup-delay-us = <70000>;
> +		enable-active-high;
> +	};
>  };
>  
>  &cpu0 {
> @@ -295,6 +305,19 @@
>  			<MX6SX_PAD_SD2_DATA3__USDHC2_DATA3	0x17059>,
>  			<MX6SX_PAD_SD1_DATA0__GPIO6_IO_2	0x17059>; /* CD */
>  	};
> +
> +	pinctrl_usdhc3: usdhc3grp {
> +		fsl,pins =
> +			<MX6SX_PAD_KEY_COL2__GPIO2_IO_12	0x15059>,
> +			<MX6SX_PAD_KEY_ROW1__GPIO2_IO_16	0x13059>,
> +			<MX6SX_PAD_SD3_DATA0__USDHC3_DATA0	0x17069>,
> +			<MX6SX_PAD_SD3_DATA1__USDHC3_DATA1	0x17069>,
> +			<MX6SX_PAD_SD3_DATA2__USDHC3_DATA2	0x17069>,
> +			<MX6SX_PAD_SD3_DATA3__USDHC3_DATA3	0x17069>,
> +			<MX6SX_PAD_SD3_CMD__USDHC3_CMD		0x17069>,
> +			<MX6SX_PAD_SD3_CLK__USDHC3_CLK		0x10069>,
> +			<MX6SX_PAD_CSI_MCLK__OSC32K_32K_OUT	0x10059>;
> +	};
>  };
>  
>  &uart1 {
> @@ -350,3 +373,25 @@
>  	wakeup-source;
>  	status = "okay";
>  };
> +
> +&usdhc3 { /* Wi-Fi */
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usdhc3>;
> +	non-removable;
> +	vmmc-supply = <&reg_wlan>;
> +	cap-power-off-card;
> +	wakeup-source;
> +	keep-power-in-suspend;
> +	status = "okay";
> +
> +	#address-cells = <1>;
> +	#size-cells = <0>;

Please have a newline between properties and child node.

Shawn

> +	wlcore: wlcore at 2 {
> +		compatible = "ti,wl1831";
> +		reg = <2>;
> +		interrupt-parent = <&gpio2>;
> +		interrupts = <16 IRQ_TYPE_EDGE_RISING>;
> +		ref-clock-frequency = <38400000>;
> +		tcxo-clock-frequency = <26000000>;
> +	};
> +};
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
