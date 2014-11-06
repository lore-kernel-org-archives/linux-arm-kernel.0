From: richardcochran@gmail.com (Richard Cochran)
Date: Thu, 6 Nov 2014 15:19:17 +0100
Subject: [PATCH 1/4] input: touchscreen: ti_am335x_tsc Interchange
 touchscreen and ADC steps
In-Reply-To: <1414408111-2631-2-git-send-email-vigneshr@ti.com>
References: <1414408111-2631-1-git-send-email-vigneshr@ti.com>
 <1414408111-2631-2-git-send-email-vigneshr@ti.com>
Message-ID: <20141106141916.GA17151@netboy>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 27, 2014 at 04:38:28PM +0530, Vignesh R wrote:

...

> @@ -209,6 +214,7 @@ static void titsc_read_coordinates(struct titsc *ts_dev,
>  	unsigned int read, diff;
>  	unsigned int i, channel;
>  	unsigned int creads = ts_dev->coordinate_readouts;
> +	unsigned int first_step = TOTAL_STEPS - (creads * 2 + 2);
>  
>  	*z1 = *z2 = 0;
>  	if (fifocount % (creads * 2 + 2))
> @@ -226,7 +232,7 @@ static void titsc_read_coordinates(struct titsc *ts_dev,
>  
>  		channel = (read & 0xf0000) >> 16;
>  		read &= 0xfff;
> -		if (channel < creads) {
> +		if (channel > first_step + creads + 2) {
>  			diff = abs(read - prev_val_x);
>  			if (diff < prev_diff_x) {
>  				prev_diff_x = diff;
> @@ -234,19 +240,19 @@ static void titsc_read_coordinates(struct titsc *ts_dev,
>  			}
>  			prev_val_x = read;
>  
> -		} else if (channel < creads * 2) {
> +		} else if (channel == first_step + creads + 1) {
> +			*z1 = read;
> +
> +		} else if (channel == first_step + creads + 2) {
> +			*z2 = read;
> +
> +		} else if (channel > first_step) {
>  			diff = abs(read - prev_val_y);
>  			if (diff < prev_diff_y) {
>  				prev_diff_y = diff;
>  				*y = read;

While you are at it, please get rid of the this "delta filter"
nonsense.

Thanks,
Richard

>  			}
>  			prev_val_y = read;
> -
> -		} else if (channel < creads * 2 + 1) {
> -			*z1 = read;
> -
> -		} else if (channel < creads * 2 + 2) {
> -			*z2 = read;
>  		}
>  	}
>  }
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
