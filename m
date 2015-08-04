From: scott.shu@mediatek.com (Scott Shu)
Date: Tue, 4 Aug 2015 21:54:16 +0800
Subject: [PATCH v3 0/8] This series adds SMP support for the MediaTek MT6580.
Message-ID: <1438696464-59858-1-git-send-email-scott.shu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds support SMP on MediaTek MT6580 Cortex-A7 quad-core SoC.

This is based on v4.2-rc1 and following patch series:
(1) Yingjoe Chen's "Add SMP bringup support for mt65xx socs" [1]
(2) Mars Cheng's "Add mt6580 basic chip support" [2]
(3) Sascha Hauer's "Mediatek SCPSYS power domain support" [3]

The secondary cores are power off as default on MT6580, this change adds
a new enable-method to turn on power to the cores during booting process.

The System Power Manager (SPM) inside the SCPSYS is for the CPU MTCMOS
power domain control. Please check [3] for more information about SCPSYS.

[1] https://lkml.org/lkml/2015/5/16/33
[2] https://lkml.org/lkml/2015/6/30/119
[3] https://lkml.org/lkml/2015/6/9/172

Change in v3:
1. Add CPU power control in SCPSYS driver

Change in v2:
1. Rebase to 4.2-rc1
2. Fix using usleep() in atomic context
3. Put a timeout in cpu power on/off sequence
4. Fix some coding style

Scott Shu (8):
  Document: bindings: DT: Add SMP enable method for MT6580     SoC
    platform
  dt-bindings: soc: Add SCPSYS compatible support for mt6580
  soc: Mediatek: Add SCPSYS CPU power domain driver
  ARM: multi_v7_defconfig: enable INFRACFG and SCPSYS modules
  ARM: mediatek: add smp bringup code for MT6580
  ARM: Mediatek: enable GPT6 on boot up to make arch timer     working
    for MT6580
  ARM: dts: mt6580: Add device nodes to the MT6580 dtsi file
  ARM: dts: mt6580: enable basic SMP bringup for MT6580

 Documentation/devicetree/bindings/arm/cpus.txt     |    1 +
 .../devicetree/bindings/soc/mediatek/scpsys.txt    |    2 +-
 arch/arm/boot/dts/mt6580.dtsi                      |   26 ++
 arch/arm/configs/multi_v7_defconfig                |    2 +
 arch/arm/mach-mediatek/mediatek.c                  |    4 +-
 arch/arm/mach-mediatek/platsmp.c                   |  137 +++++++++++
 drivers/soc/mediatek/mtk-scpsys.c                  |  250 ++++++++++++++++++++
 include/linux/soc/mediatek/scpsys.h                |    9 +
 8 files changed, 429 insertions(+), 2 deletions(-)
 create mode 100644 include/linux/soc/mediatek/scpsys.h

-- 
1.7.9.5
