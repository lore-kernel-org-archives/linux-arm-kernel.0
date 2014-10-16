From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 16 Oct 2014 09:42:00 +0200
Subject: [PATCH v2 0/7] power_supply: Decrement the device reference counter
Message-ID: <1413445327-24862-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


Changes since v1:
=================
1. Remove check for non-NULL in power_supply_put (suggested by
   Pavel Machek).
2. Add Pavel Machek's ack.


Description:
============
The reference counter of device allocated for power supply was
incremented with each call to power_supply_get_by_name() and
power_supply_get_by_phandle().

Add a symmetric 'put' operation so the device could be released after
final put_device() call during supply unregistering.


Rebased on next-20141007 + mine [1] patchset.
Tested on Trats2 board (max77693 + charger manager).

Kindly asking for reviewing and testing other drivers.

Best regards,
Krzysztof


[1] power_supply: Add API for safe access of get_property-like function attrs
http://www.spinics.net/lists/arm-kernel/msg369870.html


Krzysztof Kozlowski (7):
  power_supply: Add power_supply_put for decrementing device reference
    counter
  power: charger-manager: Decrement the power supply's device reference
    counter
  x86/olpc/xo1/sci: Use newly added power_supply_put API
  x86/olpc/xo15/sci: Use newly added power_supply_put API
  power: 88pm860x_charger: Decrement the power supply's device reference
    counter
  power: bq2415x_charger: Decrement the power supply's device reference
    counter
  mfd: ab8500: Decrement the power supply's device reference counter

 arch/x86/platform/olpc/olpc-xo1-sci.c  |  4 +-
 arch/x86/platform/olpc/olpc-xo15-sci.c |  4 +-
 drivers/mfd/ab8500-sysctrl.c           |  2 +
 drivers/power/88pm860x_charger.c       | 11 +++++-
 drivers/power/bq2415x_charger.c        |  6 ++-
 drivers/power/charger-manager.c        | 70 +++++++++++++++++++++++-----------
 drivers/power/power_supply_core.c      | 38 ++++++++++++++++++
 include/linux/power_supply.h           |  1 +
 8 files changed, 106 insertions(+), 30 deletions(-)

-- 
1.9.1
