From: stefan@agner.ch (Stefan Agner)
Date: Tue,  2 Dec 2014 18:11:57 +0100
Subject: [PATCH v3 0/3] power: reset: vf610 system reset controller
Message-ID: <1417540320-2385-1-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This third version does essentially the same as v1, but with a lot
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

Changes since v2:
- Drop priority property for syscon-reboot
- Alter default priority of syscon-reboot, set it to 192

Changes since v1:
- Total rework using syscon/syscon-reboot capabilities
- Enhance syscon-reboot with priority capabilities

Stefan Agner (3):
  power: reset: adjust priority of simple syscon reboot driver
  ARM: dts: vf610: add system reset controller and syscon-reboot
  ARM: imx_v6_v7_defconfig: add POWER_RESET_SYSCON

 arch/arm/boot/dts/vf500.dtsi         |  4 ++++
 arch/arm/boot/dts/vfxxx.dtsi         | 12 ++++++++++++
 arch/arm/configs/imx_v6_v7_defconfig |  8 ++++----
 drivers/power/reset/syscon-reboot.c  |  2 +-
 4 files changed, 21 insertions(+), 5 deletions(-)

-- 
2.1.3
