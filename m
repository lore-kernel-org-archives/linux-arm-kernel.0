From: broonie@kernel.org (Mark Brown)
Date: Thu, 23 Oct 2014 00:51:33 +0100
Subject: [PATCH] RFC: add function for localbus address
In-Reply-To: <54483746.9060104@codeaurora.org>
References: <20140729234522.E9FF1C40738@trevor.secretlab.ca>
 <1409672700-21697-1-git-send-email-svarbanov@mm-sol.com>
 <20140908145204.8ADC2C40AE5@trevor.secretlab.ca>
 <540E1014.8090102@codeaurora.org>
 <20140914044610.913E9C4102A@trevor.secretlab.ca>
 <54483746.9060104@codeaurora.org>
Message-ID: <20141022235133.GJ2344@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 22, 2014 at 04:01:26PM -0700, Stephen Boyd wrote:

> >> "Currently a bunch of I2C/SPI MFD drivers are using IORESOURCE_IO for
> >> register address ranges. Since this causes some confusion due to the
> >> primary use of this resource type for PCI/ISA I/O ports create a new
> >> resource type IORESOURCE_REG."

> > Sorry, I mistook IORESOURCE_REG or IORESOURCE_IO. You're right, this
> > isn't an issue.

> > I'm still concerned about the implications of automatically populating
> > platform_devices with this resource type. I'll talk to Mark about it
> > face to fact at Connect this week.

Hrm, missed that discussion.

> Where did this end up? When we talked at Connect I think we settled on
> exploring a driver core specific API like dev_get_localbus_address()
> that calls of_get_localbus_address() for devices with an of_node and in

...

> That's fine, but I still think we want to have the IORESOURCE_REG
> resources given that we have drivers in-flight and some already merged
> that are using the IORESOURCE_REG resource. Furthermore, ACPI is using

Right, IORESOURCE_REG was the original solution to the overlapping use
of IORESOURCE_IO (rather than having multiple IORESOURCE_IO trees since
we do special magic for IORESOURCE_IO for legacy reasons which was
causing issues but the idea of doing it for generic I/O make sense).

> the platform bus for MFDs so it's not like we're going to be using a
> different bus in the future for these pmic sub-device drivers if we
> decide to do pmic devices in ACPI (looks like there is at least
> precedence for that with Intel's i2c pmic). Supporting this on ACPI is
> going to take the same effort if we plumb it into the resource table or
> we plumb it into a new driver core API, so the bus agnostic angle isn't

Even if we do these things in ACPI it's not at all clear to me that the
idea of putting the internals of the device in ACPI would be at all
tasteful there.  Personally I'm not a big fan of always doing it in DT
either but it's more tasteful there and definitely does make sense for
some things.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141023/b0fc03ac/attachment.sig>
