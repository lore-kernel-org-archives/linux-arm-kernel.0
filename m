From: robh@kernel.org (Rob Herring)
Date: Mon, 30 Nov 2015 13:31:30 -0600
Subject: [PATCH v2 02/10] drm/hisilicon: Add DT binding docs for hi6220
 display subsystem
In-Reply-To: <1448707145-69348-3-git-send-email-xinliang.liu@linaro.org>
References: <1448707145-69348-1-git-send-email-xinliang.liu@linaro.org>
 <1448707145-69348-3-git-send-email-xinliang.liu@linaro.org>
Message-ID: <20151130193130.GA1616@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 28, 2015 at 06:38:57PM +0800, Xinliang Liu wrote:
> Add the device tree binding documentation for hi6220 SoC display subsystem.
> drm master device binding doc.
> ADE display controller binding doc.
> DSI controller binding doc.
> 
> Signed-off-by: Xinliang Liu <xinliang.liu@linaro.org>
> Signed-off-by: Xinwei Kong <kong.kongxinwei@hisilicon.com>
> Signed-off-by: Andy Green <andy.green@linaro.org>
> ---
>  .../bindings/display/hisilicon/hisi-ade.txt        | 42 ++++++++++++++
>  .../bindings/display/hisilicon/hisi-drm.txt        | 66 ++++++++++++++++++++++
>  .../bindings/display/hisilicon/hisi-dsi.txt        | 53 +++++++++++++++++
>  3 files changed, 161 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/hisilicon/hisi-ade.txt
>  create mode 100644 Documentation/devicetree/bindings/display/hisilicon/hisi-drm.txt
>  create mode 100644 Documentation/devicetree/bindings/display/hisilicon/hisi-dsi.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/hisilicon/hisi-ade.txt b/Documentation/devicetree/bindings/display/hisilicon/hisi-ade.txt
> new file mode 100644
> index 0000000..2777a2c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/hisilicon/hisi-ade.txt
> @@ -0,0 +1,42 @@
> +Device-Tree bindings for hisilicon ADE display controller driver
> +
> +ADE (Advanced Display Engine) is the display controller which grab image
> +data from memory, do composition, do post image processing, generate RGB
> +timing stream and transfer to DSI.
> +
> +Required properties:
> +- compatible: value should be one of the following
> +	"hisilicon,hi6220-ade".
> +- reg: physical base address and length of the controller's registers.
> +- reg-names: name of physical base.
> +- interrupt: the interrupt number.
> +- clocks: the clocks needed.
> +- clock-names: the name of the clocks.
> +- ade_core_clk_rate: ADE core clock rate.
> +- media_noc_clk_rate: media noc module clock rate.

I think you can use assigned clock properties instead:

assigned-clocks = <&media_ctrl HI6220_ADE_CORE>;
assigned-clock-rates = <360000000>;

I'm not sure about what media_noc corresponds to in clocks list though.

> +
> +
> +A example of HiKey board hi6220 SoC specific DT entry:
> +Example:
> +
> +	ade: ade at f4100000 {
> +		compatible = "hisilicon,hi6220-ade";
> +		reg = <0x0 0xf4100000 0x0 0x7800>,
> +		      <0x0 0xf4410000 0x0 0x1000>;
> +		reg-names = "ade_base",
> +			    "media_base";
> +		interrupts = <0 115 4>;
> +
> +		clocks = <&media_ctrl HI6220_ADE_CORE>,
> +			 <&media_ctrl HI6220_CODEC_JPEG>,
> +			 <&media_ctrl HI6220_ADE_PIX_SRC>,
> +			 <&media_ctrl HI6220_PLL_SYS>,
> +			 <&media_ctrl HI6220_PLL_SYS_MEDIA>;
> +		clock-names  = "clk_ade_core",
> +			       "aclk_codec_jpeg_src",
> +			       "clk_ade_pix",
> +			       "clk_syspll_src",
> +			       "clk_medpll_src";
> +		ade_core_clk_rate = <360000000>;
> +		media_noc_clk_rate = <288000000>;
> +	};
> diff --git a/Documentation/devicetree/bindings/display/hisilicon/hisi-drm.txt b/Documentation/devicetree/bindings/display/hisilicon/hisi-drm.txt
> new file mode 100644
> index 0000000..fd93026
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/hisilicon/hisi-drm.txt
> @@ -0,0 +1,66 @@
> +Hisilicon DRM master device
> +
> +The Hisilicon DRM master device is a virtual device needed to list all
> +the other display relevant nodes that comprise the display subsystem.

There is no need for this in DT. The ADE can be the master device and 
of-graph can link to the DSI node. I have a similar example here[1] 
with a LCD controller block, DSI block and adv7533.

> +Required properties:
> +- compatible: Should be "hisilicon,<chip>-dss"
> +- #address-cells: should be set to 2.
> +- #size-cells: should be set to 2.
> +- range: to allow probing of subdevices.
> +
> +Optional properties:
> +- dma-coherent: Present if dma operations are coherent.

Put this on the actually DMA master.

Rob

[1] https://git.linaro.org/people/rob.herring/linux.git pxa1928-drm-v2
