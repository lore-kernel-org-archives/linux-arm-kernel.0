From: jic23@kernel.org (Jonathan Cameron)
Date: Sat, 30 Aug 2014 10:49:42 +0100
Subject: [PATCH 01/11] iio: sensors-core: st: Check
 st_sensors_set_drdy_int_pin()'s return value
In-Reply-To: <1409231657-18294-1-git-send-email-lee.jones@linaro.org>
References: <1409231657-18294-1-git-send-email-lee.jones@linaro.org>
Message-ID: <54019E36.4030304@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/08/14 14:14, Lee Jones wrote:
> Value from st_sensors_set_drdy_int_pin() is assigned to err here,
> but that stored value is not used before it is overwritten.  To fix
> this we're enforcing a check on st_sensors_set_drdy_int_pin()'s
> return value and if it's an error, we're returning right away.
> 
> Cc: jic23 at kernel.org
> Cc: linux-iio at vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
Applied to the togreg branch of iio.git

Thanks,

Jonathan
> ---
>  drivers/iio/common/st_sensors/st_sensors_core.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
> index 8a4ec00..24cfe4e 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_core.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_core.c
> @@ -306,8 +306,11 @@ int st_sensors_init_sensor(struct iio_dev *indio_dev,
>  	if (of_pdata)
>  		pdata = of_pdata;
>  
> -	if (pdata)
> +	if (pdata) {
>  		err = st_sensors_set_drdy_int_pin(indio_dev, pdata);
> +		if (err < 0)
> +			return err;
> +	}
>  
>  	err = st_sensors_set_enable(indio_dev, false);
>  	if (err < 0)
> 
