From: b29396@freescale.com (Dong Aisheng)
Date: Tue, 4 Sep 2012 11:20:07 +0800
Subject: [PATCH v5 0/4] add syscon driver based on regmap for general
 registers access
Message-ID: <1346728811-25788-1-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series mainly adds an syscon driver which is used to access
general system controller registers like FSL IOMUXC GPR and ANATOP,
after that, we convert all the exist private access general registers code to use
standard API from regmap to access registers.
Finally we remove the old mfd anatop driver which is only for anatop register
access.

The patch series is based on linus's tree 3.6-rc3 since commit 9160338.

ChangeLog v4->v5:
 * change syscon driver depends on OF
 * do not call of_node_put in syscon_node_to_regmap
 * renamed: include/linux/fsl/imx6q-iomuxc-gpr.h ->
	    include/linux/mfd/syscon/imx6q-iomuxc-gpr.h

ChangeLog v3->v4:
Only '[PATCH v4 1/7] mfd: add syscon driver based on regmap' is changed.

Dong Aisheng (4):
  mfd: add syscon driver based on regmap
  ARM: imx6q: add iomuxc gpr support into syscon
  regulator: anatop-regulator: convert to use syscon to access anatop
    register
  mfd: anatop-mfd: remove anatop driver

 Documentation/devicetree/bindings/mfd/syscon.txt |   20 ++
 arch/arm/boot/dts/imx6q.dtsi                     |    9 +-
 arch/arm/mach-imx/Kconfig                        |    2 +-
 arch/arm/mach-imx/mach-imx6q.c                   |   47 ++--
 drivers/mfd/Kconfig                              |   12 +-
 drivers/mfd/Makefile                             |    2 +-
 drivers/mfd/anatop-mfd.c                         |  124 ---------
 drivers/mfd/syscon.c                             |  176 ++++++++++++
 drivers/regulator/Kconfig                        |    2 +-
 drivers/regulator/anatop-regulator.c             |   30 ++-
 include/linux/mfd/anatop.h                       |   40 ---
 include/linux/mfd/syscon.h                       |   23 ++
 include/linux/mfd/syscon/imx6q-iomuxc-gpr.h      |  319 ++++++++++++++++++++++
 13 files changed, 592 insertions(+), 214 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/syscon.txt
 delete mode 100644 drivers/mfd/anatop-mfd.c
 create mode 100644 drivers/mfd/syscon.c
 delete mode 100644 include/linux/mfd/anatop.h
 create mode 100644 include/linux/mfd/syscon.h
 create mode 100644 include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
