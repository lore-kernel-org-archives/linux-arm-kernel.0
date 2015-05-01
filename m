From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Fri, 1 May 2015 15:43:23 +0800
Subject: [PATCH 0/7] Add SMP bringup support for mt65xx socs
Message-ID: <1430466210-22963-1-git-send-email-yingjoe.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series add SMP brinup support for mediatek SoCs. This is based
on v4.1-rc1.

There are 2 similar but different SMP bringup up methods on Mediatek
mt65xx and mt81xx. On MT8135 & MT8127, system boots with a trustzone
firmware. Others, like MT6589, doesn't have trustzone, and run kernel
directly in secure world.

Patch 1~3 fix issues in mtk_timer(GPT) and enable arch timer support.
Patch 4,5 add support for cpu enable-method "mediatek,mt65xx-smp" and
"mediatek,mt81xx-tz-smp", which support Mediatek SMP bringup for non-TZ
and TZ platform.
Patch 6,7 finally enable SMP bringup for mt8135 and mt8127.

Matthias Brugger (1):
  arm: mediatek: enable gpt6 on boot up to make arch timer working

Yingjoe Chen (6):
  clocksource: mediatek: Don't run event_handler if it is NULL
  clocksource: mediatek: Use GPT as sched clock source
  devicetree: bindings: add new SMP enable method Mediatek SoC
  ARM: mediatek: add smp bringup code
  ARM: dts: mt8135: enable basic SMP bringup for mt8135
  ARM: dts: mt8127: enable basic SMP bringup for mt8127

 Documentation/devicetree/bindings/arm/cpus.txt |   2 +
 arch/arm/boot/dts/mt8127.dtsi                  |  16 +++
 arch/arm/boot/dts/mt8135.dtsi                  |  16 +++
 arch/arm/mach-mediatek/Makefile                |   3 +
 arch/arm/mach-mediatek/mediatek.c              |  29 +++++
 arch/arm/mach-mediatek/platsmp.c               | 145 +++++++++++++++++++++++++
 drivers/clocksource/mtk_timer.c                |  13 ++-
 7 files changed, 223 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/mach-mediatek/platsmp.c
