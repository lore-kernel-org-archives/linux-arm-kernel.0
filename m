From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 31 May 2017 12:06:14 +0200
Subject: [PATCH v2 linux-next 1/3] spi: imx: add selection for iMX53 and
 iMX6 controller
In-Reply-To: <1496222398-3192-2-git-send-email-jiada_wang@mentor.com>
References: <1496222398-3192-1-git-send-email-jiada_wang@mentor.com>
 <1496222398-3192-2-git-send-email-jiada_wang@mentor.com>
Message-ID: <20170531100614.nl7mjtjamtpo7ltp@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 31, 2017 at 02:19:56AM -0700, jiada_wang at mentor.com wrote:
> From: Jiada Wang <jiada_wang@mentor.com>
> 
> ECSPI contorller for iMX53 and iMX6 has few hardware issues
> comparing to iMX51.
> The change add possibility to detect which controller is used
> to apply possible workaround and limitations.
> 
> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
> ---
>  .../devicetree/bindings/spi/fsl-imx-cspi.txt       |  1 +
>  drivers/spi/spi-imx.c                              | 46 ++++++++++++++++++++--

[...]

> +
>  static inline unsigned spi_imx_get_fifosize(struct spi_imx_data *d)
>  {
> -	return is_imx51_ecspi(d) ? 64 : 8;
> +	switch (d->devtype_data->devtype) {
> +	case IMX51_ECSPI:
> +	case IMX53_ECSPI:
> +		return 64;
> +	default:
> +		return 8;
> +	}
> +}
> +
> +static inline bool spi_imx_has_dmamode(struct spi_imx_data *d)
> +{
> +	switch (d->devtype_data->devtype) {
> +	case IMX35_CSPI:
> +	case IMX51_ECSPI:
> +	case IMX53_ECSPI:
> +		return true;
> +	default:
> +		return false;
> +	}
>  }

Please add the fifosize and DMA capability to struct spi_imx_devtype_data, this
struct was introduced to hold SoC specific informations.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
