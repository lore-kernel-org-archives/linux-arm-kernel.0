From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 15 Feb 2014 13:18:02 +0100
Subject: [PATCH 1/3] mmc: add support for power-on sequencing through DT
In-Reply-To: <1626419.Ta3A7zgHIt@wuerfel>
References: <1390190215-22700-1-git-send-email-olof@lixom.net>
 <20140213144106.GW26684@n2100.arm.linux.org.uk> <1626419.Ta3A7zgHIt@wuerfel>
Message-ID: <3871646.18hjUjnpmg@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 13 February 2014 17:13:14 Arnd Bergmann wrote:
> 
> Aside from the power-on problem, my suggestion would at the same
> time solve the second problem of having a place to stick arbitrary
> DT properties for the sdio function. Again looking at the cw1200
> example, they may require passing an IRQ descriptor, a MAC address,
> the device clock rate, and two flags for things that are not
> detectable by looking at the device ID (whether a 5GHz antenna is
> connected and something about odd block size transfers).
> This is probably the main difference between the two approaches.

I just realized one more thing: Some devices have multiple
alternative bus interfaces and it would be nice to use just
one binding for the device, independent of the interface.

If a wlan adapter has both SPI and SDIO front-ends, the external
dependencies (reset, clock, voltage, ...) will be the same, and
from the kernel perspective the main difference is that SPI cannot
be probed at all, while SDIO can be probed as long as the device
is powered on already. If we do what I suggested and add a way to
the SDIO core to probe a device just from DT information, both
the binding and much of the device driver code can be shared
between the bus front-end glues, which would not be possible
if we rely on the SDIO bus probe and add the power-on sequencing
to the SDIO core.

	Arnd
