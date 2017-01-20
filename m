From: l.stach@pengutronix.de (Lucas Stach)
Date: Fri, 20 Jan 2017 16:52:21 +0100
Subject: [PATCH 0/4] i.MX6 power gating controller rework
Message-ID: <20170120155225.31905-1-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a new attempt at rewriting the i.MX6 GPC driver to properly
support multiple power domains. This needs a new DT binding to properly
describe the power domain properties in the devicetree. Newer SoCs
like the i.MX6SX are exposing more than 1 device power domain.

This new series splits out the PGC part of the GPC driver and moves it
from the architecture code to drivers/soc. It is essentially a complete
re-write of the driver, so this time I didn't try to keep it in one
commit, as this seems to cause more confusion than good for the reviewers.

The new driver keeps compatibility with the old DT binding, but new
features will only be added using the new binding.

Lucas Stach (4):
  dt-bindings: add multidomain support to i.MX GPC DT binding
  ARM: imx6: remove PGC handling from GPC driver
  soc/imx: add new GPC driver
  ARM: imx6: adopt DT to new GPC binding

 .../devicetree/bindings/power/fsl,imx-gpc.txt      |  81 ++--
 arch/arm/boot/dts/imx6q.dtsi                       |   2 +-
 arch/arm/boot/dts/imx6qdl.dtsi                     |  38 +-
 arch/arm/mach-imx/gpc.c                            | 217 ----------
 drivers/soc/Makefile                               |   1 +
 drivers/soc/imx/Makefile                           |   1 +
 drivers/soc/imx/gpc.c                              | 480 +++++++++++++++++++++
 7 files changed, 564 insertions(+), 256 deletions(-)
 create mode 100644 drivers/soc/imx/Makefile
 create mode 100644 drivers/soc/imx/gpc.c

-- 
2.11.0
