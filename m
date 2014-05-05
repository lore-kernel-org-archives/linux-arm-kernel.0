From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 5 May 2014 14:57:13 -0700
Subject: [PATCH v4 2/4] Documentation: dts: Add bindings for APM X-Gene
 SoC ethernet driver
In-Reply-To: <1399326447-2329-3-git-send-email-isubramanian@apm.com>
References: <1399326447-2329-1-git-send-email-isubramanian@apm.com>
 <1399326447-2329-3-git-send-email-isubramanian@apm.com>
Message-ID: <CAGVrzcbecJHbZn1UU3yaD3MtSWk8FmgjMxG4zmQONrnVc05uqg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-05-05 14:47 GMT-07:00 Iyappan Subramanian <isubramanian@apm.com>:
> This patch adds documentation for APM X-Gene SoC ethernet DTS binding.
>
> Signed-off-by: Iyappan Subramanian <isubramanian@apm.com>
> Signed-off-by: Ravi Patel <rapatel@apm.com>
> Signed-off-by: Keyur Chudgar <kchudgar@apm.com>
> ---
>  .../devicetree/bindings/net/apm-xgene-enet.txt     |   66 ++++++++++++++++++++
>  1 file changed, 66 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/apm-xgene-enet.txt
>
> diff --git a/Documentation/devicetree/bindings/net/apm-xgene-enet.txt b/Documentation/devicetree/bindings/net/apm-xgene-enet.txt
> new file mode 100644
> index 0000000..9ad6fe1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/apm-xgene-enet.txt
> @@ -0,0 +1,66 @@
> +APM X-Gene SoC Ethernet nodes
> +
> +Ethernet nodes are defined to describe on-chip ethernet interfaces in
> +APM X-Gene SoC.
> +
> +Required properties:
> +- compatible:          Should be "apm,xgene-enet"
> +- reg:                 First resource is the ethernet base register set
> +                       Second resource is the ring base register set
> +                       Third resource is the ring command register set
> +- interrupts:          Ethernet main interrupt
> +- clocks:              Reference to the clock entry.
> +- local-mac-address:   Ethernet MAC address.
> +- phy-connection-type: Ethernet MII mode.

- phy-handle is not listed anywhere, yet, present in the example you give.

> +
> +- mdio device tree subnode: When the X-Gene SoC has a phy connected to its local
> +               mdio, there must be device tree subnode with the following
> +               required properties:

In that specific case, 'phy-handle' becomes an optional property.

> +
> +       - compatible: Must be "apm,xgene-mdio".
> +       - #address-cells: Must be <1>.
> +       - #size-cells: Must be <0>.
> +
> +       For the phy on the mdio bus, there must be a node with the following
> +       fields:
> +
> +       - reg: phy id used to communicate to phy.

Better refer to Documentation/devicetree/bindings/ethernet/phy.txt
which contains a more exhaustive binding description for Ethernet PHY
nodes.

> +
> +Optional properties:
> +- status               : Should be "ok" or "disabled" for enabled/disabled.
> +                         Default is "ok".
> +
> +Example:
> +       menetclk: menetclk {
> +               compatible = "apm,xgene-device-clock";
> +               clock-output-names = "menetclk";
> +               status = "ok";
> +       };
> +
> +       menet: ethernet at 17020000 {
> +               compatible = "apm,xgene-enet";
> +               status = "disabled";
> +               reg = <0x0 0x17020000 0x0 0xd100>,
> +                     <0x0 0X17030000 0x0 0X400>,
> +                     <0x0 0X10000000 0x0 0X200>;

Since you have mutliple values in your 'reg' property, you could also
provide an optional 'reg-names' which documents what the register
ranges are about.

> +               interrupts = <0x0 0x3c 0x4>;
> +               clocks = <&menetclk 0>;
> +               local-mac-address = [00 01 73 00 00 01];
> +               phy-connection-type = "rgmii";
> +               phy-handle = <&menetphy>;
> +               mdio {
> +                       compatible = "apm,xgene-mdio";
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       menetphy: menetphy at 3 {

This PHY node is missing a compatible string as described in
Documentation/devicetree/bindings/net/ethernet/phy.txt. Your binding
should also link to that documentation for

> +                               reg = <0x3>;
> +                       };
> +
> +               };
> +       };
> +
> +/* Board-specific peripheral configurations */
> +
> +&menet {
> +        status = "ok";
> +};
> --
> 1.7.9.5
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel



-- 
Florian
