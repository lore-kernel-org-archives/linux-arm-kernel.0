From: svarbanov@mm-sol.com (Stanimir Varbanov)
Date: Wed, 26 Feb 2014 18:51:55 +0200
Subject: [Patch v7 2/2] dmaengine: add Qualcomm BAM dma driver
In-Reply-To: <1393283500-18599-3-git-send-email-agross@codeaurora.org>
References: <1393283500-18599-1-git-send-email-agross@codeaurora.org>
 <1393283500-18599-3-git-send-email-agross@codeaurora.org>
Message-ID: <530E1BAB.6040609@mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andy,

Thanks for the patch.

On 02/25/2014 01:11 AM, Andy Gross wrote:
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
>  drivers/dma/Kconfig        |    9 +
>  drivers/dma/Makefile       |    1 +
>  drivers/dma/qcom_bam_dma.c | 1106 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 1116 insertions(+)
>  create mode 100644 drivers/dma/qcom_bam_dma.c

<snip>

> +
> +/**
> + * bam_init
> + * @bdev: bam device
> + *
> + * Initialization helper for global bam registers
> + */
> +static int bam_init(struct bam_device *bdev)
> +{
> +	u32 val;
> +
> +	/* read revision and configuration information */
> +	val = readl_relaxed(bdev->regs + BAM_REVISION) & NUM_EES_MASK;
> +

The ees shit is not zero and you got wrong ee. Could you add the line
below or something similar:

val = (val >> NUM_EES_SHIFT) & NUM_EES_MASK;

> +	/* check that configured EE is within range */
> +	if (bdev->ee >= val)
> +		return -EINVAL;
> +

regards,
Stan
