From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 23 Mar 2011 11:03:34 +0100
Subject: [PATCH 0/6] use AMBA periphid for hardcoding
Message-ID: <1300874614-14675-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

These patches swithches the semantics of the optional AMBA periphid
field from fallback (when hardware ID is not found) to hardcoding
(overriding hardware ID) when used in platform data.

The reason is that we have hardware with valid but incorrect
periphids that need to be corrected from the platform.

Linus Walleij (4):
      mach-netx: delete hardcoded periphid
      mach-ux500: delete SSP PrimeCell ID
      amba: make hardcoded periphid override hardware
      mach-ux500: force PrimeCell revisions

Philippe Langlais (2):
      spi/pl022: Add loopback support for the SPI on 5500
      mmci: support for ST-Ericsson db8500v2

 arch/arm/mach-netx/fb.c                     |    1 -
 arch/arm/mach-ux500/board-mop500-sdi.c      |   16 +++++++++---
 arch/arm/mach-ux500/devices-common.h        |   10 ++++---
 arch/arm/mach-ux500/devices-db5500.h        |   28 +++++++++++++++-------
 arch/arm/mach-ux500/devices-db8500.h        |   34 +++++++++++++-------------
 arch/arm/mach-ux500/include/mach/hardware.h |    3 --
 drivers/amba/bus.c                          |    5 ++++
 drivers/mmc/host/mmci.c                     |   25 ++++++++++++++++++-
 drivers/spi/amba-pl022.c                    |   20 +++++++++++++++-
 9 files changed, 101 insertions(+), 41 deletions(-)

Details:

A review of existing platforms (found below) give at hand that this
change of semantics should be OK.

In order to assure this does not break anything I analyzed the
ARM tree.

Case by case breakdown as done by:
$ grep -r periphid arch/arm/

./mach-netx/fb.c:	.periphid	= 0x10112400,

This is hardcoding the CLCD driver to a periphid that the
current driver in drivers/video/amba-clcd.c does not support,
either it's a hook for out-of-tree code or just plain junk
because the right periphid is actually in the hardware.

DELETE in [1/6]

./mach-omap2/emu.c:	.periphid	= 0x000bb907,
./mach-omap2/emu.c:	.periphid	= 0x102bb921,

Valid hardcoding that will make the driver in
arch/arm/kernel/etm.c prope correctly. If the value is
actually in hardware it is superfluous but won't hurt.

./mach-ep93xx/core.c:	.periphid	= 0x00041010,
./mach-ep93xx/core.c:	.periphid	= 0x00041010,
./mach-ep93xx/core.c:	.periphid	= 0x00041010,

After hearing that the EP93xx engineers has set these
PrimeCell IDs to 0x00000000 on other components I suspect
these are necessary and valid hardcoding values for the
driver to probe and should be left as such.

./mach-lh7a40x/clcd.c:	.periphid = pid,

This is hardcoding the PrimeCell ID to the only number
that the CLCD driver supports, so doesn't hurt, the only
case would be if the silicon actually contains a newer version
of the PrimeCell that is not supposed to probe, which is
highly unlikely. If the ID is ther in the hardware this
is just surplus information.

./mach-aaec2000/core.c:	.periphid	= 0x41110,

Probably valid for the same reasons as EP93XX.

./mach-integrator/impd1.c:		d->periphid	= idev->id;
./mach-integrator/integrator_cp.c:	.periphid	= 0,
./mach-integrator/integrator_cp.c:	.periphid	= 0,
./mach-integrator/integrator_cp.c:	.periphid	= 0,
./mach-integrator/core.c:	.periphid	= 0x00041030,
./mach-integrator/core.c:	.periphid	= 0x0041010,
./mach-integrator/core.c:	.periphid	= 0x0041010,
./mach-integrator/core.c:	.periphid	= 0x00041050,
./mach-integrator/core.c:	.periphid	= 0x00041050,

OK so the integrator is hardcoding everything. This is likely
because the silicon predates the era where ARM started to add these
magic number in the silicon. Dumping some memory in the boot
monitor on the Integrator/AP gives this result:

Displaying memory at 0x18000000
0x18000000: 0x00000000
0x18000004: 0x00000003
0x18000008: 0x00000000
0x1800000C: 0x00000002
0x18000010: 0x00000000
0x18000014: 0x00000000
0x18000018: 0x00000000
0x1800001C: 0x00000000
boot Monitor > d 0x13000fe0
Displaying memory at 0x13000FE0
0x13000FE0: 0x00000000
0x13000FE4: 0x00000000
0x13000FE8: 0x00000000
0x13000FEC: 0x00000000
0x13000FF0: 0x00000000
0x13000FF4: 0x00000000
0x13000FF8: 0x00000000
0x13000FFC: 0x00000000

No peripheral ID:s on the Integrator/AP. They may be present on
the Integrator/CP for what I know, but hardcoding them will not
hurt as far as I can tell.

./mach-ux500/devices-common.c:		       int irq, void *pdata, unsigned int periphid)
./mach-ux500/devices-common.c:	dev->periphid = periphid;
./mach-ux500/devices-common.h:		       int irq, void *pdata, unsigned int periphid);

Surplus. All but one call set it to 0 anyway.
Patch [2/6] removes all traces of it, and patch [4/4]
fixes this up the proper way.

Yours,
Linus Walleij
