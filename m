From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 28 Jun 2018 10:51:11 +0800
Subject: [linux-sunxi] [PATCH v3 24/24] ARM: dts: sun8i: r40: Enable HDMI
 output on BananaPi M2 Ultra
In-Reply-To: <20180625120304.7543-25-jernej.skrabec@siol.net>
References: <20180625120304.7543-1-jernej.skrabec@siol.net>
 <20180625120304.7543-25-jernej.skrabec@siol.net>
Message-ID: <CAGb2v65AE4N6Jabo5co3nu+eitYoJwmakqU7QQtcYukG6JLY+w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 25, 2018 at 8:03 PM, Jernej Skrabec <jernej.skrabec@siol.net> wrote:
> Since HDMI can be considered as main output, most capable mixer is
> connected to it (mixer0).
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  .../boot/dts/sun8i-r40-bananapi-m2-ultra.dts  | 45 +++++++++++++++++++
>  1 file changed, 45 insertions(+)
>
> diff --git a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
> index 27d9ccd0ef2f..0ebc2f9a980e 100644
> --- a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
> +++ b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
> @@ -58,6 +58,17 @@
>                 stdout-path = "serial0:115200n8";
>         };
>
> +       connector {
> +               compatible = "hdmi-connector";
> +               type = "a";
> +
> +               port {
> +                       hdmi_con_in: endpoint {
> +                               remote-endpoint = <&hdmi_out_con>;
> +                       };
> +               };
> +       };
> +
>         leds {
>                 compatible = "gpio-leds";
>
> @@ -93,6 +104,10 @@
>         };
>  };
>
> +&de {
> +       status = "okay";
> +};
> +
>  &ehci1 {
>         status = "okay";
>  };
> @@ -101,6 +116,16 @@
>         status = "okay";
>  };
>
> +&hdmi {
> +       status = "okay";
> +};
> +
> +&hdmi_out {
> +       hdmi_out_con: endpoint {
> +               remote-endpoint = <&hdmi_con_in>;
> +       };
> +};
> +
>  &i2c0 {
>         status = "okay";
>
> @@ -195,6 +220,26 @@
>         status = "okay";
>  };
>
> +&tcon_top_hdmi_in_tcon_tv0 {
> +       remote-endpoint = <&tcon_tv0_out_tcon_top>;
> +};
> +
> +&tcon_top_mixer0_out_tcon_tv0 {
> +       remote-endpoint = <&tcon_tv0_in_tcon_top>;
> +};
> +
> +&tcon_tv0_in {
> +       tcon_tv0_in_tcon_top: endpoint {
> +               remote-endpoint = <&tcon_top_mixer0_out_tcon_tv0>;
> +       };
> +};
> +
> +&tcon_tv0_out {
> +       tcon_tv0_out_tcon_top: endpoint {
> +               remote-endpoint = <&tcon_top_hdmi_in_tcon_tv0>;
> +       };
> +};
> +

This is the wrong place for this. Once removed,

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

>  &uart0 {
>         pinctrl-names = "default";
>         pinctrl-0 = <&uart0_pb_pins>;
> --
> 2.18.0
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe at googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
