From: jic23@kernel.org (Jonathan Cameron)
Date: Mon, 06 May 2013 17:27:38 +0100
Subject: [PATCH 1/2] staging/iio/mxs-lradc: cleanup masklength
In-Reply-To: <6bb527db65fb20f60bb95814bff3abc513733a7c.1367671597.git.mirq-linux@rere.qmqm.pl>
References: <6bb527db65fb20f60bb95814bff3abc513733a7c.1367671597.git.mirq-linux@rere.qmqm.pl>
Message-ID: <5187D9FA.8000808@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/04/2013 02:19 PM, Micha? Miros?aw wrote:
> We know the exact iio->masklength = LRADC_MAX_TOTAL_CHANS.
> Let's use it consistently.
I guess this gives a small improvement in clarity so
applied to togreg branch of iio.git.

Thanks,
> 
> Signed-off-by: Micha? Miros?aw <mirq-linux@rere.qmqm.pl>
> ---
>  drivers/staging/iio/adc/mxs-lradc.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
> index 2856b8f..03299ea 100644
> --- a/drivers/staging/iio/adc/mxs-lradc.c
> +++ b/drivers/staging/iio/adc/mxs-lradc.c
> @@ -620,7 +620,7 @@ static irqreturn_t mxs_lradc_trigger_handler(int irq, void *p)
>  		((LRADC_DELAY_TIMER_LOOP - 1) << LRADC_CH_NUM_SAMPLES_OFFSET);
>  	unsigned int i, j = 0;
>  
> -	for_each_set_bit(i, iio->active_scan_mask, iio->masklength) {
> +	for_each_set_bit(i, iio->active_scan_mask, LRADC_MAX_TOTAL_CHANS) {
>  		lradc->buffer[j] = readl(lradc->base + LRADC_CH(j));
>  		writel(chan_value, lradc->base + LRADC_CH(j));
>  		lradc->buffer[j] &= LRADC_CH_VALUE_MASK;
> @@ -775,8 +775,7 @@ static bool mxs_lradc_validate_scan_mask(struct iio_dev *iio,
>  					const unsigned long *mask)
>  {
>  	struct mxs_lradc *lradc = iio_priv(iio);
> -	const int len = iio->masklength;
> -	const int map_chans = bitmap_weight(mask, len);
> +	const int map_chans = bitmap_weight(mask, LRADC_MAX_TOTAL_CHANS);
>  	int rsvd_chans = 0;
>  	unsigned long rsvd_mask = 0;
>  
> @@ -793,7 +792,7 @@ static bool mxs_lradc_validate_scan_mask(struct iio_dev *iio,
>  		rsvd_chans++;
>  
>  	/* Test for attempts to map channels with special mode of operation. */
> -	if (bitmap_intersects(mask, &rsvd_mask, len))
> +	if (bitmap_intersects(mask, &rsvd_mask, LRADC_MAX_TOTAL_CHANS))
>  		return false;
>  
>  	/* Test for attempts to map more channels then available slots. */
> @@ -969,6 +968,7 @@ static int mxs_lradc_probe(struct platform_device *pdev)
>  	iio->modes = INDIO_DIRECT_MODE;
>  	iio->channels = mxs_lradc_chan_spec;
>  	iio->num_channels = ARRAY_SIZE(mxs_lradc_chan_spec);
> +	iio->masklength = LRADC_MAX_TOTAL_CHANS;
>  
>  	ret = iio_triggered_buffer_setup(iio, &iio_pollfunc_store_time,
>  				&mxs_lradc_trigger_handler,
> 
