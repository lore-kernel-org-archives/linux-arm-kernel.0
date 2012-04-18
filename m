From: marex@denx.de (Marek Vasut)
Date: Wed, 18 Apr 2012 20:00:56 +0200
Subject: [PATCH 1/5] dma: mxs-dma: use global stmp_device functionality
In-Reply-To: <1334753197-12032-2-git-send-email-b29396@freescale.com>
References: <1334753197-12032-1-git-send-email-b29396@freescale.com>
 <1334753197-12032-2-git-send-email-b29396@freescale.com>
Message-ID: <201204182000.57054.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Dong Aisheng,

> From: Dong Aisheng <dong.aisheng@linaro.org>
> 
> This can get rid of the mach-dependency.

Reviewed-by: Marek Vasut <marex@denx.de>

> Cc: Vinod Koul <vinod.koul@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Marek Vasut <marek.vasut@gmail.com>
> Cc: Huang Shijie <b32955@freescale.com>
> Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
> ---
> This patch depends on Wolfram's
> [PATCH V2 1/3] lib: add support for stmp-style devices
> http://www.spinics.net/lists/arm-kernel/msg166232.html
> which is still not in mainline.
> ---
>  drivers/dma/Kconfig   |    1 +
>  drivers/dma/mxs-dma.c |   27 +++++++++++++--------------
>  2 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index cf9da36..af2a29f 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -239,6 +239,7 @@ config IMX_DMA
>  config MXS_DMA
>  	bool "MXS DMA support"
>  	depends on SOC_IMX23 || SOC_IMX28
> +	select STMP_DEVICE
>  	select DMA_ENGINE
>  	help
>  	  Support the MXS DMA engine. This engine including APBH-DMA
> diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
> index c81ef7e..b0051a8 100644
> --- a/drivers/dma/mxs-dma.c
> +++ b/drivers/dma/mxs-dma.c
> @@ -23,10 +23,9 @@
>  #include <linux/dmaengine.h>
>  #include <linux/delay.h>
>  #include <linux/fsl/mxs-dma.h>
> +#include <linux/stmp_device.h>
> 
>  #include <asm/irq.h>
> -#include <mach/mxs.h>
> -#include <mach/common.h>
> 
>  #include "dmaengine.h"
> 
> @@ -138,10 +137,10 @@ static void mxs_dma_reset_chan(struct mxs_dma_chan
> *mxs_chan)
> 
>  	if (dma_is_apbh() && apbh_is_old())
>  		writel(1 << (chan_id + BP_APBH_CTRL0_RESET_CHANNEL),
> -			mxs_dma->base + HW_APBHX_CTRL0 + MXS_SET_ADDR);
> +			mxs_dma->base + HW_APBHX_CTRL0 + STMP_OFFSET_REG_SET);
>  	else
>  		writel(1 << (chan_id + BP_APBHX_CHANNEL_CTRL_RESET_CHANNEL),
> -			mxs_dma->base + HW_APBHX_CHANNEL_CTRL + MXS_SET_ADDR);
> +			mxs_dma->base + HW_APBHX_CHANNEL_CTRL + 
STMP_OFFSET_REG_SET);
>  }
> 
>  static void mxs_dma_enable_chan(struct mxs_dma_chan *mxs_chan)
> @@ -170,10 +169,10 @@ static void mxs_dma_pause_chan(struct mxs_dma_chan
> *mxs_chan) /* freeze the channel */
>  	if (dma_is_apbh() && apbh_is_old())
>  		writel(1 << chan_id,
> -			mxs_dma->base + HW_APBHX_CTRL0 + MXS_SET_ADDR);
> +			mxs_dma->base + HW_APBHX_CTRL0 + STMP_OFFSET_REG_SET);
>  	else
>  		writel(1 << chan_id,
> -			mxs_dma->base + HW_APBHX_CHANNEL_CTRL + MXS_SET_ADDR);
> +			mxs_dma->base + HW_APBHX_CHANNEL_CTRL + 
STMP_OFFSET_REG_SET);
> 
>  	mxs_chan->status = DMA_PAUSED;
>  }
> @@ -186,10 +185,10 @@ static void mxs_dma_resume_chan(struct mxs_dma_chan
> *mxs_chan) /* unfreeze the channel */
>  	if (dma_is_apbh() && apbh_is_old())
>  		writel(1 << chan_id,
> -			mxs_dma->base + HW_APBHX_CTRL0 + MXS_CLR_ADDR);
> +			mxs_dma->base + HW_APBHX_CTRL0 + STMP_OFFSET_REG_CLR);
>  	else
>  		writel(1 << chan_id,
> -			mxs_dma->base + HW_APBHX_CHANNEL_CTRL + MXS_CLR_ADDR);
> +			mxs_dma->base + HW_APBHX_CHANNEL_CTRL + 
STMP_OFFSET_REG_CLR);
> 
>  	mxs_chan->status = DMA_IN_PROGRESS;
>  }
> @@ -224,11 +223,11 @@ static irqreturn_t mxs_dma_int_handler(int irq, void
> *dev_id) /* completion status */
>  	stat1 = readl(mxs_dma->base + HW_APBHX_CTRL1);
>  	stat1 &= MXS_DMA_CHANNELS_MASK;
> -	writel(stat1, mxs_dma->base + HW_APBHX_CTRL1 + MXS_CLR_ADDR);
> +	writel(stat1, mxs_dma->base + HW_APBHX_CTRL1 + STMP_OFFSET_REG_CLR);
> 
>  	/* error status */
>  	stat2 = readl(mxs_dma->base + HW_APBHX_CTRL2);
> -	writel(stat2, mxs_dma->base + HW_APBHX_CTRL2 + MXS_CLR_ADDR);
> +	writel(stat2, mxs_dma->base + HW_APBHX_CTRL2 + STMP_OFFSET_REG_CLR);
> 
>  	/*
>  	 * When both completion and error of termination bits set at the
> @@ -571,7 +570,7 @@ static int __init mxs_dma_init(struct mxs_dma_engine
> *mxs_dma) if (ret)
>  		return ret;
> 
> -	ret = mxs_reset_block(mxs_dma->base);
> +	ret = stmp_reset_block(mxs_dma->base);
>  	if (ret)
>  		goto err_out;
> 
> @@ -584,14 +583,14 @@ static int __init mxs_dma_init(struct mxs_dma_engine
> *mxs_dma) /* enable apbh burst */
>  	if (dma_is_apbh()) {
>  		writel(BM_APBH_CTRL0_APB_BURST_EN,
> -			mxs_dma->base + HW_APBHX_CTRL0 + MXS_SET_ADDR);
> +			mxs_dma->base + HW_APBHX_CTRL0 + STMP_OFFSET_REG_SET);
>  		writel(BM_APBH_CTRL0_APB_BURST8_EN,
> -			mxs_dma->base + HW_APBHX_CTRL0 + MXS_SET_ADDR);
> +			mxs_dma->base + HW_APBHX_CTRL0 + STMP_OFFSET_REG_SET);
>  	}
> 
>  	/* enable irq for all the channels */
>  	writel(MXS_DMA_CHANNELS_MASK << MXS_DMA_CHANNELS,
> -		mxs_dma->base + HW_APBHX_CTRL1 + MXS_SET_ADDR);
> +		mxs_dma->base + HW_APBHX_CTRL1 + STMP_OFFSET_REG_SET);
> 
>  err_out:
>  	clk_disable_unprepare(mxs_dma->clk);

Best regards,
Marek Vasut
