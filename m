From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 27 Oct 2013 22:12:35 +0000
Subject: [PATCH] mmc: sdhci-sirf: enable dmabounce since SiRFprimaII
 MMC DMA only access up to 256MB
In-Reply-To: <1382909030-7499-1-git-send-email-Baohua.Song@csr.com>
References: <1382909030-7499-1-git-send-email-Baohua.Song@csr.com>
Message-ID: <20131027221235.GF16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 28, 2013 at 05:23:50AM +0800, Barry Song wrote:
> @@ -92,6 +103,13 @@ static int sdhci_sirf_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> +	if (of_machine_is_compatible("sirf,prima2")) {
> +		if (pdev->dev.dma_mask)
> +			*(pdev->dev.dma_mask) = SZ_256M - 1;
> +		pdev->dev.coherent_dma_mask = SZ_256M - 1;

NAK.  Please do not directly write to the DMA mask; this is not how DMA
masks should be setup.  Please read up on the DMA API and specifically
in this case the dma_set_mask() / dma_set_coherent_mask() functions.

Also note that after the next merge window, those two calls should be
collapsed to dma_set_mask_and_coherent().

Thanks.
