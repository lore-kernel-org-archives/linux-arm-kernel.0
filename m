From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 04 Jul 2017 10:34:05 +0200
Subject: [PATCH 1/6] ARM: dts: rockchip: add regulator nodes for rk3229-evb
In-Reply-To: <1499155967-26090-2-git-send-email-frank.wang@rock-chips.com>
References: <1499155967-26090-1-git-send-email-frank.wang@rock-chips.com>
 <1499155967-26090-2-git-send-email-frank.wang@rock-chips.com>
Message-ID: <8062361.VWy3dYvDhe@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Frank,

Am Dienstag, 4. Juli 2017, 16:12:42 CEST schrieb Frank Wang:
> This patch adds vcc_io, vdd_arm and vdd_log regulator nodes
> for rk3229-evb board.
> 
> Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
> ---
>  arch/arm/boot/dts/rk3229-evb.dts | 54
> ++++++++++++++++++++++++++++++++++++++++ 1 file changed, 54 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/rk3229-evb.dts
> b/arch/arm/boot/dts/rk3229-evb.dts index 82e8a53..8b10c64 100644
> --- a/arch/arm/boot/dts/rk3229-evb.dts
> +++ b/arch/arm/boot/dts/rk3229-evb.dts
> @@ -78,6 +78,52 @@
>  		regulator-always-on;
>  		regulator-boot-on;
>  	};
> +
> +	vdd_arm: vdd-arm-regulator {
> +		compatible = "pwm-regulator";
> +		rockchip,pwm_id = <1>;
> +		rockchip,pwm_voltage = <1100000>;

This doesn't look like a part of the mainline pwm-regulator binding
(both rockchip,* properties)

> +		pwms = <&pwm1 0 25000 1>;
> +		regulator-name = "vdd_arm";
> +		regulator-min-microvolt = <950000>;
> +		regulator-max-microvolt = <1400000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};

please also add supplies for regulators. Information on supplies
should be easily extractable from the board schematics.

This not only results in a nice tree in debugfs (regulator/regulator_summary)
but also makes sure supplying regulators are not accidentially turned off.
(pwm-supply for pwm-regulators, vin-supply for fixed regulators)


> +
> +	vdd_log: vdd-log-regulator {
> +		compatible = "pwm-regulator";
> +		rockchip,pwm_id = <2>;
> +		rockchip,pwm_voltage = <1200000>;
> +		pwms = <&pwm2 0 25000 1>;
> +		regulator-name = "vdd_log";
> +		regulator-min-microvolt = <1000000>;
> +		regulator-max-microvolt = <1300000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
> +	regulators {
> +		compatible = "simple-bus";

don't create a subnode/bus for regulators. Just add them
regularly. Take a look at all the other boards (like rk3399-firefly,
gru, veyron) for reference.

> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		vccio_1v8_reg: regulator at 0 {

Same here, no regulator at 0 please, just name this one
	vccio_1v8: vccio-1v8-regulator {

(removed _reg from phandle and changed node name)

> +			compatible = "regulator-fixed";
> +			regulator-name = "vccio_1v8";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-always-on;
> +		};
> +
> +		vccio_3v3_reg: regulator at 1 {
> +			compatible = "regulator-fixed";
> +			regulator-name = "vccio_3v3";
> +			regulator-min-microvolt = <3300000>;
> +			regulator-max-microvolt = <3300000>;
> +			regulator-always-on;
> +		};
> +	};
>  };


Thanks
Heiko
