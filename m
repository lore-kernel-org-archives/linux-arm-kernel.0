From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 01 Dec 2015 11:29:41 +0100
Subject: [PATCH 2/4] dmaengine: qcom_bam_dma: clear BAM interrupt only if
 it is rised
In-Reply-To: <1448961299-15161-3-git-send-email-stanimir.varbanov@linaro.org>
References: <1448961299-15161-1-git-send-email-stanimir.varbanov@linaro.org>
 <1448961299-15161-3-git-send-email-stanimir.varbanov@linaro.org>
Message-ID: <6461444.oollnBsbrb@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 01 December 2015 11:14:57 Stanimir Varbanov wrote:
> +       if (srcs & BAM_IRQ) {
>                 clr_mask = readl_relaxed(bam_addr(bdev, 0, BAM_IRQ_STTS));
>  
> -       /* don't allow reorder of the various accesses to the BAM registers */
> -       mb();
> +               /*
> +                * don't allow reorder of the various accesses to the BAM
> +                * registers
> +                */
> +               mb();
>  
> -       writel_relaxed(clr_mask, bam_addr(bdev, 0, BAM_IRQ_CLR));
> +               writel_relaxed(clr_mask, bam_addr(bdev, 0, BAM_IRQ_CLR));
> +       }
> 

I think the comment here should be moved: change the writel_relaxed()
to writel(), which already includes the appropriate barriers, and
add a comment at the readl_relaxed() to explain why it doesn't need
a barrier.

	Arnd
