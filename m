From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 16 Dec 2015 11:29:34 +0100
Subject: [PATCH v2 1/3] reset: Add shared reset_control_[de]assert variants
In-Reply-To: <1450086655.3407.23.camel@pengutronix.de>
References: <1449848520-27379-1-git-send-email-hdegoede@redhat.com>
 <20151214093607.GF19456@lukather>
 <1450086655.3407.23.camel@pengutronix.de>
Message-ID: <20151216102934.GR19456@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 14, 2015 at 10:50:55AM +0100, Philipp Zabel wrote:
> Am Montag, den 14.12.2015, 10:36 +0100 schrieb Maxime Ripard:
> > Hi,
> > 
> > On Fri, Dec 11, 2015 at 04:41:58PM +0100, Hans de Goede wrote:
> > > diff --git a/include/linux/reset.h b/include/linux/reset.h
> > > index c4c097d..1cca8ce 100644
> > > --- a/include/linux/reset.h
> > > +++ b/include/linux/reset.h
> > > @@ -11,6 +11,8 @@ int reset_control_reset(struct reset_control *rstc);
> > >  int reset_control_assert(struct reset_control *rstc);
> > >  int reset_control_deassert(struct reset_control *rstc);
> > >  int reset_control_status(struct reset_control *rstc);
> > > +int reset_control_assert_shared(struct reset_control *rstc);
> > > +int reset_control_deassert_shared(struct reset_control *rstc);
> > 
> > Shouldn't that be handled in reset_control_get directly?
> 
> This is about different expectations of the caller.
> A driver calling reset_control_assert expects the reset line to be
> asserted after the call.

Is that behaviour documented explicitly somewhere?

> A driver calling reset_control_assert_shared
> just signals that it doesn't care about the state of the reset line
> anymore.
> We could just as well call the two new functions
> reset_control_deassert_get and reset_control_deassert_put.

What happens if you mix them? What happens if you have several drivers
ignoring this API?

The current default API totally allows to have several drivers getting
the same reset line, and happily poking that reset line without any
way for the others to A) know they're not the single users B) let them
know their device has been reset.

And not being able to tell at the consumer level if and when our
device is going to be reset behind our back is a big issue. Because
then, we simply have to expect it can be reset at any point in time,
good luck writing a driver with that expectation.

The reset framework should make sure that the shared case is an
exception, and not the default case (and make sure that it cannot
happen in the default case). Just like for any other framework with
similar resources constraints.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151216/6d382950/attachment.sig>
