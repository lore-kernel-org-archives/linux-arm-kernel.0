From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 1 Sep 2010 10:48:26 +0100
Subject: [PATCH v2] MAX8952 PMIC Driver Initial Release
In-Reply-To: <000801cb49ba$3e1e50f0$ba5af2d0$%kim@samsung.com>
References: <1282283036-12641-1-git-send-email-myungjoo.ham@samsung.com>
	<20100820095351.GD13668@rakim.wolfsonmicro.main>
	<1282301229.3084.152.camel@odin>
	<011b01cb496a$cfa773d0$6ef65b70$%kim@samsung.com>
	<20100901091519.GA17032@opensource.wolfsonmicro.com>
	<000801cb49ba$3e1e50f0$ba5af2d0$%kim@samsung.com>
Message-ID: <20100901094826.GA28490@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 01, 2010 at 06:44:11PM +0900, Kukjin Kim wrote:

> MM...but I'm not sure if I can submit other patch for max8952...
> Actually, Mr. Ham's max8952 code has been applied by Liam.

We can always remove that if it makes more sense to combine the code.

> -	return (MAX8649_DCDC_VMIN + index * MAX8649_DCDC_STEP);
> +	struct max8649_regulator_info *info = rdev_get_drvdata(rdev);
> +	int ret = MAX8649_DCDC_VMIN + index * MAX8649_DCDC_STEP;
> +
> +	if (!strcmp(info->i2c->name, "max8952"))

Rather than doing a strcmp on the name you should use the id field here:

>  static const struct i2c_device_id max8649_id[] = {
>  	{ "max8649", 0 },
> +	{ "max8952", 0 },
>  	{ }
>  };

to pass in a value which you compare against.  While it's probably not a
performance issue on this chip this is much clearer and more idiomatic.
