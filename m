From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 19 Aug 2015 12:20:01 +0800
Subject: [PATCH v3 0/8] ARM: sunxi: Add Reduced Serial Bus support
Message-ID: <1439958009-14056-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This is my third attempt at adding support for Allwinner's Reduced
Serial Bus (RSB), which is used to communicate with PMICs and other
peripherals on their newer SoCs, such as the A23/A33/A80.

RSB is a simplified two wire interface using push-pull outputs,
supporting multiple slaves, address and data parity checks, and
clock speeds up to 20 MHz. The bus only supports simple register
read/writes, with possible register sizes of 8/16/32 bits. Access
sizes not matching the slave device register sizes result in NACKs
or errors. 32 bit registers in devices have yet to be seen.

Previous attempts to add support through the I2C subsystem have
been rejected, as the bus line protocol is too different to even
consider. In this version, RSB is implemented as a new bus type,
much like SPMI.

Even though there will almost certainly be only one RSB driver,
it's still split into the bus core framework and vendor specific
driver, like other subsystems. Theoretically someone could
implement a bit-banging driver for it.


Patches 1 & 2 add the DT bindings for common RSB properties and
the controller.

Patches 3 & 4 add the RSB framework core and sunxi driver.

Patch 5 (based on regmap/for-next) adds an RSB regmap driver.

Patch 6 adds the RSB nodes for A23/A33 dtsi.

Patch 7 & 8 enable the RSB controller on the boards I have.


Still to come are axp20x driver support for the RSB based AXP223.
The complete series can be found at:

    https://github.com/wens/linux/tree/sunxi-rsb-v3

Since this is a new subsystem, I'm not sure who should pick up
the first 4 patches, or whether they are even in the right place.
Any suggestions?


Regards,
ChenYu


Chen-Yu Tsai (8):
  rsb: Add generic Reduced Serial Bus (RSB) controller binding
    documentation
  rsb: sunxi: Add Allwinner Reduced Serial Bus (RSB) controller bindings
  rsb: Linux driver framework for Reduced Serial Bus (RSB)
  rsb: sunxi: Add driver for Allwinner Reduced Serial Bus controller
  regmap: rsb: Add support for Reduced Serial Bus (RSB) based regmaps
  ARM: dts: sun8i: Add Reduced Serial Bus controller device node to
    A23/A33 dtsi
  ARM: dts: sun8i: ippo-q8h-v5: Enable Reduced Serial Bus controller
  ARM: dts: sun8i: sinlinx-sina33: Enable Reduced Serial Bus controller

 .../devicetree/bindings/rsb/rsb-sunxi.txt          |  34 ++
 Documentation/devicetree/bindings/rsb/rsb.txt      |  50 ++
 arch/arm/boot/dts/sun8i-a23-a33.dtsi               |  21 +
 arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts        |   4 +
 arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts     |   4 +
 drivers/Kconfig                                    |   2 +
 drivers/Makefile                                   |   1 +
 drivers/base/regmap/Kconfig                        |   6 +-
 drivers/base/regmap/Makefile                       |   1 +
 drivers/base/regmap/regmap-rsb.c                   | 121 +++++
 drivers/rsb/Kconfig                                |  26 ++
 drivers/rsb/Makefile                               |   6 +
 drivers/rsb/rsb-core.c                             | 511 +++++++++++++++++++++
 drivers/rsb/rsb-sunxi.c                            | 441 ++++++++++++++++++
 include/linux/regmap.h                             |  36 ++
 include/linux/rsb.h                                | 144 ++++++
 16 files changed, 1407 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/rsb/rsb-sunxi.txt
 create mode 100644 Documentation/devicetree/bindings/rsb/rsb.txt
 create mode 100644 drivers/base/regmap/regmap-rsb.c
 create mode 100644 drivers/rsb/Kconfig
 create mode 100644 drivers/rsb/Makefile
 create mode 100644 drivers/rsb/rsb-core.c
 create mode 100644 drivers/rsb/rsb-sunxi.c
 create mode 100644 include/linux/rsb.h

-- 
2.5.0
