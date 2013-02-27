From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 27 Feb 2013 20:36:04 +0000
Subject: [PATCH 01/12] ARM: dts: add generic DMA device tree binding for
 mxs-dma
In-Reply-To: <1361978748-25281-2-git-send-email-shawn.guo@linaro.org>
References: <1361978748-25281-1-git-send-email-shawn.guo@linaro.org>
 <1361978748-25281-2-git-send-email-shawn.guo@linaro.org>
Message-ID: <201302272036.05123.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 27 February 2013, Shawn Guo wrote:
> Add generic DMA device tree binding for mxs-dma.  The changes include:
> 
>  * Add channel interrupts into DMA controller nodes
>  * Add properties '#dma-cells' and 'dma-channels' for DMA controller nodes
>  * And properties 'dmas' and 'dma-names' for DMA client nodes
>  * Update mxs-dma device tree binding doc
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  .../devicetree/bindings/dma/fsl-mxs-dma.txt        |   49 +++++++++++++++--
>  arch/arm/boot/dts/imx23.dtsi                       |   42 +++++++++++++-
>  arch/arm/boot/dts/imx28.dtsi                       |   58 +++++++++++++++++++-
>  arch/arm/boot/dts/imx6qdl.dtsi                     |    8 ++-
>  4 files changed, 148 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/fsl-mxs-dma.txt b/Documentation/devicetree/bindings/dma/fsl-mxs-dma.txt
> index ded0398..a4873e5 100644
> --- a/Documentation/devicetree/bindings/dma/fsl-mxs-dma.txt
> +++ b/Documentation/devicetree/bindings/dma/fsl-mxs-dma.txt
> @@ -3,17 +3,58 @@
>  Required properties:
>  - compatible : Should be "fsl,<chip>-dma-apbh" or "fsl,<chip>-dma-apbx"
>  - reg : Should contain registers location and length
> +- interrupts : Should contain the interrupt numbers of DMA channels.
> +  If a channel is empty/reserved, 0 should be filled in place.
> +- #dma-cells : Must be <1>.  The number cell specifies the channel ID.
> +- dma-channels : Number of channels supported by the DMA controller
> +
> +Optional properties:
> +- interrupt-names : Name of DMA channel interrupts
>  


Looks good overall, just one small comment: The generic binding requires both
"dma-channels" and "dma-requests" to be listed here. My understanding of this
driver is that each channel is hardwired to one request, so you can mandate here
that the two values must be the same.

	Arnd
