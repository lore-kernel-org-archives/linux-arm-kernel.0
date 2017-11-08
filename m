From: eric@anholt.net (Eric Anholt)
Date: Wed, 08 Nov 2017 10:31:21 -0800
Subject: [PATCH v2 07/12] hwrng: bcm2835-rng: Manage an optional clock
In-Reply-To: <20171108004449.32730-8-f.fainelli@gmail.com>
References: <20171108004449.32730-1-f.fainelli@gmail.com>
 <20171108004449.32730-8-f.fainelli@gmail.com>
Message-ID: <87h8u4y64m.fsf@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Florian Fainelli <f.fainelli@gmail.com> writes:

> One of the last steps before bcm63xx-rng can be eliminated is to manage
> a clock during hwrng::init and hwrng::cleanup, so fetch it in the probe
> function, and manage it during these two steps when valid.
>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  drivers/char/hw_random/bcm2835-rng.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/char/hw_random/bcm2835-rng.c b/drivers/char/hw_random/bcm2835-rng.c
> index ed20e0b6b7ae..99b56fd5482c 100644
> --- a/drivers/char/hw_random/bcm2835-rng.c
> +++ b/drivers/char/hw_random/bcm2835-rng.c
> @@ -15,6 +15,7 @@
>  #include <linux/of_platform.h>
>  #include <linux/platform_device.h>
>  #include <linux/printk.h>
> +#include <linux/clk.h>
>  
>  #define RNG_CTRL	0x0
>  #define RNG_STATUS	0x4
> @@ -33,6 +34,7 @@ struct bcm2835_rng_priv {
>  	struct hwrng rng;
>  	void __iomem *base;
>  	bool mask_interrupts;
> +	struct clk *clk;
>  };
>  
>  static inline struct bcm2835_rng_priv *to_rng_priv(struct hwrng *rng)
> @@ -66,8 +68,15 @@ static int bcm2835_rng_read(struct hwrng *rng, void *buf, size_t max,
>  static int bcm2835_rng_init(struct hwrng *rng)
>  {
>  	struct bcm2835_rng_priv *priv = to_rng_priv(rng);
> +	int ret = 0;
>  	u32 val;
>  
> +	if (!IS_ERR(priv->clk)) {
> +		ret = clk_prepare_enable(priv->clk);
> +		if (ret)
> +			return ret;
> +	}

clk_prepare_enable() is protected by IS_ERR_OR_NULL() checks and will
return 0.

> +
>  	if (priv->mask_interrupts) {
>  		/* mask the interrupt */
>  		val = readl(priv->base + RNG_INT_MASK);
> @@ -79,7 +88,7 @@ static int bcm2835_rng_init(struct hwrng *rng)
>  	__raw_writel(RNG_WARMUP_COUNT, priv->base + RNG_STATUS);
>  	__raw_writel(RNG_RBGEN, priv->base + RNG_CTRL);
>  
> -	return 0;
> +	return ret;
>  }
>  
>  static void bcm2835_rng_cleanup(struct hwrng *rng)
> @@ -88,6 +97,9 @@ static void bcm2835_rng_cleanup(struct hwrng *rng)
>  
>  	/* disable rng hardware */
>  	__raw_writel(0, priv->base + RNG_CTRL);
> +
> +	if (!IS_ERR(priv->clk))
> +		clk_disable_unprepare(priv->clk);

Same.  With those conditionals dropped,

Reviewed-by: Eric Anholt <eric@anholt.net>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171108/5f0105ed/attachment-0001.sig>
