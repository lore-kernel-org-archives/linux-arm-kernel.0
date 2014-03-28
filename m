From: broonie@kernel.org (Mark Brown)
Date: Fri, 28 Mar 2014 13:39:34 +0000
Subject: [PATCH v3 06/10] regulator: AXP20x: Add support for regulators
 subsystem
In-Reply-To: <1395955764-18103-7-git-send-email-carlo@caione.org>
References: <1395955764-18103-1-git-send-email-carlo@caione.org>
 <1395955764-18103-7-git-send-email-carlo@caione.org>
Message-ID: <20140328133934.GQ30768@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 27, 2014 at 10:29:20PM +0100, Carlo Caione wrote:

> +static int axp20x_set_suspend_voltage(struct regulator_dev *rdev, int uV)
> +{
> +	int sel = regulator_map_voltage_iterate(rdev, uV, uV);
> +
> +	if (sel < 0)
> +		return sel;
> +
> +	return regulator_set_voltage_sel_regmap(rdev, sel);
> +}

This is fairly obviously broken - it's overwriting the normal runtime
value, this will disrupt the running system if we want the value we use
on suspend is different to the value we want at runtime.

Think about it - if this was a sane thing to do the core would just do
it without needing driver specific code, we already know how to set the
voltage for the device.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140328/80a4b3b6/attachment.sig>
