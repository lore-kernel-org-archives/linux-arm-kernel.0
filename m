From: broonie@kernel.org (Mark Brown)
Date: Tue, 1 Dec 2015 18:58:52 +0000
Subject: [PATCH 1/2] regulator: Add coupled regulator
In-Reply-To: <20151201140436.GQ29263@lukather>
References: <1448897346-17780-1-git-send-email-maxime.ripard@free-electrons.com>
 <1448897346-17780-2-git-send-email-maxime.ripard@free-electrons.com>
 <CANLsYkzBjDTCr1NPkPAQXnR5LCQ0MFFGb8EXXO2oVaxuZ0DH_A@mail.gmail.com>
 <20151201140436.GQ29263@lukather>
Message-ID: <20151201185852.GO1929@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 01, 2015 at 03:04:36PM +0100, Maxime Ripard wrote:
> On Mon, Nov 30, 2015 at 10:17:45AM -0700, Mathieu Poirier wrote:
> > On 30 November 2015 at 08:29, Maxime Ripard

> > > +       for (i = 0; i < creg->n_regulators; i++) {
> > > +               ret = regulator_disable(creg->regulators[i]);
> > > +               if (ret)
> > > +                       break;
> > > +       }

> > What happens to the other regulators when an element of the chain
> > fails to disable?  Should they be powered on again?

> That's actually a very good question, and I don't have a good answer
> to it. I guess the safest approach would be to roll back and do the
> opposite operation on the one we previously enabled / disabled.

> I wonder whether it might damage the hardware or not though.

> Mark?

Yeah, I'd expect us to try to unwind everything - presumably if the
supplies are partially enabled we'll not be able to satisfy the power
demands of whatever is connected (otherwise why would you create such an
innovative hardware design?) and it'll also mean that the refcounting
will be off if we ever try to do anything with the supply again.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151201/ae881dca/attachment-0001.sig>
