From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 17 Feb 2014 10:05:35 +0100
Subject: [PATCH v3 00/15] mfd: max14577: Add support for MAX77836
Message-ID: <1392627950-26927-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


This is third version of patchset adding support for MAX77836 device
to the max14577 driver.

Lee Jones suggested that after obtaining acks from all maintainers he can
merged these patches to his tree. These patches touch different subsystems
(charger/power, regulator, extcon and mfd) so this would be probably the best
way to merge everything. I would be glad if I could get missing acks
(or comments).


Changes since v2
================
1. Added ACK-s.
2. Applied minor checkpatch fixes (pointed by Lee Jones).
3. Rebased on next-20140217.

Changes since v1
================
1. Added ACK-s, reviews and tested-by tags.
2. Removed applied patches (they were merged to the linux-next tree).
3. Applied comments from review (Lee Jones) to 5/15 (detection of device type)
   and 8/15 (add max77836 support to max14577).
4. Rebased on next tree.
5. Added patch 13 and 14 (pointed by Jenny Tc):
   - regulator/mfd: max14577: Export symbols for calculating charger current
   - charger: max14577: Configure battery-dependent settings from DTS
6. Updated bindings documentation with new charger bindings.
Previous thread:
 - [PATCH 00/18] mfd: max14577: Add support for MAX77836
   http://thread.gmane.org/gmane.linux.kernel/1636654/focus=1636674


Description
===========
The MAX77836 is almost the same as MAX14577. Basically it is an extended
version of MAX14577. The chipsets have same MUIC component so the extcon,
charger and regulators require only little adjustments. More changes were
needed in the charger (because it uses lower charging current) and regulator
drivers (because mentioned different charing current and additional
regulators). The MAX77836 has also PMIC and Fuel Gauge (which is the same
as MAX17040/17048 Fuel Gauge).

The MAX77836 uses three I2C slave addresses and has additional interrupts
(related to PMIC and Fuel Gauge). It has also Interrupt Source register,
just like MAX77686 and MAX77693.

The patchset is organized in following way:
1. Patches from 1 to 7 prepare the driver for supporting MAX77836. They
   mostly rename symbols and add additional logic related to different
   device types.
2. Patches from 8 to 12 add support for MAX77836.
3. Patches 13 and 14 remove hard-coded charger configuration with DTS. They
   were added after review on mailing lists.
4. Patch 15 adds bindings documentation, which was not merged previously.


The patchset is based on linux-next tree and depends on patches from previous
release which are already merged into next.
Testing was done on 3.10.


TODO: Merge max14577, max77686 and max77693 into one common driver. They are
very similar.


Best regards,
Krzysztof Kozlowski


Chanwoo Choi (1):
  extcon: max14577: Change extcon name instead of static name according
    to device type

Krzysztof Kozlowski (14):
  mfd: max14577: Rename and add MAX14577 symbols to prepare for
    max77836
  mfd: max14577: Rename state container to maxim_core
  mfd: max14577: Add "muic" suffix to regmap and irq_chip
  mfd: max14577: Add detection of device type
  extcon: max14577: Add max14577 prefix to muic_irqs
  extcon: max14577: Choose muic_irqs according to device type
  mfd: max77836: Add max77836 support to max14577 driver
  extcon: max14577: Add support for max77836
  regulator: max14577: Add support for max77836 regulators
  charger: max14577: Add support for MAX77836 charger
  power: max17040: Add ID for max77836 Fuel Gauge block
  regulator/mfd: max14577: Export symbols for calculating charger
    current
  charger: max14577: Configure battery-dependent settings from DTS
  mfd: max14577: Add device tree bindings document

 Documentation/devicetree/bindings/mfd/max14577.txt |  149 +++++
 drivers/extcon/extcon-max14577.c                   |  274 +++++----
 drivers/mfd/max14577.c                             |  475 +++++++++++++---
 drivers/power/max14577_charger.c                   |  360 +++++++++---
 drivers/power/max17040_battery.c                   |    1 +
 drivers/regulator/max14577.c                       |  279 +++++++---
 include/linux/mfd/max14577-private.h               |  582 ++++++++++++--------
 include/linux/mfd/max14577.h                       |   50 +-
 8 files changed, 1636 insertions(+), 534 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/max14577.txt

-- 
1.7.9.5
