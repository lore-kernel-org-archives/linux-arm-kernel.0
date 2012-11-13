From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 13 Nov 2012 16:57:35 +0900
Subject: [PATCH 1/1] regulator: gpio-regulator: fix crash when no states
 property in dt
In-Reply-To: <CAHrpEqSbydeAHngL-NMfQa1HQUsj0US5u=aK6y-ku0DMOW-KkA@mail.gmail.com>
References: <1352450076-22682-1-git-send-email-Frank.Li@freescale.com>
 <20121109165609.GV23807@opensource.wolfsonmicro.com>
 <CAHrpEqSbydeAHngL-NMfQa1HQUsj0US5u=aK6y-ku0DMOW-KkA@mail.gmail.com>
Message-ID: <20121113075733.GN18224@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 12, 2012 at 09:56:47AM +0800, Frank Li wrote:
> 2012/11/10 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> > On Fri, Nov 09, 2012 at 04:34:36PM +0800, Frank Li wrote:

> >>       /* Fetch states. */
> >>       prop = of_find_property(np, "states", NULL);
> >> -     proplen = prop->length / sizeof(int);
> >> +     proplen = prop ? prop->length / sizeof(int) : 0;

> > Aren't states mandatory for this driver, in which case shouldn't the
> > probe fail here?

> I think No.  GPIO-Regulator can be used as just turn on/off power
> domain and not adjust voltage or current.  So "states" is option.
> "gpios" was already options.

Are you sure this actually works?  I glanced at the code and wasn't
convinced it was taking sufficient care to cope with this possibility.
Normally people use a fixed regulator for a regulator with a simple
on/off switch (which allows the voltage to be specified which this
won't...) so I'd be somewhat surprised if it were tested.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121113/d211d11f/attachment.sig>
