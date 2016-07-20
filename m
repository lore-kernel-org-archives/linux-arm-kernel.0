From: robh@kernel.org (Rob Herring)
Date: Wed, 20 Jul 2016 14:34:09 -0500
Subject: [PATCH v2 4/7] drm/bridge: Add RGB to VGA bridge support
In-Reply-To: <20160720095857.12297-5-maxime.ripard@free-electrons.com>
References: <20160720095857.12297-1-maxime.ripard@free-electrons.com>
 <20160720095857.12297-5-maxime.ripard@free-electrons.com>
Message-ID: <20160720193409.GA17313@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 20, 2016 at 11:58:54AM +0200, Maxime Ripard wrote:
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
>  .../bindings/display/bridge/dumb-vga.txt           |  54 +++++
>  drivers/gpu/drm/bridge/Kconfig                     |   6 +
>  drivers/gpu/drm/bridge/Makefile                    |   1 +
>  drivers/gpu/drm/bridge/dumb-vga.c                  | 232 +++++++++++++++++++++
>  4 files changed, 293 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/dumb-vga.txt
>  create mode 100644 drivers/gpu/drm/bridge/dumb-vga.c
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/dumb-vga.txt b/Documentation/devicetree/bindings/display/bridge/dumb-vga.txt
> new file mode 100644
> index 000000000000..0056ffa2b31d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/dumb-vga.txt
> @@ -0,0 +1,54 @@
> +Passive RGB to VGA bridge
> +-------------------------
> +
> +This binding is aimed for entirely passive RGB to VGA bridges that do not
> +require any configuration.
> +
> +Required properties:
> +
> +- compatible: Must be "dumb-vga-bridge"
> +
> +Required nodes:
> +
> +This device has two video ports. Their connections are modeled using the OF
> +graph bindings specified in Documentation/devicetree/bindings/graph.txt.
> +
> +- Video port 0 for RGB input
> +- Video port 1 for VGA output
> +
> +
> +Example
> +-------
> +
> +bridge {
> +	compatible = "dumb-vga-bridge";
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	ports {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		port at 0 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0>;
> +
> +			vga_bridge_in: endpoint at 0 {
> +				reg = <0>;

Don't need a unit address here.

> +				remote-endpoint = <&tcon0_out_vga>;
> +			};
> +		};
> +
> +		port at 1 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <1>;
> +
> +			vga_bridge_out: endpoint at 0 {
> +				reg = <0>;

Ditto.

> +				remote-endpoint = <&vga_con_in>;

Would be good to show the connector node in the example too.

With those changes,

Acked-by: Rob Herring <robh@kernel.org>
