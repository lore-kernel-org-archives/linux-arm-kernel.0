From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 18 Aug 2014 10:20:40 +0200
Subject: [PATCH] pwm: Fix period and polarity in pwm_get() for
 non-perfect matches
In-Reply-To: <1407943133-18170-1-git-send-email-geert+renesas@glider.be>
References: <1407943133-18170-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20140818082039.GA31171@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 13, 2014 at 05:18:53PM +0200, Geert Uytterhoeven wrote:
> If pwm_get() finds a look-up entry with a perfect match (both dev_id and
> con_id match), the loop is aborted, and "p" still points to the correct
> struct pwm_lookup.
> 
> If only an entry with a matching dev_id or con_id is found, the loop
> terminates after traversing the whole list, and "p" now points to
> arbitrary memory, not part of the pwm_lookup list.
> Then pwm_set_period() and pwm_set_polarity() will set random values for
> period resp. polarity.
> 
> To fix this, save period and polarity when finding a new best match,
> just like is done for chip (for the provider) and index.
> 
> This fixes the LCD backlight on r8a7740/armadillo-legacy, which was fed
> period 0 and polarity -1068821144 instead of 33333 resp. 1.
> 
> Fixes: 3796ce1d4d4b330a75005c5eda105603ce9d4071 ("pwm: add period and polarity to struct pwm_lookup")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: stable at vger.kernel.org
> ---
>  drivers/pwm/core.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Good catch! One comment below.

> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index 4b66bf09ee55..d2c35920ff08 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -606,6 +606,8 @@ struct pwm_device *pwm_get(struct device *dev, const char *con_id)
>  	unsigned int best = 0;
>  	struct pwm_lookup *p;
>  	unsigned int match;
> +	unsigned int period;
> +	enum pwm_polarity polarity;
>  
>  	/* look up via DT first */
>  	if (IS_ENABLED(CONFIG_OF) && dev && dev->of_node)
> @@ -653,6 +655,8 @@ struct pwm_device *pwm_get(struct device *dev, const char *con_id)
>  		if (match > best) {
>  			chip = pwmchip_find_by_name(p->provider);
>  			index = p->index;
> +			period = p->period;
> +			polarity = p->polarity;
>  
>  			if (match != 3)
>  				best = match;
> @@ -668,8 +672,8 @@ struct pwm_device *pwm_get(struct device *dev, const char *con_id)
>  	if (IS_ERR(pwm))
>  		return pwm;
>  
> -	pwm_set_period(pwm, p->period);
> -	pwm_set_polarity(pwm, p->polarity);
> +	pwm_set_period(pwm, period);
> +	pwm_set_polarity(pwm, polarity);

Could we achieve the same by storing a pointer to the best match and
then use that instead of p? Perhaps something like this:

	struct pwm_lookup *entry;

	...

		if (match > best) {
			chip = pwmchip_find_by_name(p->provider);
			entry = p;

			if (match != 3)
				best = match;
			else
				break;
		}

	...

	if (chip)
		pwm = pwm_request_from_chip(chip, entry->index,
					    con_id ?: dev_id);
	if (IS_ERR(pwm))
		return pwm;

	pwm_set_period(pwm, entry->period);
	pwm_set_polarity(pwm, entry->polarity);

?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140818/34f48aa0/attachment.sig>
