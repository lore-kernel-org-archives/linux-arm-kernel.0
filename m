From: eric@anholt.net (Eric Anholt)
Date: Mon, 23 May 2016 19:21:00 -0700
Subject: [PATCH 4/4] hwrng: bcm2835: Read as much data as available
In-Reply-To: <1464020451-16520-5-git-send-email-yendapally.reddy@broadcom.com>
References: <1464020451-16520-1-git-send-email-yendapally.reddy@broadcom.com>
 <1464020451-16520-5-git-send-email-yendapally.reddy@broadcom.com>
Message-ID: <87k2ik2o37.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>
writes:

> Read the requested number of data from the fifo
>
> Signed-off-by: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>
> ---
>  drivers/char/hw_random/bcm2835-rng.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/char/hw_random/bcm2835-rng.c b/drivers/char/hw_random/bcm2835-rng.c
> index b1e8b78..9bbdc07 100644
> --- a/drivers/char/hw_random/bcm2835-rng.c
> +++ b/drivers/char/hw_random/bcm2835-rng.c
> @@ -43,6 +43,8 @@ static int bcm2835_rng_read(struct hwrng *rng, void *buf, size_t max,
>  			       bool wait)
>  {
>  	void __iomem *rng_base = (void __iomem *)rng->priv;
> +	u32 max_words = max/sizeof(u32);

Style fix: Binary operators get a space on each side, so
"max / sizeof(u32);"

> @@ -50,8 +52,14 @@ static int bcm2835_rng_read(struct hwrng *rng, void *buf, size_t max,
>  		cpu_relax();
>  	}
>  
> -	*(u32 *)buf = __raw_readl(rng_base + RNG_DATA);
> -	return sizeof(u32);
> +	num_words = (readl(rng_base + RNG_STATUS) >> 24);

Optional cleanup: here and in the return statement, drop the extra
parenthesis.

Functionality-wise, this patch looks great to me, and should make the
driver more efficient.  With at least the binary operators change done,
it will be:

Reviewed-by: Eric Anholt <eric@anholt.net>

Thanks!
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160523/14498083/attachment.sig>
