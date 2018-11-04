From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 4 Nov 2018 13:16:20 +0100
Subject: [PATCH 10/11] spi: pxa2xx: Add ready signal
In-Reply-To: <20181010170936.316862-11-lkundrak@v3.sk>
References: <20181010170936.316862-1-lkundrak@v3.sk>
 <20181010170936.316862-11-lkundrak@v3.sk>
Message-ID: <20181104121620.GV23864@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 2018-10-10 19:09:35, Lubomir Rintel wrote:
> Strobe a GPIO line when the slave TX FIFO is filled. This is how the
> Embedded Controller on an OLPC XO-1.75 machine, that happens to be a SPI
> master, learns that it can initiate a transaction.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Acked-by: Pavel Machek <pavel@ucw.cz>

> ---
>  drivers/spi/spi-pxa2xx.c | 12 ++++++++++++
>  drivers/spi/spi-pxa2xx.h |  3 +++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
> index 3848842d68fd..a3b4b12c1077 100644
> --- a/drivers/spi/spi-pxa2xx.c
> +++ b/drivers/spi/spi-pxa2xx.c
> @@ -1079,6 +1079,9 @@ static int pxa2xx_spi_transfer_one(struct spi_controller *master,
>  	if (spi_controller_is_slave(master)) {
>  		while (drv_data->write(drv_data))
>  			;
> +		gpiod_set_value(drv_data->gpiod_ready, 1);
> +		udelay(1);
> +		gpiod_set_value(drv_data->gpiod_ready, 0);
>  	}
>  
>  	/*
> @@ -1784,6 +1787,15 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> +	if (platform_info->is_slave) {
> +		drv_data->gpiod_ready = devm_gpiod_get_optional(dev,
> +						"ready", GPIOD_OUT_LOW);
> +		if (IS_ERR(drv_data->gpiod_ready)) {
> +			status = (int)PTR_ERR(drv_data->gpiod_ready);
> +			goto out_error_clock_enabled;
> +		}
> +	}
> +
>  	pm_runtime_set_autosuspend_delay(&pdev->dev, 50);
>  	pm_runtime_use_autosuspend(&pdev->dev);
>  	pm_runtime_set_active(&pdev->dev);
> diff --git a/drivers/spi/spi-pxa2xx.h b/drivers/spi/spi-pxa2xx.h
> index 513c53aaeab2..4e324da66ef7 100644
> --- a/drivers/spi/spi-pxa2xx.h
> +++ b/drivers/spi/spi-pxa2xx.h
> @@ -64,6 +64,9 @@ struct driver_data {
>  
>  	/* GPIOs for chip selects */
>  	struct gpio_desc **cs_gpiods;
> +
> +	/* Optional slave FIFO ready signal */
> +	struct gpio_desc *gpiod_ready;
>  };
>  
>  struct chip_data {

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181104/7698ac8d/attachment.sig>
