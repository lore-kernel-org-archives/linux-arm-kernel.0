From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Wed, 7 Feb 2018 10:56:59 +0100
Subject: [PATCH 1/2] sun4i_ss_prng: fix return value of
 sun4i_ss_prng_generate
In-Reply-To: <20180206212022.1309-2-artem.savkov@gmail.com>
References: <20180206212022.1309-1-artem.savkov@gmail.com>
 <20180206212022.1309-2-artem.savkov@gmail.com>
Message-ID: <20180207095659.GA19249@Red>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 06, 2018 at 10:20:21PM +0100, Artem Savkov wrote:
> According to crypto/rng.h generate function should return 0 on success
> and < 0 on error.
> 
> Fixes: b8ae5c7387ad ("crypto: sun4i-ss - support the Security System PRNG")
> Signed-off-by: Artem Savkov <artem.savkov@gmail.com>
> ---
>  drivers/crypto/sunxi-ss/sun4i-ss-prng.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/crypto/sunxi-ss/sun4i-ss-prng.c b/drivers/crypto/sunxi-ss/sun4i-ss-prng.c
> index 0d01d1624252..5754e0b92fb0 100644
> --- a/drivers/crypto/sunxi-ss/sun4i-ss-prng.c
> +++ b/drivers/crypto/sunxi-ss/sun4i-ss-prng.c
> @@ -52,5 +52,5 @@ int sun4i_ss_prng_generate(struct crypto_rng *tfm, const u8 *src,
>  
>  	writel(0, ss->base + SS_CTL);
>  	spin_unlock(&ss->slock);
> -	return dlen;
> +	return 0;
>  }
> -- 
> 2.15.1
> 

According to Documentation/crypto/api-samples.rst ("Code Example For Random Number Generator Usage")
you must return the length of data generated.

So crypto_rng_generate/crypto_rng_get_bytes documentation in crypto/rng.h must be fixed.

Herbert could you confirm ?

Regards
