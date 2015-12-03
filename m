From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 03 Dec 2015 16:43:02 +0100
Subject: [PATCH 1/3] ARM: dts: rockchip: make sure edp_24m is associated
 to xin24m on veyron
In-Reply-To: <2767415.mEkgRbSSUB@diego>
References: <2767415.mEkgRbSSUB@diego>
Message-ID: <3006808.mS23SN11BJ@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 1. Dezember 2015, 18:14:27 schrieb Heiko St?bner:

applied all three patches to my dts32 branch for 4.5, after disabling emmc 
tuning on mickey (in a similar fashion as on minnie) for the short term.

> The edp-24m clock has two possible sources: the 24MHz oscillator as well
> as an external 27MHz input. The power-on-default is the 27MHz clock which
> is not supplied on all Rockchip boards. While on all current boards and
> also all Veyron Chromebooks the bootloader seems to adapt the muxing to
> the internal source, this doesn't seem to be the case on headless veyron
> devices like brain and mickey making the edp-24m clock an orphan.
> On the hardware side the 27m input also is not connected at all.
> 
> With the upcoming deferral of orphan-clocks this results in the power-
> domain code deferring, as it cannot request the needed clock and if the
> synchronous reset is sucessfullat all in this case is also unknown.
> 
> So fix that by making sure, the edp-24m clock is muxed to the internal
> 24MHz oscillator at all times.
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@collabora.com>
> ---
> It seems I had some issues sending, sorry about the double-mails.
> 
>  arch/arm/boot/dts/rk3288-veyron.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/rk3288-veyron.dtsi
> b/arch/arm/boot/dts/rk3288-veyron.dtsi index 5e61f07..9fce91f 100644
> --- a/arch/arm/boot/dts/rk3288-veyron.dtsi
> +++ b/arch/arm/boot/dts/rk3288-veyron.dtsi
> @@ -340,6 +340,11 @@
>  	i2c-scl-rising-time-ns = <1000>;
>  };
> 
> +&power {
> +	assigned-clocks = <&cru SCLK_EDP_24M>;
> +	assigned-clock-parents = <&xin24m>;
> +};
> +
>  &pwm1 {
>  	status = "okay";
>  };
