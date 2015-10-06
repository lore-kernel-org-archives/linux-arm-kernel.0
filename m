From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Tue, 6 Oct 2015 16:48:23 +0100
Subject: [PATCH 2/3] hwrng: st: Report correct FIFO size
In-Reply-To: <1444142640-14721-2-git-send-email-lee.jones@linaro.org>
References: <1444142640-14721-1-git-send-email-lee.jones@linaro.org>
 <1444142640-14721-2-git-send-email-lee.jones@linaro.org>
Message-ID: <5613ED47.1040608@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/10/15 15:43, Lee Jones wrote:
> The values supplied to the 'read random data from FIFO' arithmetic
> are not correct.  The value fed in to initialise the iterator
> describes the FIFO depth, but then the iterator is treated in
> Bytes and subsequently increased by 2 in value for every read
> word.  This means only 4 of the 8 available values are being read
> during each invocation of .read().
>
> This change increased the device bandwidth by a factor of 2.
>
> Reported-by: Daniel Thompson <daniel.thompson@linaro.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>   drivers/char/hw_random/st-rng.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/char/hw_random/st-rng.c b/drivers/char/hw_random/st-rng.c
> index 8c8a435..44480fe 100644
> --- a/drivers/char/hw_random/st-rng.c
> +++ b/drivers/char/hw_random/st-rng.c
> @@ -29,8 +29,9 @@
>   #define ST_RNG_STATUS_BAD_ALTERNANCE	BIT(1)
>   #define ST_RNG_STATUS_FIFO_FULL		BIT(5)
>
> -#define ST_RNG_FIFO_SIZE		8
>   #define ST_RNG_SAMPLE_SIZE		2 /* 2 Byte (16bit) samples */
> +#define ST_RNG_FIFO_DEPTH		8
> +#define ST_RNG_FIFO_SIZE		(ST_RNG_FIFO_DEPTH * ST_RNG_SAMPLE_SIZE)
>
>   /* Samples are available every 0.667us, which we round to 1us */
>   #define ST_RNG_FILL_FIFO_TIMEOUT   (1 * (ST_RNG_FIFO_SIZE / ST_RNG_SAMPLE_SIZE))

This change doubles the timeout and doesn't mention it in the changelog. 
Changing the order of 2/3 and 3/3 would avoid this.

Other than that:

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
