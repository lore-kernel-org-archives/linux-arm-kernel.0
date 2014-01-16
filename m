From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 16 Jan 2014 15:02:11 +0100
Subject: How to support SDIO wifi/bt in DT
In-Reply-To: <20140116133649.GV15937@n2100.arm.linux.org.uk>
References: <20140116133649.GV15937@n2100.arm.linux.org.uk>
Message-ID: <3215037.8HVCjAeS8g@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 16 January 2014 13:36:49 Russell King - ARM Linux wrote:

> 
> The Wifi/BT chip can only be detected via probing the SDIO connection, and
> only when the device has been powered up and released from reset - so we
> have to power up and reset the bcrm device before we probe via the SDIO
> bus.

This is indeed a common problem, and while we've talked about solving
it in the past, nothing has happened code-wise. It indeed needs an
implementation in the sdio framework.

> While it's possible to attach the power supply for the Wifi/BT chip to the
> vmmc-supply property of the host, it's not possible to do that with the
> oscillator supply.  Neither is there any provision for manipulating the
> GPIOs to deal with the resets.
> 
> I can't find any examples of anything similar in our existing set of DT
> files, so I suspect either this is a device which no one supports on any
> DT platform, or there's some clever way to handle this.

The former.

> How do other people support this in DT?  Do they hack up some platform
> specific code (which isn't nice)?  What other solutions are there to get
> around this problem?  How does this kind of thing get represented in DT?
> 
> (Don't suggest adding DT support to the bcrmfmac driver - this is a
> chicken-and-egg problem.  The driver isn't being probed at the moment
> because the device is powered down and/or held in reset, so is
> undetectable.  The kernel needs to power it up and release the reset
> so it becomes detectable.)

The problem is two-fold:

a) we need to add a generic mechanism to the SDIO probe code to
allow specifying clocks, regulators and resets (possibly more)
for an SDIO endpoint that get enabled before the probe starts.
This parts needs a DT binding for SDIO slots as well as code.

b) We need to add a way to attach a device_node to an sdio_func,
so that a function driver can find additional DT properties.
This part should be relatively simple once (a) is done and
should only need a little code but no new binding. The code
would be similar to what we do for amba, i2c or spi devices.

Note that the same problem exists for a number of other discoverable
buses that get used in nondiscoverable ways, e.g. USB, PCI, 
or even SCSI. It's normally a spec violation if those devices
are wired up like this, but of course we still want to support
the hardware.

	Arnd
