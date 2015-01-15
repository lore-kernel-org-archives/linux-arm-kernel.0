From: akpm@linux-foundation.org (Andrew Morton)
Date: Wed, 14 Jan 2015 17:03:43 -0800
Subject: [PATCHv0 2/3] rtc: Add support for Abracon
 AB-RTCMC-32.768kHz-B5ZE-S3 I2C RTC chip
In-Reply-To: <20150114165557.d44c5752.akpm@linux-foundation.org>
References: <cover.1421045942.git.arno@natisbad.org>
 <1ae63ab80cfb39305884bd0c2648a420ba3bc0a5.1421045942.git.arno@natisbad.org>
 <20150114165557.d44c5752.akpm@linux-foundation.org>
Message-ID: <20150114170343.6f8d807a.akpm@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 14 Jan 2015 16:55:57 -0800 Andrew Morton <akpm@linux-foundation.org> wrote:

> Something like this?

Leading to changes in [3/3].  Please have a think about where we should
be calling device_init_wakeup(dev, false) on the error recovery path.

Let me know if I should just drop it all and await a v2...


@@ -655,24 +896,28 @@ static int abb5zes3_probe(struct i2c_cli
 
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C |
 				     I2C_FUNC_SMBUS_BYTE_DATA |
-				     I2C_FUNC_SMBUS_I2C_BLOCK))
-		return -ENODEV;
+				     I2C_FUNC_SMBUS_I2C_BLOCK)) {
+		ret = -ENODEV;
+		goto out;
+	}
 
 	regmap = devm_regmap_init_i2c(client, &abb5zes3_rtc_regmap_config);
 	if (IS_ERR(regmap)) {
 		ret = PTR_ERR(regmap);
 		dev_err(dev, "%s: regmap allocation failed: %d\n",
 			__func__, ret);
-		return ret;
+		goto out;
 	}
 
 	ret = abb5zes3_i2c_validate_chip(regmap);
 	if (ret)
-		return ret;
+		goto out;
 
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
-	if (!data)
-		return -ENOMEM;
+	if (!data) {
+		ret = -ENOMEM;
+		goto out;
+	}
 
 	mutex_init(&data->lock);
 	data->regmap = regmap;
@@ -680,7 +925,7 @@ static int abb5zes3_probe(struct i2c_cli
 
 	ret = abb5zes3_rtc_check_setup(dev);
 	if (ret)
-		return ret;
+		goto out;
 
 	if (client->irq > 0) {
 		ret = devm_request_threaded_irq(dev, client->irq, NULL,
@@ -695,7 +940,7 @@ static int abb5zes3_probe(struct i2c_cli
 		} else {
 			dev_err(dev, "%s: irq %d unavailable (%d)\n",
 				__func__, client->irq, ret);
-			return ret;
+			goto out;
 		}
 	}
 
@@ -705,29 +950,23 @@ static int abb5zes3_probe(struct i2c_cli
 	if (ret) {
 		dev_err(dev, "%s: unable to register RTC device (%d)\n",
 			__func__, ret);
-		goto err;
+		goto out_deinit_wakeup;
 	}
 
-	/*
-	 * AB-B5Z5E only supports a coarse granularity alarm (one minute
-	 * resolution up to one month) so we cannot support UIE mode
-	 * using the device's alarm. Note it should be feasible to support
-	 * such a feature using one of the two timers the device provides.
-	 */
-	data->rtc->uie_unsupported = 1;
-
 	/* Enable battery low detection interrupt if battery not already low */
 	if (!data->battery_low && data->irq) {
 		ret = _abb5zes3_rtc_battery_low_irq_enable(regmap, true);
 		if (ret) {
 			dev_err(dev, "%s: enabling battery low interrupt "
 				"generation failed (%d)\n", __func__, ret);
-			goto err;
+			goto out_deinit_wakeup;
 		}
 	}
 
+out:
 	return ret;
-err:
+
+out_deinit_wakeup:
 	device_init_wakeup(dev, false);
 	return ret;
 }
_
