From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 22 Feb 2011 11:37:07 +0100
Subject: [PATCH v4 2/4] mc13xxx-core: Kconfig: Config menu driven by
	specific IC type
In-Reply-To: <1294119299-18352-3-git-send-email-marc@cpdesign.com.au>
References: <1294119299-18352-1-git-send-email-marc@cpdesign.com.au>
	<1294119299-18352-3-git-send-email-marc@cpdesign.com.au>
Message-ID: <20110222103707.GZ22310@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 04, 2011 at 04:34:57PM +1100, Marc Reilly wrote:
> This patch makes config items for the mc13892 and mc13783 distinct and
> splits introduces a separate config item for spi interface support in
> preparation for a separate i2c and spi backend.
> 
> The mc13xxx generic core is therefore selected by the spi (or i2c) item:
> having it the other way around doesn't work for other drivers that will
> need to distinguish between mc13783 and mc13892 (at build time).
> 
> Signed-off-by: Marc Reilly <marc@cpdesign.com.au>
> ---
>  drivers/mfd/Kconfig |   34 +++++++++++++++++++++++++---------
>  1 files changed, 25 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 3a1493b..9ce1d42 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -425,20 +425,36 @@ config MFD_PCF50633
>  	  so that function-specific drivers can bind to them.
>  
>  config MFD_MC13783
> -	tristate
> -
> -config MFD_MC13XXX
> -	tristate "Support Freescale MC13783 and MC13892"
>  	depends on SPI_MASTER
> -	select MFD_CORE
> -	select MFD_MC13783
> +	select MFD_MC13XXX_SPI
> +	tristate "Support for Freescale MC13783 PMIC"
>  	help
> -	  Support for the Freescale (Atlas) PMIC and audio CODECs
> -	  MC13783 and MC13892.
> -	  This driver provides common support for accessing  the device,
> +	  Support for the Freescale MC13783 PMIC and audio CODEC.
> +	  This driver provides common support for accessing the device,
>  	  additional drivers must be enabled in order to use the
>  	  functionality of the device.
>  
> +config MFD_MC13892
> +	depends on SPI_MASTER || I2C
Actually you don't have that || I2C yet, do you?

Other than that I only wonder if it's worth to split the support for
13892 and 13783 explicitly and move the spi and i2c backends to
dedicated files.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
