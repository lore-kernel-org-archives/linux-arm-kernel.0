From: robh@kernel.org (Rob Herring)
Date: Mon, 21 Nov 2016 10:59:21 -0600
Subject: [PATCH v6 1/5] drm: sun8i: Add a basic DRM driver for Allwinner
 DE2
In-Reply-To: <ff2140c86ea3b06406c77d9e8746474b6f8400c4.1479641523.git.moinejf@free.fr>
References: <cover.1479641523.git.moinejf@free.fr>
 <ff2140c86ea3b06406c77d9e8746474b6f8400c4.1479641523.git.moinejf@free.fr>
Message-ID: <20161121165921.cvh5gd3hbkbznhht@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 20, 2016 at 10:53:25AM +0100, Jean-Francois Moine wrote:
> Allwinner's recent SoCs, as A64, A83T and H3, contain a new display
> engine, DE2.
> This patch adds a DRM video driver for this device.
> 
> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
> ---
>  .../bindings/display/sunxi/sun8i-de2.txt           |  83 +++

It's preferred to split bindings to a separate patch.

>  drivers/gpu/drm/Kconfig                            |   2 +
>  drivers/gpu/drm/Makefile                           |   1 +
>  drivers/gpu/drm/sun8i/Kconfig                      |  19 +
>  drivers/gpu/drm/sun8i/Makefile                     |   7 +
>  drivers/gpu/drm/sun8i/de2_crtc.c                   | 440 +++++++++++++
>  drivers/gpu/drm/sun8i/de2_crtc.h                   |  50 ++
>  drivers/gpu/drm/sun8i/de2_drm.h                    |  48 ++
>  drivers/gpu/drm/sun8i/de2_drv.c                    | 379 +++++++++++
>  drivers/gpu/drm/sun8i/de2_plane.c                  | 712 +++++++++++++++++++++
>  10 files changed, 1741 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/sunxi/sun8i-de2.txt
>  create mode 100644 drivers/gpu/drm/sun8i/Kconfig
>  create mode 100644 drivers/gpu/drm/sun8i/Makefile
>  create mode 100644 drivers/gpu/drm/sun8i/de2_crtc.c
>  create mode 100644 drivers/gpu/drm/sun8i/de2_crtc.h
>  create mode 100644 drivers/gpu/drm/sun8i/de2_drm.h
>  create mode 100644 drivers/gpu/drm/sun8i/de2_drv.c
>  create mode 100644 drivers/gpu/drm/sun8i/de2_plane.c
> 
> diff --git a/Documentation/devicetree/bindings/display/sunxi/sun8i-de2.txt b/Documentation/devicetree/bindings/display/sunxi/sun8i-de2.txt
> new file mode 100644
> index 0000000..b9edd4b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/sunxi/sun8i-de2.txt
> @@ -0,0 +1,83 @@
> +Allwinner sun8i Display Engine 2 subsystem
> +==========================================
> +
> +The Allwinner DE2 subsystem contains a display controller (DE2),
> +one or two LCD controllers (TCON) and their external interfaces.
> +
> +Display controller
> +==================
> +
> +Required properties:
> +
> +- compatible: value should be one of the following
> +		"allwinner,sun8i-a83t-display-engine"
> +		"allwinner,sun8i-h3-display-engine"
> +
> +- clocks: must include clock specifiers corresponding to entries in the
> +		clock-names property.
> +
> +- clock-names: must contain
> +		"gate": DE bus gate
> +		"clock": DE clock
> +
> +- resets: phandle to the reset of the device
> +
> +- ports: phandle's to the LCD ports

This should use OF graph to describe the connection from the DE to the 
LCD controllers like the sun4i binding does.

No registers for the DE?

> +
> +LCD controller
> +==============
> +
> +Required properties:
> +
> +- compatible: should be
> +		"allwinner,sun8i-a83t-tcon"
> +
> +- clocks: must include clock specifiers corresponding to entries in the
> +		clock-names property.
> +
> +- clock-names: must contain
> +		"gate": TCON bus gate
> +		"clock": TCON pixel clock
> +
> +- resets: phandle to the reset of the device
> +
> +- port: port node with endpoint definitions as defined in
> +	Documentation/devicetree/bindings/media/video-interfaces.txt

Need to specify how many ports and endpoints.

> +
> +Example:
> +
> +	de: de-controller at 01000000 {
> +		compatible = "allwinner,sun8i-h3-display-engine";
> +		...

What are you not showing?

> +		clocks = <&&ccu CLK_BUS_DE>, <&ccu CLK_DE>;
> +		clock-names = "gate", "clock";
> +		resets = <&ccu RST_BUS_DE>;
> +		ports = <&lcd0_p>;
> +	};
> +
> +	lcd0: lcd-controller at 01c0c000 {
> +		compatible = "allwinner,sun8i-a83t-tcon";
> +		...

ditto.

> +		clocks = <&ccu CLK_BUS_TCON0>, <&ccu CLK_TCON0>;
> +		clock-names = "gate", "clock";
> +		resets = <&ccu RST_BUS_TCON0>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		lcd0_p: port {
> +			lcd0_ep: endpoint {
> +				remote-endpoint = <&hdmi_ep>;
> +			};
> +		};
> +	};
> +
> +	hdmi: hdmi at 01ee0000 {
> +		...
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		port {
> +			hdmi_ep: endpoint {
> +				remote-endpoint = <&lcd0_ep>;
> +			};
> +		};
> +	};
> +
