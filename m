From: stephen.neuendorffer@xilinx.com (Stephen Neuendorffer)
Date: Tue, 17 May 2011 13:28:33 -0700
Subject: device_tree binding for "amba bus"
Message-ID: <f9ae780a-2747-427f-826a-e0b510ca8afb@VA3EHSMHS001.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Grant,

I've taken a quick look at the arm trace buffer driver
(arch/arm/kernel/etm.c).
This driver uses the amba bus driver (drivers/amba/bus.c).
It appears that this driver does three things:

1) ensures that the clock named "apb_pclk" is running.
2) ensures that the regulator named "vcore" is on.
3) queries the core to verify that a hardcoded register has the correct
value.

None of this seems terribly interesting enough to justify a bus that has
a
small number of users:

drivers/tty/serial/amba-pl010.c, line 788
drivers/tty/serial/amba-pl011.c, line 1477
drivers/input/serio/ambakmi.c, line 197
drivers/watchdog/sp805_wdt.c, line 359
drivers/rtc/rtc-pl031.c, line 478
drivers/rtc/rtc-pl030.c, line 183
drivers/char/hw_random/nomadik-rng.c, line 97
drivers/mmc/host/mmci.c, line 1049
drivers/video/amba-clcd.c, line 538
drivers/gpio/pl061.c, line 344
drivers/spi/amba-pl022.c, line 2284
drivers/dma/amba-pl08x.c, line 2062
drivers/dma/pl330.c, line 841
sound/arm/aaci.c, line 1125
arch/arm/kernel/etm.c:
line 421
line 625

And at the very least the hardcoded nature of the names seems, well...
hardcoded.

Any thoughts about how to abstract this in a device tree?
(My thoughts: devices need to reference a clock, devices need to
reference a regulator,
and it seems to me that the register check could be pulled out into a
single call that the
devices that care about it can do themselves during probe() )

Steve


This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
