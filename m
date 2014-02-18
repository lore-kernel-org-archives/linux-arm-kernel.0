From: mpa@pengutronix.de (Markus Pargmann)
Date: Tue, 18 Feb 2014 22:40:07 +0100
Subject: [PATCH] regulator: core bugfix: Use normal enable for always_on
 regulators
In-Reply-To: <20140218001420.GF2669@sirena.org.uk>
References: <1392577256-20475-1-git-send-email-mpa@pengutronix.de>
 <20140218001420.GF2669@sirena.org.uk>
Message-ID: <20140218214007.GE10590@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 18, 2014 at 09:14:20AM +0900, Mark Brown wrote:
> On Sun, Feb 16, 2014 at 08:00:56PM +0100, Markus Pargmann wrote:
> 
> Please use more standard subject lines, don't do things like "core
> bugfix", just write a normal changelog.

Okay, will fix.

> 
> > +static int _regulator_do_enable_no_delay(struct regulator_dev *rdev)
> > +{
> > +	int ret;
> > +
> > +	if (rdev->ena_pin) {
> > +		ret = regulator_ena_gpio_ctrl(rdev, true);
> > +		if (ret < 0)
> > +			return ret;
> > +		rdev->ena_gpio_state = 1;
> > +	} else if (rdev->desc->ops->enable) {
> > +		ret = rdev->desc->ops->enable(rdev);
> > +	} else {
> > +		ret = -EINVAL;
> > +	}
> > +
> > +	return ret;
> > +}
> 
> I don't understand this.  Why is this called _no_delay() and why don't
> we want to delay when applying constraints?  We don't want to ever be in
> a position where we think a supply is enabled but it has in fact not
> finished ramping, and of course enable() may in fact be blocking anyway.

I tried not to modify the current behaviour of the core driver for
non-gpio regulators. Before this patch only ops->enable() was called
which also didn't have a delay. So I seperated the non-delay enable
function to have the same behaviour for normal regulators.

Also the constraints are applied when registering a new regulator. For
"boot-on" we should not delay because this regulator is already on by
definition. But I am not sure what to do with always-on regulators?

Thanks,

Markus


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140218/a448bd84/attachment.sig>
