From: vinod.koul@intel.com (Vinod Koul)
Date: Fri, 8 May 2015 14:45:28 +0530
Subject: [PATCH] dmaengine: sirf: add CSRatlas7 SoC support
In-Reply-To: <1430386542-31080-1-git-send-email-21cnbao@gmail.com>
References: <1430386542-31080-1-git-send-email-21cnbao@gmail.com>
Message-ID: <20150508091528.GE3521@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 30, 2015 at 09:35:42AM +0000, Barry Song wrote:
> From: Hao Liu <Hao.Liu@csr.com>
> 
> add support for new CSR atlas7 SoC. atlas7 exists V1 and V2 IP.
> V1 and V2 co-exist in the same chip. there are some HW configuration
> differences(register offset etc.) with old prima2 chips, so we use
> compatible string to differentiate old prima2 and new atlas7, then
> results in different set in HW for them.
> except that, atlas7 DMAv2 supports chain DMA by a chain table, this
> patch also adds chain DMA support for atlas7.
> 
> Signed-off-by: Hao Liu <Hao.Liu@csr.com>
> Signed-off-by: Yanchang Li <Yanchang.Li@csr.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>
> ---
>  drivers/dma/sirf-dma.c | 350 ++++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 276 insertions(+), 74 deletions(-)
> 
> diff --git a/drivers/dma/sirf-dma.c b/drivers/dma/sirf-dma.c
> index a1afda4..af0d65f 100644
> --- a/drivers/dma/sirf-dma.c
> +++ b/drivers/dma/sirf-dma.c
> @@ -25,6 +25,7 @@
>  
>  #define SIRFSOC_DMA_DESCRIPTORS                 16
>  #define SIRFSOC_DMA_CHANNELS                    16
> +#define SIRFSOC_DMA_TABLE_NUM                   256
>  
>  #define SIRFSOC_DMA_CH_ADDR                     0x00
>  #define SIRFSOC_DMA_CH_XLEN                     0x04
> @@ -35,15 +36,41 @@
>  #define SIRFSOC_DMA_CH_VALID                    0x140
>  #define SIRFSOC_DMA_CH_INT                      0x144
>  #define SIRFSOC_DMA_INT_EN                      0x148
> -#define SIRFSOC_DMA_INT_EN_CLR			0x14C
> +#define SIRFSOC_DMA_INT_EN_CLR                  0x14C
>  #define SIRFSOC_DMA_CH_LOOP_CTRL                0x150
> -#define SIRFSOC_DMA_CH_LOOP_CTRL_CLR            0x15C
> +#define SIRFSOC_DMA_CH_LOOP_CTRL_CLR            0x154
> +#define SIRFSOC_DMA_WIDTH_ATLAS7                0x10
> +#define SIRFSOC_DMA_VALID_ATLAS7                0x14
> +#define SIRFSOC_DMA_INT_ATLAS7                  0x18
> +#define SIRFSOC_DMA_INT_EN_ATLAS7               0x1c
> +#define SIRFSOC_DMA_LOOP_CTRL_ATLAS7            0x20
> +#define SIRFSOC_DMA_CUR_DATA_ADDR               0x34
> +#define SIRFSOC_DMA_MUL_ATLAS7                  0x38
> +#define SIRFSOC_DMA_CH_LOOP_CTRL_ATLAS7         0x158
> +#define SIRFSOC_DMA_CH_LOOP_CTRL_CLR_ATLAS7     0x15C
>  
>  #define SIRFSOC_DMA_MODE_CTRL_BIT               4
>  #define SIRFSOC_DMA_DIR_CTRL_BIT                5
> +#define SIRFSOC_DMA_MODE_CTRL_BIT_ATLAS7        2
> +#define SIRFSOC_DMA_CHAIN_CTRL_BIT_ATLAS7       3
> +#define SIRFSOC_DMA_DIR_CTRL_BIT_ATLAS7         4
> +#define SIRFSOC_DMA_TAB_NUM_ATLAS7              7
> +#define SIRFSOC_DMA_CHAIN_INT_BIT_ATLAS7        5
> +#define SIRFSOC_DMA_CHAIN_FLAG_SHIFT_ATLAS7     25
> +#define SIRFSOC_DMA_CHAIN_ADDR_SHIFT            32
> +
> +#define SIRFSOC_DMA_INT_FINI_INT_ATLAS7         BIT(0)
> +#define SIRFSOC_DMA_INT_CNT_INT_ATLAS7          BIT(1)
> +#define SIRFSOC_DMA_INT_PAU_INT_ATLAS7          BIT(2)
> +#define SIRFSOC_DMA_INT_LOOP_INT_ATLAS7         BIT(3)
> +#define SIRFSOC_DMA_INT_INV_INT_ATLAS7          BIT(4)
> +#define SIRFSOC_DMA_INT_END_INT_ATLAS7          BIT(5)
> +#define SIRFSOC_DMA_INT_ALL_ATLAS7              0x3F
>  
>  /* xlen and dma_width register is in 4 bytes boundary */
>  #define SIRFSOC_DMA_WORD_LEN			4
> +#define SIRFSOC_DMA_XLEN_MAX_V1         0x800
> +#define SIRFSOC_DMA_XLEN_MAX_V2         0x1000
>  
>  struct sirfsoc_dma_desc {
>  	struct dma_async_tx_descriptor	desc;
> @@ -56,7 +83,9 @@ struct sirfsoc_dma_desc {
>  	int             width;          /* DMA width */
>  	int             dir;
>  	bool            cyclic;         /* is loop DMA? */
> +	bool            chain;          /* is chain DMA? */
>  	u32             addr;		/* DMA buffer address */
> +	u64 chain_table[SIRFSOC_DMA_TABLE_NUM]; /* chain tbl */
>  };
>  
>  struct sirfsoc_dma_chan {
> @@ -87,10 +116,18 @@ struct sirfsoc_dma {
>  	void __iomem			*base;
>  	int				irq;
>  	struct clk			*clk;
> -	bool				is_marco;
> +	bool				is_atlas7_dma_v1;
> +	bool				is_atlas7_dma_v2;
so if there is v3 in future will you add another bool? Why not add type here
and set it to v1 and v2 for respective HW in probe?

>  	struct sirfsoc_dma_regs		regs_save;
>  };
>  
> +enum sirfsoc_dma_chain_flag {
> +	SIRFSOC_DMA_CHAIN_NORMAL = 0x01,
> +	SIRFSOC_DMA_CHAIN_PAUSE = 0x02,
> +	SIRFSOC_DMA_CHAIN_LOOP = 0x03,
> +	SIRFSOC_DMA_CHAIN_END = 0x04
> +};
> +
>  #define DRV_NAME	"sirfsoc_dma"
>  
>  static int sirfsoc_dma_runtime_suspend(struct device *dev);
> @@ -126,29 +163,91 @@ static void sirfsoc_dma_execute(struct sirfsoc_dma_chan *schan)
>  	/* Move the first queued descriptor to active list */
>  	list_move_tail(&sdesc->node, &schan->active);
>  
> +	if (sdma->is_atlas7_dma_v2)
> +		cid = 0;
> +
>  	/* Start the DMA transfer */
> -	writel_relaxed(sdesc->width, sdma->base + SIRFSOC_DMA_WIDTH_0 +
> -		cid * 4);
> -	writel_relaxed(cid | (schan->mode << SIRFSOC_DMA_MODE_CTRL_BIT) |
> -		(sdesc->dir << SIRFSOC_DMA_DIR_CTRL_BIT),
> -		sdma->base + cid * 0x10 + SIRFSOC_DMA_CH_CTRL);
> -	writel_relaxed(sdesc->xlen, sdma->base + cid * 0x10 +
> -		SIRFSOC_DMA_CH_XLEN);
> -	writel_relaxed(sdesc->ylen, sdma->base + cid * 0x10 +
> -		SIRFSOC_DMA_CH_YLEN);
> -	writel_relaxed(readl_relaxed(sdma->base + SIRFSOC_DMA_INT_EN) |
> -		(1 << cid), sdma->base + SIRFSOC_DMA_INT_EN);
>  
> +	if (sdma->is_atlas7_dma_v2) {
same here as well, why not use an ops function and call that which would
again be set to v1 or v2. That way you just invoke sdma->execute_desc();

I think this is true for most of the driver here, adding if (v2), else doesnt help much
in scaling this to another set where we will have more diff hw registers to
write to.

-- 
~Vinod
