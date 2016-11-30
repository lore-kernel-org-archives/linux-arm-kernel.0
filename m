From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 30 Nov 2016 17:56:43 +0200
Subject: [PATCH v2 3/4] dt-bindings: display: add Amlogic Meson DRM
 Bindings
In-Reply-To: <1480520625-13269-4-git-send-email-narmstrong@baylibre.com>
References: <1480520625-13269-1-git-send-email-narmstrong@baylibre.com>
 <1480520625-13269-4-git-send-email-narmstrong@baylibre.com>
Message-ID: <13104644.f9boR54smD@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Neil,

Thank you for the patch.

On Wednesday 30 Nov 2016 16:43:44 Neil Armstrong wrote:
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
> .../bindings/display/meson/meson-drm.txt           | 101 ++++++++++++++++++
> 1 file changed, 101 insertions(+)
> create mode 100644
> Documentation/devicetree/bindings/display/meson/meson-drm.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/meson/meson-drm.txt
> b/Documentation/devicetree/bindings/display/meson/meson-drm.txt new file
> mode 100644
> index 0000000..e52869a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/meson/meson-drm.txt
> @@ -0,0 +1,101 @@
> +Amlogic Meson Display Controller
> +================================
> +
> +The Amlogic Meson Display controller is composed of several components
> +that are going to be documented below:
> +
> +DMC|---------------VPU (Video Processing Unit)------------|------HHI------|
> +   | vd1   _______     _____________    _____________     |               |
> +D  |-------|      |----|            |   |            |    |   HDMI PLL    |
> +D  | vd2   | VIU  |    | Video Post |   | Video Encs |<---|-----VCLK      |
> +R  |-------|      |----| Processing |   |            |    |               |
> +   | osd2  |      |    |            |---| Enci ------|----|-----VDAC------|
> +R  |-------| CSC  |----| Scalers    |   | Encp ------|----|----HDMI-TX----|
> +A  | osd1  |      |    | Blenders   |   | Encl-------|----|---------------|
> +M  |-------|______|----|____________|   |____________|    |               |
> +___|______________________________________________________|_______________|
> +
> +
> +VIU: Video Input Unit
> +---------------------
> +
> +The Video Input Unit is in charge of the pixel scanout from the DDR memory.
> +It fetches the frames addresses, stride and parameters from the "Canvas"
> memory.
> +This part is also in charge of the CSC (Colorspace Conversion).
> +It can handle 2 OSD Planes and 2 Video Planes.
> +
> +VPP: Video Post Processing
> +--------------------------
> +
> +The Video Post Processing is in charge of the scaling and blending of the
> +various planes into a single pixel stream.
> +There is a special "pre-blending" used by the video planes with a dedicated
> +scaler and a "post-blending" to merge with the OSD Planes.
> +The OSD planes also have a dedicated scaler for one of the OSD.
> +
> +VENC: Video Encoders
> +--------------------
> +
> +The VENC is composed of the multiple pixel encoders :
> + - ENCI : Interlace Video encoder for CVBS and Interlace HDMI
> + - ENCP : Progressive Video Encoder for HDMI
> + - ENCL : LCD LVDS Encoder
> +The VENC Unit gets a Pixel Clocks (VCLK) from a dedicated HDMI PLL and
> clock
> +tree and provides the scanout clock to the VPP and VIU.
> +The ENCI is connected to a single VDAC for Composite Output.
> +The ENCI and ENCP are connected to an on-chip HDMI Transceiver.
> +
> +Device Tree Bindings:
> +---------------------
> +
> +VPU: Video Processing Unit
> +--------------------------
> +
> +Required properties:
> +- compatible: value should be different for each SoC family as :
> +	- GXBB (S905) : "amlogic,meson-gxbb-vpu"
> +	- GXL (S905X, S905D) : "amlogic,meson-gxl-vpu"
> +	- GXM (S912) : "amlogic,meson-gxm-vpu"
> +	followed by the common "amlogic,meson-gx-vpu"
> +- reg: base address and size of he following memory-mapped regions :
> +	- vpu
> +	- hhi
> +	- dmc
> +- reg-names: should contain the names of the previous memory regions
> +- interrupts: should contain the VENC Vsync interrupt number
> +
> +- ports: A ports node with endpoint definitions as defined in
> +  Documentation/devicetree/bindings/media/video-interfaces.txt.
> +  The first port should be connected to a CVBS connector endpoint if
> available.

This is a bit vague, I propose clarifying it with a description similar to the 
one in the renesas,du.txt bindings.

Required nodes:

The connections to the VPU output video ports are modeled using the OF graph
bindings specified in Documentation/devicetree/bindings/graph.txt.

The following table lists for each supported model the port number
corresponding to each DU output.

                Port 0          Port1           Port2           Port3
-----------------------------------------------------------------------------
 R8A7779 (H1)   DPAD 0          DPAD 1          -               -
 R8A7790 (H2)   DPAD            LVDS 0          LVDS 1          -
 R8A7791 (M2-W) DPAD            LVDS 0          -               -
 R8A7792 (V2H)  DPAD 0          DPAD 1          -               -
 R8A7793 (M2-N) DPAD            LVDS 0          -               -
 R8A7794 (E2)   DPAD 0          DPAD 1          -               -
 R8A7795 (H3)   DPAD            HDMI 0          HDMI 1          LVDS
 R8A7796 (M3-W) DPAD            HDMI            LVDS            -

(You should obviously replace the table with Amlogic data)

It doesn't matter if the current driver implementation only supports CVBS, the 
DT bindings can already document the other ports.

> +
> +Example:
> +
> +tv: connector {
> +	compatible = "composite-video-connector";
> +	label = "cvbs";

I'd remove the label here, as it doesn't bring any additional information. 
Unless the board you're using has a label for the connector, in case that 
label should be used.

Apart from that,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> +	port {
> +		tv_connector_in: endpoint {
> +			remote-endpoint = <&cvbs_vdac_out>;
> +		};
> +	};
> +};
> +
> +vpu: vpu at d0100000 {
> +	compatible = "amlogic,meson-gxbb-vpu";
> +	reg = <0x0 0xd0100000 0x0 0x100000>,
> +	      <0x0 0xc883c000 0x0 0x1000>,
> +	      <0x0 0xc8838000 0x0 0x1000>;
> +	reg-names = "vpu", "hhi", "dmc";
> +	interrupts = <GIC_SPI 3 IRQ_TYPE_EDGE_RISING>;
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	/* CVBS VDAC output port */
> +	port at 0 {
> +		cvbs_vdac_out: endpoint {
> +			reg = <0>;
> +			remote-endpoint = <&tv_connector_in>;
> +		};
> +	};
> +};

-- 
Regards,

Laurent Pinchart
