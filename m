From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue, 17 Oct 2017 10:11:46 +0200
Subject: [PATCH 2/2] dt-bindings: power: add amlogic meeson power domain
 bindings
In-Reply-To: <1508225882-8795-3-git-send-email-narmstrong@baylibre.com>
References: <1508225882-8795-1-git-send-email-narmstrong@baylibre.com>
 <1508225882-8795-3-git-send-email-narmstrong@baylibre.com>
Message-ID: <2c765b7a-586e-de7c-8f48-0111689146bf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/10/2017 09:38, Neil Armstrong wrote:
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../bindings/power/amlogic,meson-gx-pwrc.txt       | 65 ++++++++++++++++++++++
>  1 file changed, 65 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/amlogic,meson-gx-pwrc.txt
> 
> diff --git a/Documentation/devicetree/bindings/power/amlogic,meson-gx-pwrc.txt b/Documentation/devicetree/bindings/power/amlogic,meson-gx-pwrc.txt
> new file mode 100644
> index 0000000..94c2474
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/amlogic,meson-gx-pwrc.txt
> @@ -0,0 +1,65 @@
> +Amlogic Meson Power Controller
> +==============================
> +
> +The Amlogic Meson SoCs embeds an internal Power domain controller.
> +
> +VPU Power Domain
> +----------------
> +
> +The Video Processing Unit power domain is controlled by this power controller,
> +but the domain requires some external resources to meet the correct power
> +sequences.
> +The bindings must respect the power domain bindings as described in the file
> +power_domain.txt
> +
> +Device Tree Bindings:
> +---------------------
> +
> +Required properties:
> +- compatible: value should be different for each SoC family as :
> +	- GXBB (S905) : "amlogic,meson-gxbb-vpu"
> +	- GXL (S905X, S905D) : "amlogic,meson-gxl-vpu"
> +	- GXM (S912) : "amlogic,meson-gxm-vpu"
> +	followed by the common "amlogic,meson-gx-vpu"

Oops, wrong compatibles, please ignore this patch, I'll repost it.

> +- #power-domain-cells: should be 0
> +- amlogic,hhi-sysctrl: phandle to the HHI sysctrl node
> +- resets: phandles to the reset lines needed for this power demain sequence
> +	as described in ../reset/reset.txt
> +- clocks: from common clock binding: handle to VPU and VAPB clocks
> +- clock-names: from common clock binding: must contain "vpu", "vapb"
> +	corresponding to entry in the clocks property.
> +
> +Parent node should have the following properties :
> +- compatible: "amlogic,meson-gx-ao-sysctrl", "syscon", "simple-mfd"
> +- reg: base address and size of the AO system control register space.
> +
> +Example:
> +-------
> +
> +ao_sysctrl: sys-ctrl at 0 {
> +	compatible = "amlogic,meson-gx-ao-sysctrl", "syscon", "simple-mfd";
> +	reg =  <0x0 0x0 0x0 0x100>;
> +
> +	pwrc_vpu: power-controller-vpu {
> +		compatible = "amlogic,meson-gx-pwrc-vpu";
> +		#power-domain-cells = <0>;
> +		amlogic,hhi-sysctrl = <&sysctrl>;
> +		resets = <&reset RESET_VIU>,
> +			 <&reset RESET_VENC>,
> +			 <&reset RESET_VCBUS>,
> +			 <&reset RESET_BT656>,
> +			 <&reset RESET_DVIN_RESET>,
> +			 <&reset RESET_RDMA>,
> +			 <&reset RESET_VENCI>,
> +			 <&reset RESET_VENCP>,
> +		 	 <&reset RESET_VDAC>,
> +		 	 <&reset RESET_VDI6>,
> +		 	 <&reset RESET_VENCL>,
> +			 <&reset RESET_VID_LOCK>;
> +		clocks = <&clkc CLKID_VPU>,
> +			 <&clkc CLKID_VAPB>;
> +		clock-names = "vpu", "vapb";
> +	};
> +};
> +
> +
> 
