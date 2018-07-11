From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 11 Jul 2018 22:15:41 +0800
Subject: [linux-sunxi] [PATCH 2/2] ARM: sun8i: h3: add SY8113B regulator
 on Banana Pi M2 Zero board
In-Reply-To: <20180711134450.43148-1-icenowy@aosc.io>
References: <20180711134450.43148-1-icenowy@aosc.io>
Message-ID: <CAGb2v65C=gQtkNUX4pV5wudWUPf3hLNnGuxgB48xq=d7nH9qxA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jul 11, 2018 at 9:44 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
> Banana Pi M2 Zero board has a SY8113B regulator, which is controlled via
> GPIO and capable of outputing 1.1V when the PL1 GPIO is set to output 0
> or 1.1V when the PL6 GPIO is set to input or output 1, and the output is
> the power supply of the ARM cores in H3 SoC.
>
> Add the device tree node of this regulator and set the cpu's cpu-supply
> property to it.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  .../dts/sun8i-h2-plus-bananapi-m2-zero.dts    | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts b/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
> index eb61dcf32797..abc8dc750f4b 100644
> --- a/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
> +++ b/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
> @@ -59,6 +59,23 @@
>                 };
>         };
>
> +       reg_vdd_cpux: vdd-cpux-regulator {
> +               compatible = "regulator-gpio";
> +               regulator-name = "vdd-cpux";
> +               regulator-type = "voltage";
> +               regulator-boot-on;
> +               regulator-always-on;
> +               regulator-min-microvolt = <1100000>;
> +               regulator-max-microvolt = <1300000>;
> +               regulator-ramp-delay = <50>; /* 4ms */
> +
> +               gpios = <&r_pio 0 1 GPIO_ACTIVE_HIGH>; /* PL1 */
> +               enable-active-high;
> +               gpios-states = <0x1>;
> +               states = <1100000 0x0

So looking@the schematics with the resistor values, this calculates
to roughly 1.108475 (0.6 * (1 + 10 / 11.8)) ...

> +                         1300000 0x1>;

and this to 1.308475.

ChenYu

> +       };
> +
>         wifi_pwrseq: wifi_pwrseq {
>                 compatible = "mmc-pwrseq-simple";
>                 pinctrl-names = "default";
> @@ -66,6 +83,10 @@
>         };
>  };
>
> +&cpu0 {
> +       cpu-supply = <&reg_vdd_cpux>;
> +};
> +
>  &de {
>         status = "okay";
>  };
> --
> 2.17.1
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe at googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
