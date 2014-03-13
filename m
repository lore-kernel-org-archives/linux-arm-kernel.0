From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 14 Mar 2014 00:19:25 +0100
Subject: [RFC PATCH] i2c: new bus driver for efm32
In-Reply-To: <20140313221433.GI2696@katana>
References: <1392027598-29015-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20140310075558.GD2571@katana>
 <20140313212613.GB15674@pengutronix.de>
 <20140313221433.GI2696@katana>
Message-ID: <20140313231925.GC15674@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

On Thu, Mar 13, 2014 at 11:14:33PM +0100, Wolfram Sang wrote:
> > > Huh? Is this an accepted binding? Doesn't look like it because of a
> > > generic name and IMO a specific use-case. BTW the binding documentation
> > > for this driver is missing.
> > Regarding the generic name: I don't care much, but I don't have a
> > problem with it. IMHO it's implicitly name-spaced by the compatible
> > string which starts with "efm32," and so is fine. I'd like to have the
> > same property name for all efm32 device drivers and "location" matches
> > the hardware reference manual (apart from capitalization).
> 
> I would in deed have expected a binding like "efm32,location" to
> emphasize this is an efm32 specific thing. I know vendor-specific
> "setup" bindings from elsewhere. Since it has been accepted already in
> other places, we should keep it likes this.
Assuming you know the dt stuff better than me (and noone objects) I'd
fix the intree drivers to use efm32,location, too.

> > > > +	if (resource_size(res) < 0x42) {
> > > > +		dev_err(&pdev->dev, "memory resource too small\n");
> > > > +		return -EINVAL;
> > > > +	}
> > > 
> > > I'd drop this check since, but I won't force you to.
> > I'd understand your sentence with s/since//, not sure about it as is.
> > Anyhow, I like this check.
> 
> A leftover. I was about to write "since the check is somewhat heuristic
> and does not proof much". But then I decided it is not worth spending
> too much discussion on it :)
I'd say it's heuristic to *not* check the boundary. It doesn't apply
here, but consider a driver using a register space > PAGE_SIZE on an MMU
platform. It accesses base + PAGE_SIZE + 0x42 even if dt only gave a
register range of PAGE_SIZE / 2. It's like gets(3).

> > > > +	clkdiv = DIV_ROUND_UP(rate, 8 * ddata->pdata.frequency) - 1;
> > > > +	if (clkdiv >= 0x200) {
> > > > +		dev_err(&pdev->dev,
> > > > +				"input clock too fast (%lu) to divide down to bus freq (%lu)",
> > > > +				rate, ddata->pdata.frequency);
> > > > +		ret = -EIO;
> > > > +		goto err_disable_clk;
> > > > +	}
> > > 
> > > -EIO for clocks errors? Is this common?
> > Changed to ENODEV. Ok?
> 
> Nope, then the driver core will silent drop the error. -EINVAL?
agreed

Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
