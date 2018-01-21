From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 21 Jan 2018 02:08:40 +0100
Subject: [net-next: PATCH 0/8] Armada 7k/8k PP2 ACPI support
In-Reply-To: <20180120195246.GC27654@lahna.fi.intel.com>
References: <20180108151453.GB31502@xora-haswell>
 <20180108154243.GA30962@lunn.ch>
 <CAPv3WKewA+7WabMYN1w=9fOxe6zOKDbxcjX0VipumQmfZtJKjQ@mail.gmail.com>
 <20180109101941.GD31502@xora-haswell>
 <CAPv3WKehwsrxuxemgL_5fKtUT2xjqkE6yf9DMcCcO2WRJ6nQaQ@mail.gmail.com>
 <20180109130012.GA27447@lunn.ch>
 <20180118123141.GA2839@e107981-ln.cambridge.arm.com>
 <20180118130026.GG32299@lunn.ch>
 <CAPv3WKcYrbfKjsnwZ39Tyq3HN0aneUQZdbeUzLbFgLUbMc3w8Q@mail.gmail.com>
 <20180120195246.GC27654@lahna.fi.intel.com>
Message-ID: <20180121010840.GB1217@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I'm not familiar with MDIO bus but an alternative to GeneriSerialBus
> would be to follow what SDIO is doing, e.g have the PHY devices listed
> below the MDIO controller and use _ADR to describe their "address" on
> that bus. You can see how _ADR applies to SDIO bus from ACPI spec.

Hi Mika

SDIO is not a serial bus, well it can be in its simplest form, but
high speed implementations have 4 data lines. So i can understand them
not using GenericSerialBus.

MDIO is a serial bus, very similar to SPI, I2C, and UART.

> If you go with the SDIO way then each PHY is described as normal ACPI
> device and you can use ACPI _HID/_CID to match the device to the
> corresponding driver.

Just some background here. If you have a plain PHY as a device on an
MDIO bus, you don't need to match it to a driver within ACPI.
Registers 2 and 3 contain a vendor and product ID. That is what it
used to match the device to the driver.

What you might need to know is the protocol to talk on the bus. Most
devices use clause 22 protocol. A few devices are clause 45. 22 is the
default in Linux, and you need to indicate if 45 should be used. You
can also indicate 22.

It gets more complex when the device on the bus is not a PHY. It is a
generic bus, you can connect anything to it. Ethernet switches can be
on the bus. They generally cannot be identified using registers 2 and
3. So you do need to match the device to the driver. Most do have ID
registers, so the driver can work out what specific device is on the
bus. However, Marvell moved the ID registers on there newer generation
of devices, so we need to give the driver a hint where to look. So in
device tree, we have two different compatible string.

Broadcom really do use it as a generic bus. They have their USB PHYs
and PCIE PHYs on an MDIO bus. In DT, they have compatible strings to
match the device to the driver, as normal.

We need to ensure what we define for ACPI has the same level of
flexibility.

	Andrew
