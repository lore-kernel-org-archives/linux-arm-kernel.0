From: linux@roeck-us.net (Guenter Roeck)
Date: Fri, 13 Oct 2017 06:50:35 -0700
Subject: [PATCH 1/2] hwmon: (jc42) optionally try to disable the SMBUS
 timeout
In-Reply-To: <20171013092705.7038-2-peda@axentia.se>
References: <20171013092705.7038-1-peda@axentia.se>
 <20171013092705.7038-2-peda@axentia.se>
Message-ID: <554a4494-14c9-7743-898c-5f83e3de227d@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/13/2017 02:27 AM, Peter Rosin wrote:
> With a nxp,se97 chip on an atmel sama5d31 board, the I2C adapter driver
> is not always capable of avoiding the 25-35 ms timeout as specified by
> the SMBUS protocol. This may cause silent corruption of the last bit of
> any transfer, e.g. a one is read instead of a zero if the sensor chip
> times out. This also affects the eeprom half of the nxp-se97 chip, where
> this silent corruption was originally noticed. Other I2C adapters probably
> suffer similar issues, e.g. bit-banging comes to mind as risky...
> 
> The SMBUS register in the nxp chip is not a standard Jedec register, but
> it is not special to the nxp chips either, at least the atmel chips
> have the same mechanism. Therefore, do not special case this on the
> manufacturer, it is opt-in via the device property anyway.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>   Documentation/devicetree/bindings/hwmon/jc42.txt |  4 ++++
>   drivers/hwmon/jc42.c                             | 20 ++++++++++++++++++++
>   2 files changed, 24 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/jc42.txt b/Documentation/devicetree/bindings/hwmon/jc42.txt
> index 07a250498fbb..f569db58f64a 100644
> --- a/Documentation/devicetree/bindings/hwmon/jc42.txt
> +++ b/Documentation/devicetree/bindings/hwmon/jc42.txt
> @@ -34,6 +34,10 @@ Required properties:
>   
>   - reg: I2C address
>   
> +Optional properties:
> +- smbus-timeout-disable: When set, the smbus timeout function will be disabled.
> +			 This is not supported on all chips.
> +
>   Example:
>   
>   temp-sensor at 1a {
> diff --git a/drivers/hwmon/jc42.c b/drivers/hwmon/jc42.c
> index 1bf22eff0b08..fd816902fa30 100644
> --- a/drivers/hwmon/jc42.c
> +++ b/drivers/hwmon/jc42.c
> @@ -45,6 +45,7 @@ static const unsigned short normal_i2c[] = {
>   #define JC42_REG_TEMP		0x05
>   #define JC42_REG_MANID		0x06
>   #define JC42_REG_DEVICEID	0x07
> +#define JC42_REG_SMBUS		0x22 /* NXP and Atmel, possibly others? */
>   
>   /* Status bits in temperature register */
>   #define JC42_ALARM_CRIT_BIT	15
> @@ -73,6 +74,9 @@ static const unsigned short normal_i2c[] = {
>   #define ONS_MANID		0x1b09  /* ON Semiconductor */
>   #define STM_MANID		0x104a  /* ST Microelectronics */
>   
> +/* SMBUS register */
> +#define SMBUS_STMOUT		BIT(7)  /* SMBus time-out, active low */
> +
>   /* Supported chips */
>   
>   /* Analog Devices */
> @@ -476,6 +480,22 @@ static int jc42_probe(struct i2c_client *client, const struct i2c_device_id *id)
>   
>   	data->extended = !!(cap & JC42_CAP_RANGE);
>   
> +	if (device_property_read_bool(dev, "smbus-timeout-disable")) {
> +		int smbus;
> +
> +		/*
> +		 * Not all chips support this register, but from a
> +		 * quick read of various datasheets no chip appears
> +		 * incompatible with the below attempt to disable
> +		 * the timeout. And the whole thing is opt-in...
> +		 */
> +		smbus = i2c_smbus_read_word_swapped(client, JC42_REG_SMBUS);
> +		if (smbus < 0)
> +			return smbus;
> +		i2c_smbus_write_word_swapped(client, JC42_REG_SMBUS,
> +					     smbus | SMBUS_STMOUT);

Looking into the SE97 datasheet, the bit is only writable if the alarm bits
are not locked. Should we take this into account and unlock the alarm bits
if necessary ?

Guenter
