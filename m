From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Wed, 20 Apr 2016 07:36:22 -0700
Subject: [PATCH v2 2/2] dmaengine: vdma: Add clock support
In-Reply-To: <1461152599-28858-2-git-send-email-appanad@xilinx.com>
References: <1461152599-28858-1-git-send-email-appanad@xilinx.com>
 <1461152599-28858-2-git-send-email-appanad@xilinx.com>
Message-ID: <20160420143622.GP7128@xsjsorenbubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2016-04-20 at 17:13:19 +0530, Kedareswara rao Appana wrote:
> Added basic clock support. The clocks are requested at probe
> and released at remove.
> 
> Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
> ---
> Changes for v2:
> --> None.
> 
>  drivers/dma/xilinx/xilinx_vdma.c | 56 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
> 
> diff --git a/drivers/dma/xilinx/xilinx_vdma.c b/drivers/dma/xilinx/xilinx_vdma.c
> index 70caea6..d526029 100644
> --- a/drivers/dma/xilinx/xilinx_vdma.c
> +++ b/drivers/dma/xilinx/xilinx_vdma.c
> @@ -44,6 +44,7 @@
>  #include <linux/of_platform.h>
>  #include <linux/of_irq.h>
>  #include <linux/slab.h>
> +#include <linux/clk.h>
>  
>  #include "../dmaengine.h"
>  
> @@ -352,6 +353,8 @@ struct xilinx_dma_chan {
>   * @flush_on_fsync: Flush on frame sync
>   * @ext_addr: Indicates 64 bit addressing is supported by dma device
>   * @dmatype: DMA ip type
> + * @clks:	pointer to array of clocks
> + * @numclks:	number of clocks available
>   */
>  struct xilinx_dma_device {
>  	void __iomem *regs;
> @@ -362,6 +365,8 @@ struct xilinx_dma_device {
>  	u32 flush_on_fsync;
>  	bool ext_addr;
>  	enum xdma_ip_type dmatype;
> +	struct clk **clks;
> +	int numclks;
>  };
>  
>  /* Macros */
> @@ -1731,6 +1736,26 @@ int xilinx_vdma_channel_set_config(struct dma_chan *dchan,
>  }
>  EXPORT_SYMBOL(xilinx_vdma_channel_set_config);
>  
> +static int xdma_clk_init(struct xilinx_dma_device *xdev, bool enable)
> +{
> +	int i = 0, ret;
> +
> +	for (i = 0; i < xdev->numclks; i++) {
> +		if (enable) {
> +			ret = clk_prepare_enable(xdev->clks[i]);
> +			if (ret) {
> +				dev_err(xdev->dev,
> +					"failed to enable the axidma clock\n");
> +				return ret;
> +			}
> +		} else {
> +			clk_disable_unprepare(xdev->clks[i]);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  /* -----------------------------------------------------------------------------
>   * Probe and remove
>   */
> @@ -1919,6 +1944,7 @@ static int xilinx_dma_probe(struct platform_device *pdev)
>  	struct resource *io;
>  	u32 num_frames, addr_width;
>  	int i, err;
> +	const char *str;
>  
>  	/* Allocate and initialize the DMA engine structure */
>  	xdev = devm_kzalloc(&pdev->dev, sizeof(*xdev), GFP_KERNEL);
> @@ -1965,6 +1991,32 @@ static int xilinx_dma_probe(struct platform_device *pdev)
>  	/* Set the dma mask bits */
>  	dma_set_mask(xdev->dev, DMA_BIT_MASK(addr_width));
>  
> +	xdev->numclks = of_property_count_strings(pdev->dev.of_node,
> +						  "clock-names");
> +	if (xdev->numclks > 0) {
> +		xdev->clks = devm_kmalloc_array(&pdev->dev, xdev->numclks,
> +						sizeof(struct clk *),
> +						GFP_KERNEL);
> +		if (!xdev->clks)
> +			return -ENOMEM;
> +
> +		for (i = 0; i < xdev->numclks; i++) {
> +			of_property_read_string_index(pdev->dev.of_node,
> +						      "clock-names", i, &str);
> +			xdev->clks[i] = devm_clk_get(xdev->dev, str);
> +			if (IS_ERR(xdev->clks[i])) {
> +				if (PTR_ERR(xdev->clks[i]) == -ENOENT)
> +					xdev->clks[i] = NULL;
> +				else
> +					return PTR_ERR(xdev->clks[i]);
> +			}
> +		}
> +
> +		err = xdma_clk_init(xdev, true);
> +		if (err)
> +			return err;
> +	}

I guess this works, but the relation to the binding is a little loose,
IMHO. Instead of using the clock names from the binding this is just
using whatever is provided in DT and enabling it. Also, all the clocks
here are handled as optional feature, while binding - and I guess
reality too - have them as mandatory.
It would be nicer if the driver specifically asks for the clocks it
needs and return an error if a mandatory clock is missing.

	S?ren
