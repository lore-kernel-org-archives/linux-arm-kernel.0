From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 15 Sep 2011 21:52:43 +0200
Subject: [PATCH v2] spi/imx: Fix spi-imx when the hardware SPI
	chipselects are used
In-Reply-To: <1316111337-13485-1-git-send-email-fabio.estevam@freescale.com>
References: <1316111337-13485-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20110915195243.GH11297@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Fabio,

On Thu, Sep 15, 2011 at 03:28:57PM -0300, Fabio Estevam wrote:
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index 8ac6542..d917fa3 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -784,11 +784,13 @@ static int __devinit spi_imx_probe(struct platform_device *pdev)
>  
>  	for (i = 0; i < master->num_chipselect; i++) {
>  		int cs_gpio = of_get_named_gpio(np, "cs-gpios", i);
> -		if (cs_gpio < 0)
> +		if (cs_gpio < 0) {
>  			cs_gpio = mxc_platform_info->chipselect[i];
> +			spi_imx->chipselect[i] = cs_gpio;
> +		}
>  		if (cs_gpio < 0)
>  			continue;
> -		spi_imx->chipselect[i] = cs_gpio;
> +
>  		ret = gpio_request(spi_imx->chipselect[i], DRIVER_NAME);
>  		if (ret) {
>  			while (i > 0) {
I think this is wrong. In case of_get_named_gpio returns a gpio to use
spi_imx->chipselect[i] is unassigned.

I think you just need

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 8ac6542..fa594d6 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -786,9 +786,11 @@ static int __devinit spi_imx_probe(struct platform_device *pdev)
 		int cs_gpio = of_get_named_gpio(np, "cs-gpios", i);
 		if (cs_gpio < 0)
 			cs_gpio = mxc_platform_info->chipselect[i];
+
+		spi_imx->chipselect[i] = cs_gpio;
 		if (cs_gpio < 0)
 			continue;
-		spi_imx->chipselect[i] = cs_gpio;
+
 		ret = gpio_request(spi_imx->chipselect[i], DRIVER_NAME);
 		if (ret) {
 			while (i > 0) {

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
