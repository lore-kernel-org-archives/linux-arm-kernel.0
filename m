From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 7 Dec 2016 18:44:08 +0000
Subject: [PATCH] firmware: arm_scpi: fix reading sensor values on pre-1.0
 SCPI firmwares
In-Reply-To: <20161124001845.20830-2-martin.blumenstingl@googlemail.com>
References: <20161124001845.20830-1-martin.blumenstingl@googlemail.com>
 <20161124001845.20830-2-martin.blumenstingl@googlemail.com>
Message-ID: <663deed4-fbbb-20ad-1943-dbd4e66e797f@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 24/11/16 00:18, Martin Blumenstingl wrote:
> The pre-1.0 SCPI firmwares are using one __le32 as sensor value, while
> the 1.0 SCPI protocol uses two __le32 as sensor values (a total of
> 64bit, split into 32bit upper and 32bit lower value).
> Using an "struct sensor_value" to read the sensor value on a pre-1.0
> SCPI firmware gives garbage in the "hi_val" field. Introducing a
> separate function which handles scpi_ops.sensor_get_value for pre-1.0
> SCPI firmware implementations ensures that we do not read memory which
> was not written by the SCPI firmware (which fixes for example the
> temperature reported by scpi-hwmon).
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  drivers/firmware/arm_scpi.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
> index 70e1323..19f750d 100644
> --- a/drivers/firmware/arm_scpi.c
> +++ b/drivers/firmware/arm_scpi.c
> @@ -728,6 +728,20 @@ static int scpi_sensor_get_value(u16 sensor, u64 *val)
>  	return ret;
>  }
>  
> +static int legacy_scpi_sensor_get_value(u16 sensor, u64 *val)
> +{
> +	__le16 id = cpu_to_le16(sensor);
> +	__le32 value;
> +	int ret;
> +
> +	ret = scpi_send_message(CMD_SENSOR_VALUE, &id, sizeof(id),
> +				&value, sizeof(value));
> +	if (!ret)
> +		*val = le32_to_cpu(value);
> +
> +	return ret;
> +}

Instead of duplicating the code so much, can we just manage something
like this. If more commands need Rx len, then we can think of adding
that. Even then reseting shared buffers is not good, we can clear the
buffers on the stack.

diff --git i/drivers/firmware/arm_scpi.c w/drivers/firmware/arm_scpi.c
index 70e13230d8db..04aa873205e9 100644
--- i/drivers/firmware/arm_scpi.c
+++ w/drivers/firmware/arm_scpi.c
@@ -721,11 +721,15 @@ static int scpi_sensor_get_value(u16 sensor, u64 *val)

        ret = scpi_send_message(CMD_SENSOR_VALUE, &id, sizeof(id),
                                &buf, sizeof(buf));
-       if (!ret)
+       if (ret)
+               return ret;
+
+       if (scpi_info->is_legacy) /* 32-bits supported, hi_val can be
junk */
+               *val = le32_to_cpu(buf.lo_val);
+       else
                *val = (u64)le32_to_cpu(buf.hi_val) << 32 |
                        le32_to_cpu(buf.lo_val);
-
-       return ret;
+       return 0;
 }

 static int scpi_device_get_power_state(u16 dev_id)


-- 
Regards,
Sudeep
