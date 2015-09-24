From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Thu, 24 Sep 2015 23:38:55 +0800
Subject: [PATCH v4 0/5] Add SMP bringup support for mt65xx socs
Message-ID: <1443109140-5406-1-git-send-email-yingjoe.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series add SMP brinup support for MediaTek SoCs. This is v4 and
is based on v4.3-rc1.

There are similar but different SMP bringup up methods on MediaTek
mt65xx and mt81xx. On MT8135 & MT8127, system boots with a trustzone
firmware. Others, like MT6589, doesn't have trustzone, and run kernel
directly in secure world.

Patch 1 enable arch timer support.
Patch 2,3 add support for cpu enable-method "mediatek,mt6589-smp" and
"mediatek,mt81xx-tz-smp", which support Mediatek SMP bringup for non-TZ
and TZ platform.
Patch 4,5 finally enable SMP bringup for mt8135 and mt8127.

Changes in v4:
- rebase to v4.3-rc1
- Reserve trustzone bootinfo memory area in device tree.

Changes in v3:
- v3 in [1]
- The first 2 patches in v2 are merged in v4.2-rc1.
- Patch 3~4 in v2 are moved to another series [2]
- platsmp.c changes based on Stephen's suggestion
- Change cpu enable-method name to "mediatek,mt6589-smp"

Changes in v2:
- Fix boot issue for THUMB2 kernel.
- Not enable GPT_CLK_EVT when setup to fix GPT spurious interrupt issue
- Change platsmp.c according to Matthias' suggestion
http://lists.infradead.org/pipermail/linux-mediatek/2015-May/000714.html

v1:
http://lists.infradead.org/pipermail/linux-mediatek/2015-May/000528.html

[1]
http://lists.infradead.org/pipermail/linux-mediatek/2015-July/001570.html

[2]
http://lists.infradead.org/pipermail/linux-mediatek/2015-July/001544.html

Matthias Brugger (1):
  ARM: mediatek: enable gpt6 on boot up to make arch timer working

Yingjoe Chen (4):
  devicetree: bindings: add new SMP enable method Mediatek SoC
  ARM: mediatek: add smp bringup code
  ARM: dts: mt8135: enable basic SMP bringup for mt8135
  ARM: dts: mt8127: enable basic SMP bringup for mt8127

 Documentation/devicetree/bindings/arm/cpus.txt |   2 +
 arch/arm/boot/dts/mt8127.dtsi                  |  27 +++++
 arch/arm/boot/dts/mt8135.dtsi                  |  27 +++++
 arch/arm/mach-mediatek/Makefile                |   3 +
 arch/arm/mach-mediatek/mediatek.c              |  27 +++++
 arch/arm/mach-mediatek/platsmp.c               | 141 +++++++++++++++++++++++++
 6 files changed, 227 insertions(+)
 create mode 100644 arch/arm/mach-mediatek/platsmp.c

-- 
1.9.1
