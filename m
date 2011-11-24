From: cbouatmailru@gmail.com (Anton Vorontsov)
Date: Thu, 24 Nov 2011 22:42:15 +0400
Subject: [PATCH v5] power: bq20z75: devicetree init support
In-Reply-To: <1316031547-18281-1-git-send-email-rklein@nvidia.com>
References: <1316031547-18281-1-git-send-email-rklein@nvidia.com>
Message-ID: <20111124184215.GA29135@oksana.dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Rhyland,

Got this:

  CC [M]  drivers/power/bq20z75.o
drivers/power/bq20z75.c: In function ?bq20z75_of_populate_pdata?:
drivers/power/bq20z75.c:630:21: error: storage size of ?gpio_flags? isn?t known
drivers/power/bq20z75.c:668:2: error: implicit declaration of function ?of_get_named_gpio_flags? [-Werror=implicit-function-declaration]
drivers/power/bq20z75.c:671:19: error: ?OF_GPIO_ACTIVE_LOW? undeclared (first use in this function)
drivers/power/bq20z75.c:671:19: note: each undeclared identifier is reported only once for each function it appears in
drivers/power/bq20z75.c:630:21: warning: unused variable ?gpio_flags? [-Wunused-variable]
drivers/power/bq20z75.c:627:29: warning: unused variable ?dtid? [-Wunused-variable]

I fixed this by...

On Wed, Sep 14, 2011 at 01:19:07PM -0700, Rhyland Klein wrote:

> +#if defined(CONFIG_OF)
> +#include <linux/of_device.h>

Adding linux/of_gpio.h

> +static const struct of_device_id bq20z75_dt_ids[] = {
> +	{ .compatible = "ti,bq20z75" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, bq20z75_dt_ids);
> +
> +static struct bq20z75_platform_data *bq20z75_of_populate_pdata(
> +	struct i2c_client *client)
> +{
> +	const struct of_device_id *dtid;

And deleting that line.


Applied to battery-2.6.git, but please double check if everything
is OK.

Thanks,

-- 
Anton Vorontsov
Email: cbouatmailru at gmail.com
