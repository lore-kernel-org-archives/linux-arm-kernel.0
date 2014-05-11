From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Sun, 11 May 2014 03:40:59 +0200
Subject: [PATCH v2 0/4] arm: Add basic support for Mediatek Cortex-A7 SoCs
Message-ID: <1399772463-859-1-git-send-email-matthias.bgg@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Second round for the basic support of the mt6589 SoC from Mediatek.

I droped the patch which introduced low-level-debug for the Soc, because of
the missing serial device driver. This would prohibit the use of a multi-
platform kernel with this series. I will re-submit the patch for low-level-
debugging, when the serial driver got committed.

I added support for the Aquaris5 mobile phone, although at the moment you can't
really do anything with the phone. I also renamed the mtk6589.dtsi to 
mt6589.dtsi as it better reflects the SoC name given by Mediatek.

---
This patch set adds basic support for the Mediatek Cortex-A7 SoCs.
Support is quite basic, as the only component working up to now are the
timers.

The patch series is build against torvalds/master tree.

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>

Changes for v2:
1. Clocksource timer
- Delete unused parts for sched_clock_source
- Use irq_request instead of setup_irq
- Remove unused SMP parts
- Fix some style issues
- use of_address_to resource and request_mem_region
- delete use of named clock
- select CLKSRC_MMIO in driver Kconfig

2. DT bindings
- delete named clock bindings

3. Basic SoC support
- Clean-up Kconfig
- Add documentation of the SoC compatible property 
- DTS: rename SoC file to mt6589.dts
- DTS: Delete not present cache controller
- DTS: Add missing GICv2 properties
- DTS: Change clock names
- DTS: Add Aquaris5 board

4. Add earlyprintk
- patch droped until serial driver is available

5. Add support for Aquaris5 mobile phone

---

Matthias Brugger (4):
  clocksource: Add support for the Mediatek SoCs
  dt-bindings: add mtk-timer bindings
  arm: add basic support for Mediatek MT6589 boards
  arm: mediatek: add dts for Aquaris5 mobile phone

 .../devicetree/bindings/arm/mediatek-mt65xx.txt    |   8 +
 .../bindings/timer/mediatek,mtk-timer.txt          |  17 ++
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/Kconfig                                   |   2 +
 arch/arm/Makefile                                  |   1 +
 arch/arm/boot/dts/mt6589-aquaris5.dts              |  25 +++
 arch/arm/boot/dts/mt6589.dtsi                      |  93 ++++++++
 arch/arm/mach-mediatek/Kconfig                     |   6 +
 arch/arm/mach-mediatek/Makefile                    |   1 +
 arch/arm/mach-mediatek/mediatek.c                  |  38 ++++
 drivers/clocksource/Kconfig                        |   4 +
 drivers/clocksource/Makefile                       |   1 +
 drivers/clocksource/mtk_timer.c                    | 240 +++++++++++++++++++++
 13 files changed, 437 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek-mt65xx.txt
 create mode 100644 Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
 create mode 100644 arch/arm/boot/dts/mt6589-aquaris5.dts
 create mode 100644 arch/arm/boot/dts/mt6589.dtsi
 create mode 100644 arch/arm/mach-mediatek/Kconfig
 create mode 100644 arch/arm/mach-mediatek/Makefile
 create mode 100644 arch/arm/mach-mediatek/mediatek.c
 create mode 100644 drivers/clocksource/mtk_timer.c

-- 
1.8.1.2
