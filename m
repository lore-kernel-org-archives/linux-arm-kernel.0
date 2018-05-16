From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Wed, 16 May 2018 10:05:16 -0700
Subject: [PATCH 2/3] input: touchscreen: edt-ft5x06: assert reset during
 suspend
In-Reply-To: <20180516122829.23694-3-daniel@zonque.org>
References: <20180516122829.23694-1-daniel@zonque.org>
 <20180516122829.23694-3-daniel@zonque.org>
Message-ID: <20180516170516.GB21971@dtor-ws>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 16, 2018 at 02:28:28PM +0200, Daniel Mack wrote:
> If the device is not configured as wakeup source, it can be put in reset
> during suspend to save some power.
> 
> Signed-off-by: Daniel Mack <daniel@zonque.org>
> ---
>  drivers/input/touchscreen/edt-ft5x06.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
> index 955f085627fa..c34a0b23f90a 100644
> --- a/drivers/input/touchscreen/edt-ft5x06.c
> +++ b/drivers/input/touchscreen/edt-ft5x06.c
> @@ -1036,9 +1036,12 @@ static int edt_ft5x06_ts_remove(struct i2c_client *client)
>  static int __maybe_unused edt_ft5x06_ts_suspend(struct device *dev)
>  {
>  	struct i2c_client *client = to_i2c_client(dev);
> +	struct edt_ft5x06_ts_data *tsdata = i2c_get_clientdata(client);
>  
>  	if (device_may_wakeup(dev))
>  		enable_irq_wake(client->irq);
> +	else if (tsdata->reset_gpio)
> +		gpiod_set_value_cansleep(tsdata->reset_gpio, 1);
>  
>  	return 0;
>  }
> @@ -1046,9 +1049,12 @@ static int __maybe_unused edt_ft5x06_ts_suspend(struct device *dev)
>  static int __maybe_unused edt_ft5x06_ts_resume(struct device *dev)
>  {
>  	struct i2c_client *client = to_i2c_client(dev);
> +	struct edt_ft5x06_ts_data *tsdata = i2c_get_clientdata(client);
>  
>  	if (device_may_wakeup(dev))
>  		disable_irq_wake(client->irq);
> +	else if (tsdata->reset_gpio)
> +		gpiod_set_value_cansleep(tsdata->reset_gpio, 0);

I think you need msleep() here as the chip needs a bit to get out of
reset before it is ready. FWIW we have 300 ms delay in probe().

Thanks.

-- 
Dmitry
