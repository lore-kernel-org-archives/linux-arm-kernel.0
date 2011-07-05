From: parkch98@gmail.com (Chanho Park)
Date: Tue, 5 Jul 2011 17:39:50 +0900
Subject: [PATCH 6/7] spi/s3c64xx: Add support DMA engine API
In-Reply-To: <1309781915-31549-7-git-send-email-kgene.kim@samsung.com>
References: <1309781915-31549-1-git-send-email-kgene.kim@samsung.com>
	<1309781915-31549-7-git-send-email-kgene.kim@samsung.com>
Message-ID: <CAPTzV16XF5tVJrw0UO+kM9uz+49b3jtCi9QHVm8eDbd8kbueBA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> ?static int acquire_dma(struct s3c64xx_spi_driver_data *sdd)
> ?{
> +#if defined(CONFIG_DMADEV_PL330)
> + ? ? ? dma_cap_mask_t mask;
> + ? ? ? dma_cap_zero(mask);
> + ? ? ? dma_cap_set(DMA_SLAVE, mask);
> + ? ? ? sdd->rx_chan =
> + ? ? ? ? ? ? ? dma_request_channel(mask, rxfilter, (void *)sdd);
> + ? ? ? if (!sdd->rx_chan) {
> + ? ? ? ? ? ? ? dev_err(&sdd->pdev->dev, "cannot get RxDMA\n");
> + ? ? ? ? ? ? ? return 0;
> + ? ? ? }
> + ? ? ? sdd->tx_chan =
> + ? ? ? ? ? ? ? dma_request_channel(mask, txfilter, (void *)sdd);
> + ? ? ? if (!sdd->tx_chan) {
> + ? ? ? ? ? ? ? dev_err(&sdd->pdev->dev, "cannot get TxDMA\n");
> + ? ? ? ? ? ? ? return 0;
> + ? ? ? }
> +#else

When acquiring tx_chan is failed, you must release a rx_chan before
error return.
If not, the rx_chan is always busy because it was allocated in the
previous attempt.

-- 
Best Regards,
Chanho Park
