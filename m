From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 18 Oct 2013 08:42:25 +0200
Subject: [Patch v2][ 02/37] dma: ipu: Add devicetree support.
In-Reply-To: <1382022155-21954-3-git-send-email-denis@eukrea.com>
References: <1382022155-21954-1-git-send-email-denis@eukrea.com>
 <1382022155-21954-3-git-send-email-denis@eukrea.com>
Message-ID: <20131018064224.GR30088@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 17, 2013 at 05:02:00PM +0200, Denis Carikli wrote:
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> Cc: devicetree at vger.kernel.org
> Cc: Vinod Koul <vinod.koul@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: Eric B?nard <eric@eukrea.com>
> Signed-off-by: Denis Carikli <denis@eukrea.com>
> ---
>  .../devicetree/bindings/dma/fsl-imx-ipu.txt        |   53 ++++++++++++++++++++
>  drivers/dma/ipu/ipu_idmac.c                        |    8 +++
>  2 files changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/fsl-imx-ipu.txt
> 
> diff --git a/Documentation/devicetree/bindings/dma/fsl-imx-ipu.txt b/Documentation/devicetree/bindings/dma/fsl-imx-ipu.txt
> new file mode 100644
> index 0000000..a901c33
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/fsl-imx-ipu.txt
> @@ -0,0 +1,53 @@
> +* Freescale Image Processing Unit DMA support for i.MX3x.
> +
> +This document will only describe differences to the generic DMA Controller and
> +DMA request bindings as described in dma/dma.txt .
> +
> +This dma driver supports the imx31 and imx35 devices.
> +
> +* DMA controller
> +
> +Required properties:
> +- compatible : Should be "fsl,imx31-ipu".
> +- reg : Should contain DMA registers location and length
> +- interrupts : First item should be DMA interrupt, second one is optional and
> +    should contain DMA Error interrupt.
> +- #dma-cells : Has to be 1. The ipu driver does not support anything else.
> +
> +Optional properties:
> +- dma-channels : Number of DMA channels supported. Should be 32.
> +- #dma-requests : Number of DMA requests supported.
> +
> +Example:
> +
> +	ipu: ipu at 53fc0000 {
> +		compatible = "fsl,imx31-ipu";
> +		reg = <	0x53fc0000 0x5f
> +			0x53fc0088 0x2b >;
> +		interrupts = <42 41>;
> +		dma-channels = <32>;
> +		#dma-cells = <1>;
> +		clocks = <&clks 55>;
> +		clock-names = "";
> +		status = "disabled";
> +	};

We already have a binding for the IPUv3. We shouldn't introduce a
completely different binding for the IPUv1. We shouldn't expose the dma
channels to dt and the lcdc should either be not exported to dt or be a
subnode of the ipu node. The above binding is very close to what Linux
has implemented, but not so close to the hardware.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
