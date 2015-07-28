From: johan@kernel.org (Johan Hovold)
Date: Tue, 28 Jul 2015 11:53:37 +0200
Subject: [PATCH 8/9] gpiolib-sysfs: Show gpio-name in
 /sys/class/gpio/gpio*/name
In-Reply-To: <1437125570-28623-9-git-send-email-mpa@pengutronix.de>
References: <1437125570-28623-1-git-send-email-mpa@pengutronix.de>
 <1437125570-28623-9-git-send-email-mpa@pengutronix.de>
Message-ID: <20150728095337.GN28535@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 17, 2015 at 11:32:49AM +0200, Markus Pargmann wrote:
> This patch adds a sysfs attribute 'name' to gpios that were exported. It
> exposes the newly added name property of gpio descriptors.
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
>  drivers/gpio/gpiolib-sysfs.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/gpio/gpiolib-sysfs.c b/drivers/gpio/gpiolib-sysfs.c
> index c3b74440ca67..058019879bab 100644
> --- a/drivers/gpio/gpiolib-sysfs.c
> +++ b/drivers/gpio/gpiolib-sysfs.c
> @@ -139,6 +139,25 @@ static ssize_t value_store(struct device *dev,
>  }
>  static DEVICE_ATTR_RW(value);
>  
> +static ssize_t gpio_name_show(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	struct gpio_desc	*desc = dev_get_drvdata(dev);
> +	ssize_t			status;
> +
> +	mutex_lock(&sysfs_lock);
> +
> +	if (!test_bit(FLAG_EXPORT, &desc->flags))

No need to check flag export, and no need for the mutex either.

> +		status = -EIO;
> +	else
> +		status = sprintf(buf, "%s\n", desc->name);

Depending on sprintfs representation of NULL is not a good idea here.

> +
> +	mutex_unlock(&sysfs_lock);
> +	return status;
> +}
> +
> +static DEVICE_ATTR(name, 0444, gpio_name_show, NULL);

DEVICE_ATTR_RO

> +
>  static irqreturn_t gpio_sysfs_irq(int irq, void *priv)
>  {
>  	struct gpiod_data *data = priv;
> @@ -377,6 +396,7 @@ static struct attribute *gpio_attrs[] = {
>  	&dev_attr_edge.attr,
>  	&dev_attr_value.attr,
>  	&dev_attr_active_low.attr,
> +	&dev_attr_name.attr,
>  	NULL,
>  };

Johan
