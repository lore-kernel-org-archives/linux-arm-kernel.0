From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon, 28 May 2018 18:41:45 +0200
Subject: [PATCH 12/12] ARM: dts: exynos5250-arndale: add dsi and panel
 nodes
In-Reply-To: <1527501347-16521-1-git-send-email-m.purski@samsung.com>
References: <CGME20180528095555eucas1p2fb61f362a3aa2d0082b8c4001b17f176@eucas1p2.samsung.com>
 <1527500833-16005-1-git-send-email-m.purski@samsung.com>
 <1527501347-16521-1-git-send-email-m.purski@samsung.com>
Message-ID: <CAJKOXPc6Wxcs2XYKGRXT7_G8ENzgJT1ocWAqviNs1D-mGBoF7w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 28, 2018 at 11:55 AM, Maciej Purski <m.purski@samsung.com> wrote:
> The patch adds bridge and panel nodes.
> It adds also DSI properties specific for arndale board.
>
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> Signed-off-by: Maciej Purski <m.purski@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5250-arndale.dts | 39 ++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>
> diff --git a/arch/arm/boot/dts/exynos5250-arndale.dts b/arch/arm/boot/dts/exynos5250-arndale.dts
> index 80221fa..6f0b1c4 100644
> --- a/arch/arm/boot/dts/exynos5250-arndale.dts
> +++ b/arch/arm/boot/dts/exynos5250-arndale.dts
> @@ -71,6 +71,17 @@
>                 };
>         };
>
> +       panel: panel {
> +               compatible = "boe,hv070wsa-100";
> +               power-supply = <&vcc_3v3_reg>;
> +               enable-gpios = <&gpd1 3 GPIO_ACTIVE_HIGH>;
> +               port {
> +                       panel_ep: endpoint {
> +                               remote-endpoint = <&bridge_out_ep>;
> +                       };
> +               };
> +       };
> +
>         regulators {
>                 compatible = "simple-bus";
>                 #address-cells = <1>;
> @@ -476,6 +487,34 @@
>         };
>  };
>
> +&dsi_0 {

Please put the node alphabetically, so before &dp.

Also this patch should be squashed with previous one (regulators),
because adding non-controllable fixed regulators on its own does not
bring benefits. Linux will not disable them. You added these
regulators for the bridge below. Without the bridge, their existence
does not have much sense.

Best regards,
Krzysztof

> +       vddcore-supply = <&ldo8_reg>;
> +       vddio-supply = <&ldo10_reg>;
> +       samsung,pll-clock-frequency = <24000000>;
> +       samsung,burst-clock-frequency = <320000000>;
> +       samsung,esc-clock-frequency = <10000000>;
> +       status = "okay";
> +
> +       bridge at 0 {
> +               reg = <0>;
> +               compatible = "toshiba,tc358764";
> +               vddc-supply = <&vcc_1v2_reg>;
> +               vddio-supply = <&vcc_1v8_reg>;
> +               vddmipi-supply = <&vcc_1v2_reg>;
> +               vddlvds133-supply = <&vcc_3v3_reg>;
> +               vddlvds112-supply = <&vcc_1v2_reg>;
> +               reset-gpios = <&gpd1 6 GPIO_ACTIVE_LOW>;
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               port at 1 {
> +                       reg = <1>;
> +                       bridge_out_ep: endpoint {
> +                               remote-endpoint = <&panel_ep>;
> +                       };
> +               };
> +       };
> +};
> +
>  &i2c_2 {
>         status = "okay";
>         /* used by HDMI DDC */
> --
> 2.7.4
>
