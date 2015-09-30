From: simon.guinot@sequanux.org (Simon Guinot)
Date: Wed, 30 Sep 2015 11:10:41 +0200
Subject: [PATCH v4 0/5] Add support for the Armada-370-based Seagate NAS
Message-ID: <1443604246-29844-1-git-send-email-simon.guinot@sequanux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patch series adds support for the Seagate machines based on the
Armada-370 Marvell SoC. This includes the Personal Cloud 1 and 2-Bay
and the Seagate NAS 2 and 4-Bay.

The purpose for this new version is to fix a cpuidle issue on Personal
Cloud boards. Due to an hardware bug, all the CPU power supply units are
turned off (instead of 1.1V only) when entering in "deepidle" mode. This
triggers a CPU reset. As a consequence, we need a way to disable
"deepidle" mode for this boards.

As an answer, a patch introducing a "broken-idle" coherency-fabric DT
property has been added to the series. This new property allows to
disable cpuidle support if not supported by hardware.

Additionally, a patch enabling the "broken-idle" option for Armada 38x
SoCs has been added as well. Since cpuidle is also broken on this SoCs,
it makes sense to enable the "broken-idle" property with them.

Thanks,

Simon

Changes for v2:
- Rename DTS files using the products names.
- Update model and compatible properties as well.
- Add some information allowing to identify the devices in the commit
  message and in the DTS files headers.
- Remove duplicated rtc alias in armada-370-seagate-nas-xbay.dtsi.

Changes for v3:
- Use GPIO_ACTIVE_HIGH instead of 0 in gpios property (gpio-fan node).
- Fix spelling for Personal Cloud DTS files: 'personal' instead of
  'personnal'.
- Add Andrew's Acked-by.

Changes for v4:
- Introduces a DT coherency-fabric property: broken-idle.
- Use this new property to disable cpuidle support on Personal Cloud
  boards.
- Use this new property with Armada 38x SoCs as well.

Thanks,

Simon

Simon Guinot (2):
  ARM: mvebu: add DT support for Seagate Personal Cloud
  ARM: mvebu: enable options for Seagate NAS in mvebu_v7_defconfig

Vincent Donnefort (3):
  ARM: mvebu: add broken-idle option
  ARM: mvebu: enable broken-idle on Armada 38x
  ARM: mvebu: add DT support for Seagate NAS 2 and 4-Bay

 .../devicetree/bindings/arm/coherency-fabric.txt   |   4 +
 arch/arm/boot/dts/Makefile                         |   4 +
 arch/arm/boot/dts/armada-370-seagate-nas-2bay.dts  |  36 ++++
 arch/arm/boot/dts/armada-370-seagate-nas-4bay.dts  | 133 ++++++++++++
 arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi | 231 +++++++++++++++++++++
 .../dts/armada-370-seagate-personal-cloud-2bay.dts |  51 +++++
 .../boot/dts/armada-370-seagate-personal-cloud.dts |  37 ++++
 .../dts/armada-370-seagate-personal-cloud.dtsi     | 178 ++++++++++++++++
 arch/arm/boot/dts/armada-38x.dtsi                  |   1 +
 arch/arm/configs/mvebu_v7_defconfig                |   9 +-
 arch/arm/mach-mvebu/pmsu.c                         |  32 ++-
 11 files changed, 709 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm/boot/dts/armada-370-seagate-nas-2bay.dts
 create mode 100644 arch/arm/boot/dts/armada-370-seagate-nas-4bay.dts
 create mode 100644 arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi
 create mode 100644 arch/arm/boot/dts/armada-370-seagate-personal-cloud-2bay.dts
 create mode 100644 arch/arm/boot/dts/armada-370-seagate-personal-cloud.dts
 create mode 100644 arch/arm/boot/dts/armada-370-seagate-personal-cloud.dtsi

-- 
2.1.4
