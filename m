From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 13 Jun 2012 08:36:50 +0200
Subject: [PATCH] ARM: mxc-rnga: fix data_present API
In-Reply-To: <1795608889.2533817.1339535267600.JavaMail.root@advansee.com>
References: <1795608889.2533817.1339535267600.JavaMail.root@advansee.com>
Message-ID: <20120613063650.GB32436@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

your changelog is very sparse. Maybe point out the commit that changed
the API without fixing its users?

On Tue, Jun 12, 2012 at 11:07:47PM +0200, Beno?t Th?baudeau wrote:
> Cc: Matt Mackall <mpm@selenic.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Alan Carvalho de Assis <acassis@gmail.com>
> Cc: <linux-arm-kernel@lists.infradead.org>
> Signed-off-by: Beno?t Th?baudeau <benoit.thebaudeau@advansee.com>
> ---
>  .../drivers/char/hw_random/mxc-rnga.c              |   22 +++++++++++++-------
>  1 file changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git linux-next-HEAD-c90e5d2.orig/drivers/char/hw_random/mxc-rnga.c linux-next-HEAD-c90e5d2/drivers/char/hw_random/mxc-rnga.c
> index 187c6be..2924253 100644
> --- linux-next-HEAD-c90e5d2.orig/drivers/char/hw_random/mxc-rnga.c
> +++ linux-next-HEAD-c90e5d2/drivers/char/hw_random/mxc-rnga.c
> @@ -24,6 +24,7 @@
>  #include <linux/ioport.h>
>  #include <linux/platform_device.h>
>  #include <linux/hw_random.h>
> +#include <linux/delay.h>
>  #include <linux/io.h>
>  
>  /* RNGA Registers */
> @@ -60,16 +61,21 @@
>  
>  static struct platform_device *rng_dev;
>  
> -static int mxc_rnga_data_present(struct hwrng *rng)
> +static int mxc_rnga_data_present(struct hwrng *rng, int wait)
>  {
> -	int level;
>  	void __iomem *rng_base = (void __iomem *)rng->priv;
> -
> -	/* how many random numbers is in FIFO? [0-16] */
> -	level = ((__raw_readl(rng_base + RNGA_STATUS) &
> -			RNGA_STATUS_LEVEL_MASK) >> 8);
> -
> -	return level > 0 ? 1 : 0;
> +	int level, data, i;
level is only used in the for loop, so it should be declared there, too.

> +
> +	for (i = 0; i < 20; i++) {
> +		/* how many random numbers is in FIFO? [0-16] */
As you touch this comment can you fix the grammar, too? (i.e. s/is/are/)

> +		level = ((__raw_readl(rng_base + RNGA_STATUS) &
> +				RNGA_STATUS_LEVEL_MASK) >> 8);
> +		data = level > 0 ? 1 : 0;
This statement is equivalent to:

	data = level > 0;

so IMHO there is no need for the data variable.

> +		if (data || !wait)
> +			break;
> +		udelay(10);
Apart from the magic 20 that Fabio already pointed out, these 10 us are
magic, too. What is the requirement when wait evaluates to true? Are you
allowed to sleep? If so, maybe better do that?

> +	}
> +	return data;
>  }
>  
>  static int mxc_rnga_data_read(struct hwrng *rng, u32 * data)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
