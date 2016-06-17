From: broonie@kernel.org (Mark Brown)
Date: Fri, 17 Jun 2016 13:59:23 +0100
Subject: [RESEND v7 1/6] mfd: max8997: Use regmap to access registers
In-Reply-To: <1466143833-5856-2-git-send-email-k.kozlowski@samsung.com>
References: <1466143833-5856-1-git-send-email-k.kozlowski@samsung.com>
 <1466143833-5856-2-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20160617125923.GQ26099@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 17, 2016 at 08:10:28AM +0200, Krzysztof Kozlowski wrote:

>  drivers/extcon/extcon-max8997.c       |  31 ++++----
>  drivers/input/misc/max8997_haptic.c   |  34 ++++----
>  drivers/leds/leds-max8997.c           |  13 ++--
>  drivers/mfd/Kconfig                   |   1 +
>  drivers/mfd/max8997-irq.c             |  64 ++++++---------
>  drivers/mfd/max8997.c                 | 141 +++++++++++++++-------------------
>  drivers/power/max8997_charger.c       |  33 ++++----
>  drivers/regulator/max8997-regulator.c |  87 ++++++++++-----------
>  drivers/rtc/rtc-max8997.c             |  56 ++++++++------
>  include/linux/mfd/max8997-private.h   |  17 ++--
>  10 files changed, 228 insertions(+), 249 deletions(-)

This is doing two things at once - it's changing the I/O mechanism over
to regmap and updating all the client drivers in a single commit.
Conversions like this are normally done by first converting the
driver-specific I/O functions to use regmap internally and then
subsequently updating the individual client drivers (if that's even
useful, sometimes people don't bother as the static inlines you
usually end up with in the header are not a real cost).  This makes for
a set of smaller, more focused patches which are easier to get reviewed.

As it is due to the subject line not looking at all relevant and these
Maxim PMIC drivers generating an awful lot of resends this is the first
time I actually looked at this enough to notice there's any regulator
code, I suspect I've either deleted older versions unread or scanned
the commit message and not seen that there was a regulator change.  I
only saw it at all because it was mentioned to me on IRC and a copy
forwarded on to me.

> @@ -464,15 +449,15 @@ static int max8997_restore(struct device *dev)
>  	int i;
>  
>  	for (i = 0; i < ARRAY_SIZE(max8997_dumpaddr_pmic); i++)
> -		max8997_write_reg(i2c, max8997_dumpaddr_pmic[i],
> +		regmap_write(max8997->regmap, max8997_dumpaddr_pmic[i],
>  				max8997->reg_dump[i]);
>  

Looks like a conversion to regcache is also useful but that can be done
as a followup.

> @@ -257,15 +258,14 @@ static int max8997_get_enable_register(struct regulator_dev *rdev,
>  static int max8997_reg_is_enabled(struct regulator_dev *rdev)
>  {
>  	struct max8997_data *max8997 = rdev_get_drvdata(rdev);
> -	struct i2c_client *i2c = max8997->iodev->i2c;
>  	int ret, reg, mask, pattern;
> -	u8 val;
> +	unsigned int val;
>  
>  	ret = max8997_get_enable_register(rdev, &reg, &mask, &pattern);
>  	if (ret)
>  		return ret;
>  
> -	ret = max8997_read_reg(i2c, reg, &val);
> +	ret = regmap_read(max8997->iodev->regmap, reg, &val);
>  	if (ret)
>  		return ret;
>  

A proper regmap conversion of this driver would be to convert the
driver to use the core regmap operations and remove all the driver
specific code.  It's a step in the right direction but it's making a
bunch of code that's obviously problematic so it's hard to get
enthusiastic.  
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160617/96399f1e/attachment.sig>
