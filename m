From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 24 Jul 2018 10:21:59 +0800
Subject: [PATCH 3/3] arm64: allwinner: dts: h6: add Wi-Fi support for Pine
 H64 model A/B
In-Reply-To: <20180724011551.49603-4-icenowy@aosc.io>
References: <20180724011551.49603-1-icenowy@aosc.io>
 <20180724011551.49603-4-icenowy@aosc.io>
Message-ID: <CAGb2v67zR-Q9n7L6CaFKDUJFHFEC_h8-RYxkdyeyJb_GbNmkJw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 24, 2018 at 9:15 AM, Icenowy Zheng <icenowy@aosc.io> wrote:
> The Pine H64 model A has a Wi-Fi module connector and the model B has an
> on-board RTL8723BS Wi-Fi module.
>
> Add support for them. For model A, as it's not defaultly present, keep
> it disabled now.

Nope. Pine64 actually has two WiFi/BT modules. And they require different
device tree snippets for both the WiFi and BT side. This is better resolved
with device tree overlays.

I have both, though I've yet found time to work on them.

ChenYu

> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  .../allwinner/sun50i-h6-pine-h64-model-b.dts  |  8 +++++
>  .../boot/dts/allwinner/sun50i-h6-pine-h64.dts | 29 +++++++++++++++++++
>  2 files changed, 37 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-model-b.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-model-b.dts
> index d0fcc25efb00..d0f775613c9b 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-model-b.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-model-b.dts
> @@ -18,3 +18,11 @@
>                 };
>         };
>  };
> +
> +&mmc1 {
> +       status = "okay";
> +};
> +
> +&wifi_pwrseq {
> +       status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
> index a85867f8b684..75db6d4139bf 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
> @@ -40,6 +40,12 @@
>                         gpios = <&r_pio 0 7 GPIO_ACTIVE_HIGH>; /* PL7 */
>                 };
>         };
> +
> +       wifi_pwrseq: wifi_pwrseq {
> +               compatible = "mmc-pwrseq-simple";
> +               reset-gpios = <&r_pio 1 3 GPIO_ACTIVE_LOW>; /* PL2 */
> +               status = "disabled";
> +       };
>  };
>
>  &mmc0 {
> @@ -50,6 +56,17 @@
>         status = "okay";
>  };
>
> +&mmc1 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&mmc1_pins>;
> +       vmmc-supply = <&reg_cldo2>;
> +       vqmmc-supply = <&reg_bldo2>;
> +       mmc-pwrseq = <&wifi_pwrseq>;
> +       bus-width = <4>;
> +       non-removable;
> +       status = "disabled";
> +};
> +
>  &mmc2 {
>         pinctrl-names = "default";
>         pinctrl-0 = <&mmc2_pins>;
> @@ -128,12 +145,24 @@
>                         };
>
>                         reg_cldo2: cldo2 {
> +                               /*
> +                                * This regulator is connected with CLDO3.
> +                                * Before the kernel can support synchronized
> +                                * enable of coupled regulators, keep them
> +                                * both always on as a ugly hack.
> +                                */
> +                               regulator-always-on;
>                                 regulator-min-microvolt = <3300000>;
>                                 regulator-max-microvolt = <3300000>;
>                                 regulator-name = "vcc-wifi-1";
>                         };
>
>                         reg_cldo3: cldo3 {
> +                               /*
> +                                * This regulator is connected with CLDO2.
> +                                * See the comments for CLDO2.
> +                                */
> +                               regulator-always-on;
>                                 regulator-min-microvolt = <3300000>;
>                                 regulator-max-microvolt = <3300000>;
>                                 regulator-name = "vcc-wifi-2";
> --
> 2.18.0
>
