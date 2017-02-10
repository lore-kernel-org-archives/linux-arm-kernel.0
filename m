From: khilman@baylibre.com (Kevin Hilman)
Date: Fri, 10 Feb 2017 11:07:46 -0800
Subject: [PATCH 3/8] spi: davinci: limit the transfer size if DMA enabled
In-Reply-To: <1486740584-17875-4-git-send-email-fisaksen@baylibre.com> (Frode
 Isaksen's message of "Fri, 10 Feb 2017 16:29:39 +0100")
References: <1486740584-17875-1-git-send-email-fisaksen@baylibre.com>
 <1486740584-17875-4-git-send-email-fisaksen@baylibre.com>
Message-ID: <m2tw81hnjx.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Frode Isaksen <fisaksen@baylibre.com> writes:

> Limit the transfer size to 20 scatter/gather pages if
> DMA is enabled.
> The eDMA DMA engine is limited to 20 SG entries in one DMA
> transaction. If this number is exceeded, DMA receive fails.
> This error occurs with large vmalloc'ed buffers.
>
> Signed-off-by: Frode Isaksen <fisaksen@baylibre.com>
> ---
>  drivers/spi/spi-davinci.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
> index b7b2da1..f1b46f6 100644
> --- a/drivers/spi/spi-davinci.c
> +++ b/drivers/spi/spi-davinci.c
> @@ -485,6 +485,16 @@ static bool davinci_spi_can_dma(struct spi_master *master,
>  	return __davinci_spi_can_dma(spi);
>  }
>  
> +static size_t davinci_spi_max_transfer_size(struct spi_device *spi)
> +{
> +	/*
> +	 * The eDMA DMA engine is limited to 20 SG entries in one DMA
> +	 * transaction. If this number is exceeded, DMA receive fails.
> +	 * An extra SG entry is needed when the buffer is not page aligned.
> +	 */
> +	return (__davinci_spi_can_dma(spi)) ? 19 * PAGE_SIZE : SIZE_MAX;

The number here should be a #define.

Also, comment says 20, code says 19.  This should be clarified.

Kevin
