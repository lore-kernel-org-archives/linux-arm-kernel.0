From: marex@denx.de (Marek Vasut)
Date: Mon, 31 Mar 2014 11:36:49 +0200
Subject: [PATCH 2/8] PCI: designware: split Exynos and i.MX bindings
In-Reply-To: <1396258109.5533.11.camel@weser.hi.pengutronix.de>
References: <1396025579-14344-1-git-send-email-l.stach@pengutronix.de>
 <201403301936.49692.marex@denx.de>
 <1396258109.5533.11.camel@weser.hi.pengutronix.de>
Message-ID: <201403311136.49280.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, March 31, 2014 at 11:28:29 AM, Lucas Stach wrote:
> Am Sonntag, den 30.03.2014, 19:36 +0200 schrieb Marek Vasut:
> > On Friday, March 28, 2014 at 05:52:53 PM, Lucas Stach wrote:
> > > The glue around the core designware IP is significantly
> > > different between the Exynos and i.MX implementation,
> > > which is reflected in the DT bindings.
> > > 
> > > This changes the i.MX6 binding to reuse as much as
> > > possible from the common designware binding and
> > > removes old cruft.
> > > 
> > > I removed the optional GPIOs with the following reasoning:
> > > - disable-gpio: endpoint specific GPIO, not currently
> > > 
> > >   wired up in any code. Should be handled by the PCI device
> > >   driver, not the host controller driver.
> > > 
> > > - wake-up-gpio: same as above.
> > > - power-on-gpio: No user in any upstream DT. This should
> > > 
> > >   be handled by a regulator which shouldn't be controlled
> > >   by the host driver, but rather by the PCI device driver.
> > 
> > This power-on-gpio should indeed be handled by the regulator, but the
> > regulator cannot be handled by the PCIe device driver. This
> > power-on-gpio must be operated on per-slot basis if I understand it
> > correctly, so it cannot be controlled by the host controller driver
> > either.
> > 
> > The reason why this cannot be controlled by the device driver is that if
> > the device is powered down, it won't be detected on the PCIe bus, thus
> > it cannot enable the regulator which will power up the slot the device
> > is sitting in.
> 
> So we are on the same page with regard to a GPIO being the wrong
> abstraction for this, I think.

Yes.

> For the regulator part I would argue that PCI is a bus that is built
> around the ability to inspect the bus and detect devices on the bus at
> probe time, so any regulator that's powering a PCI device should be
> boot-on.

This thing about regulator being boot-on should really be documented.

Moreover, I think it's a waste of power to keep the devices ON on boot even if 
the PCIe bus was not started (yet). The bus might not be started at all and the 
regulators would still be ON, which would be quite a waste.

> Only after the device driver is loaded it should be able to fetch the
> regulator to power down/up the device as it wishes. In the x86 world
> this is AFAIK done using ACPI methods.
> 
> I think the host controller driver has no business in controlling the
> device power, more so as there possibly could be a lot of devices on the
> bus even with a single host lane.

The power should be controlled per-slot, but I don't know how to model that. 
Note that there might be a PCIe device with a switch popped into a single slot, 
which makes things much more interesting. In such case, you need to power up the 
slot and neither of the downstream devices should control the power regulator of 
that slot.

> > btw. am I blind or do I just not see devicetree-discuss on CC ?
> 
> Hm, there is devicetree at vger.kernel.org on CC, which MAINTAINER says is
> the right list for this stuff.

OK, I was blind, sorry.

Best regards,
Marek Vasut
