From: vinod.koul@linux.intel.com (Vinod Koul)
Date: Fri, 14 Sep 2012 08:15:20 +0530
Subject: [PATCH v5 3/3] ARM: dt: mmp-dma: add binding file
In-Reply-To: <1346641427-5002-4-git-send-email-zhangfei.gao@marvell.com>
References: <1346641427-5002-1-git-send-email-zhangfei.gao@marvell.com>
 <1346641427-5002-4-git-send-email-zhangfei.gao@marvell.com>
Message-ID: <1347590720.1943.0.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2012-09-03 at 11:03 +0800, Zhangfei Gao wrote:
> Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Vinod Koul <vinod.koul@linux.intel.com>

I think this patch should be merged in tree having this file, possibly
arm tree?

> ---
>  Documentation/devicetree/bindings/dma/mmp-dma.txt |   75 +++++++++++++++++++++
>  1 files changed, 75 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/dma/mmp-dma.txt
> 
> diff --git a/Documentation/devicetree/bindings/dma/mmp-dma.txt b/Documentation/devicetree/bindings/dma/mmp-dma.txt
> new file mode 100644
> index 0000000..36254c4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/mmp-dma.txt
> @@ -0,0 +1,75 @@
> +* MARVELL MMP DMA controller
> +
> +Marvell Peripheral DMA Controller
> +Used platfroms: pxa688, pxa910, pxa3xx, etc
> +
> +Required properties:
> +- compatible: Should be "marvell,pdma-1.0"
> +- reg: Should contain DMA registers location and length.
> +- interrupts: Either contain all of the per-channel DMA interrupts
> +		or one irq for pdma device
> +- #dma-channels: Number of DMA channels supported by the controller.
> +
> +"marvell,pdma-1.0"
> +Used platfroms: pxa25x, pxa27x, pxa3xx, pxa93x, pxa168, pxa910, pxa688.
> +
> +Examples:
> +
> +/*
> + * Each channel has specific irq
> + * ICU parse out irq channel from ICU register,
> + * while DMA controller may not able to distinguish the irq channel
> + * Using this method, interrupt-parent is required as demuxer
> + * For example, pxa688 icu register 0x128, bit 0~15 is PDMA channel irq,
> + * 18~21 is ADMA irq
> + */
> +pdma: dma-controller at d4000000 {
> +	      compatible = "marvell,pdma-1.0";
> +	      reg = <0xd4000000 0x10000>;
> +	      interrupts = <0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15>;
> +	      interrupt-parent = <&intcmux32>;
> +	      #dma-channels = <16>;
> +      };
> +
> +/*
> + * One irq for all channels
> + * Dmaengine driver (DMA controller) distinguish irq channel via
> + * parsing internal register
> + */
> +pdma: dma-controller at d4000000 {
> +	      compatible = "marvell,pdma-1.0";
> +	      reg = <0xd4000000 0x10000>;
> +	      interrupts = <47>;
> +	      #dma-channels = <16>;
> +      };
> +
> +
> +Marvell Two Channel DMA Controller used specifically for audio
> +Used platfroms: pxa688, pxa910
> +
> +Required properties:
> +- compatible: Should be "marvell,adma-1.0" or "marvell,pxa910-squ"
> +- reg: Should contain DMA registers location and length.
> +- interrupts: Either contain all of the per-channel DMA interrupts
> +		or one irq for dma device
> +
> +"marvell,adma-1.0" used on pxa688
> +"marvell,pxa910-squ" used on pxa910
> +
> +Examples:
> +
> +/* each channel has specific irq */
> +adma0: dma-controller at d42a0800 {
> +	      compatible = "marvell,adma-1.0";
> +	      reg = <0xd42a0800 0x100>;
> +	      interrupts = <18 19>;
> +	      interrupt-parent = <&intcmux32>;
> +      };
> +
> +/* One irq for all channels */
> +squ: dma-controller at d42a0800 {
> +	      compatible = "marvell,pxa910-squ";
> +	      reg = <0xd42a0800 0x100>;
> +	      interrupts = <46>;
> +      };
> +


-- 
~Vinod
