From: heiko@sntech.de (Heiko Stuebner)
Date: Mon, 08 Oct 2018 11:30:47 +0200
Subject: [PATCH 3/3] This patch adds wifi to asus tinker board S
In-Reply-To: <20180922170236.8690-4-beagleboard@davidjohnsummers.uk>
References: <20180922170236.8690-1-beagleboard@davidjohnsummers.uk>
 <20180922170236.8690-4-beagleboard@davidjohnsummers.uk>
Message-ID: <5682345.Yzn33l6ONg@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

Am Samstag, 22. September 2018, 19:02:36 CEST schrieb David Summers:
> Now as fair as I understand. the asus tinker board contains a wifi
> So should this patch be added to the tinker board dtsi ?
> 
> It also far move complex - it adds far more things, so consider
> 
> Signed-off-by: David Summers <beagleboard@davidjohnsummers.uk>
> ---
>  arch/arm/boot/dts/rk3288-tinker-s.dts | 93 +++++++++++++++++++++++++++
>  1 file changed, 93 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/rk3288-tinker-s.dts b/arch/arm/boot/dts/rk3288-tinker-s.dts
> index bc691e3f9c07..3d91924fd8db 100644
> --- a/arch/arm/boot/dts/rk3288-tinker-s.dts
> +++ b/arch/arm/boot/dts/rk3288-tinker-s.dts
> @@ -10,6 +10,95 @@
>  / {
>  	model = "Rockchip RK3288 Asus Tinker Board S";
>  	compatible = "asus,rk3288-tinker-s", "rockchip,rk3288";
> +
> +	wireless-bluetooth {
> +		compatible = "bluetooth-platdata";
> +		uart_rts_gpios = <&gpio4 19 GPIO_ACTIVE_LOW>;
> +		pinctrl-names = "default","rts_gpio";
> +		pinctrl-0 = <&uart0_rts>;
> +		pinctrl-1 = <&uart0_gpios>;
> +		BT,reset_gpio    = <&gpio4 29 GPIO_ACTIVE_HIGH>;
> +		BT,wake_gpio     = <&gpio4 26 GPIO_ACTIVE_HIGH>;
> +		BT,wake_host_irq = <&gpio4 31 GPIO_ACTIVE_HIGH>;
> +		status = "okay";
> +	};

the basic problem here is, that all these nodes stem from the so called
soc-vendor-tree. Devicetree bindings normally go through a review process
while soc vendors often invent their own shortcut that is not and will
not be supported by the mainline kernel.

Bluetooth-platdata and wlan-platdata are examples of that.

Additionally, the kernel now has the somewhat new "serdev" to manage the
needed connection between bluetooth and uart. See
http://events17.linuxfoundation.org/sites/events/files/slides/serdev-elce-2017-2.pdf
for an introduction.


> +	wireless-wlan {
> +		compatible = "wlan-platdata";
> +		rockchip,grf = <&grf>;
> +		wifi_chip_type = "ap6212";
> +		sdio_vref = <1800>;
> +		WIFI,host_wake_irq = <&gpio4 30 GPIO_ACTIVE_HIGH>;
> +		status = "okay";
> +	};
> +
> +	io-domains {
> +		compatible = "rockchip,rk3288-io-voltage-domain";
> +		rockchip,grf = <&grf>;
> +		flash0-supply = <&vcc_flash>;
> +		gpio30-supply = <&vcc_io>;
> +		wifi-supply = <&vcc_18>;
> +		sdcard-supply = <&vccio_sd>;
> +	};

io-domains node is already present in rk3288-tinker.dtsi, so please
add additional properties there (compatible + rockchip,grf are not needed)

> +
> +	sdio_pwrseq: sdio-pwrseq {
> +		compatible = "mmc-pwrseq-simple";
> +		clocks = <&rk808 1>;
> +		clock-names = "ext_clock";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&chip_enable_h>, <&wifi_enable_h>;
> +
> +		/*
> +		 * On the module itself this is one of these (depending
> +		 * on the actual card populated):
> +		 * - SDIO_RESET_L_WL_REG_ON
> +		 * - PDN (power down when low)
> +		 */
> +		reset-gpios = <&gpio4 28 GPIO_ACTIVE_LOW>, <&gpio4 27 GPIO_ACTIVE_LOW>;
> +	};
> +
> +	vcc_flash: flash-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc_flash";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		vin-supply = <&vcc_io>;
> +	};

that is a supply for the emmc - so not related to wifi at all, and I don't
think that is actually named that way in the device schematics. Please
use supply-names as described in the schematics pdf - I'd think Asus
should provide one for the dev-board somewhere.


> +};
> +
> +&pinctrl {
> +	sdio-pwrseq {
> +		wifi_enable_h: wifi-enable-h {
> +			rockchip,pins = <4 28 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +		chip_enable_h: chip-enable-h {
> +			rockchip,pins = <4 27 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	wireless-bluetooth {
> +		uart0_gpios: uart0-gpios {
> +			rockchip,pins = <4 19 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};

not needed

> +};
> +
> +&sdio0 {
> +	status = "okay";
> +	clock-frequency = <50000000>;
> +	clock-freq-min-max = <200000 50000000>;
> +	bus-width = <4>;
> +	cap-sd-highspeed;
> +	cap-sdio-irq;
> +	disable-wp;
> +	keep-power-in-suspend;
> +	mmc-pwrseq = <&sdio_pwrseq>;
> +	non-removable;
> +	num-slots = <1>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&sdio0_bus4 &sdio0_cmd &sdio0_clk>;
> +	sd-uhs-sdr104;
> +	supports-sdio;
>  };
>  
>  &emmc {
> @@ -25,3 +114,7 @@
>  	mmc-ddr-1_8v;
>  	status = "okay";
>  };
> +
> +&uart0 {
> +	pinctrl-0 = <&uart0_xfer>, <&uart0_cts>;
> +};
> 

So ideally, take a look at other Rockchip boards on how they hook up wifi
and start small by checking what the &sdio part above actually needs to
function, then expand from there.


Heiko
