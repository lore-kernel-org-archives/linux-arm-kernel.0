From: simon.guinot@sequanux.org (Simon Guinot)
Date: Wed, 24 Apr 2013 19:06:46 +0200
Subject: [PATCHv1 1/3] hwmon: Add support for GMT G762/G763 PWM fan
 controller
In-Reply-To: <63961d39aee9db94767f28fd441312bec2029473.1366753420.git.arno@natisbad.org>
References: <cover.1366753420.git.arno@natisbad.org>
 <63961d39aee9db94767f28fd441312bec2029473.1366753420.git.arno@natisbad.org>
Message-ID: <20130424170646.GB17771@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 24, 2013 at 12:05:56AM +0200, Arnaud Ebalard wrote:
> 
> Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
> Tested-by: Arnaud Ebalard <arno@natisbad.org>

Hi Arnaud,

Thanks for this patch.

I have partially tested this driver (with the default configuration) on
a net2big_v2 board. I say "partially" because on this board, a two wire
fan is connected to the g762. This means that the measure speed and
alarm features as well as the closed-loop mode are not available.
But all what is left seems to work as expected.

See below for a few remarks and questions about the driver code.

> ---
>  drivers/hwmon/Kconfig  |   10 +
>  drivers/hwmon/Makefile |    1 +
>  drivers/hwmon/g762.c   | 1058 ++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 1069 insertions(+)
>  create mode 100644 drivers/hwmon/g762.c
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 89ac1cb..cb4879c 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -423,6 +423,16 @@ config SENSORS_G760A
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called g760a.
>  
> +config SENSORS_G762
> +	tristate "GMT G762 and G763"
> +	depends on I2C
> +	help
> +	  If you say yes here you get support for Global Mixed-mode
> +	  Technology Inc G762 and G763 fan speed PWM controller chips.
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called g762.
> +
>  config SENSORS_GL518SM
>  	tristate "Genesys Logic GL518SM"
>  	depends on I2C
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index 8d6d97e..4b49504 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -57,6 +57,7 @@ obj-$(CONFIG_SENSORS_F75375S)	+= f75375s.o
>  obj-$(CONFIG_SENSORS_FAM15H_POWER) += fam15h_power.o
>  obj-$(CONFIG_SENSORS_FSCHMD)	+= fschmd.o
>  obj-$(CONFIG_SENSORS_G760A)	+= g760a.o
> +obj-$(CONFIG_SENSORS_G762)	+= g762.o
>  obj-$(CONFIG_SENSORS_GL518SM)	+= gl518sm.o
>  obj-$(CONFIG_SENSORS_GL520SM)	+= gl520sm.o
>  obj-$(CONFIG_SENSORS_GPIO_FAN)	+= gpio-fan.o
> diff --git a/drivers/hwmon/g762.c b/drivers/hwmon/g762.c
> new file mode 100644
> index 0000000..810b019
> --- /dev/null
> +++ b/drivers/hwmon/g762.c

Snip

