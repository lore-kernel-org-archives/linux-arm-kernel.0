From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 2 Aug 2017 11:03:14 +0530
Subject: [PATCH v1 3/6] dma: fsl-qdma: workaround for ERR010812
In-Reply-To: <1501553651-7203-4-git-send-email-jiaheng.fan@nxp.com>
References: <1501553651-7203-1-git-send-email-jiaheng.fan@nxp.com>
 <1501553651-7203-4-git-send-email-jiaheng.fan@nxp.com>
Message-ID: <20170802053314.GZ3053@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 01, 2017 at 10:14:08AM +0800, jiaheng.fan wrote:

The purpose of the title is to describe the change, ERR010812 doesnt mean
anything to wider audience, so please describe the change in title and log
while keeping the errate number and details..

> ERR010812:
> Enqueue rejection occurs as a results of the lack of processing by the
> consumer of the command descriptors in the status queue. This may be due
> to the size of the status queue, i.e. too small, to account for the
> delay in reacting to an exceeded queue threshold or other means of
> determining a non-empty status queue. While increasing the status queue
> size may alleviate the occurrence of enqueue rejections, it is  not a
> complete solution. qDMA supports flow control (XOFF) flowing from the
> status queue to the command queue(s) producing traffic. This flow
> control is initiated when and enter XOFF watermark is triggered as
> defined by register SQCCMR. Setting this to the recommended value in the
> register description will guarantee that no enqueue rejections will ever
> occur.
> 
> Signed-off-by: jiaheng.fan <jiaheng.fan@nxp.com>
> ---
>  drivers/dma/fsl-qdma.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/dma/fsl-qdma.c b/drivers/dma/fsl-qdma.c
> index 41bec13..7b9e09a 100644
> --- a/drivers/dma/fsl-qdma.c
> +++ b/drivers/dma/fsl-qdma.c
> @@ -63,6 +63,7 @@
>  #define FSL_QDMA_CQDSCR2                0xa0c
>  #define FSL_QDMA_CQIER			0xa10
>  #define FSL_QDMA_CQEDR			0xa14
> +#define FSL_QDMA_SQCCMR			0xa20
>  
>  #define FSL_QDMA_SQICR_ICEN
>  
> @@ -76,6 +77,7 @@
>  #define FSL_QDMA_BSQICR_ICST(x)		((x) << 16)
>  #define FSL_QDMA_CQIER_MEIE		0x80000000
>  #define FSL_QDMA_CQIER_TEIE		0x1
> +#define FSL_QDMA_SQCCMR_ENTER_WM	0x200000
>  
>  #define FSL_QDMA_QUEUE_MAX		8
>  
> @@ -842,6 +844,13 @@ static int fsl_qdma_reg_init(struct fsl_qdma_engine *fsl_qdma)
>  	}
>  
>  	/*
> +	 * Workaround for erratum: ERR010812.
> +	 * We must enable XOFF to avoid the enqueue rejection occurs.
> +	 * Setting SQCCMR ENTER_WM to 0x20.
> +	 */
> +	qdma_writel(fsl_qdma, FSL_QDMA_SQCCMR_ENTER_WM,
> +			      block + FSL_QDMA_SQCCMR);
> +	/*
>  	 * Initialize status queue registers to point to the first
>  	 * command descriptor in memory.
>  	 * Dequeue Pointer Address Registers
> -- 
> 2.7.4
> 

-- 
~Vinod
