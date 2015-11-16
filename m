From: broonie@kernel.org (Mark Brown)
Date: Mon, 16 Nov 2015 18:42:38 +0000
Subject: [PATCH v4 09/24] regulator: pwm: use pwm_get/set_default_xxx()
 helpers where appropriate
In-Reply-To: <20151116132359.39d84279@bbrezillon>
References: <1447664207-24370-1-git-send-email-boris.brezillon@free-electrons.com>
 <1447664207-24370-10-git-send-email-boris.brezillon@free-electrons.com>
 <20151116105558.GB31303@sirena.org.uk>
 <20151116132359.39d84279@bbrezillon>
Message-ID: <20151116184238.GJ31303@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 16, 2015 at 01:23:59PM +0100, Boris Brezillon wrote:
> Mark Brown <broonie@kernel.org> wrote:
> > On Mon, Nov 16, 2015 at 09:56:32AM +0100, Boris Brezillon wrote:

> > > -	pwm_reg_period = pwm_get_period(drvdata->pwm);
> > > +	pwm_reg_period = pwm_get_default_period(drvdata->pwm);

> > It's not clear to me that we're not looking for the current period here
> > or in the other use.  Won't configuring based on a period other than the
> > one that has been set give the wrong answer?

> Hm, maybe that's naming problem. What I call the 'default' period here
> is actually the period configured in your board file (using a PWM lookup
> table) or your DT. This value represent the period requested by the PWM
> user not a default value specified by the PWM chip driver.

> The reason we're not using the 'current' period value is because it may
> have been set by the bootloader, and may be inappropriate for our use
> case (ie. the period may be to small to represent the different
> voltages).

> ITOH, we're using the current period value when calculating the current
> voltage, because we want to get the correct voltage value, and the PWM
> device may still use the configuration set by the bootloader (not the
> default one specified in your board or DT files).

> I hope this clarifies the differences between the current and default
> period, and why we should use the default value here.

To be honest I'm still a bit confused here.  When do we actually apply
the default setting and why do we keep on having to constantly override
it rather than doing this once at boot?  It feels wrong to be using it
every time we set anything.  I'd expect it to be something we only need
to do at probe time or which would automatically be handled by the PWM
framework (but that'd have issues changing the state and potentially
breaking things if done in an uncoordiated fashion).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151116/e7cb878e/attachment.sig>
