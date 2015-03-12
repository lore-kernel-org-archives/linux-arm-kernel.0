From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Thu, 12 Mar 2015 14:54:33 -0700
Subject: [PATCH] touchscreen: sun4i-ts: Really fix A10 temperature
 reporting
In-Reply-To: <1425893870-28715-1-git-send-email-hdegoede@redhat.com>
References: <1425893870-28715-1-git-send-email-hdegoede@redhat.com>
Message-ID: <20150312215433.GC4720@dtor-ws>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 09, 2015 at 10:37:50AM +0100, Hans de Goede wrote:
> The commit titled:
> "touchscreen: sun4i-ts: A10 (sun4i) has a different temperature curve"
> contains a math error, the offset it uses is in degrees, but the actual code
> applies the offset before multiplying by stepsize :|
> 
> Given that this is rather backwards (every math course ever thought applies
> the multiplication before the offset for linear functions), this commit
> fixes things by changing the code applying the offset to do the logical
> thing, adjusting the offset for the other models accordingly.
> 
> This has been tested on an A10, A13, A20 and A31 to make sure everything really
> is correct now.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Note if possible this commit should be squashed into the original
> "touchscreen: sun4i-ts: A10 (sun4i) has a different temperature curve"
> commit as a fixup.

It's a bit too late, I do not like rewinding my 'next' branch unless it
is a compile error caught recently. So applied as a separate commit.

Thanks.

> ---
>  drivers/input/touchscreen/sun4i-ts.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/sun4i-ts.c b/drivers/input/touchscreen/sun4i-ts.c
> index 66ccd5a..178d2ef 100644
> --- a/drivers/input/touchscreen/sun4i-ts.c
> +++ b/drivers/input/touchscreen/sun4i-ts.c
> @@ -193,7 +193,7 @@ static int sun4i_get_temp(const struct sun4i_ts_data *ts, long *temp)
>  	if (ts->temp_data == -1)
>  		return -EAGAIN;
>  
> -	*temp = (ts->temp_data - ts->temp_offset) * ts->temp_step;
> +	*temp = ts->temp_data * ts->temp_step - ts->temp_offset;
>  
>  	return 0;
>  }
> @@ -255,17 +255,17 @@ static int sun4i_ts_probe(struct platform_device *pdev)
>  	ts->ignore_fifo_data = true;
>  	ts->temp_data = -1;
>  	if (of_device_is_compatible(np, "allwinner,sun6i-a31-ts")) {
> -		/* Allwinner SDK has temperature = -271 + (value / 6) (C) */
> -		ts->temp_offset = 1626;
> +		/* Allwinner SDK has temperature (C) = (value / 6) - 271 */
> +		ts->temp_offset = 271000;
>  		ts->temp_step = 167;
>  	} else if (of_device_is_compatible(np, "allwinner,sun4i-a10-ts")) {
>  		/*
>  		 * The A10 temperature sensor has quite a wide spread, these
>  		 * parameters are based on the averaging of the calibration
>  		 * results of 4 completely different boards, with a spread of
> -		 * temp_step from 96 - 170 and temp_offset from 1758 - 3310.
> +		 * temp_step from 0.096 - 0.170 and temp_offset from 176 - 331.
>  		 */
> -		ts->temp_offset = 2570;
> +		ts->temp_offset = 257000;
>  		ts->temp_step = 133;
>  	} else {
>  		/*
> @@ -273,13 +273,13 @@ static int sun4i_ts_probe(struct platform_device *pdev)
>  		 * the temperature. The formula used here is from the AXP209,
>  		 * which is designed by X-Powers, an affiliate of Allwinner:
>  		 *
> -		 *     temperature = -144.7 + (value * 0.1)
> +		 *     temperature (C) = (value * 0.1) - 144.7
>  		 *
>  		 * Allwinner does not have any documentation whatsoever for
>  		 * this hardware. Moreover, it is claimed that the sensor
>  		 * is inaccurate and cannot work properly.
>  		 */
> -		ts->temp_offset = 1447;
> +		ts->temp_offset = 144700;
>  		ts->temp_step = 100;
>  	}
>  
> -- 
> 2.3.1
> 

-- 
Dmitry
