From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue, 21 Jun 2016 12:02:45 +0200
Subject: [RFC PATCH v2 0/9] scpi: Add SCPI registry to handle legacy protocol
Message-ID: <1466503374-28841-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset aims to support the legacy SCPI firmware implementation that was
delivered as early technology preview for the JUNO platform.

Finally a stable, maintained and public implementation for the SCPI protocol
has been upstreamed part of the JUNO support and it is the recommended way
of implementing SCP communication on ARMv8 platforms.

The Amlogic GXBB platform is using this legacy protocol, as the RK3368 & RK3399
platforms. Only the GXBB example is provided here, but it's unclear if other
Amlogic ARMv8 based SoCs uses this legacy procotol.

In order to support the legacy protocol :
 - Move the scpi_get_ops to a thin registry layer
 - Change the arm_scpi.c to use the registry layer
 - Add a separate config option to build the registry layer
 - Add the legacy SCPI driver based on the new implementation
 - For example, add the Amlogic GXBB MHU and SCPI DT cpufreq & sensors nodes

Initial RFC discution tread can be found at https://lkml.org/lkml/2016/5/26/111

Neil Armstrong (9):
  mailbox: Add Amlogic Meson Message-Handling-Unit
  dt-bindings: mailbox: Add Amlogic Meson MHU Bindings
  ARM64: dts: meson-gxbb: Add Meson MHU Node
  firmware: Add a SCPI registry to handle multiple implementations
  firmware: scpi: Switch arm_scpi to use new registry
  firmware: Add legacy SCPI protocol driver
  dt-bindings: arm: Update arm,scpi bindings with Meson GXBB SCPI
  ARM64: dts: meson-gxbb: Add SRAM node
  ARM64: dts: meson-gxbb: Add SCPI with cpufreq & sensors Nodes

 Documentation/devicetree/bindings/arm/arm,scpi.txt |   8 +-
 .../devicetree/bindings/mailbox/meson-mhu.txt      |  33 ++
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi        |  53 ++
 drivers/firmware/Kconfig                           |  24 +
 drivers/firmware/Makefile                          |   2 +
 drivers/firmware/arm_scpi.c                        |  14 +-
 drivers/firmware/legacy_scpi.c                     | 644 +++++++++++++++++++++
 drivers/firmware/scpi.c                            |  94 +++
 drivers/mailbox/Makefile                           |   2 +
 drivers/mailbox/meson_mhu.c                        | 199 +++++++
 include/linux/scpi_protocol.h                      |  15 +-
 11 files changed, 1075 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mailbox/meson-mhu.txt
 create mode 100644 drivers/firmware/legacy_scpi.c
 create mode 100644 drivers/firmware/scpi.c
 create mode 100644 drivers/mailbox/meson_mhu.c

-- 
2.7.0
