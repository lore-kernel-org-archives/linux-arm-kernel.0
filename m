From: wens@csie.org (Chen-Yu Tsai)
Date: Sun, 31 Jan 2016 11:46:25 +0800
Subject: [PATCH 11/14] ARM: dts: sun8i-a83t: Add R_PIO controller node to
 the dtsi
In-Reply-To: <1454203266-4450-12-git-send-email-vishnupatekar0510@gmail.com>
References: <1454203266-4450-1-git-send-email-vishnupatekar0510@gmail.com>
 <1454203266-4450-12-git-send-email-vishnupatekar0510@gmail.com>
Message-ID: <CAGb2v65=2VvyiUUHQ_yM_99tEF4pHuvQWWM0q7wTZ0nhVY7+xg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 31, 2016 at 9:21 AM, Vishnu Patekar
<vishnupatekar0510@gmail.com> wrote:
> Now that we have a driver for the R_PIO controller,
> add the corresponding device node to the dtsi.
>
> Signed-off-by: Vishnu Patekar <vishnupatekar0510@gmail.com>
> ---
>  arch/arm/boot/dts/sun8i-a83t.dtsi | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
> index 5ea20ff..11be9e1 100644
> --- a/arch/arm/boot/dts/sun8i-a83t.dtsi
> +++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
> @@ -478,5 +478,26 @@
>                         compatible = "allwinner,sun6i-a31-clock-reset";
>                         #reset-cells = <1>;
>                 };
> +
> +               r_pio: pinctrl at 01f02c00 {
> +                       compatible = "allwinner,sun8i-a83t-r-pinctrl";
> +                       reg = <0x01f02c00 0x400>;
> +                       interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&apb0_gates 0>;
> +                       resets = <&apb0_reset 0>;
> +                       gpio-controller;
> +                       interrupt-controller;
> +                       #interrupt-cells = <3>;
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;

#address-cells and #size-cells aren't needed. They were incorrectly included
in the first place. They were removed from &pio but not &r_pio.

> +                       #gpio-cells = <3>;
> +
> +                       r_rsb_pins: r_rsb {
> +                               allwinner,pins = "PL0", "PL1";
> +                               allwinner,function = "s_rsb";
> +                               allwinner,drive = <SUN4I_PINCTRL_20_MA>;
> +                               allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
> +                       };

This setting should be part of the next patch, the RSB node patch.
The rest looks fine.

ChenYu

> +               };
>         };
>  };
> --
> 1.9.1
>
