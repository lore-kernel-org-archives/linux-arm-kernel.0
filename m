From: broonie@kernel.org (Mark Brown)
Date: Wed, 19 Feb 2014 10:46:15 +0900
Subject: [PATCH] regulator: core bugfix: Use normal enable for always_on
 regulators
In-Reply-To: <20140218214007.GE10590@pengutronix.de>
References: <1392577256-20475-1-git-send-email-mpa@pengutronix.de>
 <20140218001420.GF2669@sirena.org.uk>
 <20140218214007.GE10590@pengutronix.de>
Message-ID: <20140219014615.GK2669@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 18, 2014 at 10:40:07PM +0100, Markus Pargmann wrote:
> On Tue, Feb 18, 2014 at 09:14:20AM +0900, Mark Brown wrote:

> > I don't understand this.  Why is this called _no_delay() and why don't
> > we want to delay when applying constraints?  We don't want to ever be in
> > a position where we think a supply is enabled but it has in fact not
> > finished ramping, and of course enable() may in fact be blocking anyway.

> I tried not to modify the current behaviour of the core driver for
> non-gpio regulators. Before this patch only ops->enable() was called
> which also didn't have a delay. So I seperated the non-delay enable
> function to have the same behaviour for normal regulators.

No, that's not good.  The fact that it wasn't applying delays is going
to be a bug - it should've been doing that.

> Also the constraints are applied when registering a new regulator. For
> "boot-on" we should not delay because this regulator is already on by
> definition. But I am not sure what to do with always-on regulators?

I'd just always apply a delay, it's simpler and more robust.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140219/d68d5fd4/attachment.sig>
