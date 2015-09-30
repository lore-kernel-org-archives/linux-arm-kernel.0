From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 30 Sep 2015 20:01:43 +0900
Subject: [PATCH v4 0/3] ARM: uniphier: add outer cache support and rework SMP
 operations
Message-ID: <1443610906-8608-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

Now Linux 4.3-rc1 is out, so I am back to this.

1/3: add outer cache support
2/3: rework SMP operations
3/3: add device tree nodes

Because 2/3 highly depends on 1/3, I hope whole of this series
is applied through ARM-SOC tree.


Changes in v4:
  - Add more detailed comments to explain why no spin lock is needed
  - Add two examples to the binding document

Changes in v3:
  - Drop bogus includes

Changes in v2:
  - Use pr_fmt() to have pr_<level> are automatically prefixed
  - Re-design to initialize the outer cache earlier in init_IRQ()
  - Require DT properties such as "cacne-unified", "cache-size",
    "cache-sets", "cache-size", "cache-line-size".
  - Follow "next-level-cache" property to search further outer caches

Masahiro Yamada (3):
  ARM: uniphier: add outer cache support
  ARM: uniphier: rework SMP operations to use trampoline code
  ARM: dts: uniphier: add outer cache controller nodes

 .../bindings/arm/uniphier/cache-uniphier.txt       |  60 +++
 MAINTAINERS                                        |   2 +
 arch/arm/boot/dts/uniphier-ph1-ld4.dtsi            |  13 +
 arch/arm/boot/dts/uniphier-ph1-pro4.dtsi           |  14 +
 arch/arm/boot/dts/uniphier-ph1-pro5.dtsi           |  27 +
 arch/arm/boot/dts/uniphier-ph1-sld3.dtsi           |  14 +
 arch/arm/boot/dts/uniphier-ph1-sld8.dtsi           |  13 +
 arch/arm/boot/dts/uniphier-proxstream2.dtsi        |  16 +
 arch/arm/include/asm/hardware/cache-uniphier.h     |  46 ++
 arch/arm/kernel/irq.c                              |   3 +
 arch/arm/mach-uniphier/Makefile                    |   2 +-
 arch/arm/mach-uniphier/headsmp.S                   |  43 ++
 arch/arm/mach-uniphier/platsmp.c                   | 185 +++++--
 arch/arm/mm/Kconfig                                |  10 +
 arch/arm/mm/Makefile                               |   1 +
 arch/arm/mm/cache-uniphier.c                       | 554 +++++++++++++++++++++
 16 files changed, 972 insertions(+), 31 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/uniphier/cache-uniphier.txt
 create mode 100644 arch/arm/include/asm/hardware/cache-uniphier.h
 create mode 100644 arch/arm/mach-uniphier/headsmp.S
 create mode 100644 arch/arm/mm/cache-uniphier.c

-- 
1.9.1
