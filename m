From: jagan@amarulasolutions.com (Jagan Teki)
Date: Tue, 5 Dec 2017 11:45:47 +0530
Subject: [PATCH] arm64: dts: allwinner: a64: bananapi-m64: Add LED device
 node
In-Reply-To: <20171201162733.23156-1-wens@csie.org>
References: <20171201162733.23156-1-wens@csie.org>
Message-ID: <CAMty3ZC2-sVbCgzKV3nZQfG4CtNXJdntuPhjyr_Wbn1xXJc=Dw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 1, 2017 at 9:57 PM, Chen-Yu Tsai <wens@csie.org> wrote:
> The Bananapi-M64 has 3 LEDS in red, green, and blue. These are toggled
> via GPIO lines, which drive transistors that control current across the
> LEDS. The red LED is by default on, via an additional pull-up on the
> control line. We consider this means that it is a power indicator.
> So we set the "default-on" property for it.
>
> The pingroups the GPIO lines belong to require external regulators be
> enabled to be able to drive the GPIO high. These regulators also have
> other purposes. However the pin controller does not have bindings for
> regulators. Here we just set them to always-on.
>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  .../boot/dts/allwinner/sun50i-a64-bananapi-m64.dts | 36 ++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
> index 4a8d3f83a36e..a6975670cd1c 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
> @@ -60,6 +60,26 @@
>                 stdout-path = "serial0:115200n8";
>         };
>
> +       leds {
> +               compatible = "gpio-leds";
> +
> +               pwr-led {
> +                       label = "bananapi-m64:red:pwr";
> +                       gpios = <&pio 3 24 GPIO_ACTIVE_HIGH>; /* PD24 */
> +                       default-state = "on";
> +               };
> +
> +               green {
> +                       label = "bananapi-m64:green:user";
> +                       gpios = <&pio 4 14 GPIO_ACTIVE_HIGH>; /* PE14 */
> +               };
> +
> +               blue {
> +                       label = "bananapi-m64:blue:user";
> +                       gpios = <&pio 4 15 GPIO_ACTIVE_HIGH>; /* PE15 */
> +               };
> +       };
> +
>         wifi_pwrseq: wifi_pwrseq {
>                 compatible = "mmc-pwrseq-simple";
>                 reset-gpios = <&r_pio 0 2 GPIO_ACTIVE_LOW>; /* PL2 */
> @@ -153,6 +173,17 @@
>
>  #include "axp803.dtsi"
>
> +&reg_aldo1 {
> +       /*
> +        * This regulator also drives the PE pingroup GPIOs,
> +        * which also controls two LEDs.
> +        */
> +       regulator-always-on;
> +       regulator-min-microvolt = <2800000>;
> +       regulator-max-microvolt = <2800000>;

why 2.8v?

> +       regulator-name = "afvcc-csi";
> +};
> +
>  &reg_aldo2 {
>         regulator-always-on;
>         regulator-min-microvolt = <1800000>;
> @@ -168,6 +199,11 @@
>  };
>
>  &reg_dc1sw {
> +       /*
> +        * This regulator also indirectly drives the PD pingroup GPIOs,
> +        * which also controls the power LED.
> +        */
> +       regulator-always-on;

This make rgmii phy always on, does this make emac power-drop?



-- 
Jagan Teki
Senior Linux Kernel Engineer | Amarula Solutions
U-Boot, Linux | Upstream Maintainer
Hyderabad, India.
