From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Tue,  3 Oct 2017 01:28:00 +0200
Subject: [PATCH v2 0/4] Amlogic Meson6/Meson8/Meson8b efuse support
Message-ID: <20171002232804.20042-1-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series implements a driver for the efuse found on the Amlogic
Meson6/Meson8/Meson8b SoCs.
A new driver is needed because the existing "meson-efuse" driver
communicates through the "secure monitor" firmware with the HW,
while these older SoCs access the hardware registers directly.

An additional patch also explicitly states that the existing
"meson-efuse" driver is only for the Meson GX SoCs by adjusting
the dt-binding docs, Kconfig help texts, etc.

Please note that the dts patch ("ARM: dts: meson: add the efuse node")
is built on top of my other series ("soc: amlogic: Add Meson6/8/8b SoC
Information driver") from: [0]


changes since v1 at [1]:
- removed incorrect clock operations from .probe() and .remove()
  which were left-over from initial development. many thanks to
  Srinivas Kandagatla for the super-fast review and for spotting
  this!
- extended the commit message of patch #3 with a note stating that
  writing is currently not supported by the driver
- updated the .dts patch to include the #size-cells and
  #address-cells properties (which allow adding sub-nodes with the
  actual nvmem cells)


[0] http://lists.infradead.org/pipermail/linux-amlogic/2017-September/004772.html
[1] http://lists.infradead.org/pipermail/linux-amlogic/2017-October/004825.html


Martin Blumenstingl (4):
  dt-bindings: nvmem: Describe the Amlogic Meson6/Meson8/Meson8b efuse
  nvmem: meson-efuse: indicate that this driver is only for Meson GX
    SoCs
  nvmem: add a driver for the Amlogic Meson6/Meson8/Meson8b SoCs
  ARM: dts: meson: add the efuse node

 .../devicetree/bindings/nvmem/amlogic-efuse.txt    |   2 +-
 .../bindings/nvmem/amlogic-meson-mx-efuse.txt      |  22 ++
 arch/arm/boot/dts/meson.dtsi                       |  15 ++
 arch/arm/boot/dts/meson6.dtsi                      |   3 +
 arch/arm/boot/dts/meson8.dtsi                      |   6 +
 arch/arm/boot/dts/meson8b.dtsi                     |   7 +
 drivers/nvmem/Kconfig                              |  14 +-
 drivers/nvmem/Makefile                             |   2 +
 drivers/nvmem/meson-efuse.c                        |   4 +-
 drivers/nvmem/meson-mx-efuse.c                     | 266 +++++++++++++++++++++
 10 files changed, 336 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/nvmem/amlogic-meson-mx-efuse.txt
 create mode 100644 drivers/nvmem/meson-mx-efuse.c

-- 
2.14.2