> +/* Set pwm mode. Accepts either 0 (pwm mode) or 1 (linear mode) */
> +static int do_set_pwm_mode(struct device *dev, unsigned long val)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct g762_data *data = g762_update_client(dev);
> +	int ret = 0;
> +
> +	mutex_lock(&data->update_lock);
> +	switch (val) {
> +	case OUT_MODE_PWM:
> +		data->fan_cmd1 |= G762_REG_FAN_CMD1_OUT_MODE;
> +		break;
> +	case OUT_MODE_DAC: /* i.e. linear mode */
> +		data->fan_cmd1 &= ~G762_REG_FAN_CMD1_OUT_MODE;
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +	g762_write_value(client, G762_REG_FAN_CMD1, data->fan_cmd1);

I noticed you never check the value returned by the functions
g762_{read,write}_value(). Is that because the functions
i2c_smbus_{read,write}_byte_data() are not likely to fail ?

> + out:
> +	mutex_unlock(&data->update_lock);
> +
> +	return ret;
> +}
> +
> +/*
> + * Set reference clock. Accepted values are between 0 and 0xffffff.
> + * Note that this is an internal parameter, i.e. value is not passed
> + * to the device.
> + */
> +static int do_set_pwm_freq(struct device *dev, unsigned long val)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct g762_data *data = i2c_get_clientdata(client);
> +	int ret = -EINVAL;
> +
> +	if (val <= 0xffffff) {
> +		data->clk = val;
> +		ret = 0;
> +	}
> +
> +	return ret;
> +}
> +
> +/* Set fan clock divisor. Accepted values are 1, 2, 4 and 8. */
> +static int do_set_fan_div(struct device *dev, unsigned long val)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct g762_data *data = g762_update_client(dev);
> +	int ret = 0;
> +
> +	mutex_lock(&data->update_lock);
> +	switch (val) {
> +	case 1:
> +		data->fan_cmd1 &= ~G762_REG_FAN_CMD1_CLK_DIV_ID0;
> +		data->fan_cmd1 &= ~G762_REG_FAN_CMD1_CLK_DIV_ID1;
> +		break;
> +	case 2:
> +		data->fan_cmd1 |=  G762_REG_FAN_CMD1_CLK_DIV_ID0;
> +		data->fan_cmd1 &= ~G762_REG_FAN_CMD1_CLK_DIV_ID1;
> +		break;
> +	case 4:
> +		data->fan_cmd1 &= ~G762_REG_FAN_CMD1_CLK_DIV_ID0;
> +		data->fan_cmd1 |=  G762_REG_FAN_CMD1_CLK_DIV_ID1;
> +		break;
> +	case 8:
> +		data->fan_cmd1 |=  G762_REG_FAN_CMD1_CLK_DIV_ID0;
> +		data->fan_cmd1 |=  G762_REG_FAN_CMD1_CLK_DIV_ID1;
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +	g762_write_value(client, G762_REG_FAN_CMD1, data->fan_cmd1);
> + out:
> +	mutex_unlock(&data->update_lock);
> +
> +	return ret;
> +}
> +
> +/* Set fan gear mode. Accepted values are either 0, 1 or 2. */
> +static int do_set_fan_gear_mode(struct device *dev, unsigned long val)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct g762_data *data = g762_update_client(dev);
> +	int ret = 0;
> +
> +	mutex_lock(&data->update_lock);
> +	switch (val) {
> +	case 0:
> +		data->fan_cmd2 &= ~G762_REG_FAN_CMD2_GEAR_MODE_0;
> +		data->fan_cmd2 &= ~G762_REG_FAN_CMD2_GEAR_MODE_1;
> +		break;
> +	case 1:
> +		data->fan_cmd2 |=  G762_REG_FAN_CMD2_GEAR_MODE_0;
> +		data->fan_cmd2 &= ~G762_REG_FAN_CMD2_GEAR_MODE_1;
> +		break;
> +	case 2:
> +		data->fan_cmd2 &= ~G762_REG_FAN_CMD2_GEAR_MODE_0;
> +		data->fan_cmd2 |=  G762_REG_FAN_CMD2_GEAR_MODE_1;
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +	g762_write_value(client, G762_REG_FAN_CMD2, data->fan_cmd2);
> + out:
> +	mutex_unlock(&data->update_lock);
> +
> +	return ret;
> +}
> +
> +/* Set pulse per revolution value. Accepts either 2 or 4. */
> +static int do_set_fan_pulses(struct device *dev, unsigned long val)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct g762_data *data = g762_update_client(dev);
> +	int ret = 0;
> +
> +	mutex_lock(&data->update_lock);
> +	switch (val) {
> +	case 2:
> +		data->fan_cmd1 &= ~G762_REG_FAN_CMD1_PULSE_PER_REV;
> +		break;
> +	case 4:
> +		data->fan_cmd1 |=  G762_REG_FAN_CMD1_PULSE_PER_REV;
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +	g762_write_value(client, G762_REG_FAN_CMD1, data->fan_cmd1);
> + out:
> +	mutex_unlock(&data->update_lock);
> +
> +	return ret;
> +}
> +
> +/* Set fan mode. Accepts either 1 (open loop) or 2 (closed loop). */
> +static int do_set_pwm_enable(struct device *dev, unsigned long val)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct g762_data *data = g762_update_client(dev);
> +	int ret = 0;
> +
> +	mutex_lock(&data->update_lock);
> +	switch (val) {
> +	case FAN_MODE_OPEN_LOOP:
> +		data->fan_cmd1 &= ~G762_REG_FAN_CMD1_FAN_MODE;
> +		break;
> +	case FAN_MODE_CLOSED_LOOP:
> +		data->fan_cmd1 |=  G762_REG_FAN_CMD1_FAN_MODE;
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	g762_write_value(client, G762_REG_FAN_CMD1, data->fan_cmd1);
> + out:
> +	mutex_unlock(&data->update_lock);
> +
> +	return ret;
> +}
> +
> +/* Set pwm polarity (0 for negative duty, 1 for positive duty) */
> +static int do_set_pwm_polarity(struct device *dev, unsigned long val)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct g762_data *data = g762_update_client(dev);
> +	int ret = 0;
> +
> +	mutex_lock(&data->update_lock);
> +	switch (val) {
> +	case 0: /* i.e. negative duty */
> +		data->fan_cmd1 &= ~G762_REG_FAN_CMD1_PWM_POLARITY;
> +		break;
> +	case 1: /* i.e. positive duty */
> +		data->fan_cmd1 |=  G762_REG_FAN_CMD1_PWM_POLARITY;
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +	g762_write_value(client, G762_REG_FAN_CMD1, data->fan_cmd1);
> + out:
> +	mutex_unlock(&data->update_lock);
> +
> +	return ret;
> +}
> +
> +/*
> + * Set pwm value. Accepted values are between 0 and 255. Note that the
> + * internal register used for setting the value depends ont the fan
> + * mode of the device.
> + */
> +static int do_set_pwm(struct device *dev, unsigned long val)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct g762_data *data = g762_update_client(dev);
> +	int ret = -EINVAL;
> +
> +	mutex_lock(&data->update_lock);
> +	if (val > 255)
> +		goto out;
> +
> +	if (data->fan_cmd1 & G762_REG_FAN_CMD1_FAN_MODE) { /* closed-loop */
> +		data->set_cnt = PWM_TO_CNT(val);
> +		g762_write_value(client, G762_REG_SET_CNT, (u8)val);
> +	} else {                                           /* open-loop */
> +		data->set_out = val;
> +		g762_write_value(client, G762_REG_SET_OUT, (u8)val);
> +	}
> +
> +	ret = 0;
> + out:
> +	mutex_unlock(&data->update_lock);
> +
> +	return ret;
> +}
> +
> +/* Set fan RPM value. This only makes sense in closed-loop mode. */
> +static int do_set_fan_target(struct device *dev, unsigned long val)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct g762_data *data = g762_update_client(dev);
> +	int ret = -EINVAL;
> +
> +	mutex_lock(&data->update_lock);
> +	if (data->fan_cmd1 & G762_REG_FAN_CMD1_FAN_MODE) { /* closed-loop */
> +		data->set_cnt = cnt_from_rpm(val, data->clk,
> +					     PULSE_FROM_REG(data->fan_cmd1),
> +					     CLKDIV_FROM_REG(data->fan_cmd1),
> +					     GEARMODE_FROM_REG(data->fan_cmd2));
> +		g762_write_value(client, G762_REG_SET_CNT, data->set_cnt);
> +		ret = 0;
> +	}
> +	mutex_unlock(&data->update_lock);
> +
> +	return ret;
> +}
> +
> +/* Enable/disable fan failure detection. Accepted values are 1 and 0. */
> +static int do_fan_failure_detection_toggle(struct device *dev,
> +					   unsigned long enable)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct g762_data *data = g762_update_client(dev);
> +	int ret = 0;
> +
> +	mutex_lock(&data->update_lock);
> +	switch (enable) {
> +	case 0:
> +		data->fan_cmd1 &= ~G762_REG_FAN_CMD1_DET_FAN_FAIL;
> +		break;
> +	case 1:
> +		data->fan_cmd1 |=  G762_REG_FAN_CMD1_DET_FAN_FAIL;
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +	g762_write_value(client, G762_REG_FAN_CMD1, data->fan_cmd1);
> + out:
> +	mutex_unlock(&data->update_lock);
> +
> +	return ret;
> +}
> +
> +/* Enable/disable fan out of control detection. Accepted values are 1 and 0 */
> +static int do_fan_ooc_detection_toggle(struct device *dev, unsigned int enable)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct g762_data *data = g762_update_client(dev);
> +	int ret = 0;
> +
> +	mutex_lock(&data->update_lock);
> +	switch (enable) {
> +	case 0:
> +		data->fan_cmd1 &= ~G762_REG_FAN_CMD1_DET_FAN_OOC;
> +		break;
> +	case 1:
> +		data->fan_cmd1 |=  G762_REG_FAN_CMD1_DET_FAN_OOC;
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +	g762_write_value(client, G762_REG_FAN_CMD1, data->fan_cmd1);
> + out:
> +	mutex_unlock(&data->update_lock);
> +
> +	return ret;
> +}
> +
> +/* Set startup voltage. Accepted values are either 0, 1, 2 or 3. */
> +static int do_set_fan_startv(struct device *dev, unsigned long val)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct g762_data *data = g762_update_client(dev);
> +	int ret = 0;
> +
> +	mutex_lock(&data->update_lock);
> +	switch (val) {
> +	case 0:
> +		data->fan_cmd2 &= ~G762_REG_FAN_CMD2_FAN_STARTV_0;
> +		data->fan_cmd2 &= ~G762_REG_FAN_CMD2_FAN_STARTV_1;
> +		break;
> +	case 1:
> +		data->fan_cmd2 |=  G762_REG_FAN_CMD2_FAN_STARTV_0;
> +		data->fan_cmd2 &= ~G762_REG_FAN_CMD2_FAN_STARTV_1;
> +		break;
> +	case 2:
> +		data->fan_cmd2 &= ~G762_REG_FAN_CMD2_FAN_STARTV_0;
> +		data->fan_cmd2 |=  G762_REG_FAN_CMD2_FAN_STARTV_1;
> +		break;
> +	case 3:
> +		data->fan_cmd2 |=  G762_REG_FAN_CMD2_FAN_STARTV_0;
> +		data->fan_cmd2 |=  G762_REG_FAN_CMD2_FAN_STARTV_1;
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +	g762_write_value(client, G762_REG_FAN_CMD2, data->fan_cmd2);
> + out:
> +	mutex_unlock(&data->update_lock);
> +
> +	return ret;
> +}

