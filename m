From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 24 Feb 2015 18:29:00 +0800
Subject: [PATCH 0/4] i2c: sunxi: Add Reduced Serial Bus (RSB) support
Message-ID: <1424773744-15106-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This series adds support for the Reduced Serial Bus (RSB)
controller found on newer Allwinner SoCs, such as the A23
or A80. The RSB is used to communicate with companion ICs,
notably the bundled PMIC.

RSB is an improvement over P2WI that was found on the A31
SoC. The main new feature is support for multiple slave
devices on the same bus, using addresses that are configured
at runtime. The slave devices also have a hardware address,
which is only used when setting the runtime address.

Like the P2WI, the RSB is an SMBus like interface, supporting
byte, word and double-word transfers only. However, the wire
protocol is different so only RSB compatible devices can be
used. This class currently consists of the AXP223, AXP806,
AXP809 PMICs, and the AC100 audio codec, all from X-Powers.

Following the P2WI driver, we hope this driver can be integrated
into the I2C subsystem as well.


Patch 1 adds the driver supporting RSB.

Patch 2 documents the device tree bindings for the driver.

Patch 3 adds a device node for RSB to the A23 dtsi.

Patch 4 enables the RSB for the only supported A23 device.

Only the A23 is enabled at the moment. The A80 uses the same
IP block with no differences, but the related clock/reset/pinctrl
drivers are still WIP.


Regards,
ChenYu

Chen-Yu Tsai (4):
  i2c: sunxi: Add Reduced Serial Bus (RSB) support
  i2c: sunxi: Add Reduced Serial Bus (RSB) DT bindings documentation
  ARM: dts: sun8i: Add Reduced Serial Bus controller device node to A23
    dtsi
  ARM: dts: sun8i: ippo-q8h-v5: Enable Reduced Serial Bus controller

 .../devicetree/bindings/i2c/i2c-sunxi-rsb.txt      |  50 +++
 arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts        |   4 +
 arch/arm/boot/dts/sun8i-a23.dtsi                   |  21 +
 drivers/i2c/busses/Kconfig                         |  12 +
 drivers/i2c/busses/Makefile                        |   1 +
 drivers/i2c/busses/i2c-sunxi-rsb.c                 | 458 +++++++++++++++++++++
 6 files changed, 546 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-sunxi-rsb.txt
 create mode 100644 drivers/i2c/busses/i2c-sunxi-rsb.c

-- 
2.1.4
