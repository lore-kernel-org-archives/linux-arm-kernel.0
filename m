From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 24 Jun 2016 13:48:38 +0800
Subject: [PATCH] ARM: dts: sun7i: Add BCM53125 Device Tree nodes
In-Reply-To: <1465690459-30751-2-git-send-email-f.fainelli@gmail.com>
References: <1465690459-30751-1-git-send-email-f.fainelli@gmail.com>
 <1465690459-30751-2-git-send-email-f.fainelli@gmail.com>
Message-ID: <CAGb2v64u74cXG0R-MSMtDBxBpg2tFoifQwqbvWL-+3pG=GLVTQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Jun 12, 2016 at 8:14 AM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> Now that we have a proper binding for Ethernet switches hanging off
> different buses, and a driver for the BCM53125 switch, add its Device
> Tree as a child MDIO node, at MDIO address 30 (Broadcom pseudo-PHY
> address) and describe the ports layout of the Lamobo R1 board.
>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts | 60 +++++++++++++++++++++++++++++--
>  1 file changed, 57 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts b/arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts
> index 5ee43d8bf174..697582397dcf 100644
> --- a/arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts
> @@ -110,13 +110,67 @@
>  &gmac {
>         pinctrl-names = "default";
>         pinctrl-0 = <&gmac_pins_rgmii_a>;
> -       phy = <&phy1>;
>         phy-mode = "rgmii";
>         phy-supply = <&reg_gmac_3v3>;
>         status = "okay";
>
> -       phy1: ethernet-phy at 1 {
> -               reg = <1>;
> +       fixed-link {
> +               speed = <1000>;
> +               full-duplex;
> +       };
> +
> +       mdio1 {

mdio will suffice.

> +               compatible = "snps,dwmac-mdio";
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               switch: ethernet-switch at 30 {

30 decimal or 0x30 hex? We typically use hex values here.

Otherwise this patch looks good. You should send it to Maxime though.

ChenYu

> +                       compatible = "brcm,bcm53125";
> +                       reg = <30>;
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +
> +                       ports {
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +
> +                               port at 0 {
> +                                       reg = <0>;
> +                                       label = "lan2";
> +                               };
> +
> +                               port at 1 {
> +                                       reg = <1>;
> +                                       label = "lan3";
> +                               };
> +
> +                               port at 2 {
> +                                       reg = <2>;
> +                                       label = "lan4";
> +                               };
> +
> +                               port at 3 {
> +                                       reg = <3>;
> +                                       label = "wan";
> +                               };
> +
> +                               port at 4 {
> +                                       reg = <4>;
> +                                       label = "lan1";
> +                               };
> +
> +                               port at 8 {
> +                                       reg = <8>;
> +                                       label = "cpu";
> +                                       ethernet = <&gmac>;
> +                                       phy-mode = "rgmii";
> +                                       fixed-link {
> +                                               speed = <1000>;
> +                                               full-duplex;
> +                                       };
> +                               };
> +                       };
> +               };
>         };
>  };
>
> --
> 2.7.4
>
