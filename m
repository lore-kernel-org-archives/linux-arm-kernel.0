From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 22 Feb 2012 16:34:44 +0000
Subject: [PATCH v3 02/10] pwm: Allow chips to support multiple PWMs.
In-Reply-To: <1329923841-32017-3-git-send-email-thierry.reding@avionic-design.de>
References: <1329923841-32017-1-git-send-email-thierry.reding@avionic-design.de>
 <1329923841-32017-3-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <201202221634.45159.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 22 February 2012, Thierry Reding wrote:

>  #include <linux/module.h>
> +#include <linux/of_pwm.h>
>  #include <linux/pwm.h>

You should probably reorder the patches for bisectability, or move the
of_* related changes out of this patch into patch 3. At the point
where patch 2 is applied, linux/of_pwm.h does not exist yet.

>  
> +/**
> + * pwmchip_find() - iterator for locating a specific pwm_chip
> + * @data: data to pass to match function
> + * @match: callback function to check pwm_chip
> + */
> +struct pwm_chip *pwmchip_find(void *data, int (*match)(struct pwm_chip *chip,
> +						       void *data))
> +{
> +	struct pwm_chip *ret = NULL;
> +	struct pwm_chip *chip;
> +
> +	mutex_lock(&pwm_lock);
> +
> +	list_for_each_entry(chip, &pwm_chips, list) {
> +		if (match(chip, data)) {
> +			ret = chip;
> +			break;
> +		}
> +	}
> +
> +	mutex_unlock(&pwm_lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(pwmchip_find);

Is this only used for the device tree functions? If so, I would recommend
making it less generic and always search for a device node.

> +static int pwm_show(struct seq_file *s, void *unused)
> +{
> +	const char *prefix = "";
> +	struct pwm_chip *chip;
> +
> +	list_for_each_entry(chip, &pwm_chips, list) {
> +		struct device *dev = chip->dev;
> +
> +		seq_printf(s, "%s%s/%s, %d PWM devices\n", prefix,
> +			   dev->bus ? dev->bus->name : "no-bus",
> +			   dev_name(dev), chip->npwm);
> +
> +		if (chip->ops->dbg_show)
> +			chip->ops->dbg_show(chip, s);
> +		else
> +			pwm_dbg_show(chip, s);
> +
> +		prefix = "\n";
> +	}
> +
> +	return 0;
> +}
> +
> +static int pwm_open(struct inode *inode, struct file *file)
> +{
> +	return single_open(file, pwm_show, NULL);
> +}

When you have a seq_file with a (possibly long) list of entries, better
use seq_open instead of single_open and print each item in the
->next() callback function.

	Arnd
