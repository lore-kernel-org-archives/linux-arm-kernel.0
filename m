From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Fri, 9 Jan 2015 09:23:18 -0800
Subject: [PATCH v2 1/9] Input: sun4i-ts: Add thermal zone sensor support
In-Reply-To: <1420798676-22856-2-git-send-email-wens@csie.org>
References: <1420798676-22856-1-git-send-email-wens@csie.org>
 <1420798676-22856-2-git-send-email-wens@csie.org>
Message-ID: <20150109172318.GA39037@dtor-ws>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 09, 2015 at 06:17:48PM +0800, Chen-Yu Tsai wrote:
> The touchscreen controller has a temperature sensor embedded in the SoC,
> which already has hwmon support in the driver.
> 
> Add DT thermal zone support so we can use it with cpufreq for thermal
> throttling.
> 
> This also adds a comment stating that we do not know the actual formula
> for calculating the temperature.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---


  CC [M]  drivers/input/touchscreen/sun4i-ts.o
drivers/input/touchscreen/sun4i-ts.c:208:15: error: variable
?sun4i_ts_tz_ops? has initializer but incomplete type
 static struct thermal_zone_of_device_ops sun4i_ts_tz_ops = {
               ^
drivers/input/touchscreen/sun4i-ts.c:209:2: error: unknown field
?get_temp? specified in initializer
  .get_temp = get_temp,
  ^
drivers/input/touchscreen/sun4i-ts.c:209:2: warning: excess elements in
struct initializer [enabled by default]
drivers/input/touchscreen/sun4i-ts.c:209:2: warning: (near
initialization for ?sun4i_ts_tz_ops?) [enabled by default]
drivers/input/touchscreen/sun4i-ts.c: In function ?sun4i_ts_probe?:
drivers/input/touchscreen/sun4i-ts.c:331:8: warning: passing argument 4
of ?thermal_zone_of_sensor_register? from incompatible pointer type
[enabled by default]
        &sun4i_ts_tz_ops);
        ^
In file included from drivers/input/touchscreen/sun4i-ts.c:37:0:
include/linux/thermal.h:302:1: note: expected ?int (*)(void *, long int
*)? but argument is of type ?struct thermal_zone_of_device_ops *?
 thermal_zone_of_sensor_register(struct device *dev, int id,
 ^
drivers/input/touchscreen/sun4i-ts.c:331:8: error: too few arguments to
function ?thermal_zone_of_sensor_register?
        &sun4i_ts_tz_ops);
        ^
