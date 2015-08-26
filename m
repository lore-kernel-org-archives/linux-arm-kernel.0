From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 26 Aug 2015 18:34:35 +0200
Subject: [RFC][PATCH 1/2] dt-bindings: drm/mediatek: Add Mediatek DRM
 dts binding
In-Reply-To: <1431530626-31493-2-git-send-email-ck.hu@mediatek.com>
References: <1431530626-31493-1-git-send-email-ck.hu@mediatek.com>
 <1431530626-31493-2-git-send-email-ck.hu@mediatek.com>
Message-ID: <1440606875.3190.103.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

overall it looks to me like this binding is modeled after the Linux DRM
abstractions. Instead, the device nodes should be modeled after the
hardware.

Describing each function block as a separate device node is probably not
the best choice, as would be combining all devices in the mmsys range
into a single device node. So a somewhat arbitrary decision has to be
made what to group together. See my comments below:

Am Mittwoch, den 13.05.2015, 23:23 +0800 schrieb CK Hu:
> This patch includes
> 1. Mediatek DRM Device binding
> 2. Mediatek DSI Device binding
> 3. Mediatek CRTC Main Device binding
> 4. Mediatek DDP Device binding
> 
> Signed-off-by: CK Hu <ck.hu@mediatek.com>
> ---
>  .../bindings/drm/mediatek/mediatek,crtc-main.txt   | 38 ++++++++++++++++++++++
>  .../bindings/drm/mediatek/mediatek,ddp.txt         | 22 +++++++++++++
>  .../bindings/drm/mediatek/mediatek,drm.txt         | 27 +++++++++++++++
>  .../bindings/drm/mediatek/mediatek,dsi.txt         | 20 ++++++++++++
>  4 files changed, 107 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/drm/mediatek/mediatek,crtc-main.txt
>  create mode 100644 Documentation/devicetree/bindings/drm/mediatek/mediatek,ddp.txt
>  create mode 100644 Documentation/devicetree/bindings/drm/mediatek/mediatek,drm.txt
>  create mode 100644 Documentation/devicetree/bindings/drm/mediatek/mediatek,dsi.txt
> 
> diff --git a/Documentation/devicetree/bindings/drm/mediatek/mediatek,crtc-main.txt b/Documentation/devicetree/bindings/drm/mediatek/mediatek,crtc-main.txt
> new file mode 100644
> index 0000000..5c6c420
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/drm/mediatek/mediatek,crtc-main.txt
> @@ -0,0 +1,38 @@
> +Mediatek CRTC Main Device
> +================================
> +
> +The Mediatek CRTC Main device is a crtc device of DRM system.

"crtc" does not belong in the device tree. There is no crtc hardware.
What this node describes is a useful, but fixed configuration of a part
of the DISP subsystem function blocks.

In my opinion, it would be better to not describe the separate display
pipes in the device tree at all if they are dynamically configurable.
What for example if you model two separate fixed pipelines in the device
tree and then in the future you want to support the MERGE or SPLIT
blocks (I'm not sure what MERGE does, SPLIT seems to be needed for
8-lane DSI)?

As far as I currently understand, there are five source function blocks
that can read from memory (OVL0, OVL1, RDMA0, RDMA1, RDMA2) and three
sink function blocks (DSI0, DSI1, DPI0) that can be connected to panels,
or encoder bridges. How these map to the crtcs doesn't necessarily have
to be described in the device tree.

How about a single node that contains all of the DISP functional blocks
that don't need their own node (like DSI, which has to be connectable to
bridges or panels):

