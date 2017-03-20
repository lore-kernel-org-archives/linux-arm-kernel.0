From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Mon, 20 Mar 2017 14:47:23 +0800
Subject: [PATCH v6 0/4] leds: add leds-mt6323 support on MT7623 SoC
Message-ID: <1489992447-13007-1-git-send-email-sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

MT7623 SoC uses MT6323 PMIC as the default power supply which has LED function
insides. The patchset introduces the LED support for MT6323 with on, off and
hardware dimmed and blinked and it should work on other similar SoCs if also
using MT6323.

Changes since v1:
- fixed typo in the comments
- sorted include directives alphabetically
- applied all register definitions with MT6323 prefix
- removed the redundant structure declaration
- fixed coding style defined in kernel doc format consistently
- added error handling into all the occurrences where regmap APIs
  are used
- removed loudly debug message
- made magic constant into meaningful macro
- added missing mutex_destroy when module removed called
- updated module license with GPL
- fixed sparse warnings

Changes since v2:
- fixed the typo in devicetree Documentation
- cleaned up the style and explanation in the comments
- applied all macro/struct/function definitions with MT6323 prefix
- put the logic about the setup from device tree into function for simplicity

Changes since v3:
- changed the variable current_brightness into the proper type
- removed the redundant member led_num from mt6323_leds structure
- collected the brightness setting into mt6323_led_hw_brightness() call
- added brightness_get() support into the core layer
- fixed zero duty cycle handling due to hardware doesn't support
- fixed duty cycle calculation mapping to the hardware register
- added the brightness as the input in mt6323_led_hw_on() call
- enhanced error handling in mt6323_led_set_dt_default() call
- fixed potential issue which caused accessing unallocated memory if excessive
  the led controller nodes are defined
- fixed redundant memory allocation in mt6323_leds structure
- added reg property for defining the led controller for which the child
  node is predestined

Changes since v4:
- enhanced the example in leds-mt6323.txt for patch 1/4 with adding the missing
  #address-cell and #size-cell, correcting sub-node naming with led at 0 style,
  removing the unrelated setup for LED and moving the description for the node
  properties into the right place
- enhanced the documentation in mt6397.txt for patch 2/4
- changed the subject prefixes into "dt-bindings: ..." for the device tree commits
- fixed that missing of_node_put() in the error path called from mt6323_led_probe()
- fixed that incorrect duty_cycle calculation mapping into the hardware register in
case duty ratio is lower than 1/64 rather than 0

Changes since v5:
- changed codebase into 4.11-rc1
- split the already merged ones out from patch #2 and #4 on v4
- fixed line wrap to 72-80 char for patch #1
- grouped properties by required and optional for patch #1
- enhanced the node identifier for the example with "mt6323: pmic" instead of
"pmic: mt6323" for patch #1

Sean Wang (4):
  dt-bindings: leds: Add document bindings for leds-mt6323
  dt-bindings: mfd: Add the description for LED as the sub module
  leds: Add LED support for MT6323 PMIC
  mfd: mt6397: Align the placement at which the mfd_cell of LED is
    defined

 .../devicetree/bindings/leds/leds-mt6323.txt       |  60 +++
 Documentation/devicetree/bindings/mfd/mt6397.txt   |   1 +
 drivers/leds/Kconfig                               |   8 +
 drivers/leds/Makefile                              |   1 +
 drivers/leds/leds-mt6323.c                         | 502 +++++++++++++++++++++
 drivers/mfd/mt6397-core.c                          |   3 +-
 6 files changed, 573 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-mt6323.txt
 create mode 100644 drivers/leds/leds-mt6323.c

-- 
1.9.1
