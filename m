From: heiko@sntech.de (Heiko =?iso-8859-15?q?St=FCbner?=)
Date: Wed, 9 May 2012 11:20:41 +0200
Subject: [PATCH 07/10] spi: s3c64xx: Remove the 'set_level' callback from
 controller data
In-Reply-To: <1336514694-22393-8-git-send-email-thomas.abraham@linaro.org>
References: <1336514694-22393-1-git-send-email-thomas.abraham@linaro.org>
 <1336514694-22393-8-git-send-email-thomas.abraham@linaro.org>
Message-ID: <201205091120.41978.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 9. Mai 2012, 00:04:51 schrieb Thomas Abraham:
> The set_level callback in the controller data, which is used to configure
> the slave select line, cannot be supported when migrating the driver to
> device tree based discovery. Since all the platforms currently use gpio
> as the slave select line, this callback can be removed from the
> controller data and replaced with call to gpio_set_value in the driver.

I was quite fond of the set_level callback. On one of the machines I'm working
on there is some sort of multiplexer (TI-sn74cbtlv3257) sitting between the
controller and spi devices to provide support for more than one device.
So I was doing the switch to the correct device in the set_level callback,
which worked quite well.


In the end, I'm still ok with this consolidation, as the device line has
reached it's end of life and the second device (an epaper controller)
provides another form of access to it through the display controller of the
s3c2416.


Heiko

[1] https://github.com/mmind/linux-es600/blob/topic/es600-devel/arch/arm/mach-s3c24xx/common-es600.c#L1155

> Cc: Jaswinder Singh <jaswinder.singh@linaro.org>
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> ---
>  arch/arm/plat-samsung/include/plat/s3c64xx-spi.h |    2 --
>  drivers/spi/spi-s3c64xx.c                        |    8 ++++----
>  2 files changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h
> b/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h index a733ce9..48a6495
> 100644
> --- a/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h
> +++ b/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h
> @@ -18,7 +18,6 @@ struct platform_device;
>   * @fb_delay: Slave specific feedback delay.
>   *            Refer to FB_CLK_SEL register definition in SPI chapter.
>   * @line: Custom 'identity' of the CS line.
> - * @set_level: CS line control.
>   *
>   * This is per SPI-Slave Chipselect information.
>   * Allocate and initialize one in machine init code and make the
> @@ -27,7 +26,6 @@ struct platform_device;
>  struct s3c64xx_spi_csinfo {
>  	u8 fb_delay;
>  	unsigned line;
> -	void (*set_level)(unsigned line_id, int lvl);
>  };
> 
>  /**
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index f6bc0e3..d84ce7f 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -406,14 +406,14 @@ static inline void enable_cs(struct
> s3c64xx_spi_driver_data *sdd, if (sdd->tgl_spi != spi) { /* if last mssg
> on diff device */
>  			/* Deselect the last toggled device */
>  			cs = sdd->tgl_spi->controller_data;
> -			cs->set_level(cs->line,
> -					spi->mode & SPI_CS_HIGH ? 0 : 1);
> +			gpio_set_value(cs->line,
> +				spi->mode & SPI_CS_HIGH ? 0 : 1);
>  		}
>  		sdd->tgl_spi = NULL;
>  	}
> 
>  	cs = spi->controller_data;
> -	cs->set_level(cs->line, spi->mode & SPI_CS_HIGH ? 1 : 0);
> +	gpio_set_value(cs->line, spi->mode & SPI_CS_HIGH ? 1 : 0);
>  }
> 
>  static int wait_for_xfer(struct s3c64xx_spi_driver_data *sdd,
> @@ -499,7 +499,7 @@ static inline void disable_cs(struct
> s3c64xx_spi_driver_data *sdd, if (sdd->tgl_spi == spi)
>  		sdd->tgl_spi = NULL;
> 
> -	cs->set_level(cs->line, spi->mode & SPI_CS_HIGH ? 0 : 1);
> +	gpio_set_value(cs->line, spi->mode & SPI_CS_HIGH ? 0 : 1);
>  }
> 
>  static void s3c64xx_spi_config(struct s3c64xx_spi_driver_data *sdd)