In file included from drivers/input/touchscreen/sun4i-ts.c:37:0:
include/linux/thermal.h:302:1: note: declared here
 thermal_zone_of_sensor_register(struct device *dev, int id,
 ^
make[1]: *** [drivers/input/touchscreen/sun4i-ts.o] Error 1
make: *** [drivers/input/touchscreen/sun4i-ts.o] Error 2

> 
> changes since v1:
> 
>     - clean up thermal zone sensor when input device register fails
>     - unconditionally unregister thermal zone sensor on removal.
>       the unregister function checks the pointers passed in.
>     - add comment explaining the lack of documents for the temperature
>       calculation formula
> 
> ---
>  .../bindings/input/touchscreen/sun4i.txt           |  2 +
>  drivers/input/touchscreen/sun4i-ts.c               | 47 ++++++++++++++++++++++
>  2 files changed, 49 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/sun4i.txt b/Documentation/devicetree/bindings/input/touchscreen/sun4i.txt
> index aef57791f40b..a8405bab6c00 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/sun4i.txt
> +++ b/Documentation/devicetree/bindings/input/touchscreen/sun4i.txt
> @@ -5,6 +5,7 @@ Required properties:
>   - compatible: "allwinner,sun4i-a10-ts"
>   - reg: mmio address range of the chip
>   - interrupts: interrupt to which the chip is connected
> + - #thermal-sensor-cells: shall be 0
>  
>  Optional properties:
>   - allwinner,ts-attached: boolean indicating that an actual touchscreen is
> @@ -17,4 +18,5 @@ Example:
>  		reg = <0x01c25000 0x100>;
>  		interrupts = <29>;
>  		allwinner,ts-attached;
> +		#thermal-sensor-cells = <0>;
>  	};
> diff --git a/drivers/input/touchscreen/sun4i-ts.c b/drivers/input/touchscreen/sun4i-ts.c
> index 28a06749ae42..aac49db0b09d 100644
> --- a/drivers/input/touchscreen/sun4i-ts.c
> +++ b/drivers/input/touchscreen/sun4i-ts.c
> @@ -34,6 +34,7 @@
>  
>  #include <linux/err.h>
>  #include <linux/hwmon.h>
> +#include <linux/thermal.h>
>  #include <linux/init.h>
>  #include <linux/input.h>
>  #include <linux/interrupt.h>
> @@ -107,6 +108,7 @@
>  struct sun4i_ts_data {
>  	struct device *dev;
>  	struct input_dev *input;
> +	struct thermal_zone_device *tz;
>  	void __iomem *base;
>  	unsigned int irq;
>  	bool ignore_fifo_data;
> @@ -180,6 +182,33 @@ static void sun4i_ts_close(struct input_dev *dev)
>  	writel(TEMP_IRQ_EN(1), ts->base + TP_INT_FIFOC);
>  }
>  
> +static int get_temp(void *data, long *temp)
> +{
> +	struct sun4i_ts_data *ts = data;
> +
> +	/* No temp_data until the first irq */
> +	if (ts->temp_data == -1)
> +		return -EAGAIN;
> +
> +	/*
> +	 * The user manuals do not contain the formula for calculating
> +	 * the temperature. The formula used here is from the AXP209,
> +	 * which is designed by X-Powers, an affiliate of Allwinner:
> +	 *
> +	 *     temperature = -144.7 + (value * 0.1)
> +	 *
> +	 * This should be replaced with the correct one if such information
> +	 * becomes available.
> +	 */
> +	*temp = (ts->temp_data - 1447) * 100;
> +
> +	return 0;
> +}
> +
> +static struct thermal_zone_of_device_ops sun4i_ts_tz_ops = {
> +	.get_temp = get_temp,
> +};
> +
>  static ssize_t show_temp(struct device *dev, struct device_attribute *devattr,
>  			 char *buf)
>  {
> @@ -189,6 +218,16 @@ static ssize_t show_temp(struct device *dev, struct device_attribute *devattr,
>  	if (ts->temp_data == -1)
>  		return -EAGAIN;
>  
> +	/*
> +	 * The user manuals do not contain the formula for calculating
> +	 * the temperature. The formula used here is from the AXP209,
> +	 * which is designed by X-Powers, an affiliate of Allwinner:
> +	 *
> +	 *     temperature = -144.7 + (value * 0.1)
> +	 *
> +	 * This should be replaced with the correct one if such information
> +	 * becomes available.
> +	 */
>  	return sprintf(buf, "%d\n", (ts->temp_data - 1447) * 100);

Why duplicate it here, instead of doing:

static int sun4i_get_temp(struct sun4i_ts_data *ts, int *temp)
{
	if (ts->temp_data == -1)
		return -EAGAIN;

	/* comment */
	*temp = (ts->temp_data - 1447) * 100);

	return 0;
}

static int sun4i_tz_get_temp(void *data, long *temp)
{
	return sun4i_get_temp(data, temp);
}

static ssize_t sun4i_show_temp(...)
{
	error = sun4i_get_temp(ts, &temp);
	if (error)
		return error;

	return sprintf(buf, "%d\n", temp);
}

Also, thermal core seems to allow creating hwmon devices for thermal
zones, can we use this feature?

Thanks.

-- 
Dmitry
