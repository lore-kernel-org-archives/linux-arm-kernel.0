From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 22 Dec 2015 10:50:32 +0100
Subject: [PATCH 4/5] ARM: dts: add the wifi/bt regulator for kylin board
In-Reply-To: <1450776833-27639-5-git-send-email-wxt@rock-chips.com>
References: <1450776833-27639-1-git-send-email-wxt@rock-chips.com>
 <1450776833-27639-5-git-send-email-wxt@rock-chips.com>
Message-ID: <1796344.o2BSs8sx7m@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Caesaer,

Am Dienstag, 22. Dezember 2015, 17:33:52 schrieb Caesar Wang:
> Without this the wifi/bluetooth module doesn't work
> properly at bootup.
> 
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> 
> Patchset: Rockchip kylin board Patch[6/6], bring up kylin board.
> We need add the wifi regulator to control the power.
> 
> (am https://patchwork.kernel.org/patch/7873721/)
> ---
> 
>  arch/arm/boot/dts/rk3036-kylin.dts | 43
> +++++++++++++++++++++++++++++++++++++- 1 file changed, 42 insertions(+), 1
> deletion(-)
> 
> diff --git a/arch/arm/boot/dts/rk3036-kylin.dts
> b/arch/arm/boot/dts/rk3036-kylin.dts index 2ef38be..ed0466f 100644
> --- a/arch/arm/boot/dts/rk3036-kylin.dts
> +++ b/arch/arm/boot/dts/rk3036-kylin.dts
> @@ -76,6 +76,32 @@
>  		regulator-always-on;
>  		regulator-boot-on;
>  	};
> +
> +	bt_regulator: bt-regulator {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpio = <&gpio2 9 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&bt_rst_l>;
> +		regulator-name = "bt_regulator";
> +	};
> +
> +	wifi_regulator: wifi-regulator {
> +		/*
> +		 * On the module itself this is one of these (depending
> +		 * on the actual card populated):
> +		 * - SDIO_RESET_L_WL_REG_ON
> +		 * - PDN (power down when low)
> +		 */
> +
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpio = <&gpio0 26 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&wifi_enable_h>;
> +		regulator-name = "wifi_regulator";
> +		vin-supply = <&bt_regulator>;
> +	};
>  };
> 
>  &acodec {
> @@ -303,12 +329,13 @@
>  	sd-uhs-sdr50;
>  	sd-uhs-sdr104;
>  	cap-sdio-irq;
> +	card-external-vcc-supply = <&wifi_regulator>;

as I said in our chat, that concept didn't make it into the kernel. mmc-power-
sequences are the new thing. Please look into the sdio-pwrseq node in rk3288-
veyron.dtsi for examples.


Heiko

>  	default-sample-phase = <90>;
>  	keep-power-in-suspend;
>  	non-removable;
>  	num-slots = <1>;
>  	pinctrl-names = "default";
> -	pinctrl-0 = <&sdio_clk &sdio_cmd &sdio_bus4>;
> +	pinctrl-0 = <&sdio_clk &sdio_cmd &sdio_bus4 &bt_wake_h>;
>  };
> 
>  &uart2 {
> @@ -330,6 +357,20 @@
>  		};
>  	};
> 
> +	sdio {
> +		wifi_enable_h: wifienable-h {
> +			rockchip,pins = <0 26 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		bt_rst_l: bt-rst-l {
> +			rockchip,pins = <2 9 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		bt_wake_h: bt-wake-h {
> +			rockchip,pins = <2 8 RK_FUNC_GPIO &pcfg_pull_default>;
> +		};
> +	};
> +
>  	sleep {
>  		global_pwroff: global-pwroff {
>  			rockchip,pins = <2 7 RK_FUNC_1 &pcfg_pull_none>;
