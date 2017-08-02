From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 2 Aug 2017 10:55:55 +0800
Subject: [PATCH v2] ARM: dts: sun8i: h3: Enable EMAC with external PHY on
 NanoPi M1 Plus
In-Reply-To: <20170802025026.24232-1-luaraneda@gmail.com>
References: <20170802025026.24232-1-luaraneda@gmail.com>
Message-ID: <CAGb2v653hG2h5fZSBGeXaVE2Gn03vsncHi1d87cmyYA=w2TnKw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 2, 2017 at 10:50 AM, Luis Araneda <luaraneda@gmail.com> wrote:
> The Nanopi M1 Plus uses an external Realtek RTL8211E PHY in RGMII mode,
> enabled by a GPIO-based regulator.
>
> Signed-off-by: Luis Araneda <luaraneda@gmail.com>
>
> ---
> Changes v1 -> v2:
> - Removed unnecessary property
> - Corrected part address to match reg value
>
>  arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts | 30 +++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts b/arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts
> index 8ddd1b2cc..1273a5e45 100644
> --- a/arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts
> +++ b/arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts
> @@ -45,6 +45,20 @@
>  / {
>         model = "FriendlyArm NanoPi M1 Plus";
>         compatible = "friendlyarm,nanopi-m1-plus", "allwinner,sun8i-h3";
> +
> +       aliases {
> +               ethernet0 = &emac;
> +       };
> +
> +       reg_gmac_3v3: gmac-3v3 {
> +               compatible = "regulator-fixed";
> +               regulator-name = "gmac-3v3";
> +               regulator-min-microvolt = <3300000>;
> +               regulator-max-microvolt = <3300000>;
> +               startup-delay-us = <100000>;
> +               enable-active-high;
> +               gpio = <&pio 3 6 GPIO_ACTIVE_HIGH>; /* PD6 */
> +       };
>  };
>
>  &ehci1 {
> @@ -55,6 +69,22 @@
>         status = "okay";
>  };
>
> +&emac {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&emac_rgmii_pins>;
> +       phy-supply = <&reg_gmac_3v3>;
> +       phy-handle = <&ext_rgmii_phy>;
> +       phy-mode = "rgmii";
> +       status = "okay";
> +};
> +
> +&mdio {
> +       ext_rgmii_phy: ethernet-phy at 0 {
> +               compatible = "ethernet-phy-ieee802.3-c22";
> +               reg = <0>;

Please use the actual address as designed on the board.
It seems to be 7. 0 for the RTL8211E is a broadcast address.

ChenYu

> +       };
> +};
> +
>  &ohci1 {
>         status = "okay";
>  };
> --
> 2.13.3
>
