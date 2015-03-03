From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 03 Mar 2015 11:42:16 +0100
Subject: [PATCH 2/2] ARM: dts: hummingboard: Setup pwm lines
In-Reply-To: <E1YSWZL-0002Aw-B5@rmk-PC.arm.linux.org.uk>
References: <E1YSWZL-0002Aw-B5@rmk-PC.arm.linux.org.uk>
Message-ID: <1425379336.3146.38.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, den 02.03.2015, 20:03 +0000 schrieb Russell King:
> From: Rabeeh Khoury <rabeeh@solid-run.com>
> 
> Setup pwm lines as follows -
> pwm1: In case HummingBoard base carrier; this pin drives through a serial
>       capacitor the mono out of the audio jack.
>       In case HummingBoard pro the this pad can be reached by wiring to
>       C8 capacitors on the board.
> pwm2: Setup pwm2 on gpio-1 but leave the default function of the iopad as
>       a gpio.
>       The user can change the io pad mux in user space and therefore use
>       this function on gpio-1 (pin number 7 on the 26 pin header).
> pwm3,pwm4: unused
> 
> Signed-off-by: Rabeeh Khoury <rabeeh@solid-run.com>
> [tweaked alias for pwm pinctrl group --rmk]
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
> For acks please.
> 
>  arch/arm/boot/dts/imx6qdl-hummingboard.dtsi | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi b/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
> index 93588c987d2c..c0dc5948fa3c 100644
> --- a/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
> @@ -164,6 +164,10 @@
>  			>;
>  		};
>  
> +		pinctrl_hummingboard_pwm1: pwm1grp {
> +			fsl,pins = <MX6QDL_PAD_DISP0_DAT8__PWM1_OUT 0x1b0b1>;
> +		};
> +
>  		pinctrl_hummingboard_spdif: hummingboard-spdif {
>  			fsl,pins = <MX6QDL_PAD_GPIO_17__SPDIF_OUT 0x13091>;
>  		};
> @@ -203,6 +207,25 @@
>  	};
>  };
>  
> +&pwm1 {
> +	 pinctrl-names = "default";
> +	 pinctrl-0 = <&pinctrl_hummingboard_pwm1>;
> +	 status = "okay";
> +};
> +
> +&pwm2 {
> +	 pinctrl-names = "default";
> +	 status = "okay";
> +};
> +
> +&pwm3 {
> +	status = "disabled";
> +};
> +
> +&pwm4 {
> +	status = "disabled";
> +};

I wanted to point out these two are superfluous since pwm3/4 are
disabled in the dtsi by default, but I just learned they aren't.

Should we add status = "disabled" to unusable (because not externally
connected) PWMs, and if so, shouldn't that be done in the dtsi already?

regards
Philipp
