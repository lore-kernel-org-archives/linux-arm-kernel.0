From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Thu, 28 Apr 2016 15:30:36 +0200
Subject: [PATCH] i2c: st: Implement i2c_bus_recovery_info callbacks
In-Reply-To: <20160424211044.GD4317@katana>
References: <1460467759-11737-1-git-send-email-peter.griffin@linaro.org>
 <20160424211044.GD4317@katana>
Message-ID: <5722107C.3000600@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

On 04/24/2016 11:10 PM, Wolfram Sang wrote:
>> +/*
>> + * i2c bus recovery routines
>> + * get_scl and set_scl must be defined to avoid the recover_bus field of
>> + * i2c_bus_recovery_info to be overriden with NULL during the
>> + * i2c_add_adapter call
>> + */
> Oh, that shouldn't be like this. Can you try this patch and remove the
> empty functions please?
>
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index 4979728f7fb2de..604936955807e5 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -1595,10 +1595,12 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
>   
>   			bri->get_scl = get_scl_gpio_value;
>   			bri->set_scl = set_scl_gpio_value;
> -		} else if (!bri->set_scl || !bri->get_scl) {
> +		} else if (bri->recover_bus == i2c_generic_scl_recovery) {
>   			/* Generic SCL recovery */
> -			dev_err(&adap->dev, "No {get|set}_gpio() found, not using recovery\n");
> -			adap->bus_recovery_info = NULL;
> +			if (!bri->set_scl || !bri->get_scl) {
> +				dev_err(&adap->dev, "No {get|set}_scl() found, not using recovery\n");
> +				adap->bus_recovery_info = NULL;
> +			}
>   		}
>   	}
>   
>
>> +static int st_i2c_recover_bus(struct i2c_adapter *i2c_adap)
>> +{
> Can you describe what the function does? It is not clear to me that it
> generates 9 scl pulses.
I agree, it would need some comments.
This IP is dual-role, it can do either SPI or I2C.
The trick is to switch to SPI mode, 9 bits words and write a 0,
so that 9 clock pulses are generated.

This is easier to manage than switching to GPIO mode,
as we don't need to provide the gpio handles in DT, and no need to 
put/get the pinctrl handle.

Regards,
Maxime
