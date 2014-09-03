From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 3 Sep 2014 13:48:07 -0300
Subject: [BUG] staging: imx-drm: clock reparent fails for LDB channel 1 on
 i.MX53
In-Reply-To: <54074359.5090500@tqsc.de>
References: <54074359.5090500@tqsc.de>
Message-ID: <CAOMZO5AEKmFg-eM=b6WWYG4qy-1PRcsSHfoKG2aZFMmQBgw5Hw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 3, 2014 at 1:35 PM, Markus Niebel <list-09_linux_arm@tqsc.de> wrote:
> Hello,
>
> playing with LVDS channel 1 on a TQMa53 with MBa53 mainboard we see error
>
> imx-ldb 53fa8008.ldb: unable to set di0 parent clock to ldb_di1
>
> this comes from imx_ldb_set_clock with mux = 0. If setting mux parameter hard to "1"
> LVDS on channel 1 works just fine. The value of the mux param comes from device tree
> port settings.
>
> The following device tree change fixes the issue, but im not sure if this is the
> correct way.
>
> diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
> index 6456a00..acdfabf 100644
> --- a/arch/arm/boot/dts/imx53.dtsi
> +++ b/arch/arm/boot/dts/imx53.dtsi
> @@ -419,10 +419,14 @@
>                                 status = "disabled";
>
>                                 lvds-channel at 0 {
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
>                                         reg = <0>;
>                                         status = "disabled";
>
>                                         port {
> +                                               reg = <0>;
> +
>                                                 lvds0_in: endpoint {
>                                                         remote-endpoint = <&ipu_di0_lvds0>;
>                                                 };
> @@ -430,10 +434,14 @@
>                                 };
>
>                                 lvds-channel at 1 {
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
>                                         reg = <1>;
>                                         status = "disabled";
>
>                                         port {
> +                                               reg = <1>;
> +
>                                                 lvds1_in: endpoint {
>                                                         remote-endpoint = <&ipu_di1_lvds1>;
>                                                 };
>
> In my understanding the i.MX53 has no multiplexer for the input, so
> DI1 -> LVDS1 in case of single channel or separate channels

Your change looks good. Adding Philipp and Shawn on Cc.

Thanks
