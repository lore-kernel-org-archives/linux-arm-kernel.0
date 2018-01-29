From: l.stelmach@samsung.com (=?utf-8?Q?=C5=81ukasz_Stelmach?=)
Date: Mon, 29 Jan 2018 14:24:00 +0100
Subject: [PATCH][next] hwrng: exynos: check for -ve error return from
 readl_poll_timeout
In-Reply-To: <20180112163048.26960-1-colin.king@canonical.com>
References: <20180112163048.26960-1-colin.king@canonical.com>
 <CGME20180129132405eucas1p244f341793274cd1c11aa09e0b1d2c4bd@eucas1p2.samsung.com>
Message-ID: <87fu6oyf0v.fsf%l.stelmach@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It was <2018-01-12 pi? 17:30>, when Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> Currently, the return from readl_poll_timeout is being assigned to
> a u32 and this is being checked for a -ve return which is always
> false since a u32 cannot be less than zero.  Fix this by changing
> val to an int so that error returns can be correctly detected.
>
> Detected by CoverityScan, CID#1463776 ("Logically dead code")
>
> Fixes: 6cd225cc5d8a ("hwrng: exynos - add Samsung Exynos True RNG driver")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/char/hw_random/exynos-trng.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/char/hw_random/exynos-trng.c b/drivers/char/hw_random/exynos-trng.c
> index 34d6f51ecbee..f4643e3ec346 100644
> --- a/drivers/char/hw_random/exynos-trng.c
> +++ b/drivers/char/hw_random/exynos-trng.c
> @@ -55,7 +55,7 @@ static int exynos_trng_do_read(struct hwrng *rng, void *data, size_t max,
>  			       bool wait)
>  {
>  	struct exynos_trng_dev *trng;
> -	u32 val;
> +	int val;
>  
>  	max = min_t(size_t, max, (EXYNOS_TRNG_FIFO_LEN * 4));

Fixed.

https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git/commit/?id=a8bc71d4960391f732ec0307ebd69e4a25aaf4d3

-- 
?ukasz Stelmach
Samsung R&D Institute Poland
Samsung Electronics
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 472 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180129/dd38b2f7/attachment.sig>
