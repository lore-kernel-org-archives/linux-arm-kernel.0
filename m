From: akpm@linux-foundation.org (Andrew Morton)
Date: Wed, 14 Jan 2015 16:55:57 -0800
Subject: [PATCHv0 2/3] rtc: Add support for Abracon
 AB-RTCMC-32.768kHz-B5ZE-S3 I2C RTC chip
In-Reply-To: <1ae63ab80cfb39305884bd0c2648a420ba3bc0a5.1421045942.git.arno@natisbad.org>
References: <cover.1421045942.git.arno@natisbad.org>
 <1ae63ab80cfb39305884bd0c2648a420ba3bc0a5.1421045942.git.arno@natisbad.org>
Message-ID: <20150114165557.d44c5752.akpm@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 12 Jan 2015 09:16:36 +0100 Arnaud Ebalard <arno@natisbad.org> wrote:

> This patch adds support for Abracon AB-RTCMC-32.768kHz-B5ZE-S3
> RTC/Calendar module w/ I2C interface.
> 
> This supports includes RTC time reading and setting, Alarm (1 minute
> accuracy) reading and setting, and battery low detection. The device
> also supports frequency adjustment and two timers but those features
> are currently not implemented in this driver. Due to alarm accuracy
> limitation (and current lack of timer support in the driver), UIE
> mode is not supported.
> 
> ...
>
> +static int abb5zes3_probe(struct i2c_client *client,
> +			  const struct i2c_device_id *id)
> +{
> +	struct device *dev = &client->dev;
> +	struct abb5zes3_rtc_data *data;
> +	struct regmap *regmap;
> +	int ret;
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C |
> +				     I2C_FUNC_SMBUS_BYTE_DATA |
> +				     I2C_FUNC_SMBUS_I2C_BLOCK))
> +		return -ENODEV;
> +
> +	regmap = devm_regmap_init_i2c(client, &abb5zes3_rtc_regmap_config);
> +	if (IS_ERR(regmap)) {
> +		ret = PTR_ERR(regmap);
> +		dev_err(dev, "%s: regmap allocation failed: %d\n",
> +			__func__, ret);
> +		return ret;
> +	}
> +
> +	ret = abb5zes3_i2c_validate_chip(regmap);
> +	if (ret)
> +		return ret;
> +
> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	mutex_init(&data->lock);
> +	data->regmap = regmap;
> +	dev_set_drvdata(dev, data);
> +
> +	ret = abb5zes3_rtc_check_setup(dev);
> +	if (ret)
> +		return ret;
> +
> +	if (client->irq > 0) {
> +		ret = devm_request_threaded_irq(dev, client->irq, NULL,
> +						_abb5zes3_rtc_interrupt,
> +						IRQF_SHARED|IRQF_ONESHOT,
> +						DRV_NAME, client);
> +		if (!ret) {
> +			device_init_wakeup(dev, true);
> +			data->irq = client->irq;
> +			dev_dbg(dev, "%s: irq %d used by RTC\n", __func__,
> +				client->irq);
> +		} else {
> +			dev_err(dev, "%s: irq %d unavailable (%d)\n",
> +				__func__, client->irq, ret);
> +		}
> +	}
> +
> +	data->rtc = devm_rtc_device_register(dev, DRV_NAME, &rtc_ops,
> +					     THIS_MODULE);
> +	ret = PTR_ERR_OR_ZERO(data->rtc);

If devm_request_threaded_irq() returned an error, we just wiped that
out here.  I'd suggest consistently adding a few "return ret;"
statements in this function.

Something like this?

--- a/drivers/rtc/rtc-ab-b5ze-s3.c~rtc-add-support-for-abracon-ab-rtcmc-32768khz-b5ze-s3-i2c-rtc-chip-fix
+++ a/drivers/rtc/rtc-ab-b5ze-s3.c
@@ -695,6 +695,7 @@ static int abb5zes3_probe(struct i2c_cli
 		} else {
 			dev_err(dev, "%s: irq %d unavailable (%d)\n",
 				__func__, client->irq, ret);
+			return ret;
 		}
 	}
 
@@ -704,7 +705,7 @@ static int abb5zes3_probe(struct i2c_cli
 	if (ret) {
 		dev_err(dev, "%s: unable to register RTC device (%d)\n",
 			__func__, ret);
-		device_init_wakeup(dev, false);
+		goto err;
 	}
 
 	/*
@@ -718,12 +719,17 @@ static int abb5zes3_probe(struct i2c_cli
 	/* Enable battery low detection interrupt if battery not already low */
 	if (!data->battery_low && data->irq) {
 		ret = _abb5zes3_rtc_battery_low_irq_enable(regmap, true);
-		if (ret)
+		if (ret) {
 			dev_err(dev, "%s: enabling battery low interrupt "
 				"generation failed (%d)\n", __func__, ret);
+			goto err;
+		}
 	}
 
 	return ret;
+err:
+	device_init_wakeup(dev, false);
+	return ret;
 }
 
 static int abb5zes3_remove(struct i2c_client *client)
_
