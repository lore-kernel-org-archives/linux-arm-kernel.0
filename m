From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Wed, 07 Aug 2013 11:27:22 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAxLzJdIGh3bW9uOiAobG05MCkgQWRkIHBvd2VyIGNvbnRy?=
 =?UTF-8?B?b2w=?=
In-Reply-To: <1375858358-15070-2-git-send-email-wni@nvidia.com>
References: <1375858358-15070-1-git-send-email-wni@nvidia.com>
 <1375858358-15070-2-git-send-email-wni@nvidia.com>
Message-ID: <1375860442.896960598@f427.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> The device lm90 can be controlled by the vdd rail.
> Adding the power control support to power on/off the vdd rail.
> And make sure that power is enabled before accessing the device.
> 
> Signed-off-by: Wei Ni <wni@nvidia.com>
> ---
>  drivers/hwmon/lm90.c |   52 ++++++++++++++++++++++++++++++++++++++++++++++++++
[...]
> +	if (!data->lm90_reg) {
> +		data->lm90_reg = regulator_get(&client->dev, "vdd");
> +		if (IS_ERR_OR_NULL(data->lm90_reg)) {
> +			if (PTR_ERR(data->lm90_reg) == -ENODEV)
> +				dev_info(&client->dev,
> +					 "No regulator found for vdd. Assuming vdd is always powered.");
> +			else
> +				dev_warn(&client->dev,
> +					 "Error [%ld] in getting the regulator handle for vdd.\n",
> +					 PTR_ERR(data->lm90_reg));
> +			data->lm90_reg = NULL;
> +			mutex_unlock(&data->update_lock);
> +			return -ENODEV;
> +		}
> +	}
> +	if (is_enable) {
> +		ret = regulator_enable(data->lm90_reg);
> +		msleep(POWER_ON_DELAY);

Can this delay be handled directly from regulator?

[...]
---
