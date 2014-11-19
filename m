From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Nov 2014 15:57:56 +0100
Subject: [PATCH v2] mmc: atmel-mci: use probe deferring if dma controller
 is not ready yet
In-Reply-To: <1416408667-4666-1-git-send-email-ludovic.desroches@atmel.com>
References: <1416408667-4666-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <12322299.5p08TVzGz4@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 19 November 2014 15:51:07 Ludovic Desroches wrote:
> @@ -2265,37 +2265,39 @@ static void atmci_cleanup_slot(struct atmel_mci_slot *slot,
>         mmc_free_host(slot->mmc);
>  }
>  
> -static bool atmci_configure_dma(struct atmel_mci *host)
> +static int atmci_configure_dma(struct atmel_mci *host)
>  {
>         struct mci_platform_data        *pdata;
>         dma_cap_mask_t mask;
> +       int ret = 0;
>  
>         if (host == NULL)
> -               return false;
> +               return -EINVAL;
>  
>         pdata = host->pdev->dev.platform_data;
>  
>         dma_cap_zero(mask);
>         dma_cap_set(DMA_SLAVE, mask);
>  
> 

Host can't be NULL here, the only caller has already checked and dereferenced
the pointer before calling atmci_configure_dma.

The mask variable is now completely unused and can be removed.

	Arnd
