From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 14 Mar 2017 09:08:59 +0530
Subject: [PATCH v2 2/2] dma: xilinx: Add reset support
In-Reply-To: <f7e00cde86aebcc5a0e85ea67ec96f27544acc82.1488801913.git.roliveir@synopsys.com>
References: <cover.1488801913.git.roliveir@synopsys.com>
 <f7e00cde86aebcc5a0e85ea67ec96f27544acc82.1488801913.git.roliveir@synopsys.com>
Message-ID: <20170314033859.GA2843@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 06, 2017 at 12:17:39PM +0000, Ramiro Oliveira wrote:
> Add a DT property to control an optional external reset line
> 
> Signed-off-by: Ramiro Oliveira <roliveir@synopsys.com>
> ---
>  drivers/dma/xilinx/xilinx_dma.c | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
> index 5c9f11b623ca..589cbb611bc8 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c
> @@ -32,20 +32,21 @@
>   */
>  
>  #include <linux/bitops.h>
> -#include <linux/dmapool.h>
> +#include <linux/clk.h>
>  #include <linux/dma/xilinx_dma.h>
> +#include <linux/dmapool.h>
>  #include <linux/init.h>
>  #include <linux/interrupt.h>
> +#include <linux/io-64-nonatomic-lo-hi.h>
>  #include <linux/io.h>
>  #include <linux/iopoll.h>
>  #include <linux/module.h>
>  #include <linux/of_address.h>
>  #include <linux/of_dma.h>
> -#include <linux/of_platform.h>
>  #include <linux/of_irq.h>
> +#include <linux/of_platform.h>
> +#include <linux/reset.h>
>  #include <linux/slab.h>
> -#include <linux/clk.h>
> -#include <linux/io-64-nonatomic-lo-hi.h>

this is noise in the patch, if you want to change the order feel free to
send a separate patch

>  
>  #include "../dmaengine.h"
>  
> @@ -409,6 +410,7 @@ struct xilinx_dma_device {
>  	struct clk *rxs_clk;
>  	u32 nr_channels;
>  	u32 chan_id;
> +	struct reset_control *rst;
>  };
>  
>  /* Macros */
> @@ -2543,6 +2545,20 @@ static int xilinx_dma_probe(struct platform_device *pdev)
>  	if (IS_ERR(xdev->regs))
>  		return PTR_ERR(xdev->regs);
>  
> +	xdev->rst = devm_reset_control_get_optional_shared(&pdev->dev, NULL);
> +	if (IS_ERR(xdev->rst)) {
> +		err = PTR_ERR(xdev->rst);
> +		if (err == -EPROBE_DEFER)
> +			return err;
> +		xdev->rst = NULL;

is this optional, how will it work if you can't bring device out if reset

> +	} else {
> +		err = reset_control_deassert(xdev->rst);
> +		if (err) {
> +			dev_err(xdev->dev, "error deasserting reset %d\n", err);
> +			return err;
> +		}
> +	}
> +
>  	/* Retrieve the DMA engine properties from the device tree */
>  	xdev->has_sg = of_property_read_bool(node, "xlnx,include-sg");
>  	if (xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA)
> -- 
> 2.11.0
> 
> 

-- 
~Vinod
