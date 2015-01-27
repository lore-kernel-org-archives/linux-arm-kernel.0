From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 27 Jan 2015 10:18:29 +0100
Subject: [PATCH] arm: sunxi: input: RFC: Add sysfs voltage for
 sun4i-lradc driver
In-Reply-To: <1422291516-24895-1-git-send-email-plaes@plaes.org>
References: <1422291516-24895-1-git-send-email-plaes@plaes.org>
Message-ID: <20150127091829.GD7200@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jan 26, 2015 at 06:58:32PM +0200, Priit Laes wrote:
> ---

Like Hans was pointing out, commit log and signed-off-by please

>  .../ABI/testing/sysfs-driver-input-sun4i-lradc     |  4 ++
>  drivers/input/keyboard/sun4i-lradc-keys.c          | 49 +++++++++++++++++-----
>  2 files changed, 43 insertions(+), 10 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-driver-input-sun4i-lradc
> 
> diff --git a/Documentation/ABI/testing/sysfs-driver-input-sun4i-lradc b/Documentation/ABI/testing/sysfs-driver-input-sun4i-lradc
> new file mode 100644
> index 0000000..e4e6448
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-driver-input-sun4i-lradc
> @@ -0,0 +1,4 @@
> +What:		/sys/class/input/input(x)/device/voltage
> +Date:		February 2015
> +Contact:	Priit Laes <plaes@plaes.org>
> +Description:	ADC output voltage in microvolts or 0 if device is not opened.

Why is it returning 0 when "device is not opened" ? What does that
even mean? You can't read that file without opening it.

> diff --git a/drivers/input/keyboard/sun4i-lradc-keys.c b/drivers/input/keyboard/sun4i-lradc-keys.c
> index cc8f7dd..c0ab8ec 100644
> --- a/drivers/input/keyboard/sun4i-lradc-keys.c
> +++ b/drivers/input/keyboard/sun4i-lradc-keys.c
> @@ -79,10 +79,27 @@ struct sun4i_lradc_data {
>  	u32 vref;
>  };
>  
> +static u32 sun4i_lradc_read_voltage(struct sun4i_lradc_data *lradc)
> +{
> +	u32 val = readl(lradc->base + LRADC_DATA0) & 0x3f;
> +	return val * lradc->vref / 63;
> +};
> +
> +static ssize_t
> +sun4i_lradc_dev_voltage_show(struct device *dev,
> +			struct device_attribute *attr, char *buf)
> +{
> +	struct sun4i_lradc_data *lradc = dev_get_drvdata(dev);
> +
> +	return sprintf(buf, "%u\n", sun4i_lradc_read_voltage(lradc));
> +}
> +
> +static const DEVICE_ATTR(voltage, S_IRUGO, sun4i_lradc_dev_voltage_show, NULL);
> +
>  static irqreturn_t sun4i_lradc_irq(int irq, void *dev_id)
>  {
>  	struct sun4i_lradc_data *lradc = dev_id;
> -	u32 i, ints, val, voltage, diff, keycode = 0, closest = 0xffffffff;
> +	u32 i, ints, voltage, diff, keycode = 0, closest = 0xffffffff;
>  
>  	ints  = readl(lradc->base + LRADC_INTS);
>  
> @@ -97,8 +114,7 @@ static irqreturn_t sun4i_lradc_irq(int irq, void *dev_id)
>  	}
>  
>  	if ((ints & CHAN0_KEYDOWN_IRQ) && lradc->chan0_keycode == 0) {
> -		val = readl(lradc->base + LRADC_DATA0) & 0x3f;
> -		voltage = val * lradc->vref / 63;
> +		voltage = sun4i_lradc_read_voltage(lradc);
>  
>  		for (i = 0; i < lradc->chan0_map_count; i++) {
>  			diff = abs(lradc->chan0_map[i].voltage - voltage);
> @@ -156,7 +172,7 @@ static void sun4i_lradc_close(struct input_dev *dev)
>  }
>  
>  static int sun4i_lradc_load_dt_keymap(struct device *dev,
> -				      struct sun4i_lradc_data *lradc)
> +				    struct sun4i_lradc_data *lradc)
>  {
>  	struct device_node *np, *pp;
>  	int i;
> @@ -168,8 +184,8 @@ static int sun4i_lradc_load_dt_keymap(struct device *dev,
>  
>  	lradc->chan0_map_count = of_get_child_count(np);
>  	if (lradc->chan0_map_count == 0) {
> -		dev_err(dev, "keymap is missing in device tree\n");
> -		return -EINVAL;
> +		dev_info(dev, "keymap is missing in device tree\n");
> +		return 0;
>  	}
>  
>  	lradc->chan0_map = devm_kmalloc_array(dev, lradc->chan0_map_count,
> @@ -185,19 +201,19 @@ static int sun4i_lradc_load_dt_keymap(struct device *dev,
>  
>  		error = of_property_read_u32(pp, "channel", &channel);
>  		if (error || channel != 0) {
> -			dev_err(dev, "%s: Inval channel prop\n", pp->name);
> +			dev_err(dev, "%s: Invalid 'channel' property\n", pp->name);
>  			return -EINVAL;
>  		}
>  
>  		error = of_property_read_u32(pp, "voltage", &map->voltage);
>  		if (error) {
> -			dev_err(dev, "%s: Inval voltage prop\n", pp->name);
> +			dev_err(dev, "%s: Invalid 'voltage' property\n", pp->name);
>  			return -EINVAL;
>  		}
>  
>  		error = of_property_read_u32(pp, "linux,code", &map->keycode);
>  		if (error) {
> -			dev_err(dev, "%s: Inval linux,code prop\n", pp->name);
> +			dev_err(dev, "%s: Invalid 'linux,code' property\n", pp->name);
>  			return -EINVAL;
>  		}
>  
> @@ -257,14 +273,26 @@ static int sun4i_lradc_probe(struct platform_device *pdev)
>  	if (error)
>  		return error;
>  
> -	error = input_register_device(lradc->input);
> +	error = device_create_file(dev, &dev_attr_voltage);

As I told you already, if you're going to expose this an ADC in the
end, the proper solution is to use the IIO framework, not adding a
custom sysfs file.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150127/b90b0164/attachment.sig>
