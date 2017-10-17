From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 17 Oct 2017 22:38:45 +0800
Subject: [linux-sunxi] [PATCH 08/10] ARM: dts: sun4i: Enable HDMI support
 on some A10 devices
In-Reply-To: <20171017121807.2994-9-wens@csie.org>
References: <20171017121807.2994-1-wens@csie.org>
 <20171017121807.2994-9-wens@csie.org>
Message-ID: <CAGb2v65Z2N24AZp=Y-_YgKuZiT1uSDX5pzMrceU3+TY=+Zdf7g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 17, 2017 at 8:18 PM, Chen-Yu Tsai <wens@csie.org> wrote:
> Various A10-based development boards have standard HDMI connectors
> wired to the dedicated HDMI pins on the SoC.
>
> Enable the display pipeline and HDMI output on boards I have or have
> access to schematics:
>
>   - Cubieboard
>   - Olimex A10-OLinuXino-LIME
>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>
> Can someone could double check the LIME for me? It should work given
> it's the same layout as the A20 variant, which has been tested.
>
> ---
>  arch/arm/boot/dts/sun4i-a10-cubieboard.dts     | 25 +++++++++++++++++++++++++
>  arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts | 21 +++++++++++++++++++++
>  2 files changed, 46 insertions(+)
>
> diff --git a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
> index d5ba5400a975..1982c8c238c5 100644
> --- a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
> +++ b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
> @@ -59,6 +59,17 @@
>                 stdout-path = "serial0:115200n8";
>         };
>
> +       hdmi-connector {
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
>                 pinctrl-names = "default";
> @@ -90,6 +101,10 @@
>         cpu-supply = <&reg_dcdc2>;
>  };
>
> +&de {
> +       status = "okay";
> +};
> +
>  &ehci0 {
>         status = "okay";
>  };
> @@ -107,6 +122,16 @@
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
> diff --git a/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts b/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts
> index 2d1b4329f54a..e39ec9beef75 100644
> --- a/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts
> +++ b/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts
> @@ -58,6 +58,17 @@
>                 stdout-path = "serial0:115200n8";
>         };
>
> +       hdmi-connector {
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
>                 pinctrl-names = "default";
> @@ -106,6 +117,16 @@
>         status = "okay";
>  };

The LIME's dts change is missing the &de part. :(
I can fix this when applying.

ChenYu

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
> --
> 2.14.2
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe at googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
