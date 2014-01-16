From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 16 Jan 2014 13:36:49 +0000
Subject: How to support SDIO wifi/bt in DT
Message-ID: <20140116133649.GV15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Okay, I'm hitting something of a dead end with trying to work out how to
support this in DT.

The Wifi/BT (bcrmfmac) device has multiple connections to the host device
- it has a SDIO connection, a UART connection, and an audio connection.
In addition, a series of GPIOs are wired to control this device:

- Reset for bluetooth plus two additional GPIOs (unused I think)
- Reset for Wifi plus two additional GPIOs (again, I think unused)
- GPIO to control regulator supplying power to the Wifi/BT chip
- GPIO to control regulator supplying power to the oscillator for
  the Wifi/BT chip.

The Wifi/BT chip can only be detected via probing the SDIO connection, and
only when the device has been powered up and released from reset - so we
have to power up and reset the bcrm device before we probe via the SDIO
bus.

While it's possible to attach the power supply for the Wifi/BT chip to the
vmmc-supply property of the host, it's not possible to do that with the
oscillator supply.  Neither is there any provision for manipulating the
GPIOs to deal with the resets.

I can't find any examples of anything similar in our existing set of DT
files, so I suspect either this is a device which no one supports on any
DT platform, or there's some clever way to handle this.

How do other people support this in DT?  Do they hack up some platform
specific code (which isn't nice)?  What other solutions are there to get
around this problem?  How does this kind of thing get represented in DT?

(Don't suggest adding DT support to the bcrmfmac driver - this is a
chicken-and-egg problem.  The driver isn't being probed at the moment
because the device is powered down and/or held in reset, so is
undetectable.  The kernel needs to power it up and release the reset
so it becomes detectable.)

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
