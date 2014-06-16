From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 16 Jun 2014 15:58:47 -0600
Subject: [PATCH 3/9] ARM: tegra: Add SATA and SATA power to Jetson TK1
 device tree
In-Reply-To: <1401881559-18469-4-git-send-email-mperttunen@nvidia.com>
References: <1401881559-18469-1-git-send-email-mperttunen@nvidia.com>
 <1401881559-18469-4-git-send-email-mperttunen@nvidia.com>
Message-ID: <539F6897.7080306@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/04/2014 05:32 AM, Mikko Perttunen wrote:
> This enables the integrated SATA controller on the Tegra124 system-on-chip
> on the Jetson TK1 board and adds regulators for the onboard Molex connector
> commonly used to power SATA devices. The regulators are marked always-on
> since they can be used for other purposes than powering SATA devices.

> diff --git a/arch/arm/boot/dts/tegra124-jetson-tk1.dts b/arch/arm/boot/dts/tegra124-jetson-tk1.dts

> +	sata at 0,70020000 {

> +		target-supply = <&vdd_5v0_sata>;

   	regulators {

> +		/* Molex power connector */
> +		vdd_5v0_sata: regulator at 13 {
> +			compatible = "regulator-fixed";
> +			reg = <13>;
> +			regulator-name = "+5V_SATA";
> +			regulator-min-microvolt = <5000000>;
> +			regulator-max-microvolt = <5000000>;
> +			gpio = <&gpio TEGRA_GPIO(EE, 2) GPIO_ACTIVE_HIGH>;
> +			enable-active-high;
> +			vin-supply = <&vdd_5v0_sys>;
> +			regulator-always-on;
> +		};

Why is this always-on, considering that the SATA node references this,
and presumably the driver explicitly enables this regulator?

> +
> +		vdd_12v0_sata: regulator at 14 {
> +			compatible = "regulator-fixed";
> +			reg = <14>;
> +			regulator-name = "+12V_SATA";
> +			regulator-min-microvolt = <12000000>;
> +			regulator-max-microvolt = <12000000>;
> +			gpio = <&gpio TEGRA_GPIO(EE, 2) GPIO_ACTIVE_HIGH>;
> +			enable-active-high;
> +			vin-supply = <&vdd_mux>;
> +			regulator-always-on;
> +		};
>  	};

If there are two regulators required for the SATA devices, shouldn't the
SATA node's target-supply property reference them both? Well, I suppose
there'd need to be target-5v-supply and target-12v-supply properties,
since each regulator property can only reference a single supply, IIRC.
I think the DT binding needs to be updated for this.