disp: disp at 0x1400c000 {
        compatible = "mediatek,mt8173-disp";
        interrupts = <GIC_SPI 180 IRQ_TYPE_LEVEL_LOW>, /* OVL0 */
                     <GIC_SPI 181 IRQ_TYPE_LEVEL_LOW>; /* OVL1 */
	interrupt-names = "ovl0", "ovl1";
        reg = <0 0x1400c000 0 0x1000>,  /* OVL0 */
              <0 0x1400d000 0 0x1000>,  /* OVL1 */
              <0 0x1400e000 0 0x1000>,  /* RDMA0 */
              <0 0x1400f000 0 0x1000>,  /* RDMA1 */
              <0 0x14010000 0 0x1000>,  /* RDMA2 */
              <0 0x14013000 0 0x1000>,  /* COLOR0 */
              <0 0x14014000 0 0x1000>,  /* COLOR1 */
              <0 0x14015000 0 0x1000>,  /* AAL */
              <0 0x14016000 0 0x1000>,  /* GAMMA */
              <0 0x14017000 0 0x1000>,  /* MERGE */
              <0 0x14018000 0 0x1000>,  /* SPLIT0 */
              <0 0x14019000 0 0x1000>,  /* SPLIT1 */
              <0 0x1401a000 0 0x1000>,  /* UFOE */
              <0 0x14020000 0 0x1000>;  /* MUTEX */
              <0 0x14023000 0 0x1000>;  /* OD */
	reg-names = "ovl0", "ovl1", "rdma0", "rdma1", "rdma2",
		"color0", "color1", "aal", "gamma", "merge",
		"split0", "split1", "ufoe", "mutex", "od";
        clocks = <&mmsys CLK_MM_DISP_OVL0>,
		 <&mmsys CLK_MM_DISP_OVL1>,
                 <&mmsys CLK_MM_DISP_RDMA0>,
                 <&mmsys CLK_MM_DISP_RDMA1>,
                 <&mmsys CLK_MM_DISP_RDMA2>,
                 <&mmsys CLK_MM_DISP_COLOR0>,
                 <&mmsys CLK_MM_DISP_COLOR1>,
                 <&mmsys CLK_MM_DISP_AAL>,
                 <&mmsys CLK_MM_DISP_GAMMA>,
                 <&mmsys CLK_MM_DISP_MERGE>,
                 <&mmsys CLK_MM_DISP_SPLIT0>,
                 <&mmsys CLK_MM_DISP_SPLIT1>,
                 <&mmsys CLK_MM_DISP_UFOE>,
                 <&mmsys CLK_MM_MUTEX_32K>,
                 <&mmsys CLK_MM_DISP_OD>;
	clock-names = "ovl0", "ovl1", "rdma0", "rdma1", "rdma2",
		"color0", "color1", "aal", "gamma", "merge",
		"split0", "split1", "ufoe", "mutex", "od";
        power-domains = <&scpsys MT8173_POWER_DOMAIN_DIS>;
        config = <&mmsys>; /* syscon */
};

How the muxes in the config area are set up to connect those blocks
could be determined by the driver.

> +Required properties:
> +- compatible: "mediatek,<chip>-crtc-main"
> +- interrupts: The interrupt signal from the CRTC Main block.
> +- reg: Physical base address and length of the controller's registers
> +- clocks: device clocks
> +  See Documentation/devicetree/bindings/clock/clock-bindings.txt for details.
> +- ddp: phandle of ddp device which control display data path.
> +
> +Example:
> +
> +crtc_main: crtc at 1400c000 {
> +	compatible = "mediatek,mt8173-crtc-main";
> +	interrupts = <GIC_SPI 196 IRQ_TYPE_LEVEL_LOW>;

Should it be mentioned that this is the interrupt of the source of the
pipeline (OVL0/1)?

> +	reg = <0 0x1400c000 0 0x1000>,	/* OVL0 */
> +	      <0 0x1400e000 0 0x1000>,	/* RDMA0 */
> +	      <0 0x14013000 0 0x1000>,	/* COLOR0 */
> +	      <0 0x14015000 0 0x1000>,	/* AAL */
> +	      <0 0x1401a000 0 0x1000>,	/* UFOE */
> +	      <0 0x14023000 0 0x1000>;	/* OD */

With the amount of register ranges and given the symmetry with the
clocks, better use reg-names instead of position to determine the
register space for each function block.

	reg-names = "ovl0", "rdma0", "color0", "aal", "ufoe", "od";

> +	clocks = <&mmsys MM_DISP_OVL0>,
> +		 <&mmsys MM_DISP_RDMA0>,
> +		 <&mmsys MM_DISP_COLOR0>,
> +		 <&mmsys MM_DISP_AAL>,
> +		 <&mmsys MM_DISP_UFOE>,
> +		 <&mmsys MM_DISP_OD>;
> +	clock-names = "ovl0_disp",
> +		      "rdma0_disp",
> +		      "color0_disp",
> +		      "aal_disp",
> +		      "ufoe_disp",
> +		      "od_disp";

I'd drop the disp suffix from the clock input names.

	clock-names = "ovl0", "rdma0", "color0", "aal", "ufoe", "od";

> +	ddp = <&ddp>;
> +};
> \ No newline at end of file
> diff --git a/Documentation/devicetree/bindings/drm/mediatek/mediatek,ddp.txt b/Documentation/devicetree/bindings/drm/mediatek/mediatek,ddp.txt
> new file mode 100644
> index 0000000..77cf630
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/drm/mediatek/mediatek,ddp.txt
> @@ -0,0 +1,22 @@
> +Mediatek DDP Device
> +================================
> +
> +The Mediatek DDP device control the display data path.

