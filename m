From: jic23@kernel.org (Jonathan Cameron)
Date: Sat, 15 Aug 2015 14:13:14 +0100
Subject: [PATCH 16/20] iio: bmc150: Fix irq checks
In-Reply-To: <1439374365-20623-17-git-send-email-mpa@pengutronix.de>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
 <1439374365-20623-17-git-send-email-mpa@pengutronix.de>
Message-ID: <55CF3AEA.2070508@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/08/15 11:12, Markus Pargmann wrote:
> Valid irqs are > 0. This patch fixes the check which fails for the new
> spi driver part if no interrupt was given.
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
This one crossed with Octavian's patch that cleaned up all cases of this.
c176becd81843 iio: fix drivers that consider 0 as a valid IRQ in client->irq

Hence you can drop this one from the v2 of this series.

(Its amazing how many times we get multiple patches for the same issue that
has been there for ages in the same week or so!)

Jonathan
> ---
>  drivers/iio/accel/bmc150-accel.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/bmc150-accel.c b/drivers/iio/accel/bmc150-accel.c
> index 4e70f51c2370..fe2d2316158f 100644
> --- a/drivers/iio/accel/bmc150-accel.c
> +++ b/drivers/iio/accel/bmc150-accel.c
> @@ -1660,10 +1660,10 @@ static int bmc150_accel_probe(struct i2c_client *client,
>  		return ret;
>  	}
>  
> -	if (client->irq < 0)
> +	if (client->irq <= 0)
>  		client->irq = bmc150_accel_gpio_probe(client, data);
>  
> -	if (client->irq >= 0) {
> +	if (client->irq > 0) {
>  		ret = devm_request_threaded_irq(
>  						&client->dev, client->irq,
>  						bmc150_accel_irq_handler,
> 
