From: eric@anholt.net (Eric Anholt)
Date: Wed, 08 Nov 2017 10:22:29 -0800
Subject: [PATCH v2 02/12] hwrng: bcm2835-rng: Define a driver private
 context
In-Reply-To: <20171108004449.32730-3-f.fainelli@gmail.com>
References: <20171108004449.32730-1-f.fainelli@gmail.com>
 <20171108004449.32730-3-f.fainelli@gmail.com>
Message-ID: <87po8sy6je.fsf@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Florian Fainelli <f.fainelli@gmail.com> writes:

> Instead of making hwrng::priv host the base register address, define a
> driver private context, make it per platform device instance and pass it
> down the different functions.
>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  drivers/char/hw_random/bcm2835-rng.c | 55 ++++++++++++++++++++++--------------
>  1 file changed, 34 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/char/hw_random/bcm2835-rng.c b/drivers/char/hw_random/bcm2835-rng.c
> index a818418a7e4c..0d72147ab45b 100644
> --- a/drivers/char/hw_random/bcm2835-rng.c
> +++ b/drivers/char/hw_random/bcm2835-rng.c

> -static struct hwrng bcm2835_rng_ops = {
> -	.name	= "bcm2835",
> -	.read	= bcm2835_rng_read,
> -};
> -

>  	/* map peripheral */
> -	rng_base = devm_ioremap_resource(dev, r);
> -	if (IS_ERR(rng_base)) {
> +	priv->base = devm_ioremap_resource(dev, r);
> +	if (IS_ERR(priv->base)) {
>  		dev_err(dev, "failed to remap rng regs");
> -		return PTR_ERR(rng_base);
> +		return PTR_ERR(priv->base);
>  	}
> -	bcm2835_rng_ops.priv = (unsigned long)rng_base;
> +
> +	priv->rng.name = "bcm2835-rng";

Looks like an unintentional change from the previous "bcm2835" here?

Other than that, 1-2 are:

Reviewed-by: Eric Anholt <eric@anholt.net>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171108/68614950/attachment.sig>
