From: robh+dt@kernel.org (Rob Herring)
Date: Fri, 16 Oct 2015 08:21:38 -0500
Subject: [RFC 1/2] Dcumentation: bridge: Add documentation for ps8640 DT
 properties
In-Reply-To: <1444997709-57293-1-git-send-email-ck.hu@mediatek.com>
References: <1444997709-57293-1-git-send-email-ck.hu@mediatek.com>
Message-ID: <CAL_JsqKMqiqwZaxnZGKo3eh6m+mE9aX8HnWkDZkSivSn1PHy2A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 16, 2015 at 7:15 AM, CK Hu <ck.hu@mediatek.com> wrote:
> From: Jitao Shi <jitao.shi@mediatek.com>
>
> Add documentation for DT properties supported by ps8640
> DSI-eDP converter.
>
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  .../devicetree/bindings/video/bridge/ps8640.txt    |   48 ++++++++++++++++++++

Please move to bindings/display/bridge/.

>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/video/bridge/ps8640.txt
>
> diff --git a/Documentation/devicetree/bindings/video/bridge/ps8640.txt b/Documentation/devicetree/bindings/video/bridge/ps8640.txt
> new file mode 100644
> index 0000000..450b5df
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/video/bridge/ps8640.txt
> @@ -0,0 +1,48 @@
> +ps8640-bridge bindings
> +
> +Required properties:
> +       - compatible: "parade,ps8640"
> +       - reg: first i2c address of the bridge
> +       - power-gpios: OF device-tree gpio specification for power pin.
> +       - reset-gpios: OF device-tree gpio specification for reset pin.
> +       - mode-sel-gpios: OF device-tree gpio specification for mode-sel pin.
> +       - ps8640-1v2-supply: OF device-tree regulator specification for 1v2.
> +       - ps8640-3v3-supply: OF device-tree regulator specification for 3v3.

As others have said, I would drop the part number and name them based
on the supply name (e.g. vdd?, vcore?).

> +
> +Optional properties:
> +       - video interfaces: Device node can contain video interface port
> +                           nodes for panel according to [1].

I don't think this should be optional.

> +
> +[1]: Documentation/devicetree/bindings/media/video-interfaces.txt
> +
> +Example:
> +       edp-bridge at 18 {
> +               compatible = "parade,ps8640";
> +               reg = <0x18>;
> +               power-gpios = <&pio 116 GPIO_ACTIVE_HIGH>;
> +               reset-gpios = <&pio 115 GPIO_ACTIVE_HIGH>;
> +               mode-sel-gpios = <&pio 92 GPIO_ACTIVE_HIGH>;
> +               ps8640-1v2-supply = <&ps8640_fixed_1v2>;
> +               ps8640-3v3-supply = <&mt6397_vgp2_reg>;
> +
> +               ports {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +
> +                       port at 0 {
> +                               reg = <0>;
> +
> +                               ps8640_in: endpoint {
> +                                       remote-endpoint = <&dsi0_out>;
> +                               };
> +                       };
> +
> +                       port at 1 {
> +                               reg = <1>;
> +
> +                               ps8640_out: endpoint {
> +                                       remote-endpoint = <&panel_in>;
> +                               };
> +                       };
> +               };
> +       };
> --
> 1.7.9.5
>
