From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 23 Feb 2012 15:34:22 +0000
Subject: [PATCH] regulator: twl6030: add support for vdd1, vdd2 and vdd3
 regulators
In-Reply-To: <1329995109-4795-1-git-send-email-t-kristo@ti.com>
References: <1329995109-4795-1-git-send-email-t-kristo@ti.com>
Message-ID: <20120223153422.GF4553@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 23, 2012 at 01:05:09PM +0200, Tero Kristo wrote:

> +static int twl6030coresmps_set_voltage(struct regulator_dev *rdev, int min_uV,
> +	int max_uV, unsigned *selector)
> +{
> +	struct twlreg_info *info = rdev_get_drvdata(rdev);
> +
> +	if (info->set_voltage)
> +		return info->set_voltage(info->data, min_uV);
> +
> +	return 0;
> +}

This should be returning an error if it failed to set the voltage.
Since you're using min_uV as the "register value" you probably ought to
be returning that as the selector too and supplying a list_voltage()
which just passes the selector back in case something tries to use it
and gets confused.

> +static int twl6030coresmps_get_voltage(struct regulator_dev *rdev)
> +{
> +	struct twlreg_info *info = rdev_get_drvdata(rdev);
> +
> +	if (info->get_voltage)
> +		return info->get_voltage(info->data);
> +
> +	return 0;

Similarly here.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120223/7a7b9d61/attachment-0001.sig>
