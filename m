From: johan@kernel.org (Johan Hovold)
Date: Tue, 28 Jul 2015 11:50:04 +0200
Subject: [PATCH 7/9] gpiolib-sysfs: Add gpio name parsing for sysfs export
In-Reply-To: <1437125570-28623-8-git-send-email-mpa@pengutronix.de>
References: <1437125570-28623-1-git-send-email-mpa@pengutronix.de>
 <1437125570-28623-8-git-send-email-mpa@pengutronix.de>
Message-ID: <20150728095004.GM28535@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 17, 2015 at 11:32:48AM +0200, Markus Pargmann wrote:
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
>  drivers/gpio/gpiolib-sysfs.c | 41 ++++++++++++++++++++++++++++-------------
>  1 file changed, 28 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpio/gpiolib-sysfs.c b/drivers/gpio/gpiolib-sysfs.c
> index b57ed8e55ab5..c3b74440ca67 100644
> --- a/drivers/gpio/gpiolib-sysfs.c
> +++ b/drivers/gpio/gpiolib-sysfs.c
> @@ -443,18 +443,25 @@ static ssize_t export_store(struct class *class,
>  				const char *buf, size_t len)
>  {
>  	long			gpio;
> -	struct gpio_desc	*desc;
> +	struct gpio_desc	*desc = NULL;
>  	int			status;
>  
>  	status = kstrtol(buf, 0, &gpio);
> -	if (status < 0)
> -		goto done;
> +	if (!status)
> +		desc = gpio_to_desc(gpio);
>  
> -	desc = gpio_to_desc(gpio);
> -	/* reject invalid GPIOs */
> +	/* Fall back on detection by name */
>  	if (!desc) {
> -		pr_warn("%s: invalid GPIO %ld\n", __func__, gpio);
> -		return -EINVAL;
> +		char *gpio_name = kstrdup(buf, GFP_KERNEL);

Must check for allocation failures, but why use kstrdup at all?

> +
> +		desc = gpio_name_to_desc(strim(gpio_name));
> +		kfree(gpio_name);
> +
> +		/* reject invalid GPIOs */
> +		if (!desc) {
> +			pr_warn("%s: invalid GPIO %s\n", __func__, buf);
> +			return -EINVAL;
> +		}
>  	}
>  
>  	/* No extra locking here; FLAG_SYSFS just signifies that the
> @@ -485,17 +492,25 @@ static ssize_t unexport_store(struct class *class,
>  				const char *buf, size_t len)
>  {
>  	long			gpio;
> -	struct gpio_desc	*desc;
> +	struct gpio_desc	*desc = NULL;
>  	int			status;
>  
>  	status = kstrtol(buf, 0, &gpio);
> -	if (status < 0)
> -		goto done;
> +	if (!status)
> +		desc = gpio_to_desc(gpio);
> +
> +	/* Fall back on detection by name */
> +	if (!desc) {
> +		char *gpio_name = kstrdup(buf, GFP_KERNEL);

Same here.

> +
> +		desc = gpio_name_to_desc(strim(gpio_name));
> +		kfree(gpio_name);
> +	}
> +

Random whitespace change.

>  
> -	desc = gpio_to_desc(gpio);
>  	/* reject bogus commands (gpio_unexport ignores them) */
>  	if (!desc) {
> -		pr_warn("%s: invalid GPIO %ld\n", __func__, gpio);
> +		pr_warn("%s: invalid GPIO %s\n", __func__, buf);
>  		return -EINVAL;
>  	}

Johan
