From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Wed, 13 Jul 2016 14:31:01 +0300
Subject: [PATCH] dmaengine: zynqmp_dma: Fix static checker warning
In-Reply-To: <1468406536-6350-1-git-send-email-appanad@xilinx.com>
References: <1468406536-6350-1-git-send-email-appanad@xilinx.com>
Message-ID: <20160713113101.GU32247@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 13, 2016 at 04:12:16PM +0530, Kedareswara rao Appana wrote:
> diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dma.c
> index f777a5b..2248704 100644
> --- a/drivers/dma/xilinx/zynqmp_dma.c
> +++ b/drivers/dma/xilinx/zynqmp_dma.c
> @@ -970,8 +970,13 @@ static int zynqmp_dma_chan_probe(struct zynqmp_dma_device *zdev,
>  	chan->dst_burst_len = ZYNQMP_DMA_AWLEN_RST_VAL;
>  	chan->src_burst_len = ZYNQMP_DMA_ARLEN_RST_VAL;
>  	err = of_property_read_u32(node, "xlnx,bus-width", &chan->bus_width);
> -	if ((err < 0) && ((chan->bus_width != ZYNQMP_DMA_BUS_WIDTH_64) ||
> -			  (chan->bus_width != ZYNQMP_DMA_BUS_WIDTH_128))) {
> +	if (err < 0) {
> +		dev_err(&pdev->dev, "missing xlnx,bus-width property\n");
> +		return err;
> +	}
> +
> +	if ((chan->bus_width != ZYNQMP_DMA_BUS_WIDTH_64) ||

This has to be an && because it can never be both widths.  You didn't
test this patch.  Also too many parenthesis (you're thinking of LISP).

> +	    (chan->bus_width != ZYNQMP_DMA_BUS_WIDTH_128)) {
>  		dev_err(zdev->dev, "invalid bus-width value");
>  		return err;

This has to be a negative error code.

regards,
dan carpenter
