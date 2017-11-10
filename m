From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri, 10 Nov 2017 18:48:03 +0100
Subject: [PATCH v4] ARM: dts: exynos: add bcm4334 device node to trats2
In-Reply-To: <20171109100645.GA32635@lineageos.org>
References: <20171109100645.GA32635@lineageos.org>
Message-ID: <20171110174803.umsgcs45pmjhplgk@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 09, 2017 at 09:06:45PM +1100, Simon Shields wrote:
> This patch allows the bcm4334 to power on and enables
> wifi functionality on trats2.
> 
> Signed-off-by: Simon Shields <simon@lineageos.org>
> ---
>  arch/arm/boot/dts/exynos4412-trats2.dts | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/exynos4412-trats2.dts b/arch/arm/boot/dts/exynos4412-trats2.dts
> index bceb919ac637..1bf1943ba7a1 100644
> --- a/arch/arm/boot/dts/exynos4412-trats2.dts
> +++ b/arch/arm/boot/dts/exynos4412-trats2.dts
> @@ -241,6 +241,13 @@
>  
>  	};
>  
> +	wlan_pwrseq: sdhci3-pwrseq {
> +		compatible = "mmc-pwrseq-simple";
> +		reset-gpios = <&gpj0 0 GPIO_ACTIVE_LOW>;
> +		clocks = <&max77686 MAX77686_CLK_PMIC>;
> +		clock-names = "ext_clock";
> +	};
> +
>  	sound {
>  		compatible = "samsung,trats2-audio";
>  		samsung,i2s-controller = <&i2s0>;
> @@ -1239,6 +1246,27 @@
>  	status = "okay";
>  };
>  
> +&sdhci_3 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	non-removable;
> +	bus-width = <4>;
> +
> +	mmc-pwrseq = <&wlan_pwrseq>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&sd3_clk &sd3_cmd &sd3_bus4>;
> +	vmmc-supply = <&ldo21_reg>;

How did you get LDO21 here? It does not look correct.

> +	status = "okay";
> +
> +	brcmf: brcmf at 1 {

The node name should be generic class of device, thus maybe "wifi"?
Label can stay although I see it is not used now.

Best regards,
Krzysztof

> +		reg = <1>;
> +		compatible = "brcm,bcm4329-fmac";
> +		interrupt-parent = <&gpx2>;
> +		interrupts = <5 IRQ_TYPE_NONE>;
> +		interrupt-names = "host-wake";
> +	};
> +};
> +
>  &serial_0 {
>  	status = "okay";
>  };
> -- 
> 2.15.0
> 
