From: LW@KARO-electronics.de (=?iso-8859-15?Q?Lothar_Wa=DFmann?=)
Date: Fri, 17 Sep 2010 13:11:14 +0200
Subject: [PATCH 04/16] spi/imx: save the spi chip select in config struct,
	not the gpio to use
In-Reply-To: <1284717274-12850-4-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20100917095247.GB30441@pengutronix.de>
	<1284717274-12850-4-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <19603.19666.323684.891456@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> diff --git a/drivers/spi/spi_imx.c b/drivers/spi/spi_imx.c
> index 60a52d1..23db984 100644
> --- a/drivers/spi/spi_imx.c
> +++ b/drivers/spi/spi_imx.c
> @@ -56,7 +56,7 @@ struct spi_imx_config {
>  	unsigned int speed_hz;
>  	unsigned int bpw;
>  	unsigned int mode;
> -	int cs;
> +	u8 cs;
        ^^^^^^
>  };
>  
>  enum spi_imx_devtype {
> @@ -218,6 +218,7 @@ static int __maybe_unused spi_imx0_4_config(struct spi_imx_data *spi_imx,
>  		struct spi_imx_config *config)
>  {
>  	unsigned int reg = MX31_CSPICTRL_ENABLE | MX31_CSPICTRL_MASTER;
> +	int cs = spi_imx->chipselect[config->cs];
>  
>  	reg |= spi_imx_clkdiv_2(spi_imx->spi_clk, config->speed_hz) <<
>  		MX31_CSPICTRL_DR_SHIFT;
> @@ -230,9 +231,8 @@ static int __maybe_unused spi_imx0_4_config(struct spi_imx_data *spi_imx,
>  		reg |= MX31_CSPICTRL_POL;
>  	if (config->mode & SPI_CS_HIGH)
>  		reg |= MX31_CSPICTRL_SSPOL;
> -	if (config->cs < 0) {
> -		reg |= (config->cs + 32) << MX31_CSPICTRL_CS_SHIFT;
> -	}
> +	if (cs < 0)
>
This can never be true, since an 'int' promoted from 'u8' will always
be positive!


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
