From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 14 Nov 2016 16:18:42 +0100
Subject: [PATCH RESEND] spi: atmel: Fix scheduling while atomic
In-Reply-To: <1479136400-10285-1-git-send-email-ben.whitten@lairdtech.com>
References: <1479136400-10285-1-git-send-email-ben.whitten@lairdtech.com>
Message-ID: <b01ca892-4405-fe8e-b6e2-eb02e7b86cac@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 14/11/2016 ? 16:13, Ben Whitten a ?crit :
> A call to clk_get_rate appears to be called in the context of an interrupt,
> cache the bus clock for the frequency calculations in transmission.
> 
> This fixes a 'BUG: scheduling while atomic' and
> 'WARNING: CPU: 0 PID: 777 at kernel/sched/core.c:2960 atmel_spi_unlock'
> 
> Signed-off-by: Ben Whitten <ben.whitten@lairdtech.com>
> Signed-off-by: Steve deRosier <steve.derosier@lairdtech.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>


> ---
> 
> Resending due to missing off the subsystem maintainer in initial submission,
> pointed out by Alexandre Belloni, thanks.

BTW, it's actually more a "v2" than a "RESEND".

Thanks a lot for your patch.
Best regards,

> ---
>  drivers/spi/spi-atmel.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
> index 8feac59..c281d1a 100644
> --- a/drivers/spi/spi-atmel.c
> +++ b/drivers/spi/spi-atmel.c
> @@ -295,6 +295,7 @@ struct atmel_spi {
>  	int			irq;
>  	struct clk		*clk;
>  	struct platform_device	*pdev;
> +	unsigned long		spi_clk;
>  
>  	struct spi_transfer	*current_transfer;
>  	int			current_remaining_bytes;
> @@ -864,7 +865,7 @@ static int atmel_spi_set_xfer_speed(struct atmel_spi *as,
>  	unsigned long		bus_hz;
>  
>  	/* v1 chips start out at half the peripheral bus speed. */
> -	bus_hz = clk_get_rate(as->clk);
> +	bus_hz = as->spi_clk;
>  	if (!atmel_spi_is_v2(as))
>  		bus_hz /= 2;
>  
> @@ -1606,6 +1607,9 @@ static int atmel_spi_probe(struct platform_device *pdev)
>  	ret = clk_prepare_enable(clk);
>  	if (ret)
>  		goto out_free_irq;
> +
> +	as->spi_clk = clk_get_rate(clk);
> +
>  	spi_writel(as, CR, SPI_BIT(SWRST));
>  	spi_writel(as, CR, SPI_BIT(SWRST)); /* AT91SAM9263 Rev B workaround */
>  	if (as->caps.has_wdrbt) {
> 


-- 
Nicolas Ferre
