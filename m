From: robh@kernel.org (Rob Herring)
Date: Tue, 15 Sep 2015 13:11:32 -0500
Subject: [PATCH RFC 1/8] dt-bindings: Document the hi6220 bindings for DRM
 driver
In-Reply-To: <1442309834-21420-2-git-send-email-kong.kongxinwei@hisilicon.com>
References: <1442309834-21420-1-git-send-email-kong.kongxinwei@hisilicon.com>
 <1442309834-21420-2-git-send-email-kong.kongxinwei@hisilicon.com>
Message-ID: <55F85F54.1020807@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/15/2015 04:37 AM, Xinwei Kong wrote:
> This adds documentation of device tree bindings for the
> Graphics Processing Unit of hi6220 SOC.
> 
> Signed-off-by: Xinliang Liu <xinliang.liu@linaro.org>
> Signed-off-by: Xinwei Kong <kong.kongxinwei@hisilicon.com>
> Signed-off-by: Andy Green <andy.green@linaro.org>
> Signed-off-by: Jiwen Qi <qijiwen@hisilicon.com>
> Signed-off-by: Yu Gong <gongyu@hisilicon.com>
> ---
>  .../devicetree/bindings/gpu/hisilicon,hi6220.txt   | 69 ++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpu/hisilicon,hi6220.txt
> 
> diff --git a/Documentation/devicetree/bindings/gpu/hisilicon,hi6220.txt b/Documentation/devicetree/bindings/gpu/hisilicon,hi6220.txt
> new file mode 100644
> index 0000000..173ac63
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpu/hisilicon,hi6220.txt
> @@ -0,0 +1,69 @@
> + * Hisilicon hi6220 Graphics Processing Unit for HiKey board
> +
> + ** display-subsystem: Master device for binding DRM sub-components

DRM is a Linuxism that doesn't belong in the binding.

> +    This master device is parent node and it will be responsible to bind all
> +    sub-components devices node.

Are these nodes a single block in the h/w? If not, you should describe
the connection of sub-nodes with of-graph instead.

> +    - Required properties :
> +      - compatible: "hisilicon,display-subsystem".
> +      - #address-cells, #size-cells: Must be present if the device has sub-nodes.
> +      - ranges: to allow probing of subdevices.
> +      - dma-coherent: Present if dma operations are coherent.
> +
> + ** ade: Graphic overlay, Graphic post-processing, display timing control.
> +    This device is child node of display-subsystem
> +    - Required properties :
> +      - compatible: "hisilicon,hi6220-ade".
> +      - reg: physical base address of the ADE register and length of memory
> +	region.
> +      - reg-names: Should contain the reg names "ade_base" and "media_base".
> +      - interrupt: The interrupt number to the cpu. Defines the interrupt
> +        by ADE.
> +      - clocks: The clocks needed by the ADE module.
> +      - clock-names: the name of the clocks.
> +
> + ** dsi: support mipi dsi interface
> +    This device is child node of display-subsystem
> +    - Required properties :
> +      - compatible: "hisilicon,hi6220-dsi".
> +      - reg: physical base address of the DSI register and length of memory
> +	region.
> +      - clocks: The clocks needed by the DSI module.
> +      - clock-names: the name of the clocks.
> +      -	encoder-slave: phandles to a 'encoder-slave' subnode which DSI connect
> +        ADV7533 in order to support hdmi display.

What the ADV7533 binding looks like is still being discussed.
"encoder-slave" is certainly DRM specific and not how it should be done.
Most likely, this needs to use the of-graph ports.

Also, the ADV7533 connection is specific to HiKey. This binding should
just generically describe how any bridge or panel is connected.

Rob
