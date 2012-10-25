From: rajanikanth.hv@stericsson.com (Rajanikanth H.V)
Date: Thu, 25 Oct 2012 12:00:50 +0530
Subject: [PATCH 0/4] Implement device tree support for ab8500 BM Devices
Message-ID: <1351146654-9110-1-git-send-email-rajanikanth.hv@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Rajanikanth H.V" <rajanikanth.hv@stericsson.com>

This patch-set adds device tree binding for ab8500 battery-managed
devices. Removes the redundant platform structure maintained
across bm devices and implements common DT probe routine across all the
modules.

Test status:
a) Tested across 'legacy platform data' and DT binding support
	a.1) ab8500_charger driver fails to get regulator in the
		legacy platform mode.
b) Interrupt numbers assigned differs between legacy and FDT mode.
    (a) Legacy platform_data Mode:
    root at ME:/ cat /proc/interrupts
               CPU0       CPU1
    483:          0          0    ab8500  ab8500-ponkey-dbf
    484:          0          0    ab8500  ab8500-ponkey-dbr
    485:          0          0    ab8500  BATT_OVV
    494:          0          1    ab8500
    495:          0          0    ab8500  ab8500-rtc
    501:          0         13    ab8500  NCONV_ACCU
    503:          7         22    ab8500  CCEOC
    504:          0          1    ab8500  CC_INT_CALIB
    505:          0          0    ab8500  LOW_BAT_F
    516:          0         34    ab8500  ab8500-gpadc
    556:          0          0    ab8500  usb-link-status
    
    (b) FDT Mode:
    root at ME:/ cat /proc/interrupts
               CPU0       CPU1
      6:          0          0    ab8500  ab8500-ponkey-dbf
      7:          0          0    ab8500  ab8500-ponkey-dbr
      8:          0          0    ab8500  BATT_OVV
    162:          0          7    ab8500  ab8500-gpadc
    163:          0          1    ab8500
    164:          0          0    ab8500  ab8500-rtc
    484:          0          0    ab8500  usb-link-status
    499:          0          4    ab8500  NCONV_ACCU
    500:          0          0    ab8500  LOW_BAT_F
    502:          0          1    ab8500  CC_INT_CALIB
    503:          0          6    ab8500  CCEOC

c) Event handlers across bm-modules have been verified only
   during 'battery discharge process' as 'battery charging process'
   depends on ab8500-usb code

Rajanikanth H.V (4):
  mfd: ab8500: add devicetree support for fuelgauge
  mfd: ab8500: add devicetree support for btemp
  mfd: ab8500: add devicetree support for charger
  mfd: ab8500: add devicetree support for chargalg

 Documentation/devicetree/bindings/mfd/ab8500.txt   |   27 +-
 .../bindings/power_supply/ab8500/btemp.txt         |   16 +
 .../bindings/power_supply/ab8500/chargalg.txt      |   16 +
 .../bindings/power_supply/ab8500/charger.txt       |   25 +
 .../devicetree/bindings/power_supply/ab8500/fg.txt |   58 +++
 arch/arm/boot/dts/dbx5x0.dtsi                      |   28 +-
 drivers/mfd/ab8500-core.c                          |   20 +
 drivers/power/Kconfig                              |    6 -
 drivers/power/Makefile                             |    2 +-
 drivers/power/ab8500_bmdata.c                      |  513 ++++++++++++++++++++
 drivers/power/ab8500_btemp.c                       |   76 +--
 drivers/power/ab8500_charger.c                     |   82 ++--
 drivers/power/ab8500_fg.c                          |   80 +--
 drivers/power/abx500_chargalg.c                    |   56 ++-
 include/linux/mfd/abx500.h                         |   34 +-
 15 files changed, 876 insertions(+), 163 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power_supply/ab8500/btemp.txt
 create mode 100644 Documentation/devicetree/bindings/power_supply/ab8500/chargalg.txt
 create mode 100644 Documentation/devicetree/bindings/power_supply/ab8500/charger.txt
 create mode 100644 Documentation/devicetree/bindings/power_supply/ab8500/fg.txt
 create mode 100644 drivers/power/ab8500_bmdata.c

-- 
1.7.10.4
