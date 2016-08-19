From: clabbe.montjoie@gmail.com (Corentin LABBE)
Date: Fri, 19 Aug 2016 07:40:41 +0200
Subject: [PATCH -next] crypto: fix missing unlock on error in sun4i_hash()
In-Reply-To: <1471560130-5265-1-git-send-email-weiyj.lk@gmail.com>
References: <1471560130-5265-1-git-send-email-weiyj.lk@gmail.com>
Message-ID: <8aa15aa0-4aa3-793c-c9cf-e8f94caf12f1@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/08/2016 00:42, Wei Yongjun wrote:
> Add the missing unlock before return from function sun4i_hash()
> in the error handling case.
> 
> Fixes: 477d9b2e591b ("crypto: sun4i-ss - unify update/final function")
> Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>
> ---
>  drivers/crypto/sunxi-ss/sun4i-ss-hash.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/crypto/sunxi-ss/sun4i-ss-hash.c b/drivers/crypto/sunxi-ss/sun4i-ss-hash.c
> index 2ee3b59..de66f47 100644
> --- a/drivers/crypto/sunxi-ss/sun4i-ss-hash.c
> +++ b/drivers/crypto/sunxi-ss/sun4i-ss-hash.c
> @@ -245,6 +245,7 @@ int sun4i_hash(struct ahash_request *areq)
>  		if (end > areq->nbytes || areq->nbytes - end > 63) {
>  			dev_err(ss->dev, "ERROR: Bound error %u %u\n",
>  				end, areq->nbytes);
> +			spin_unlock(&ss->slock);
>  			return -EINVAL;
>  		}
>  	} else {
> 

Hello

Thanks for the finding, but it is better in that case to use the goto release_ss since it need also to stop the device.

Regards

LABBE Corentin
