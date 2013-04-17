From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 17 Apr 2013 22:05:35 +0200
Subject: [PATCH 29/30] spi: s3c64xx: move to generic dmaengine API
In-Reply-To: <1365638712-1028578-30-git-send-email-arnd@arndb.de>
References: <1365638712-1028578-1-git-send-email-arnd@arndb.de>
 <1365638712-1028578-30-git-send-email-arnd@arndb.de>
Message-ID: <201304172205.35526.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 11 April 2013, Arnd Bergmann wrote:
> @@ -713,9 +836,9 @@ static int s3c64xx_spi_transfer_one_message(struct spi_master *master,
>                 }
>  
>                 /* Polling method for xfers not bigger than FIFO capacity */
> -               if (xfer->len <= ((FIFO_LVL_MASK(sdd) >> 1) + 1))
> -                       use_dma = 0;
> -               else
> +               use_dma = 0;
> +               if (sdd->rx_dma.ch && sdd->tx_dma.ch &&
> +                   (xfer->len > ((FIFO_LVL_MASK(sdd) >> 1) + 1)))
>                         use_dma = 1;
>  
>                 spin_lock_irqsave(&sdd->lock, flags);

Can you try just reverting this hunk? It's actually not required and
comes from an earlier version of the patch. I assumed it was harmless,
but it's the only think I see that should actually make a difference
in my patch for the case of !CONFIG_SAMSUNG_DMADEV.

	Arnd
