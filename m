From: lars@metafoo.de (Lars-Peter Clausen)
Date: Tue, 04 Feb 2014 12:58:25 +0100
Subject: [Patch v4 1/2] dmaengine: add Qualcomm BAM dma driver
In-Reply-To: <1391468687-4347-2-git-send-email-agross@codeaurora.org>
References: <1391468687-4347-1-git-send-email-agross@codeaurora.org>
 <1391468687-4347-2-git-send-email-agross@codeaurora.org>
Message-ID: <52F0D5E1.3040409@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/04/2014 12:04 AM, Andy Gross wrote:
[...]
> +static int bam_dma_remove(struct platform_device *pdev)
> +{
> +	struct bam_device *bdev = platform_get_drvdata(pdev);
> +	u32 i;
> +
> +	dma_async_device_unregister(&bdev->common);
> +	of_dma_controller_free(pdev->dev.of_node);

The controller should first be removed from the of lookup table, then free 
the device.

> +
> +	/* mask all interrupts for this execution environment */
> +	writel_relaxed(0, bdev->regs + BAM_IRQ_SRCS_MSK_EE(bdev->ee));

You still need to free the interrupt to make this race free, especially on a 
multi-processor system. free_irq() acts as a synchronization point that 
makes sure that interrupt handler has finished running and that no new 
interrupt handlers are being run after this point. Just masking the 
interrupt in the control register does not provide these guarantees.

> +
> +	for (i = 0; i < bdev->num_channels; i++) {
> +		bam_dma_terminate_all(&bdev->channels[i]);
> +		tasklet_kill(&bdev->channels[i].vc.task);
> +	}
> +
> +	tasklet_kill(&bdev->task);
> +
> +	clk_disable_unprepare(bdev->bamclk);
> +
> +	return 0;
> +}
[...]
