From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 04 Nov 2015 17:28:21 +0900
Subject: [PATCH v5 4/4] ARM: dts: Add Ethernet chip to SMDK5410
In-Reply-To: <4568ad982f0af1846994119961cbb798edff311c.1446542020.git.p.fedin@samsung.com>
References: <cover.1446542020.git.p.fedin@samsung.com>
 <4568ad982f0af1846994119961cbb798edff311c.1446542020.git.p.fedin@samsung.com>
Message-ID: <5639C1A5.1040708@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03.11.2015 18:16, Pavel Fedin wrote:
> The chip is smsc9115, connected via SROMc bank 3. Additionally, some GPIO
> initialization is required.
> 
> Signed-off-by: Pavel Fedin <p.fedin@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5410-smdk5410.dts | 40 +++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/exynos5410-smdk5410.dts b/arch/arm/boot/dts/exynos5410-smdk5410.dts
> index cebeaab..f41952f 100644
> --- a/arch/arm/boot/dts/exynos5410-smdk5410.dts
> +++ b/arch/arm/boot/dts/exynos5410-smdk5410.dts
> @@ -61,6 +61,27 @@
>  	disable-wp;
>  };
>  
> +&pinctrl_0 {
> +	srom_ctl: srom-ctl {
> +		samsung,pins = "gpy0-3", "gpy0-4", "gpy0-5",
> +			       "gpy1-0", "gpy1-1", "gpy1-2", "gpy1-3";
> +		samsung,pin-function = <2>;
> +		samsung,pin-drv = <0>;
> +	};
> +
> +	srom_ebi: srom-ebi {
> +		samsung,pins = "gpy3-0", "gpy3-1", "gpy3-2", "gpy3-3",
> +			       "gpy3-4", "gpy3-5", "gpy3-6", "gpy3-7",
> +			       "gpy5-0", "gpy5-1", "gpy5-2", "gpy5-3",
> +			       "gpy5-4", "gpy5-5", "gpy5-6", "gpy5-7",
> +			       "gpy6-0", "gpy6-1", "gpy6-2", "gpy6-3",
> +			       "gpy6-4", "gpy6-5", "gpy6-6", "gpy6-7";
> +		samsung,pin-function = <2>;
> +		samsung,pin-pud = <3>;
> +		samsung,pin-drv = <0>;
> +	};
> +};
> +
>  &uart0 {
>  	status = "okay";
>  };
> @@ -72,3 +93,22 @@
>  &uart2 {
>  	status = "okay";
>  };
> +
> +&sromc {

Put sromc in alphabetical order.

> +	pinctrl-names = "default";
> +	pinctrl-0 = <&srom_ctl>, <&srom_ebi>;
> +
> +	ethernet at 3 {
> +		compatible = "smsc,lan9115";
> +		reg = <3 0 0x10000>;
> +		phy-mode = "mii";
> +		interrupt-parent = <&gpx0>;
> +		interrupts = <5 8>;

s/8/IRQ_TYPE_LEVEL_LOW/
(is this really level low interrupt?)

> +		reg-io-width = <2>;
> +		smsc,irq-push-pull;
> +		smsc,force-internal-phy;
> +
> +		samsung,srom-page-mode = <1>;
> +		samsung,srom-timing = <9 12 1 9 1 1>;

Some other DTS include regulators: vddvario-supply and vdd33a-supply. It
seems that they are not described in SMSC911x bindings but in
GPMC-eth... but the smsc911x driver is requesting them. Could you
investigate that? I think these regulators should be provided (and
SMSC911x bindings should be updated).

> +	};
> +};

I don't have the board schematics so I couldn't verify the GPIOs.
Overall looks good.

Best regards,
Krzysztof
