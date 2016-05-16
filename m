From: robh+dt@kernel.org (Rob Herring)
Date: Mon, 16 May 2016 09:07:18 -0500
Subject: [PATCH 13/20] drm/bridge: Add RGB to VGA bridge support
In-Reply-To: <1463402840-17062-14-git-send-email-maxime.ripard@free-electrons.com>
References: <1463402840-17062-1-git-send-email-maxime.ripard@free-electrons.com>
 <1463402840-17062-14-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <CAL_JsqKMJ7X2MU7vF9n7_MmAUQJ2v+yKyazcmMurgbTxYGfw_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 16, 2016 at 7:47 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Some boards have an entirely passive RGB to VGA bridge, based on either
> DACs or resistor ladders.
>
> Those might or might not have an i2c bus routed to the VGA connector in
> order to access the screen EDIDs.
>
> Add a bridge that doesn't do anything but expose the modes available on the
> screen, either based on the EDIDs if available, or based on the XGA
> standards.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  .../bindings/display/bridge/dumb-vga.txt           |  40 +++++
>  drivers/gpu/drm/bridge/Kconfig                     |   6 +
>  drivers/gpu/drm/bridge/Makefile                    |   1 +
>  drivers/gpu/drm/bridge/dumb-vga.c                  | 186 +++++++++++++++++++++
>  4 files changed, 233 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/dumb-vga.txt
>  create mode 100644 drivers/gpu/drm/bridge/dumb-vga.c
>
> diff --git a/Documentation/devicetree/bindings/display/bridge/dumb-vga.txt b/Documentation/devicetree/bindings/display/bridge/dumb-vga.txt
> new file mode 100644
> index 000000000000..757f04de97f3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/dumb-vga.txt
> @@ -0,0 +1,40 @@
> +Passive RGB to VGA bridge
> +-------------------------
> +
> +This binding is aimed for entirely passive RGB to VGA bridges that do not
> +require any configuration.

No reset or enable lines or regulators?

> +
> +Required properties:
> +
> +- compatible: Should be "dumb-vga-bridge"
> +
> +Optional properties:
> +
> +- ddc-i2c-bus: phandle to the i2c bus used to communicate with the monitor

The i2c bus is a property of the connector, not the bridge chip, so it
belongs in a VGA connector node (which we already have binding for).

I think for the really "dumb" (or transparent case), you should only
have a connector. For anything more complex, then you should have both
a DAC and connector node.

On the driver side, I think we could handle multiple connectors with a
single driver. Ideally, that would work with any DRM driver that has a
connector node.

> +
> +Required nodes:
> +
> +This device has one video port. Its connection is modelled using the OF
> +graph bindings specified in Documentation/devicetree/bindings/graph.txt. This
> +connection is meant to be the RGB input bus.
> +
> +
> +Example
> +-------
> +
> +bridge {
> +        compatible = "dumb-vga-bridge";
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        port at 0 {
> +                reg = <0>;
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                vga_input: endpoint at 0 {
> +                        reg = <0>;
> +                        remote-endpoint = <&tcon0_out_vga>;
> +               };
> +        };
> +};
