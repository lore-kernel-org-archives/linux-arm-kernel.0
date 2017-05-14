From: vinod.koul@intel.com (Vinod Koul)
Date: Sun, 14 May 2017 18:04:18 +0530
Subject: [PATCH 4/6] dma: pl08x: Add support for Faraday Technology
 FTDMAC020
In-Reply-To: <20170408120457.22750-4-linus.walleij@linaro.org>
References: <20170408120457.22750-1-linus.walleij@linaro.org>
 <20170408120457.22750-4-linus.walleij@linaro.org>
Message-ID: <20170514123418.GH6263@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 08, 2017 at 02:04:55PM +0200, Linus Walleij wrote:

> +#define FTDMAC020_CH_CSR_FIFOTH_MSK		(0x7 << 24)

IIUC we can have a GENMASK(27, 25), won't that be a bit better here and
other places?

> +#define FTDMAC020_CH_CSR_FIFOTH_SHIFT		(24)

and you may use ffs(FTDMAC020_CH_CSR_FIFOTH_MSK) or keep a shift define

> +#define FTDMAC020_CH_CSR_CHPR1_MSK		(0x3 << 22)
> +#define FTDMAC020_CH_CSR_PROT3			BIT(21)
> +#define FTDMAC020_CH_CSR_PROT2			BIT(20)
> +#define FTDMAC020_CH_CSR_PROT1			BIT(19)
> +#define FTDMAC020_CH_CSR_SRC_SIZE_MSK		(0x7 << 16)
> +#define FTDMAC020_CH_CSR_SRC_SIZE_SHIFT		(16)
> +#define FTDMAC020_CH_CSR_ABT			BIT(15)
> +#define FTDMAC020_CH_CSR_SRC_WIDTH_MSK		(0x7 << 11)
> +#define FTDMAC020_CH_CSR_SRC_WIDTH_SHIFT	(11)
> +#define FTDMAC020_CH_CSR_DST_WIDTH_MSK		(0x7 << 8)
> +#define FTDMAC020_CH_CSR_DST_WIDTH_SHIFT	(8)
> +#define FTDMAC020_CH_CSR_MODE			BIT(7)
> +/* 00 = increase, 01 = decrease, 10 = fix */
> +#define FTDMAC020_CH_CSR_SRCAD_CTL_MSK		(0x3 << 5)
> +#define FTDMAC020_CH_CSR_SRCAD_CTL_SHIFT	(5)
> +#define FTDMAC020_CH_CSR_DSTAD_CTL_MSK		(0x3 << 3)
> +#define FTDMAC020_CH_CSR_DSTAD_CTL_SHIFT	(3)
> +#define FTDMAC020_CH_CSR_SRC_SEL		BIT(2)
> +#define FTDMAC020_CH_CSR_DST_SEL		BIT(1)
> +#define FTDMAC020_CH_CSR_EN			BIT(0)
> +
> +/* FIFO threshold setting */
> +#define FTDMAC020_CH_CSR_FIFOTH_1		(0x0)
> +#define FTDMAC020_CH_CSR_FIFOTH_2		(0x1)
> +#define FTDMAC020_CH_CSR_FIFOTH_4		(0x2)
> +#define FTDMAC020_CH_CSR_FIFOTH_8		(0x3)
> +#define FTDMAC020_CH_CSR_FIFOTH_16		(0x4)
> +/* The FTDMAC020 supports 64bit wide transfers */
> +#define FTDMAC020_WIDTH_64BIT			(0x3)
> +/* Address can be increased, decreased or fixed */
> +#define FTDMAC020_CH_CSR_SRCAD_CTL_INC		(0x0)
> +#define FTDMAC020_CH_CSR_SRCAD_CTL_DEC		(0x1)
> +#define FTDMAC020_CH_CSR_SRCAD_CTL_FIXED	(0x2)
> +
> +#define FTDMAC020_CH_CFG_LLP_CNT_MASK		(0xf << 16)
> +#define FTDMAC020_CH_CFG_LLP_CNT_SHIFT		(16)
> +#define FTDMAC020_CH_CFG_BUSY			BIT(8)
> +#define FTDMAC020_CH_CFG_INT_ABT_MASK		BIT(2)
> +#define FTDMAC020_CH_CFG_INT_ERR_MASK		BIT(1)
> +#define FTDMAC020_CH_CFG_INT_TC_MASK		BIT(0)
> +
> +/* Inside the LLIs, the applicable CSR fields are mapped differently */
> +#define FTDMAC020_LLI_TC_MSK			BIT(28)
> +#define FTDMAC020_LLI_SRC_WIDTH_MSK		(0x7 << 25)
> +#define FTDMAC020_LLI_SRC_WIDTH_SHIFT		(25)
> +#define FTDMAC020_LLI_DST_WIDTH_MSK		(0x7 << 22)
> +#define FTDMAC020_LLI_DST_WIDTH_SHIFT		(22)
> +#define FTDMAC020_LLI_SRCAD_CTL_MSK		(0x3 << 20)
> +#define FTDMAC020_LLI_SRCAD_CTL_SHIFT		(20)
> +#define FTDMAC020_LLI_DSTAD_CTL_MSK		(0x3 << 18)
> +#define FTDMAC020_LLI_DSTAD_CTL_SHIFT		(18)
> +#define FTDMAC020_LLI_SRC_SEL			BIT(17)
> +#define FTDMAC020_LLI_DST_SEL			BIT(16)
> +#define FTDMAC020_LLI_TRANSFER_SIZE_MASK	(0xfff << 0)
> +#define FTDMAC020_LLI_TRANSFER_SIZE_SHIFT	(0)
> +
> +#define FTDMAC020_CFG_LLP_CNT_MASK		(0x0f << 16)
> +#define FTDMAC020_CFG_LLP_CNT_SHIFT		(16)
> +#define FTDMAC020_CFG_BUSY			BIT(8)
> +#define FTDMAC020_CFG_INT_ABT_MSK		BIT(2)
> +#define FTDMAC020_CFG_INT_ERR_MSK		BIT(1)
> +#define FTDMAC020_CFG_INT_TC_MSK		BIT(0)
> +
>  /* DMA linked list chain structure */
>  
>  struct pl080_lli {
> -- 
> 2.9.3
> 

-- 
~Vinod
