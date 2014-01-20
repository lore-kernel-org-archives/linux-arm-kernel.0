From: robherring2@gmail.com (Rob Herring)
Date: Mon, 20 Jan 2014 08:57:53 -0600
Subject: [PATCH v3 3/7] net: moxa: connect to PHY
In-Reply-To: <1390216399-27028-3-git-send-email-jonas.jensen@gmail.com>
References: <1390216399-27028-1-git-send-email-jonas.jensen@gmail.com>
 <1390216399-27028-3-git-send-email-jonas.jensen@gmail.com>
Message-ID: <CAL_JsqKs-snsRaD1JQRVUrg+WBDd9cYxPhtfKf9m5HeJ6df3Pw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 20, 2014 at 5:13 AM, Jonas Jensen <jonas.jensen@gmail.com> wrote:
> The kernel now has a MDIO bus driver and a phy_driver (RTL8201CP),
> connect to this PHY using OF.
>
> Signed-off-by: Jonas Jensen <jonas.jensen@gmail.com>
> ---
>
> Notes:
>     Applies to next-20140120
>
>  .../devicetree/bindings/net/moxa,moxart-mac.txt    | 47 ++++++++++-
>  drivers/net/ethernet/moxa/moxart_ether.c           | 92 +++++++++++++++++++++-
>  drivers/net/ethernet/moxa/moxart_ether.h           |  2 +
>  3 files changed, 138 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/net/moxa,moxart-mac.txt b/Documentation/devicetree/bindings/net/moxa,moxart-mac.txt
> index 583418b..94c1f3b 100644
> --- a/Documentation/devicetree/bindings/net/moxa,moxart-mac.txt
> +++ b/Documentation/devicetree/bindings/net/moxa,moxart-mac.txt
> @@ -1,21 +1,64 @@
>  MOXA ART Ethernet Controller
>
> +Integrated MDIO bus node:
> +
> +- compatible: "moxa,moxart-mdio"
> +- Inherits from MDIO bus node binding[1]
> +
> +[1] Documentation/devicetree/bindings/net/phy.txt
> +
> +
> +Ethernet node:
> +
>  Required properties:
>
>  - compatible : Must be "moxa,moxart-mac"
>  - reg : Should contain register location and length
>  - interrupts : Should contain the mac interrupt number
>
> +Optional Properties:
> +
> +- phy-handle : the phandle to a PHY node
> +
> +
>  Example:
>
> +       mdio0: mdio at 90900090 {
> +               compatible = "moxa,moxart-mdio";
> +               reg = <0x90900090 0x8>;
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               ethphy0: ethernet-phy at 1 {
> +                       device_type = "ethernet-phy";

Drop this. device_type is only for real OpenFirmware.

> +                       compatible = "moxa,moxart-rtl8201cp", "ethernet-phy-ieee802.3-c22";
> +                       reg = <1>;
> +               };
> +       };
> +
> +       mdio1: mdio at 92000090 {
> +               compatible = "moxa,moxart-mdio";
> +               reg = <0x92000090 0x8>;
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               ethphy1: ethernet-phy at 1 {
> +                       device_type = "ethernet-phy";
> +                       compatible = "moxa,moxart-rtl8201cp", "ethernet-phy-ieee802.3-c22";
> +                       reg = <1>;
> +               };
> +       };
> +
>         mac0: mac at 90900000 {

Not part of this patch, but this should really be ethernet at ...

>                 compatible = "moxa,moxart-mac";
> -               reg =   <0x90900000 0x100>;
> +               reg = <0x90900000 0x90>;
>                 interrupts = <25 0>;
> +               phy-handle = <&ethphy0>;
>         };
>
>         mac1: mac at 92000000 {
>                 compatible = "moxa,moxart-mac";
> -               reg =   <0x92000000 0x100>;
> +               reg = <0x92000000 0x90>;
>                 interrupts = <27 0>;
> +               phy-handle = <&ethphy1>;
>         };
