From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 16 Jan 2013 17:13:00 +0100
Subject: [RFC PATCH 0/5] Reset controller API to reset IP modules on i.MX5 and
 i.MX6
Message-ID: <1358352787-15441-1-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The system reset controller (SRC) on i.MX51, i.MX53, and i.MX6q controls
reset lines to the GPU, VPU, IPU, and OpenVG IP modules.

The following patches add a simple API for devices to request being reset
by separate reset controller hardware. They implement the reset signal
device tree binding proposed by Stephen Warren. Contrary to Tegra hardware,
the i.MX SRC has self-deasserting reset bits, so I've included both
ops to manually assert/deassert a reset line, as well as a reset
operation that is supposed to assert the reset line and wait for it to
deassert.

The i.MX SRC is enhanced to provide a reset controller and the IPU driver
is made to request being reset by calling the device_reset(&pdev->dev)
convenience wrapper during probing.

regards
Philipp

---
 .../devicetree/bindings/reset/fsl,imx-src.txt      |   49 ++++
 Documentation/devicetree/bindings/reset/reset.txt  |   75 ++++++
 .../bindings/staging/imx-drm/fsl-imx-drm.txt       |    3 +
 arch/arm/boot/dts/imx51.dtsi                       |    7 +
 arch/arm/boot/dts/imx53.dtsi                       |    7 +
 arch/arm/boot/dts/imx6q.dtsi                       |    3 +
 arch/arm/mach-imx/Kconfig                          |    1 +
 arch/arm/mach-imx/common.h                         |    3 +-
 arch/arm/mach-imx/mach-imx6q.c                     |    2 +-
 arch/arm/mach-imx/mm-imx5.c                        |    2 +
 arch/arm/mach-imx/src.c                            |   86 ++++++-
 drivers/Kconfig                                    |    2 +
 drivers/Makefile                                   |    2 +
 drivers/reset/Kconfig                              |   10 +
 drivers/reset/Makefile                             |    2 +
 drivers/reset/core.c                               |  241 ++++++++++++++++++++
 drivers/staging/imx-drm/ipu-v3/ipu-common.c        |   12 +-
 include/linux/imx-src.h                            |    6 +
 18 files changed, 507 insertions(+), 6 deletions(-)
