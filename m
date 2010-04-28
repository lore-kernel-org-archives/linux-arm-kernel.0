From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Wed, 28 Apr 2010 23:47:53 +0200
Subject: PCI Express MSI support on Kirkwood?
In-Reply-To: <q2lc384c5ea1004281434x8083ea2ak90c61266d44ee3f7@mail.gmail.com>
References: <r2oc384c5ea1004150237w99d31004r986829697b019e59@mail.gmail.com>
	<g2ic384c5ea1004210555i3ba44b35xf58c233be742be2f@mail.gmail.com>
	<20100421131434.GZ4586@mail.wantstofly.org>
	<q2lc384c5ea1004281434x8083ea2ak90c61266d44ee3f7@mail.gmail.com>
Message-ID: <20100428214753.GB4586@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 28, 2010 at 11:34:14PM +0200, Leon Woestenberg wrote:

> Hello Lennert,

Hello Leon,

Removing the openrd@ group from the CC as it's a closed group.
Removing nico at marvell.com from the CC as Nico is no longer with Marvell.


> >> I'm interested in PCI Express MSI support for Linux / Kirkwood, has
> >> this been addressed yet in any of the GIT trees?
> >
> > It hasn't been done yet as far as I know.
> >
> > I don't think KW was designed with MSI in mind, but it can perhaps be
> > done (MSI with up to 16 messages but without multiple message enable,
> > or MSI-X with up to 32 system-wide messages) if you use the interrupt
> > controller Doorbell interrupts for this purpose.
> 
> The datasheet mentions support for Root Complex mode as well, but does
> not any specific address for the Message Address Register,

The Root Complex doesn't need to have an MSI or MSI-X capability
structure -- it's a property of the endpoint (which generates
interrupts).


> so that would mean I could use any (allocated) piece of system RAM,
> for example?

Yes, but the whole point is that the write to the special MSI
address will generate an interrupt to the host CPU, while if you fill
in a PCI bus address corresponding to system RAM, you'd then have to
poll that RAM location to see if interrupts occured.

(Be careful when choosing the MSI address -- if any MSI write is
terminated with an abort, you end up triggering SERR#.)


> "6.1.1 Message Signaled Interrupts (MSI)
> Message Signaled Interrupts (MSI) are supported in both Root Complex
> and Endpoint modes.
> Root Complex mode: The Host sets the PCI Express MSI Message Address Register
>                       (Table 288 p. 461) to the same value that it has
> set the Endpoint device.
>                       A memory write received, with the same address,
> is handle as an MSI.
>                       Upon receipt of MSI, an interrupt is set in the
> <RcvMsi> field in the PCI
>                       Express Interrupt Cause Register (Table 320 p.
> 487). Interrupt data is
>                       saved in the PCI Express MSI Message Data Register
>                       (Table 290 p. 461).
> "

Where is this from?  (This doesn't appear in my copy of the Kirkwood
functional spec at least.)

The address match described here is cute, but the fact that it saves
the data in a single register appears to make it kind of useless for
use with multiple interrupt sources.  (You're likely still better off
with the doorbell registers, as they can collapse multiple events and
will never overflow.)
