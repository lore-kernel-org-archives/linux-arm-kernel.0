From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Wed,  7 May 2014 19:58:33 +0200
Subject: [PATCH v2 0/2] i2c: sunxi: add P2WI controller support
Message-ID: <1399485515-11243-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This series adds support for the P2WI block used by some Allwinner
boards to interface with the AXP221 PMIC.

I'm still not sure on how this bus should be integrated into the I2C
subsystem:
There was a discussion about adding new I2C flags: [1], but, I want
to reuse the existing axp209 driver [2] which in turn uses a regmap,
and the regmap over I2C driver does not support setting specific flags
when launching I2C transfer (thought this could be added to the regmap
code ;-)).

I decided to get rid of these new flags (I2C_PUSHPULL,
I2C_M_DROP_ADDRESS, ...) in my first proposal, but let me know if
you think this should be re-introduced.

Most of the parts missing in v1 have been implemented:
 - the bus frequency config:
   the requested frequency is retrieved from DT and configured according
   to the P2WI parent clk rate.
 - the initialization (or I2C to P2WI mode switch) process:
   the mode register and mode value needed to launch the initialization
   are both retrieved from DT ("allwinner,p2wi-mode-reg" and
   "allwinner,p2wi-mode-val" properties on the first child node of the
   P2WI bus)
 - address consistency check:
   The slave address is now retrieved from the DT ("reg" property) during
   probe and stored in the p2wi struct.
   This slave address is then checked for each transfer.


Best Regards,

Boris

Changes since v1:
- implement P2WI initilization
- implement P2WI bus frequency configuration
- implement address consistency check
- fix devm_request_and_ioremap return check
- rework the macro definitions
- fix typos

[1] http://www.spinics.net/lists/linux-i2c/msg15066.html
[2] http://comments.gmane.org/gmane.comp.hardware.netbook.arm.sunxi/8947
Boris BREZILLON (2):
  i2c: sunxi: add P2WI DT bindings documentation
  i2c: sunxi: add P2WI (Push/Pull 2 Wire Interface) controller support

 .../devicetree/bindings/i2c/i2c-sunxi-p2wi.txt     |  27 ++
 drivers/i2c/busses/Kconfig                         |  12 +
 drivers/i2c/busses/Makefile                        |   1 +
 drivers/i2c/busses/i2c-sun6i-p2wi.c                | 375 +++++++++++++++++++++
 4 files changed, 415 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-sunxi-p2wi.txt
 create mode 100644 drivers/i2c/busses/i2c-sun6i-p2wi.c

-- 
1.8.3.2
