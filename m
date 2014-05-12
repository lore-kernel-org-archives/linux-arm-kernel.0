From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Tue, 13 May 2014 01:49:24 +0200
Subject: [PATCH v3 0/6] arm: Add basic support for Mediatek Cortex-A7 SoCs
Message-ID: <1399938570-11356-1-git-send-email-matthias.bgg@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Third round for the Mediatek patches.

I split up the patch which introduced the basic support for Mediatek devices.
The series contains instead of the one patch:
a patch with dt board file and dtsi, one for the vendor prefix
and one for the documentation of the SoC DT bindings.

---
This patch set adds basic support for the Mediatek Cortex-A7 SoCs.
Support is quite basic, as the only component working up to now are the
timers.

The patch series is build against torvalds/master tree.

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>

Changes for v3:
1. Clocksource timer
- Set cpu_mask_all and irq in clock_event_device
- Use device private structure for driver specific values

2. Timer DT bindings
- Define order of the clock phandles
- Fix typos

3. Basic SoC support
- DTS: set gic to a15-gic
- DTS: order by physical address
- Remove call to dt_init function


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

Matthias Brugger (6):
  clocksource: Add support for the Mediatek SoCs
  dt-bindings: add mtk-timer bindings
  vendor-prefixes: add prefix for Mediaktek Inc.
  arm: add basic support for Mediatek MT6589 boards
  dt-bindings: add documentation for Mediatek SoC
  arm: mediatek: add dts for Aquaris5 mobile phone

 .../devicetree/bindings/arm/mediatek-mt65xx.txt    |   8 +
 .../bindings/timer/mediatek,mtk-timer.txt          |  18 ++
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/Kconfig                                   |   2 +
 arch/arm/Makefile                                  |   1 +
 arch/arm/boot/dts/mt6589-aquaris5.dts              |  25 ++
 arch/arm/boot/dts/mt6589.dtsi                      |  93 ++++++++
 arch/arm/mach-mediatek/Kconfig                     |   6 +
 arch/arm/mach-mediatek/Makefile                    |   1 +
 arch/arm/mach-mediatek/mediatek.c                  |  32 +++
 drivers/clocksource/Kconfig                        |   4 +
 drivers/clocksource/Makefile                       |   1 +
 drivers/clocksource/mtk_timer.c                    | 263 +++++++++++++++++++++
 13 files changed, 455 insertions(+)
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
