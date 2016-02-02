From: robh@kernel.org (Rob Herring)
Date: Tue, 2 Feb 2016 15:50:36 -0600
Subject: [PATCH v4 2/2] drm: sunxi: Add a basic DRM driver for Allwinner
 DE2
In-Reply-To: <76ae5b406ad64b2717c0b1c62c3005a62b2715b8.1454435944.git.moinejf@free.fr>
References: <cover.1454435944.git.moinejf@free.fr>
 <76ae5b406ad64b2717c0b1c62c3005a62b2715b8.1454435944.git.moinejf@free.fr>
Message-ID: <20160202215036.GA25521@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 02, 2016 at 04:25:51PM +0100, Jean-Francois Moine wrote:
> In recent SoCs, as the H3, Allwinner uses a new display interface, DE2.
> This patch adds a DRM video driver for this interface.
> 
> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
> ---
> v4: (no change)
> v3:
> 	- add the hardware cursor
> 	- simplify and fix the DE2 init sequences
> 	- generation for all SUNXI SoCs (Andre Przywara)
> v2:
> 	- remarks from Russell King
> 	- DT documentation added
> 	- working resolution change with xrandr
> 	- removal of the HDMI driver
> ---
>  .../devicetree/bindings/display/sunxi.txt          |  81 ++++
>  drivers/gpu/drm/Kconfig                            |   2 +
>  drivers/gpu/drm/Makefile                           |   1 +
>  drivers/gpu/drm/sunxi/Kconfig                      |  20 +
>  drivers/gpu/drm/sunxi/Makefile                     |   7 +
>  drivers/gpu/drm/sunxi/de2_crtc.c                   | 421 +++++++++++++++++
>  drivers/gpu/drm/sunxi/de2_crtc.h                   |  61 +++
>  drivers/gpu/drm/sunxi/de2_de.c                     | 505 +++++++++++++++++++++
>  drivers/gpu/drm/sunxi/de2_drm.h                    |  40 ++
>  drivers/gpu/drm/sunxi/de2_drv.c                    | 377 +++++++++++++++
>  drivers/gpu/drm/sunxi/de2_plane.c                  |  91 ++++
>  11 files changed, 1606 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/sunxi.txt
>  create mode 100644 drivers/gpu/drm/sunxi/Kconfig
>  create mode 100644 drivers/gpu/drm/sunxi/Makefile
>  create mode 100644 drivers/gpu/drm/sunxi/de2_crtc.c
>  create mode 100644 drivers/gpu/drm/sunxi/de2_crtc.h
>  create mode 100644 drivers/gpu/drm/sunxi/de2_de.c
>  create mode 100644 drivers/gpu/drm/sunxi/de2_drm.h
>  create mode 100644 drivers/gpu/drm/sunxi/de2_drv.c
>  create mode 100644 drivers/gpu/drm/sunxi/de2_plane.c
> 
> diff --git a/Documentation/devicetree/bindings/display/sunxi.txt b/Documentation/devicetree/bindings/display/sunxi.txt
> new file mode 100644
> index 0000000..35f9763
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/sunxi.txt
> @@ -0,0 +1,81 @@
> +Allwinner sunxi display subsystem
> +=================================
> +
> +The sunxi display subsystems contain a display controller (DE),
> +one or two LCD controllers (TCON) and their external interfaces.
> +
> +Display controller
> +==================
> +
> +Required properties:
> +
> +- compatible: value should be one of the following
> +		"allwinner,sun8i-h3-display-engine"
> +
> +- clocks: must include clock specifiers corresponding to entries in the
> +		clock-names property.
> +
> +- clock-names: must contain
> +		gate: for DE activation
> +		clock: DE clock
> +
> +- resets: phandle to the reset of the device
> +
> +- ports: phandle's to the LCD ports
> +
> +LCD controller
> +==============
> +
> +Required properties:
> +
> +- compatible: value should be one of the following
> +		"allwinner,sun8i-h3-lcd"
> +
> +- clocks: must include clock specifiers corresponding to entries in the
> +		clock-names property.
> +
> +- clock-names: must contain
> +		gate: for LCD activation
> +		clock: pixel clock
> +
> +- resets: phandle to the reset of the device
> +
> +- port: port node with endpoint definitions as defined in
> +	Documentation/devicetree/bindings/media/video-interfaces.txt

Define how many ports and endpoints.

> +
> +Example:
> +
> +	de: de-controller at 01000000 {
> +		compatible = "allwinner,sun8i-h3-display-engine";
> +		...
> +		clocks = <&bus_gates 44>, <&de_clk>;
> +		clock-names = "gate", "clock";
> +		resets = <&ahb_rst 44>;
> +		ports = <&lcd0_p>;

This is pointless if you only have one item in ports. Is this really a 
separate h/w block? Can't you move all this into the node below?

> +	};
> +
> +	lcd0: lcd-controller at 01c0c000 {
> +		compatible = "allwinner,sun8i-h3-lcd";
> +		...
> +		clocks = <&bus_gates 35>, <&tcon0_clk>;
> +		clock-names = "gate", "clock";
> +		resets = <&ahb_rst 35>;
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
