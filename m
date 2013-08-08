From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Thu, 08 Aug 2013 11:13:42 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2MiAxLzNdIGh3bW9uOiAobG05MCkgQWRkIHBvd2VyIGNv?=
 =?UTF-8?B?bnRyb2w=?=
In-Reply-To: <1375944991-29182-2-git-send-email-wni@nvidia.com>
References: <1375944991-29182-1-git-send-email-wni@nvidia.com>
 <1375944991-29182-2-git-send-email-wni@nvidia.com>
Message-ID: <1375946022.222322391@f304.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> The device lm90 can be controlled by the vdd rail.
> Adding the power control support to power on/off the vdd rail.
> And make sure that power is enabled before accessing the device.
> 
> Signed-off-by: Wei Ni <wni@nvidia.com>
> ---
>  drivers/hwmon/lm90.c |   49 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
> 
> diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
[...]
> +static void lm90_power_control(struct i2c_client *client, bool is_enable)
> +{
> +	struct lm90_data *data = i2c_get_clientdata(client);
> +	int ret;
> +
> +	if (!data->lm90_reg)
> +		return;
> +
> +	mutex_lock(&data->update_lock);
> +
> +	if (is_enable)
> +		ret = regulator_enable(data->lm90_reg);
> +	else
> +		ret = regulator_disable(data->lm90_reg);
> +
> +	if (ret < 0)
> +		dev_err(&client->dev,
> +			"Error in %s rail vdd, error %d\n",
> +			(is_enable) ? "enabling" : "disabling", ret);
> +	else
> +		dev_info(&client->dev, "success in %s rail vdd\n",
> +			 (is_enable) ? "enabling" : "disabling");

dev_dbg() ?

> +
> +	mutex_unlock(&data->update_lock);
> +}
> +
>  static int lm90_probe(struct i2c_client *client,
>  		      const struct i2c_device_id *id)
>  {
> @@ -1406,6 +1434,20 @@ static int lm90_probe(struct i2c_client *client,
>  	i2c_set_clientdata(client, data);
>  	mutex_init(&data->update_lock);
>  
> +	data->lm90_reg = regulator_get(&client->dev, "vdd");
> +	if (IS_ERR_OR_NULL(data->lm90_reg)) {

What about deferred probe?
if (PTR_ERR(data->lm90_reg) == -EPROBE_DEFER)
return -EPROBE_DEFER;

> +		if (PTR_ERR(data->lm90_reg) == -ENODEV)
> +			dev_info(&client->dev,
> +				 "No regulator found for vdd. Assuming vdd is always powered.");

On my opinion it is unnecessary message.

> +		else
> +			dev_warn(&client->dev,
> +				 "Error [%ld] in getting the regulator handle for vdd.\n",
> +				 PTR_ERR(data->lm90_reg));

Ditto.

> +		data->lm90_reg = NULL;

You can just use !IS_ERR(data->lm90_reg) macro in the future,
rather than set this to NULL.

[...]

---
