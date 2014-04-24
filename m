From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Thu, 24 Apr 2014 13:55:14 +0200
Subject: [PATCH 0/2] i2c: sunxi: add P2WI controller support
Message-ID: <1398340516-29547-1-git-send-email-boris.brezillon@free-electrons.com>
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

Moreover, some parts are missing (either because I need some informations
on the HW blocks or because I don't know how it should be done):
 - the bus frequency config (the current version hardcode the bus frequency
   config):
   I need informations about the clk tree used by APB0 clks in order to
   properly implement missing clk drivers and define missing DT nodes.
 - the initialization (or I2C to P2WI mode switch) process:
   A specific value has to be written in one of the slave device register
   to switch the device from I2C to P2WI mode.
   The switch process is handled by the P2WI controller block (using the
   P2WI_PMCR register).
   The problem is that I don't know which register should be written and
   what's the value to switch to the P2WI mode (only the device driver
   knows it).
   How about encoding this in the DT, and then parse the child node
   during probe ?
 - address consistency check:
   I don't know when the slave device address should be saved in the p2wi
   struct (during probe using DT child node informations, at the first
   transfer, ...)



Best Regards,

Boris

[1] http://www.spinics.net/lists/linux-i2c/msg15066.html
[2] http://comments.gmane.org/gmane.comp.hardware.netbook.arm.sunxi/8947

Boris BREZILLON (2):
  i2c: sunxi: add P2WI DT bindings documentation
  i2c: sunxi: add P2WI (Push/Pull 2 Wire Interface) controller support

 .../devicetree/bindings/i2c/i2c-sunxi-p2wi.txt     |  27 ++
 drivers/i2c/busses/Kconfig                         |  12 +
 drivers/i2c/busses/Makefile                        |   1 +
 drivers/i2c/busses/i2c-sunxi-p2wi.c                | 317 +++++++++++++++++++++
 4 files changed, 357 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-sunxi-p2wi.txt
 create mode 100644 drivers/i2c/busses/i2c-sunxi-p2wi.c

-- 
1.8.3.2
