From: baruch@tkos.co.il (Baruch Siach)
Date: Thu, 6 Oct 2011 22:30:23 +0200
Subject: [PATCHv2] hw_random: add driver for atmel true hardware random
	number generator
In-Reply-To: <1317923791-31200-1-git-send-email-jacmet@sunsite.dk>
References: <1317923791-31200-1-git-send-email-jacmet@sunsite.dk>
Message-ID: <20111006203023.GE24034@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On Thu, Oct 06, 2011 at 07:56:30PM +0200, Peter Korsgaard wrote:
> For the IP block on 9g45/9g46/9m10/9m11.
> 
> Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
> ---

[snip]

> +static int atmel_trng_read(struct hwrng *rng, void *buf, size_t max,
> +			   bool wait)
> +{
> +	struct atmel_trng *trng = container_of(rng, struct atmel_trng, rng);
> +	u32 *data = buf;
> +
> +	/* data ready? */
> +	if (readl(trng->base + TRNG_ODATA) & 1) {
> +		*data = readl(trng->base + TRNG_ODATA);
> +		return 4;

Shouldn't you check for max >= 4 before writing to *buf?

> +	} else
> +		return 0;
> +}

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
