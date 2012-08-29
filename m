From: b29396@freescale.com (Dong Aisheng)
Date: Wed, 29 Aug 2012 18:56:51 +0800
Subject: [PATCH v4 0/7] add syscon driver based on regmap for general
 registers access
Message-ID: <1346237818-9498-1-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series mainly adds an syscon driver which is used to access
general system controller registers like FSL IOMUXC GPR and ANATOP,
after that, we convert all the exist private access general registers code to use
standard API from regmap to access registers.
Finally we remove the old mfd anatop driver which is only for anatop register
access.

The patch series is based on linus's tree 3.6-rc3 since commit 9160338.

ChangeLog v3->v4:
Only '[PATCH v4 1/7] mfd: add syscon driver based on regmap' is changed.

Dong Aisheng (7):
  mfd: add syscon driver based on regmap
  ARM: imx6q: add iomuxc gpr support into syscon
  ARM: imx6q: add anatop support into syscon
  regulator: anatop-regulator: convert to use syscon to access anatop
    register
  ARM: imx6q: convert to use syscon to access anatop registers
  ARM: dts: imx6q: add simple-bus compatible string for anatop
  mfd: anatop-mfd: remove anatop driver

 Documentation/devicetree/bindings/mfd/syscon.txt |   20 ++
 arch/arm/boot/dts/imx6q.dtsi                     |    9 +-
 arch/arm/mach-imx/Kconfig                        |    2 +-
 arch/arm/mach-imx/mach-imx6q.c                   |   47 ++--
 drivers/mfd/Kconfig                              |   13 +-
 drivers/mfd/Makefile                             |    2 +-
 drivers/mfd/anatop-mfd.c                         |  124 ---------
 drivers/mfd/syscon.c                             |  170 ++++++++++++
 drivers/regulator/Kconfig                        |    2 +-
 drivers/regulator/anatop-regulator.c             |   30 ++-
 include/linux/fsl/imx6q-iomuxc-gpr.h             |  319 ++++++++++++++++++++++
 include/linux/mfd/anatop.h                       |   40 ---
 include/linux/mfd/syscon.h                       |   23 ++
 13 files changed, 586 insertions(+), 215 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/syscon.txt
 delete mode 100644 drivers/mfd/anatop-mfd.c
 create mode 100644 drivers/mfd/syscon.c
 create mode 100644 include/linux/fsl/imx6q-iomuxc-gpr.h
 delete mode 100644 include/linux/mfd/anatop.h
 create mode 100644 include/linux/mfd/syscon.h
