From: scott.shu@mediatek.com (Scott Shu)
Date: Sun, 23 Aug 2015 17:00:59 +0800
Subject: [PATCH v4 0/8] This series adds SMP support for the MediaTek MT6580.
Message-ID: <1440320467-26118-1-git-send-email-scott.shu@mediatek.com>
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

Change in v4:
1. Remove boot_lock and pen_release stuff
2. Fix some coding style

Change in v3:
1. Add CPU power control in SCPSYS driver

Change in v2:
1. Rebase to 4.2-rc1
2. Fix using usleep() in atomic context
3. Put a timeout in cpu power on/off sequence
4. Fix some coding style

Scott Shu (8):
  Document: bindings: DT: Add SMP enable method for MT6580 SoC platform
  dt-bindings: soc: Add SCPSYS compatible support for mt6580
  soc: Mediatek: Add SCPSYS CPU power domain driver
  ARM: multi_v7_defconfig: enable INFRACFG and SCPSYS modules
  ARM: mediatek: add smp bringup code for MT6580
  ARM: Mediatek: enable GPT6 on boot up to make arch timer working    
    for MT6580
  ARM: dts: mt6580: Add device nodes to the MT6580 dtsi file
  ARM: dts: mt6580: enable basic SMP bringup for MT6580

 Documentation/devicetree/bindings/arm/cpus.txt     |   1 +
 .../devicetree/bindings/soc/mediatek/scpsys.txt    |   2 +-
 arch/arm/boot/dts/mt6580.dtsi                      |  26 +++
 arch/arm/configs/multi_v7_defconfig                |   2 +
 arch/arm/mach-mediatek/mediatek.c                  |   4 +-
 arch/arm/mach-mediatek/platsmp.c                   |  67 ++++++
 drivers/soc/mediatek/mtk-scpsys.c                  | 250 +++++++++++++++++++++
 include/linux/soc/mediatek/scpsys.h                |   9 +
 8 files changed, 359 insertions(+), 2 deletions(-)
 create mode 100644 include/linux/soc/mediatek/scpsys.h

-- 
1.9.1

************* Email Confidentiality Notice ********************
The information contained in this e-mail message (including any 
attachments) may be confidential, proprietary, privileged, or otherwise
exempt from disclosure under applicable laws. It is intended to be 
conveyed only to the designated recipient(s). Any use, dissemination, 
distribution, printing, retaining or copying of this e-mail (including its 
attachments) by unintended recipient(s) is strictly prohibited and may 
be unlawful. If you are not an intended recipient of this e-mail, or believe 
that you have received this e-mail in error, please notify the sender 
immediately (by replying to this e-mail), delete any and all copies of 
this e-mail (including any attachments) from your system, and do not
disclose the content of this e-mail to any other person. Thank you!
