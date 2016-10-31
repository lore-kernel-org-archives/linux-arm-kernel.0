From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Mon, 31 Oct 2016 15:45:33 +0100
Subject: [PATCH v2 0/5] ARM: da850: new drivers for better LCDC support
Message-ID: <1477925138-23457-1-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds two new drivers in order to better support the LCDC
rev1 present on the da850 boards.

The first patch adds a new memory driver which allows to write to the
DDR2/mDDR memory controller present on the da8xx SoCs.

The second patch adds a new bus driver which allows to interact with
the MSTPRI registers of the SYSCFG0 module

As is mentioned in the comments: we don't want to commit to supporting
stable interfaces (DT bindings or sysfs attributes) so we hardcode the
settings required by some boards (for now only da850-lcdk) with the
hope that linux gets an appropriate framework for performance knobs
in the future.

Potential extensions of these drivers should be straightforward in the
future.

Subsequent patches add DT nodes for the new drivers: disabled nodes
in da850.dtsi and enabled in da850-lcdk.dts.

The last patch adds a workaround for current lack of support for drm
bridges in tilcdc.

Tested on a da850-lcdk with a display connected over VGA and two
additional patches for tilcdc (sent to linux-drm): ran simple modetest
for supported resolutions, used X.org and fluxbox as graphical
environment, played video with mplayer.

v1 -> v2:
- used regular readl()/writel() instead of __raw_** versions
- used resource_size() instead of calculating the size by hand
- used ioremap instead of syscon in patch [2/5]
- added the DT nodes in patches [3/5]-[5/5]

Bartosz Golaszewski (5):
  ARM: memory: da8xx-ddrctl: new driver
  ARM: bus: da8xx-mstpri: new driver
  ARM: dts: da850: add the mstpri and ddrctl nodes
  ARM: dts: da850-lcdk: enable mstpri and ddrctl nodes
  ARM: dts: da850-lcdk: add tilcdc panel node

 .../devicetree/bindings/bus/ti,da850-mstpri.txt    |  20 ++
 .../memory-controllers/ti-da8xx-ddrctl.txt         |  20 ++
 arch/arm/boot/dts/da850-lcdk.dts                   |  71 ++++++
 arch/arm/boot/dts/da850.dtsi                       |  11 +
 drivers/bus/Kconfig                                |   9 +
 drivers/bus/Makefile                               |   2 +
 drivers/bus/da8xx-mstpri.c                         | 269 +++++++++++++++++++++
 drivers/memory/Kconfig                             |   8 +
 drivers/memory/Makefile                            |   1 +
 drivers/memory/da8xx-ddrctl.c                      | 175 ++++++++++++++
 10 files changed, 586 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/bus/ti,da850-mstpri.txt
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/ti-da8xx-ddrctl.txt
 create mode 100644 drivers/bus/da8xx-mstpri.c
 create mode 100644 drivers/memory/da8xx-ddrctl.c

-- 
2.9.3
