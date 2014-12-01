From: stefan@agner.ch (Stefan Agner)
Date: Mon,  1 Dec 2014 18:03:06 +0100
Subject: [PATCH v2 0/3] power: reset: vf610 system reset controller
Message-ID: <1417453389-1588-1-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This second version does essentially the same as v1, but with a lot
less code due to the usage of syscon and syscon-reboot driver. My
earlier misgivings that it might be a problem for the suspend/resume
implementation later on did not hold true: I tested my prelinear
suspend code and in case the code really needs to access some
registers form assembler, it is possible to map temporarly the
relevant region again.

I refrained from adding POWER_RESET_SYSCON as a hard dependency for
Vybrid (SOC_VF610): In its dual-core configuration, one might want
have the Cortex-M4 in charge of the system reset... Hence the user
should be able to build a kernel without the system reset (beside
the option to create a board specific device tree with disabled
SRC node).

Shawn, the defconfig change is based on the latest (almost-merged?)
defconfig patch.

Changes since v1:
- Total rework using syscon/syscon-reboot capabilities
- Enhance syscon-reboot with priority capabilities (as suggested by Guenter)

Stefan Agner (3):
  power: reset: read priority from device tree
  ARM: dts: vf610: add system reset controller and syscon-reboot
  ARM: imx_v6_v7_defconfig: add POWER_RESET_SYSCON

 .../devicetree/bindings/power/reset/syscon-reboot.txt       |  3 +++
 arch/arm/boot/dts/vf500.dtsi                                |  4 ++++
 arch/arm/boot/dts/vfxxx.dtsi                                | 13 +++++++++++++
 arch/arm/configs/imx_v6_v7_defconfig                        |  8 ++++----
 drivers/power/reset/syscon-reboot.c                         |  5 ++++-
 5 files changed, 28 insertions(+), 5 deletions(-)

-- 
2.1.3
