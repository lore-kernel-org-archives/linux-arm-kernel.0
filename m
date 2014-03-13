From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 13 Mar 2014 23:14:33 +0100
Subject: [RFC PATCH] i2c: new bus driver for efm32
In-Reply-To: <20140313212613.GB15674@pengutronix.de>
References: <1392027598-29015-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20140310075558.GD2571@katana>
 <20140313212613.GB15674@pengutronix.de>
Message-ID: <20140313221433.GI2696@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> it is, at least in mainline. My (not very strong) POV is that it's not
> much effort/code size to support both. I dropped the non-DT part, it's
> easily readded if need should arise.

Thanks, I think it simplifies the review for this first (public)
iteration of the driver.

> > > +		break;
> > > +	case REG_STATE_STATE_WAIT:
> > > +		/* huh, this shouldn't happen */
> > > +		BUG();
> > 
> > Is this really a reason to halt the kernel?
> No, probably not. What do you suggest? Reinit the hardware, report and
> return an error?

Can't really say, because I don't know what the HW is waiting for. What
you say sounds sensible, though.

> > Check the core. It has per adapter locks. So the lock can go away.
> ok. So I can also drop the "if (ddata->msgs)" check, right?

Yes.

> > Check Documentation/i2c/fault-codes for more fine grained responses.
> ok, I have EAGAIN for arbitration lost, ENXIO for NAck in address phase
> and EIO for NAck in data phase now. Sounds good?

Yup!

> > That is usually enough. Make sure you checked SMBUS_QUICK, though
> > (i2cdetect -q ...).
> Both -q and -r seem to do the right thing.

Good.

> > Huh? Is this an accepted binding? Doesn't look like it because of a
> > generic name and IMO a specific use-case. BTW the binding documentation
> > for this driver is missing.
> Regarding the generic name: I don't care much, but I don't have a
> problem with it. IMHO it's implicitly name-spaced by the compatible
> string which starts with "efm32," and so is fine. I'd like to have the
> same property name for all efm32 device drivers and "location" matches
> the hardware reference manual (apart from capitalization).

I would in deed have expected a binding like "efm32,location" to
emphasize this is an efm32 specific thing. I know vendor-specific
"setup" bindings from elsewhere. Since it has been accepted already in
other places, we should keep it likes this.

> > > +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > > +	if (!res) {
> > > +		dev_err(&pdev->dev, "failed to determine base address\n");
> > 
> > devm_ioremap_resource() checks for a valid resource. Drop this.
> But resource_size doesn't ...

Right (another reason to drop the check in my book ;))

>  
> > > +		return -ENODEV;
> > > +	}
> > > +
> > > +	if (resource_size(res) < 0x42) {
> > > +		dev_err(&pdev->dev, "memory resource too small\n");
> > > +		return -EINVAL;
> > > +	}
> > 
> > I'd drop this check since, but I won't force you to.
> I'd understand your sentence with s/since//, not sure about it as is.
> Anyhow, I like this check.

A leftover. I was about to write "since the check is somewhat heuristic
and does not proof much". But then I decided it is not worth spending
too much discussion on it :)

> > > +	clkdiv = DIV_ROUND_UP(rate, 8 * ddata->pdata.frequency) - 1;
> > > +	if (clkdiv >= 0x200) {
> > > +		dev_err(&pdev->dev,
> > > +				"input clock too fast (%lu) to divide down to bus freq (%lu)",
> > > +				rate, ddata->pdata.frequency);
> > > +		ret = -EIO;
> > > +		goto err_disable_clk;
> > > +	}
> > 
> > -EIO for clocks errors? Is this common?
> Changed to ENODEV. Ok?

Nope, then the driver core will silent drop the error. -EINVAL?

Regards,

   Wolfram

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140313/85b4c732/attachment.sig>
