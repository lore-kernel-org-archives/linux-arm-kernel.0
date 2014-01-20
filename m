From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 20 Jan 2014 16:41:43 +0100
Subject: [PATCH v7 0/7] ARM: rockchip: add smp functionality
Message-ID: <4970034.fqvMoHdOyd@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series enables the use of the additional cores on Rockchip
Cortex-A9 SoCs.

To achieve this, add the scu, the needed sram and power-management-unit.

Tested on both a BQ Curie2 (rk3066a / dual core) and
on a Radxa Rock (rk3188 / quad core).

changes since v6:
- address comments from Mark Rutland
  - using of_property_read_u32_index instead of parsing the list manually
  - include v4 of "of: add functions to count number of elements in a property"
    to not have to count property-elements manually anymore
changes since v5:
- Grant Likely liked it better to "specify reserved regions of the
  memory instead of the valid ranges", so go back to the mmio-sram-reserved
  property originally suggested by Rob Herring

changes since v4:
- rebase on top of the recent rk3188 board support
- implement suggestion from Matt Sealey in moving the sram-limit from
  marking reserved regions to marking available regions - hopefully
  I got the usage right 
- remove __CPUINIT as suggested by Fabio Estevam

changes since v3:
- address comments from Rob Herring:
  - split the gathering of the reserve-data into a separate loop
  - spelling and style fixes
- first patch only included for reference, already part of the
  char-misc git tree

changes since v2:
- rework the sram allocation following the suggestion from Philipp Zabel

changes since v1:
- add reserved block feature for mmio-sram, to not use two logical
  sram nodes
- the sram content is kept intact while the device is running, so
  copying the trampoline is only needed once

Heiko Stuebner (7):
  of: add functions to count number of elements in a property
  dt-bindings: sram: describe option to reserve parts of the memory
  misc: sram: implement mmio-sram-reserved option
  ARM: rockchip: add snoop-control-unit
  ARM: rockchip: add sram dt nodes and documentation
  ARM: rockchip: add power-management-unit
  ARM: rockchip: add smp bringup code

 .../devicetree/bindings/arm/rockchip/pmu.txt       |   16 ++
 .../devicetree/bindings/arm/rockchip/smp-sram.txt  |   23 +++
 Documentation/devicetree/bindings/misc/sram.txt    |    8 +
 arch/arm/boot/dts/rk3066a.dtsi                     |    6 +
 arch/arm/boot/dts/rk3188.dtsi                      |    6 +
 arch/arm/boot/dts/rk3xxx.dtsi                      |   10 +
 arch/arm/mach-rockchip/Kconfig                     |    1 +
 arch/arm/mach-rockchip/Makefile                    |    1 +
 arch/arm/mach-rockchip/core.h                      |   22 +++
 arch/arm/mach-rockchip/headsmp.S                   |   30 +++
 arch/arm/mach-rockchip/platsmp.c                   |  208 ++++++++++++++++++++
 arch/arm/mach-rockchip/rockchip.c                  |    2 +
 drivers/misc/sram.c                                |  121 +++++++++++-
 drivers/of/base.c                                  |   32 +++
 include/linux/of.h                                 |   76 +++++++
 15 files changed, 554 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/rockchip/pmu.txt
 create mode 100644 Documentation/devicetree/bindings/arm/rockchip/smp-sram.txt
 create mode 100644 arch/arm/mach-rockchip/core.h
 create mode 100644 arch/arm/mach-rockchip/headsmp.S
 create mode 100644 arch/arm/mach-rockchip/platsmp.c

-- 
1.7.10.4
