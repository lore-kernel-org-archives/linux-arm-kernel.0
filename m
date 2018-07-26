From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 26 Jul 2018 15:48:09 +0800
Subject: [PATCH v2 17/18] arm64: dts: allwinner: a64: NanoPi-A64: Add
 Wifi/Bluetooth chip
In-Reply-To: <20180726003532.18751-18-andre.przywara@arm.com>
References: <20180726003532.18751-1-andre.przywara@arm.com>
 <20180726003532.18751-18-andre.przywara@arm.com>
Message-ID: <CAGb2v64UKUj6EkiqT5pnY28vZQjwS+bPmgZAce8O=vNmKDmWHg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 26, 2018 at 8:35 AM, Andre Przywara <andre.przywara@arm.com> wrote:
> The NanoPi-A64 has an on-board WiFi/Bluetooth combo chip, connected

The NanoPi A64 uses the RTL8189, which does _not_ have Bluetooth.
Something is seriously wrong here.

> to the usual MMC1 and UART1. The AXP power line is the always-on
> VDD_SYS_3.3V, but it uses pin L2 to enable the regulator.
> As the actual WiFi driver is not in mainline Linux, it doesn't have a
> compatible string, so we omit this from the node.
>
> Add the respective nodes to the DT to make it usable.
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  .../boot/dts/allwinner/sun50i-a64-nanopi-a64.dts   | 31 ++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
> index bd35a093e6cd..705e0b23589e 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
> @@ -53,11 +53,17 @@
>         aliases {
>                 ethernet0 = &emac;
>                 serial0 = &uart0;
> +               serial1 = &uart1;
>         };
>
>         chosen {
>                 stdout-path = "serial0:115200n8";
>         };
> +
> +       wifi_pwrseq: wifi_pwrseq {
> +               compatible = "mmc-pwrseq-simple";
> +               reset-gpios = <&r_pio 0 2 GPIO_ACTIVE_LOW>; /* PL2 */
> +       };
>  };
>
>  &ehci0 {
> @@ -105,6 +111,24 @@
>         status = "okay";
>  };
>
> +&mmc1 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&mmc1_pins>;
> +       vmmc-supply = <&reg_dcdc1>;
> +       vqmmc-supply = <&reg_dldo4>;
> +       mmc-pwrseq = <&wifi_pwrseq>;
> +       bus-width = <4>;
> +       non-removable;
> +       status = "okay";
> +
> +       rtl8189etv: wifi at 1 {
> +               reg = <1>;
> +               interrupt-parent = <&r_pio>;
> +               interrupts = <0 3 IRQ_TYPE_LEVEL_LOW>; /* PL3 */
> +               interrupt-names = "host-wake";
> +       };
> +};
> +
>  &ohci0 {
>         status = "okay";
>  };
> @@ -222,6 +246,13 @@
>         status = "okay";
>  };
>
> +/* Connected to the Bluetooth UART, with hardware handshake pins */
> +&uart1 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&uart1_pins>, <&uart1_rts_cts_pins>;
> +       status = "okay";
> +};
> +
>  &usbphy {
>         status = "okay";
>  };
> --
> 2.14.4
>
