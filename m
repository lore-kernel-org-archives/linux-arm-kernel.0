From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 14 Jan 2014 11:43:48 -0800
Subject: [PATCH v2 1/2] dmaengine: add Qualcomm BAM dma driver
In-Reply-To: <1389380874-22753-2-git-send-email-agross@codeaurora.org>
References: <1389380874-22753-1-git-send-email-agross@codeaurora.org>
 <1389380874-22753-2-git-send-email-agross@codeaurora.org>
Message-ID: <20140114194348.GH14405@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(Mostly nitpicks)

On 01/10, Andy Gross wrote:
> Add the DMA engine driver for the QCOM Bus Access Manager (BAM) DMA controller
> found in the MSM 8x74 platforms.
> 
> Each BAM DMA device is associated with a specific on-chip peripheral.  Each
> channel provides a uni-directional data transfer engine that is capable of
> transferring data between the peripheral and system memory (System mode), or
> between two peripherals (BAM2BAM).
> 
> The initial release of this driver only supports slave transfers between
> peripherals and system memory.
> 
> Signed-off-by: Andy Gross <agross@codeaurora.org>
> ---
>  drivers/dma/Kconfig        |   9 +
>  drivers/dma/Makefile       |   1 +
>  drivers/dma/qcom_bam_dma.c | 843 +++++++++++++++++++++++++++++++++++++++++++++
>  drivers/dma/qcom_bam_dma.h | 268 ++++++++++++++
>  4 files changed, 1121 insertions(+)
>  create mode 100644 drivers/dma/qcom_bam_dma.c
>  create mode 100644 drivers/dma/qcom_bam_dma.h
> 
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index c823daa..e58e6d2 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -384,4 +384,13 @@ config DMATEST
>  config DMA_ENGINE_RAID
>  	bool
>  
> +config QCOM_BAM_DMA
> +	tristate "QCOM BAM DMA support"
> +	depends on ARCH_MSM || COMPILE_TEST

I don't think writel_relaxed() is available on every arch, so
it's possible this will break some random arch that doesn't have
that function.

> +	select DMA_ENGINE
> +	select DMA_VIRTUAL_CHANNELS
> +	---help---
> +	  Enable support for the QCOM BAM DMA controller.  This controller
> +	  provides DMA capabilities for a variety of on-chip devices.
> +
>  endif
> diff --git a/drivers/dma/qcom_bam_dma.c b/drivers/dma/qcom_bam_dma.c
> new file mode 100644
> index 0000000..7a84b02
> --- /dev/null
> +++ b/drivers/dma/qcom_bam_dma.c
[...]
> +static int bam_alloc_chan(struct dma_chan *chan)
[...]
> +
> +	/* Go ahead and initialize the pipe/channel hardware here
> +	   - Reset the channel to clear internal state of the FIFO
> +	   - Program in the FIFO address
> +	   - Configure the irq based on the EE passed in from the DT entry
> +	   - Set mode, direction and enable channel
> +
> +	   We do this here because the channel can only be enabled once and
> +	   can only be disabled via a reset.  If done here, we don't have to
> +	   manage additional state to figure out when to do this
> +	*/

Multi-line comments are of the form:

	/*
	 * comment
	 */

> +
> +	bam_reset_channel(bdev, bchan->id);
> +
> +	/* write out 8 byte aligned address.  We have enough space for this
> +	   because we allocated 1 more descriptor (8 bytes) than we can use */
> +	writel_relaxed(ALIGN(bchan->fifo_phys, sizeof(struct bam_desc_hw)),
> +			bdev->regs + BAM_P_DESC_FIFO_ADDR(bchan->id));
> +	writel_relaxed(BAM_DESC_FIFO_SIZE, bdev->regs +
> +			BAM_P_FIFO_SIZES(bchan->id));
[...]
> +
> +/**
> + * bam_dma_terminate_all - terminate all transactions
> + * @chan: dma channel
> + *
> + * Idles channel and dequeues and frees all transactions
> + * No callbacks are done
> + *
> +*/

Weird '*' starting the line here and on the next function.

> +static void bam_dma_terminate_all(struct dma_chan *chan)
> +{
> +	struct bam_chan *bchan = to_bam_chan(chan);
> +	struct bam_device *bdev = bchan->bdev;
> +
> +	bam_reset_channel(bdev, bchan->id);
> +
> +	vchan_free_chan_resources(&bchan->vc);
> +}
> +
> +/**
> + * bam_control - DMA device control
> + * @chan: dma channel
> + * @cmd: control cmd
> + * @arg: cmd argument
> + *
> + * Perform DMA control command
> + *
> +*/
> +static int bam_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
> +	unsigned long arg)
> +{
> +	struct bam_chan *bchan = to_bam_chan(chan);
> +	struct bam_device *bdev = bchan->bdev;
> +	int ret = 0;
> +	unsigned long flag;
> +
[...]
> +/**
> + * bam_dma_irq - irq handler for bam controller
> + * @irq: IRQ of interrupt
> + * @data: callback data
> + *
> + * IRQ handler for the bam controller
> + */
> +static irqreturn_t bam_dma_irq(int irq, void *data)
> +{
> +	struct bam_device *bdev = (struct bam_device *)data;

Unnecessary cast from void.

> +static int bam_dma_probe(struct platform_device *pdev)
> +{
[...]
> +
> +	irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> +	if (!irq_res) {
> +		dev_err(bdev->dev, "irq resource is missing\n");
> +		return -EINVAL;
> +	}

Please use platform_get_irq() instead.

> diff --git a/drivers/dma/qcom_bam_dma.h b/drivers/dma/qcom_bam_dma.h
> new file mode 100644
> index 0000000..2cb3b5f
> --- /dev/null
> +++ b/drivers/dma/qcom_bam_dma.h
[...]
> +#define BAM_CNFG_BITS_DEFAULT	(BAM_PIPE_CNFG |	\
> +			BAM_NO_EXT_P_RST |		\
> +			BAM_IBC_DISABLE |		\
> +			BAM_SB_CLK_REQ |		\
> +			BAM_PSM_CSW_REQ |		\
> +			BAM_PSM_P_RES |			\
> +			BAM_AU_P_RES |			\
> +			BAM_SI_P_RES |			\
> +			BAM_WB_P_RES |			\
> +			BAM_WB_BLK_CSW |		\
> +			BAM_WB_CSW_ACK_IDL |		\
> +			BAM_WB_RETR_SVPNT |		\
> +			BAM_WB_DSC_AVL_P_RST |		\
> +			BAM_REG_P_EN |			\
> +			BAM_PSM_P_HD_DATA |		\
> +			BAM_AU_ACCUMED |		\
> +			BAM_CMD_ENABLE)
> +
> +/* PIPE CTRL */
> +#define	P_EN			BIT(1)

Nit: Weird formatting here?

> +#define P_DIRECTION		BIT(3)
[...]
> +
> +
> +struct bam_device {
> +	void __iomem *regs;
> +	struct device *dev;
> +	struct dma_device common;
> +	struct device_dma_parameters dma_parms;
> +	struct bam_chan *channels;

Maybe this should be a flexible array. It looks like probe might
need to be rewritten to detect the number of channels from the
hardware before assigning anything, but it should be possible.
But it probably doesn't matter.

> +	u32 num_channels;
> +	u32 num_ees;
> +	unsigned long enabled_ees;
> +	int irq;

Is irq used?

> +	struct clk *bamclk;
> +
> +	/* dma start transaction tasklet */
> +	struct tasklet_struct task;
> +};

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
