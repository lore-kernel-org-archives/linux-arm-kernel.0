From: sameo@linux.intel.com (Samuel Ortiz)
Date: Fri, 29 Jan 2010 20:54:07 +0100
Subject: [PATCH 1/4] mfd: update i2c driver for max8925
In-Reply-To: <771cded01001250307o7e340a0dsf7e02762dad8c953@mail.gmail.com>
References: <771cded01001250307o7e340a0dsf7e02762dad8c953@mail.gmail.com>
Message-ID: <20100129195405.GB23130@sortiz.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Haojian,

On Mon, Jan 25, 2010 at 06:07:08AM -0500, Haojian Zhuang wrote:
>  static inline int max8925_read_device(struct i2c_client *i2c,
>  				      int reg, int bytes, void *dest)
>  {
> -	unsigned char data;
> -	unsigned char *buf;
>  	int ret;
> 
> -	buf = kzalloc(bytes + 1, GFP_KERNEL);
> -	if (!buf)
> -		return -ENOMEM;
> -
> -	data = (unsigned char)reg;
> -	ret = i2c_master_send(i2c, &data, 1);
> -	if (ret < 0)
> -		return ret;
> -
> -	ret = i2c_master_recv(i2c, buf, bytes + 1);
> -	if (ret < 0)
> -		return ret;
> -	memcpy(dest, buf, bytes);
> -	return 0;
> +	if (bytes > 1)
> +		ret = i2c_smbus_read_i2c_block_data(i2c, reg, bytes, dest);
> +	else {
> +		ret = i2c_smbus_read_byte_data(i2c, reg);
> +		if (ret < 0)
> +			return ret;
> +		*(unsigned char *)dest = (unsigned char)ret;
> +	}
> +	return ret;
Your read_device routine looks much better now :)

> @@ -142,28 +138,56 @@ static int __devinit max8925_probe(struct
> i2c_client *client,
>  				   const struct i2c_device_id *id)
>  {
>  	struct max8925_platform_data *pdata = client->dev.platform_data;
> -	struct max8925_chip *chip;
> +	struct i2c_board_info rtc_info, adc_info;
> +	const unsigned short addr_rtc[] = {
> +		RTC_I2C_ADDR,
> +		I2C_CLIENT_END,
> +	};
> +	const unsigned short addr_adc[] = {
> +		ADC_I2C_ADDR,
> +		I2C_CLIENT_END,
> +	};
If you know the devices adress, why do you call i2c_new_probed_device()
instead of i2c_new_device() ?


> +	static struct max8925_chip *chip;
> +	static int init_gpm = 0, init_adc = 0, init_rtc = 0, count = 0;
Those static here are not looking good at all...

> +	if (!init_gpm) {
> +		init_gpm = 1;
> +		chip = kzalloc(sizeof(struct max8925_chip), GFP_KERNEL);
> +		if (chip == NULL)
> +			return -ENOMEM;
> +		chip->i2c = client;
> +		chip->dev = &client->dev;
> +		i2c_set_clientdata(client, chip);
> +		dev_set_drvdata(chip->dev, chip);
> +		mutex_init(&chip->io_lock);
> +	}
> +	if (!init_rtc) {
> +		init_rtc = 1;
> +		memset(&rtc_info, 0, sizeof(struct i2c_board_info));
> +		strlcpy(rtc_info.type, "max8925", I2C_NAME_SIZE);
> +		rtc_info.platform_data = chip->i2c->dev.platform_data;
> +		chip->rtc = i2c_new_probed_device(chip->i2c->adapter,
> +						&rtc_info, addr_rtc);
> +		i2c_set_clientdata(chip->rtc, chip);
> +	} else if (!init_adc) {
> +		init_adc = 1;
> +		memset(&adc_info, 0, sizeof(struct i2c_board_info));
> +		strlcpy(adc_info.type, "max8925", I2C_NAME_SIZE);
> +		adc_info.platform_data = chip->i2c->dev.platform_data;
> +		if (pdata->tsc_irq > 0)
> +			adc_info.irq = pdata->tsc_irq;
> +		chip->adc = i2c_new_probed_device(chip->i2c->adapter,
> +						&adc_info, addr_adc);
> +		i2c_set_clientdata(chip->adc, chip);
> +	}
> +	/* Initialize max8925 until all of three I2C clients are ready */
> +	if (++count == 3)
> +		max8925_device_init(chip, pdata);
This has to be rewritten, but first let me try to understand something: You
need the max9825 core to have pointers to the other i2c devices because of how
it handles IRQs right ? In your max9825 irq handler you need to be able to
access the rtc and the adc devices, right ? And then on yourrtc and power
drivers, you actually only access the max8925 core i2c registers ?
I would appreciate if most of your answers to those questions could morph into
code comments to this probe routine.

Then, about the code design: Having your probe routine relying on those static
variable is not ok. If I undersand you correctly, what you trying to achieve
here is not calling max8925_device_init() before you actually have the core,
the i2c and the adc pointer setup ?
If that's so, why not simply use i2c_new_dummy() instead of having to handle
recursive calls of your probe routine ?

Cheers,
Samuel.



 
>  	return 0;
>  }
> @@ -171,10 +195,23 @@ static int __devinit max8925_probe(struct
> i2c_client *client,
>  static int __devexit max8925_remove(struct i2c_client *client)
>  {
>  	struct max8925_chip *chip = i2c_get_clientdata(client);
> +	static int init_gpm = 1, init_adc = 1, init_rtc = 1;
> 
> -	max8925_device_exit(chip);
> -	i2c_set_clientdata(client, NULL);
> -	kfree(chip);
> +	if (client->addr == ADC_I2C_ADDR)
> +		init_adc = 0;
> +	else if (client->addr == RTC_I2C_ADDR)
> +		init_rtc = 0;
> +	else
> +		init_gpm = 0;
> +	if (!init_gpm && !init_rtc && !init_adc) {
> +		max8925_device_exit(chip);
> +		i2c_unregister_device(chip->adc);
> +		i2c_unregister_device(chip->rtc);
> +		i2c_set_clientdata(chip->adc, NULL);
> +		i2c_set_clientdata(chip->rtc, NULL);
> +		i2c_set_clientdata(chip->i2c, NULL);
> +		kfree(chip);
> +	}
>  	return 0;
>  }
> 
> -- 
> 1.5.6.5

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