It seems to me that all the functions above are more or less using the
same code. For example do_set_fan_pulses, do_set_pwm_enable and
do_set_pwm_polarity are very similar. Then, there is probably room for
some code factorisation ? For example, you could use some functions to
set or clear a mask against a given register. Or something else...

> +
> +
> +
> +/*
> + * Configuration-related definitions
> + */
> +
> +struct g762_config {
> +	u32 fan_startv;
> +	u32 fan_gear_mode;
> +	u32 fan_div;
> +	u32 fan_pulses;
> +	u32 fan_target;
> +	u32 pwm_polarity;
> +	u32 pwm_enable;
> +	u32 pwm_freq;
> +	u32 pwm_mode;
> +};
> +
> +/*
> + * g762 default values: it is assumed that the fan is set for a 32KHz clock
> + * source, a fan clock divisor of 1 and two pulses per revolution. Default
> + * fan driving mode is linear mode (g762/g763 also support PWM mode). Note
> + * the specific init value for properties which may be left unmodified.
> + */
> +#define G762_DEFAULT_CLK            32768
> +#define G762_DEFAULT_FAN_DIV        1
> +#define G762_DEFAULT_FAN_PULSES     2
> +#define G762_DEFAULT_OUT_MODE       0
> +#define G762_DEFAULT_FAN_MODE       2
> +#define G762_DEFAULT_FAN_STARTV     1
> +#define G762_DEFAULT_FAN_GEAR_MODE  0
> +#define G762_DEFAULT_FAN_POLARITY   0
> +#define G762_UNTOUCHED_VAL          0xffffffff
> +
> +static void g762_config_init(struct g762_config *conf)
> +{
> +	conf->pwm_enable = G762_DEFAULT_FAN_MODE;
> +	conf->pwm_mode = G762_DEFAULT_OUT_MODE;
> +	conf->pwm_freq = G762_DEFAULT_CLK;
> +	conf->pwm_polarity = G762_DEFAULT_FAN_POLARITY;
> +	conf->fan_pulses = G762_DEFAULT_FAN_PULSES;
> +	conf->fan_div = G762_DEFAULT_FAN_DIV;
> +	conf->fan_startv = G762_DEFAULT_FAN_STARTV;
> +	conf->fan_gear_mode = G762_DEFAULT_FAN_GEAR_MODE;
> +	conf->fan_target = G762_UNTOUCHED_VAL;
> +}
> +
> +static inline int g762_one_prop_commit(struct i2c_client *client,
> +				       u32 pval, const char *pname,
> +				       int (*psetter)(struct device *dev,
> +						      unsigned long val))
> +{
> +	int ret = 0;
> +
> +	if ((pval != G762_UNTOUCHED_VAL) && (*psetter)(&client->dev, pval)) {
> +		dev_info(&client->dev, "unable to set %s (%d)\n", pname, pval);
> +		ret = -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +static int g762_config_commit(struct i2c_client *client,
> +			      struct g762_config *conf)
> +{
> +	int ret = 0;
> +
> +	if (g762_one_prop_commit(client, conf->pwm_mode,
> +				 "pwm_mode", &do_set_pwm_mode) ||
> +	    g762_one_prop_commit(client, conf->pwm_enable,
> +				 "pwm_enable", &do_set_pwm_enable) ||
> +	    g762_one_prop_commit(client, conf->fan_div,
> +				 "fan_div", &do_set_fan_div) ||
> +	    g762_one_prop_commit(client, conf->fan_pulses,
> +				 "fan_pulses", &do_set_fan_pulses) ||
> +	    g762_one_prop_commit(client, conf->pwm_freq,
> +				 "pwm_freq", &do_set_pwm_freq) ||
> +	    g762_one_prop_commit(client, conf->fan_gear_mode,
> +				 "fan_gear_mode", &do_set_fan_gear_mode) ||
> +	    g762_one_prop_commit(client, conf->pwm_polarity,
> +				 "pwm_polarity", &do_set_pwm_polarity) ||
> +	    g762_one_prop_commit(client, conf->fan_startv,
> +				 "fan_startv", &do_set_fan_startv) ||
> +	    g762_one_prop_commit(client, conf->fan_target,
> +				 "fan_target", &do_set_fan_target)) {

Is that correct ? Here, g762_update_client() is called several times in
a short time interval. This means that the registers are not re-read
after each write operation (only after the first). If the chip updates
internally some registers after a write, then a mismatch between
struct g762_data and the real registers values could happen.

> +		ret = -EINVAL;
> +	}
> +
> +	return ret;
> +}

Snip

> +/*
> + * Get/set the fan speed in open-loop mode using pwm1 sysfs file. Speed is
> + * given as a relative value from 0 to 255, where 255 is maximum speed. Note
> + * that this is done by writing directly to the chip's DAC, it won't change
> + * the closed loop speed set by fan1_target. Also note that due to rounding
> + * errors it is possible that you don't read back exactly the value you have
> + * set.
> + */
> +static ssize_t get_pwm(struct device *dev, struct device_attribute *da,
> +		       char *buf)
> +{
> +	struct g762_data *data = g762_update_client(dev);
> +	int val;
> +
> +	mutex_lock(&data->update_lock);
> +	if (data->fan_cmd1 & G762_REG_FAN_CMD1_FAN_MODE) { /* closed-loop */
> +		val = PWM_FROM_CNT(data->set_cnt);
> +	} else {                                            /* open-loop */
> +		val = data->set_out;
> +	}

I don't think you need to use braces for the above statement.

Regards,

Simon
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130424/9838afdc/attachment-0001.sig>
