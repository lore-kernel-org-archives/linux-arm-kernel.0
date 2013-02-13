From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 13 Feb 2013 18:34:24 +0100
Subject: [PATCH v2 0/5] Reset controller API to reset IP modules on i.MX5 and
 i.MX6
Message-ID: <1360776872-18584-1-git-send-email-p.zabel@pengutronix.de>
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

Changes since v1:
 - Fixed issues from comments 
 - Added reset controller driver for GPIO controlled resets

regards
Philipp

---
 .../devicetree/bindings/reset/fsl,imx-src.txt      |   49 ++++
 Documentation/devicetree/bindings/reset/reset.txt  |   75 ++++++
 .../bindings/staging/imx-drm/fsl-imx-drm.txt       |    3 +
 arch/arm/boot/dts/imx51.dtsi                       |    7 +
 arch/arm/boot/dts/imx53.dtsi                       |    7 +
 arch/arm/boot/dts/imx6q.dtsi                       |    5 +-
 arch/arm/mach-imx/Kconfig                          |    2 +
 arch/arm/mach-imx/mm-imx5.c                        |    2 +
 arch/arm/mach-imx/src.c                            |   58 ++++-
 drivers/Kconfig                                    |    2 +
 drivers/Makefile                                   |    3 +
 drivers/reset/Kconfig                              |   22 ++
 drivers/reset/Makefile                             |    2 +
 drivers/reset/core.c                               |  238 ++++++++++++++++++++
 drivers/reset/gpio-reset.c                         |  188 ++++++++++++++++
 drivers/staging/imx-drm/ipu-v3/ipu-common.c        |   12 +-
 include/linux/reset-controller.h                   |   39 ++++
 include/linux/reset.h                              |   17 ++
 18 files changed, 726 insertions(+), 5 deletions(-)
