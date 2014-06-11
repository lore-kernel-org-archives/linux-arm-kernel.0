From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Wed, 11 Jun 2014 11:17:28 +0200
Subject: [PATCH v7 0/2] i2c: sunxi: add P2WI controller support
Message-ID: <1402478250-7292-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This series adds support for the P2WI block used by some Allwinner boards
to interface with the AXP221 PMIC.

The P2WI controller looks like an SMBus controller which only supports byte
data transfers. But, it differs from standard SMBus protocol on several
aspects:
- it supports only one slave device, and thus drop the address field
- it adds a parity bit every 8bits of data
- only one read access is required to read a byte (instead of a write
  followed by a read access in standard SMBus protocol)
- there's no Ack bit after each byte transfer

This means this bus cannot be used to interface with standard SMBus
devices (the only known device to support this interface is the AXP221
PMIC).
However the P2WI protocol is close enough to SMBus to be integrated in
the I2C subsystem (see this thread [1] for detailed reasons that led to
integrating this driver in the I2C subsystem).

[1] http://www.spinics.net/lists/linux-i2c/msg15066.html

Best Regards,

Boris

Changes sinve v6:
- declare as "GPL v2" instead of "GPL"
- add Arnd's ack
- add COMPILE_TEST support

Changes since v5:
- add Maxime's ack
- rework commit message to mention the discussion that led to integrating
  this driver in the I2C subsystem
- add missing dependency on RESET_CONTROLLER
- clean up header inclusions
- fix coding style issues

Changes since v4:
- add P2WI protocol description in driver header comment
- remove unneeded i2c address check
- remove unneeded irq field from p2wi struct

Changes since v3:
- update the DT bindings doc
- fix a comment that was no longer true

Changes since v2:
- drop the initialization (switch from I2C to P2WI mode) part
- print devm_ioremap_resource err code

Boris BREZILLON (2):
  i2c: sunxi: add P2WI DT bindings documentation
  i2c: sunxi: add P2WI (Push/Pull 2 Wire Interface) controller support

 .../devicetree/bindings/i2c/i2c-sunxi-p2wi.txt     |  41 +++
 drivers/i2c/busses/Kconfig                         |  13 +
 drivers/i2c/busses/Makefile                        |   1 +
 drivers/i2c/busses/i2c-sun6i-p2wi.c                | 345 +++++++++++++++++++++
 4 files changed, 400 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-sunxi-p2wi.txt
 create mode 100644 drivers/i2c/busses/i2c-sun6i-p2wi.c

-- 
1.8.3.2
