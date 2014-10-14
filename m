From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 14 Oct 2014 14:20:38 +0200
Subject: [PATCH 0/8] power_supply: Add API for safe access of get_property-like
 function attrs
Message-ID: <1413289246-31650-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


After fixing issue with referencing old power supply after driver
unbind in charger manager [1] I noticed that the race condition in such
case may still exist. It would be harder to trigger but still possible.

The race is between using a reference to power supply (obtained
with power_supply_get_by_name()) and removing the driver.

This patchset aims to fix the race by introducing wrappers for
accessing the power supply function attributes.

Patch 1 introduces new API. Other patches replace direct calls in
drivers.

Rebased on next-20141007.
Tested on Trats2 board (max77693 + charger manager).


Kindly asking for reviewing/testing the drivers, although the changes
are straightforward.


Best regards,
Krzysztof


[1] https://lkml.org/lkml/2014/10/13/272



Krzysztof Kozlowski (8):
  power_supply: Add API for safe access of power supply function attrs
  power_supply: sysfs: Use power_supply_*() API for accessing function
    attrs
  power: 88pm860x_charger: Use power_supply_*() API for accessing
    function attrs
  power: ab8500: Use power_supply_*() API for accessing function attrs
  mfd: ab8500: Use power_supply_*() API for accessing function attrs
  power: apm_power: Use power_supply_*() API for accessing function
    attrs
  power: bq2415x_charger: Use power_supply_*() API for accessing
    function attrs
  power: charger-manager: Use power_supply_*() API for accessing
    function attrs

 drivers/mfd/ab8500-sysctrl.c       |  7 +++--
 drivers/power/88pm860x_charger.c   | 13 +++++----
 drivers/power/ab8500_btemp.c       |  2 +-
 drivers/power/ab8500_charger.c     |  2 +-
 drivers/power/ab8500_fg.c          |  2 +-
 drivers/power/abx500_chargalg.c    |  4 +--
 drivers/power/apm_power.c          |  4 +--
 drivers/power/bq2415x_charger.c    |  3 +-
 drivers/power/charger-manager.c    | 37 +++++++++++++------------
 drivers/power/power_supply_core.c  | 57 ++++++++++++++++++++++++++++++++++++--
 drivers/power/power_supply_sysfs.c |  6 ++--
 include/linux/power_supply.h       | 16 +++++++++++
 12 files changed, 115 insertions(+), 38 deletions(-)

-- 
1.9.1
