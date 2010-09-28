From: ryan@bluewatersys.com (Ryan Mallon)
Date: Wed, 29 Sep 2010 08:42:05 +1300
Subject: [PATCH 1/7] pwm: Add pwm core driver
In-Reply-To: <1285659648-21409-2-git-send-email-arun.murthy@stericsson.com>
References: <1285659648-21409-1-git-send-email-arun.murthy@stericsson.com>
	<1285659648-21409-2-git-send-email-arun.murthy@stericsson.com>
Message-ID: <4CA2450D.8090104@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/28/2010 08:40 PM, Arun Murthy wrote:
> The existing pwm based led and backlight driver makes use of the
> pwm(include/linux/pwm.h). So all the board specific pwm drivers will
> be exposing the same set of function name as in include/linux/pwm.h.
> As a result build fails.
> 
> In order to overcome this issue all the pwm drivers must register to
> some core pwm driver with function pointers for pwm operations (i.e
> pwm_config, pwm_enable, pwm_disable).

The other major benefit of this patch set is that it allows non-soc
pwms, such as those provided on an i2c or spi device, to be added easily.

> The clients of pwm device will have to call pwm_request, wherein
> they will get the pointer to struct pwm_ops. This structure include
> function pointers for pwm_config, pwm_enable and pwm_disable.
> 
> Signed-off-by: Arun Murthy <arun.murthy@stericsson.com>
> Acked-by: Linus Walleij <linus.walleij@stericsson.com>
> ---

> +menuconfig PWM_DEVICES
> +	bool "PWM devices"
> +	default y
> +	---help---
> +	  Say Y here to get to see options for device drivers from various
> +	  different categories. This option alone does not add any kernel code.

This help text doesn't really explain what the option does.

> +struct pwm_device {
> +	struct pwm_ops *pops;
> +	int pwm_id;
> +};
> +
> +struct pwm_dev_info {
> +	struct pwm_device *pwm_dev;
> +	struct list_head list;
> +};

These two structures can be merged into one which will make the code
much simpler.

> +static struct pwm_dev_info *di;

This appears to be used as just a list, and could be replaced by:

static LIST_HEAD(pwm_list);

> +struct pwm_device *pwm_request(int pwm_id, const char *name)
> +{
> +	struct pwm_dev_info *pwm;
> +	struct list_head *pos;
> +
> +	down_read(&pwm_list_lock);
> +	list_for_each(pos, &di->list) {
> +		pwm = list_entry(pos, struct pwm_dev_info, list);
> +		if ((!strcmp(pwm->pwm_dev->pops->name, name)) &&
> +				(pwm->pwm_dev->pwm_id == pwm_id)) {
> +			up_read(&pwm_list_lock);
> +			return pwm->pwm_dev;
> +		}
> +	}
> +	up_read(&pwm_list_lock);
> +	return ERR_PTR(-ENOENT);
> +}

Is it by design that multiple users can request and use the same pwm or
should pwms have a use count and return -EBUSY if already requested?

> +static int __init pwm_init(void)
> +{
> +	struct pwm_dev_info *pwm;
> +
> +	pwm = kzalloc(sizeof(struct pwm_dev_info), GFP_KERNEL);
> +	if (!pwm)
> +		return -ENOMEM;
> +	INIT_LIST_HEAD(&pwm->list);
> +	di = pwm;
> +	return 0;

If di is changed to a list as suggested above this function does not
need to exist.

> +static void __exit pwm_exit(void)
> +{
> +	kfree(di);

Do you need to ensure the list is empty first or do module dependencies
ensure that?

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
