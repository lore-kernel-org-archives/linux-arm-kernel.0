From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Sat, 16 May 2015 15:58:21 +0800
Subject: [PATCH v2 0/9] Add SMP bringup support for mt65xx socs
Message-ID: <1431763110-443-1-git-send-email-yingjoe.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series add SMP brinup support for mediatek SoCs. This is based
on v4.1-rc1.

There are 2 similar but different SMP bringup up methods on Mediatek
mt65xx and mt81xx. On MT8135 & MT8127, system boots with a trustzone
firmware. Others, like MT6589, doesn't have trustzone, and run kernel
directly in secure world.

Patch 1,2 are preparing patch, cleanup/fix in secondary_startup_arm
Patch 3~5 fix issues in mtk_timer(GPT) and enable arch timer support.
Patch 6,7 add support for cpu enable-method "mediatek,mt65xx-smp" and
"mediatek,mt81xx-tz-smp", which support Mediatek SMP bringup for non-TZ
and TZ platform.
Patch 8,9 finally enable SMP bringup for mt8135 and mt8127.

Changes in v2:
- Fix boot issue for THUMB2 kernel.
- Not enable GPT_CLK_EVT when setup to fix GPT spurious interrupt issue
- Change platsmp.c according to Matthias' suggestion

v1:
http://lists.infradead.org/pipermail/linux-mediatek/2015-May/000528.html

Matthias Brugger (1):
  ARM: mediatek: enable gpt6 on boot up to make arch timer working

Yingjoe Chen (8):
  ARM: correct secondary_startup_arm mode
  ARM: add secondary_startup_arm prototype in header file
  clocksource: mediatek: do not enable GPT_CLK_EVT when setup
  clocksource: mediatek: Use GPT as sched clock source
  devicetree: bindings: add new SMP enable method Mediatek SoC
  ARM: mediatek: add smp bringup code
  ARM: dts: mt8135: enable basic SMP bringup for mt8135
  ARM: dts: mt8127: enable basic SMP bringup for mt8127

 Documentation/devicetree/bindings/arm/cpus.txt |   2 +
 arch/arm/boot/dts/mt8127.dtsi                  |  16 +++
 arch/arm/boot/dts/mt8135.dtsi                  |  16 +++
 arch/arm/include/asm/smp.h                     |   1 +
 arch/arm/kernel/head.S                         |   2 +-
 arch/arm/mach-mediatek/Makefile                |   3 +
 arch/arm/mach-mediatek/mediatek.c              |  29 +++++
 arch/arm/mach-mediatek/platsmp.c               | 144 +++++++++++++++++++++++++
 drivers/clocksource/mtk_timer.c                |  25 ++++-
 9 files changed, 232 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm/mach-mediatek/platsmp.c
