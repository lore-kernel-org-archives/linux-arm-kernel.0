From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 4 Jan 2016 15:20:01 +0100
Subject: [RFC PATCH 2/5] crypto: sunxi-ss: fix min3() call to match types
In-Reply-To: <1450787267-26836-3-git-send-email-andre.przywara@arm.com>
References: <1450787267-26836-1-git-send-email-andre.przywara@arm.com>
 <1450787267-26836-3-git-send-email-andre.przywara@arm.com>
Message-ID: <20160104142001.GB28361@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 22, 2015 at 12:27:44PM +0000, Andre Przywara wrote:
> The min3() macro expects all arguments to be of the same type (or
> size at least). While two arguments are ints or u32s, one is size_t,
> which does not match on 64-bit architectures.
> Cast the size_t to u32 to make min3() happy. In this context here the
> length should never exceed 32 bits anyway.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  drivers/crypto/sunxi-ss/sun4i-ss-cipher.c | 12 ++++++------
>  drivers/crypto/sunxi-ss/sun4i-ss-hash.c   |  8 ++++----
>  2 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/crypto/sunxi-ss/sun4i-ss-cipher.c b/drivers/crypto/sunxi-ss/sun4i-ss-cipher.c
> index a19ee12..b3bc7bd 100644
> --- a/drivers/crypto/sunxi-ss/sun4i-ss-cipher.c
> +++ b/drivers/crypto/sunxi-ss/sun4i-ss-cipher.c
> @@ -79,7 +79,7 @@ static int sun4i_ss_opti_poll(struct ablkcipher_request *areq)
>  	oi = 0;
>  	oo = 0;
>  	do {
> -		todo = min3(rx_cnt, ileft, (mi.length - oi) / 4);
> +		todo = min3(rx_cnt, ileft, (u32)(mi.length - oi) / 4);

For this case the min function has a min_t variant to specify the
argument. What about introducing min3_t?

BTW, I don't understand why min3(x, y, z) isn't just defined as

	#define min3(x, y, z) min(min(x, y), z)

but instead as:

	#define min3(x, y, z) min((typeof(x))min(x, y), z)

. I thought min(x, y) has the same type as x anyhow?

Best regards
Uwe


-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
