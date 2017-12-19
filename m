From: nicolas.ferre@microchip.com (Nicolas Ferre)
Date: Tue, 19 Dec 2017 11:23:25 +0100
Subject: [PATCH] spi: atmel: fixed spin_lock usage inside atmel_spi_remove
In-Reply-To: <1513352417-15275-1-git-send-email-radu.pirea@microchip.com>
References: <1513352417-15275-1-git-send-email-radu.pirea@microchip.com>
Message-ID: <16338851-85fe-27ab-3da6-7c37212b82b8@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/12/2017 at 16:40, Radu Pirea wrote:
> The only part of atmel_spi_remove which needs to be atomic is hardware
> reset.
> 
> atmel_spi_stop_dma calls dma_terminate_all and this needs interrupts
> enabled.
> atmel_spi_release_dma calls dma_release_channel and dma_release_channel
> locks a mutex inside of spin_lock.
> 
> So the call of these functions can't be inside a spin_lock.
> 
> Reported-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> Signed-off-by: Radu Pirea <radu.pirea@microchip.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Thanks Radu. Regards,
  Nicolas

> ---
>  drivers/spi/spi-atmel.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
> index f95da36..6694709 100644
> --- a/drivers/spi/spi-atmel.c
> +++ b/drivers/spi/spi-atmel.c
> @@ -1661,12 +1661,12 @@ static int atmel_spi_remove(struct platform_device *pdev)
>  	pm_runtime_get_sync(&pdev->dev);
>  
>  	/* reset the hardware and block queue progress */
> -	spin_lock_irq(&as->lock);
>  	if (as->use_dma) {
>  		atmel_spi_stop_dma(master);
>  		atmel_spi_release_dma(master);
>  	}
>  
> +	spin_lock_irq(&as->lock);
>  	spi_writel(as, CR, SPI_BIT(SWRST));
>  	spi_writel(as, CR, SPI_BIT(SWRST)); /* AT91SAM9263 Rev B workaround */
>  	spi_readl(as, SR);
> 


-- 
Nicolas Ferre
