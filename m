From: jic23@kernel.org (Jonathan Cameron)
Date: Sat, 14 Sep 2013 18:31:17 +0100
Subject: [PATCH 31/38] iio: accel-core: st: Clean up error handling in
 probe()
In-Reply-To: <1378817379-8238-32-git-send-email-lee.jones@linaro.org>
References: <1378817379-8238-1-git-send-email-lee.jones@linaro.org>
 <1378817379-8238-32-git-send-email-lee.jones@linaro.org>
Message-ID: <52349D65.6000403@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/10/13 13:49, Lee Jones wrote:
> Reduce the amount of those unnecessary goto calls, as in most cases
> we can simply return immediately. We also only call for the IRQ number
> once and use that value throughout.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
...
> -	if (adata->get_irq_data_ready(indio_dev) > 0) {
> +	if (irq > 0) {
>  		err = st_accel_allocate_ring(indio_dev);
>  		if (err < 0)
> -			goto st_accel_common_probe_error;
> +			return err;
>  
>  		err = st_sensors_allocate_trigger(indio_dev,
>  						 ST_ACCEL_TRIGGER_OPS);
> @@ -492,18 +493,16 @@ int st_accel_common_probe(struct iio_dev *indio_dev,
>  	}
>  
>  	err = iio_device_register(indio_dev);
> -	if (err)
> +	if (err && irq > 0)
>  		goto st_accel_device_register_error;
This is the same structure I moaned about earlier. Again, put the if (irq > 0) in the error handling
not here.
>  
>  	return err;
>  
>  st_accel_device_register_error:
> -	if (adata->get_irq_data_ready(indio_dev) > 0)
> -		st_sensors_deallocate_trigger(indio_dev);
> +	st_sensors_deallocate_trigger(indio_dev);
>  st_accel_probe_trigger_error:
> -	if (adata->get_irq_data_ready(indio_dev) > 0)
> -		st_accel_deallocate_ring(indio_dev);
> -st_accel_common_probe_error:
> +	st_accel_deallocate_ring(indio_dev);
> +
>  	return err;
>  }
>  EXPORT_SYMBOL(st_accel_common_probe);
> 
