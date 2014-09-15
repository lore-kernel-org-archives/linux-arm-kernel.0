From: broonie@kernel.org (Mark Brown)
Date: Mon, 15 Sep 2014 09:12:12 -0700
Subject: [RFC PATCH for Juno 1/2] net: smsc911x add support for probing
 from ACPI
In-Reply-To: <20140915041404.A72CCC40A02@trevor.secretlab.ca>
References: <1409583961-7466-1-git-send-email-hanjun.guo@linaro.org>
 <1409583961-7466-2-git-send-email-hanjun.guo@linaro.org>
 <20140901170447.GF608@arm.com> <21764799.KDNDm9XRax@wuerfel>
 <20140915041404.A72CCC40A02@trevor.secretlab.ca>
Message-ID: <20140915161212.GQ7960@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 14, 2014 at 09:14:04PM -0700, Grant Likely wrote:
> On Mon, 01 Sep 2014 19:11:44 +0200, Arnd Bergmann <arnd@arndb.de> wrote:

> > > > +     config->phy_interface = PHY_INTERFACE_MODE_MII;

> > > > +     config->flags |= SMSC911X_USE_32BIT;

> > > > +     config->irq_polarity = SMSC911X_IRQ_POLARITY_ACTIVE_HIGH;

> > > > +     config->irq_type = SMSC911X_IRQ_TYPE_PUSH_PULL;

> > > > +     return 0;
> > > > +}

...

> > There is of course the possibility to set those values based on the
> > acpi_device_id, but that is exactly the part that _DSD is trying to
> > avoid.

> These are merely defaults. DSD parsing, when implemented, would be
> override these default values.

One note of caution here: I do agree that default settings are good but
it's worth having clear rules for how we pick the defaults, and advice
for maintainers on how to pick those rules.  If there's a default people
often want to pick it to match their particular system and it can
sometimes be hard for the maintainer to identify if a given tweak
someone is proposing in the defaults might break some other existing
system.  Having clear guidelines for picking the defaults avoids
arguments and breakage.

The two basic rules I've seen are that we either follow the defaults
the hardware has after reset or we follow the state the hardware is left
in when the kernel starts.  Neither is perfect and sometimes the
bootloader option just doesn't make sense at all but they're at least
clear and simple to understand.

It's not the end of the world to do something else, and sometimes the
way systems are done just doesn't lend itself to providing clear rules,
but if we encourage people to set them they can save grief.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140915/17641002/attachment.sig>
