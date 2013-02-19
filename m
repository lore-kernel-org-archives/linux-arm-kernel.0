From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 19 Feb 2013 12:35:24 +0100
Subject: [PATCH v3 0/8] Reset controller API to reset IP modules on i.MX5 and
 i.MX6
Message-ID: <1361273732-23357-1-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The system reset controller (SRC) on i.MX51, i.MX53, and i.MX6q controls
reset lines to the GPU, VPU, IPU, and OpenVG IP modules.

The following patches add a simple API for devices to request being reset
by separate reset controller hardware and implements the reset signal
device tree binding proposed by Stephen Warren. Contrary to Tegra hardware,
the i.MX SRC contains self-deasserting reset registers, so I've included
both ops to manually assert/deassert a reset line, as well as a "reset"
operation that is supposed to assert the reset line and wait for it to
deassert.

The i.MX SRC is enhanced to provide a reset controller and the IPU driver
is made to request being reset by calling the device_reset(&pdev->dev)
convenience wrapper during probing.

Changes since v2:
 - Added ARCH_HAS_RESET_CONTROLLER to enable the reset controller API
   by default, where needed. Select it from HAVE_IMX_SRC.
 - Fixed kerneldoc comments.
 - Export reset_controller_(un)register
 - Simplified reset_control_get
 - Call reset_control_put in device_reset
 - Add locking around read-modify-write accesses to SCR_SRC
 - Renamed "gpios" device tree property to "reset-gpios" and added
   device tree binding documentation for gpio-reset.
 - Rebased onto next-20120219.

regards
Philipp

---
 .../devicetree/bindings/reset/fsl,imx-src.txt      |   49 +++++
 .../devicetree/bindings/reset/gpio-reset.txt       |   31 +++
 Documentation/devicetree/bindings/reset/reset.txt  |   75 +++++++
 .../bindings/staging/imx-drm/fsl-imx-drm.txt       |    3 +
 arch/arm/boot/dts/imx51.dtsi                       |    7 +
 arch/arm/boot/dts/imx53.dtsi                       |    7 +
 arch/arm/boot/dts/imx6q.dtsi                       |    1 +
 arch/arm/boot/dts/imx6qdl.dtsi                     |    4 +-
 arch/arm/mach-imx/Kconfig                          |    3 +
 arch/arm/mach-imx/mm-imx5.c                        |    2 +
 arch/arm/mach-imx/src.c                            |   68 +++++-
 drivers/Kconfig                                    |    2 +
 drivers/Makefile                                   |    3 +
 drivers/reset/Kconfig                              |   26 +++
 drivers/reset/Makefile                             |    2 +
 drivers/reset/core.c                               |  220 ++++++++++++++++++++
 drivers/reset/gpio-reset.c                         |  189 +++++++++++++++++
 drivers/staging/imx-drm/ipu-v3/ipu-common.c        |   12 +-
 include/linux/reset-controller.h                   |   43 ++++
 include/linux/reset.h                              |   17 ++
 20 files changed, 759 insertions(+), 5 deletions(-)
