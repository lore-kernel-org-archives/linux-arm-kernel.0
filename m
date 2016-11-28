From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Mon, 28 Nov 2016 10:33:07 +0200
Subject: [RFC PATCH 3/3] dt-bindings: display: add Amlogic Meson DRM
 Bindings
In-Reply-To: <1480089791-12517-4-git-send-email-narmstrong@baylibre.com>
References: <1480089791-12517-1-git-send-email-narmstrong@baylibre.com>
 <1480089791-12517-4-git-send-email-narmstrong@baylibre.com>
Message-ID: <3721857.XEGXu9B51N@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Neil,

Thank you for the patch.

On Friday 25 Nov 2016 17:03:11 Neil Armstrong wrote:
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../bindings/display/meson/meson-drm.txt           | 134 +++++++++++++++++
>  1 file changed, 134 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/display/meson/meson-drm.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/meson/meson-drm.txt
> b/Documentation/devicetree/bindings/display/meson/meson-drm.txt new file
> mode 100644
> index 0000000..89c1b5f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/meson/meson-drm.txt
> @@ -0,0 +1,134 @@
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
> +VPP: Video Processing Unit

Do you mean "Video Post Processing" ? In your diagram above Video Processing 
Unit is abbreviated VPU and covers the VIU, VPP and encoders.

> +--------------------------
> +
> +The Video Processing Unit is in charge if the scaling and blending of the
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
> + - compatible: value should be different for each SoC family as :
> + 	- GXBB (S905) : "amlogic,meson-gxbb-vpu"
> + 	- GXL (S905X, S905D) : "amlogic,meson-gxl-vpu"
> + 	- GXM (S912) : "amlogic,meson-gxm-vpu"
> +	followed by the common "amlogic,meson-gx-vpu"
> + - reg: base address and size of he following memory-mapped regions :
> +	- vpu
> +	- hhi
> +	- dmc
> + - reg-names: should contain the names of the previous memory regions
> + - interrupts: should contain the VENC Vsync interrupt number
> +
> +- ports: A ports node with endpoint definitions as defined in
> +  Documentation/devicetree/bindings/media/video-interfaces.txt. The
> +  second port should be the output endpoints for VENC connectors.
> +
> +VENC CBVS Output
> +----------------------
> +
> +The VENC can output Composite/CVBS output via a decicated VDAC.
> +
> +Required properties:
> +  - compatible: value must be one of:
> + - compatible: value should be different for each SoC family as :

One of those two lines is redundant.

> + 	- GXBB (S905) : "amlogic,meson-gxbb-venc-cvbs"
> + 	- GXL (S905X, S905D) : "amlogic,meson-gxl-venc-cvbs"
> + 	- GXM (S912) : "amlogic,meson-gxm-venc-cvbs"
> +	followed by the common "amlogic,meson-gx-venc-cvbs"
> +

No registers ? Are the encoders registers part of the VPU register space, 
intertwined in a way that they can't be specified separately here ?

> +- ports: A ports node with endpoint definitions as defined in
> +  Documentation/devicetree/bindings/media/video-interfaces.txt. The
> +  first port should be the input endpoints, connected ot the VPU node.
> +
> +Example:
> +
> +venc_cvbs: venc-cvbs {
> +	compatible = "amlogic,meson-gxbb-venc-cvbs";
> +	status = "okay";
> +
> +	ports {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		enc_cvbs_in: port at 0 {
> +			 #address-cells = <1>;
> +			 #size-cells = <0>;
> +			 reg = <0>;
> +
> +			 venc_cvbs_in_vpu: endpoint at 0 {
> +				 reg = <0>;
> +				 remote-endpoint = <&vpu_out_venc_cvbs>;
> +			};
> +		};
> +	};
> +};
> +
> +vpu: vpu at d0100000 {
> +	compatible = "amlogic,meson-gxbb-vpu";
> +	reg = <0x0 0xd0100000 0x0 0x100000>,
> +	      <0x0 0xc883c000 0x0 0x1000>,
> +	      <0x0 0xc8838000 0x0 0x1000>;
> +	reg-names = "base", "hhi", "dmc";
> +	interrupts = <GIC_SPI 3 IRQ_TYPE_EDGE_RISING>;
> +
> +	ports {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		vpu_out: port at 1 {
> +			 #address-cells = <1>;
> +			 #size-cells = <0>;
> +			 reg = <1>;
> +
> +			 vpu_out_venc_cvbs: endpoint at 0 {
> +				 reg = <0>;
> +				 remote-endpoint = <&venc_cvbs_in_vpu>;
> +			 };
> +		 };
> +	};
> +};

-- 
Regards,

Laurent Pinchart