This is not a real device either. There is nothing wrong with having a
ddp driver, but I don't think it is right to describe this driver in the
device tree. What we really have here is the mutex function block and
some registers in the mmsys config region, which already can be accessed
via the mmsys syscon.
With a single disp device node including the mutex and power domain
phandle this node would not be necessary.

> +Required properties:
> +- compatible: "mediatek,<chip>-ddp"
> +- reg: Physical base address and length of the controller's registers
> +- power-domains: a phandle to DDP power domain node.
> +- clocks: device clocks
> +  See Documentation/devicetree/bindings/clock/clock-bindings.txt for details.
> +
> +Example:
> +
> +ddp: ddp at 14000000 {
> +	compatible = "mediatek,mt8173-ddp";
> +	reg = <0 0x14000000 0 0x100>,	/* CONFIG */

This remaps part of the mmsys register space, which is already a syscon.
Why not use syscon to access it?

> +	      <0 0x14020000 0 0x1000>;	/* MUTEX */
> +	power-domains = <&scpsys MT8173_POWER_DOMAIN_DIS>;
> +	clocks = <&mmsys MM_MUTEX_32K>;
> +	clock-names = "mutex_disp";
> +};
> \ No newline at end of file
> diff --git a/Documentation/devicetree/bindings/drm/mediatek/mediatek,drm.txt b/Documentation/devicetree/bindings/drm/mediatek/mediatek,drm.txt
> new file mode 100644
> index 0000000..c4a5702
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/drm/mediatek/mediatek,drm.txt
> @@ -0,0 +1,27 @@
> +Mediatek DRM Device
> +================================
> +
> +The Mediatek DRM device is a device needed to list all
> +display component nodes that comprise the display subsystem.
> +And it list the memory-related interface.

"drm" does not belong in the device tree. There is no "drm" hardware.
Other SoCs use the "display-subsystem" name for this node, it would be
better to follow that.

> +Required properties:
> +- compatible: "mediatek,<chip>-drm"
> +- larb: Should contain a list of phandles pointing to larb device.
> +  larb definitions as defined in
> +  Documentation/devicetree/bindings/soc/mediatek/mediatek,smi-larb.txt
> +- iommus: required a iommu node
> +- connectors: Should contain a list of phandles pointing to connector device.
> +  connector device should be one component of this master.
> +- crtcs: Should contain a list of phandles pointing to crtc device.
> +  crtc device should be one component of this master.

"connectors" and "crtcs" as used here are DRM concepts, not hardware
devices that should exist in the device tree. Ideally you would use
something recognizable from the datasheet, like "sinks" or from the
device tree, like "ports" if of-graph bindings are used, or just
"components" if this also were to include things like the ddp.

Another possibility would be to even merge the 

> +
> +Example:
> +
> +drm0: drm {
> +	compatible = "mediatek,mt8173-drm";
> +	larb = <&larb0>;
> +	iommus = <&iommu M4U_PORT_DISP_OVL0>;
> +	connectors = <&dsi>;
> +	crtcs = <&crtc_main>;
> +};
> \ No newline at end of file
> diff --git a/Documentation/devicetree/bindings/drm/mediatek/mediatek,dsi.txt b/Documentation/devicetree/bindings/drm/mediatek/mediatek,dsi.txt
> new file mode 100644
> index 0000000..16e3eb3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/drm/mediatek/mediatek,dsi.txt
> @@ -0,0 +1,20 @@
> +Mediatek DSI Device
> +================================
> +
> +The Mediatek DSI device is a connector device of DRM system.
> +
> +Required properties:
> +- compatible: "mediatek,<chip>-dsi"
> +- reg: Physical base address and length of the controller's registers
> +- clocks: device clocks
> +  See Documentation/devicetree/bindings/clock/clock-bindings.txt for details.

Will this use the
Documentation/devicetree/bindings/mipi/dsi/mipi-dsi-bus.txt
bindings to connect panels controlled via the DSI command channel
or the
Documentation/devicetree/bindings/graph.txt
bindings to connect panels controlled via I2C or other control buses?
If so, this should be documented here.

> +Example:
> +
> +dsi: dsi at 10215000 {
> +	compatible = "mediatek,mt8173-dsi";
> +	reg = <0 0x1401B000 0 0x1000>,	/* DSI0 */
> +	      <0 0x10215000 0 0x1000>;  /* MIPITX */
> +	clocks = <&mmsys MM_DSI0_ENGINE>,	<&mmsys MM_DSI0_DIGITAL>;
> +	clock-names = "dsi0_engine_disp_ck", "dsi0_digital_disp_ck";

Maybe shorten the clock names to "engine" and "digital" ?
And add an example of panel or bridge connected to the DSI sink.

What about DSI1 and the DPI sink?

best regards
Philipp
