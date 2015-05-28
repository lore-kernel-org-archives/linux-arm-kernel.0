From: manabian@gmail.com (Joachim Eastwood)
Date: Thu, 28 May 2015 22:31:42 +0200
Subject: [PATCH v4 0/5] Clk drivers for NXP LPC18xx family
Message-ID: <1432845107-12458-1-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set adds support for the two main clock peripherals in the
LPC18xx/43xx MCU family.

The Clock Generation Unit (CGU) is the base source of all clocks. It has
five external inputs and contains PLLs, dividers and muxes. The outputs
from the CGU are then routed to a Clock Control Unit (CCU) and a few
peripherals directly. There are two CCUs in the MCU. The CCU is a
collection of gates and a few dividers that sits between the CGU and
most of the peripherals. These clock drivers are needed by the timer at
early boot so both are using CLK_OF_DECLARE.

Which clocks that are available depends on the specific device and it's
peripherals. It's possible in DT to setup the routing between the CGU
and the CCUs.


The biggest change in v4 is the way parent names for CCU clocks are
stored and how clock branches are selected for registration in the
CCU driver.

* Parent clock names are now stored together with branch name in the
clk_branches[] table.

* Selection of which branch clock to register on the two CCU instances
is determined by the 'clock-names' property. If a clock name matches
with the parent name in the clk_branches[] table that branch clock is
registered on the CCU.

Alternativly the clk_branches[] table could be split between the CCUs,
but there would still be a need to identify the CCU instance. For
example by using different compatability stings in DT or adding an id
property to DT.

I belive the best solution is to let the driver decide which branch
clocks to register based on the clock routing information already
provided in DT. As mentioned above this is now done by using the
'clock-names' property and matching strings in the clk_branches[]
table.

Clock tree can be found here: http://slexy.org/raw/s2I3bIFJxg


Changes since v3:
 - put CCU parent clock names directly in clk_branches[] table
 - use 'clock-names' property to find figure out which branch
   clocks to register in CCU driver as oppose to clk id
 - remove CCU clock list from doc and refer to lpc18xx-ccu.h
 - remove patch with of_clk_get_index

Changes since v2:
 - use 'clock-controller' as node name in doc
 - add patch with of_clk_get_index function
 - drop 'clock-indices' and 'clock-output-names' from cgu node
 - move base clock names into cgu driver
 - use of_clk_get/__clk_get_name in ccu to get parent name for
   composite clocks.
 - other misc fixes to ccu driver and cgu doc

Changes since v1:
 - reorganize cgu clk structs
 - macros to create cgu clk structs
 - move drivers to nxp subdir
 - rebase on v4.1-rc1


The last patch (dts changes) are only included in this patch set for
illustration purposes. DTS changes will be sent separately to the ARM
SoC team later.

Base support for LPC18xx is now in arm-soc next. Pinctrl, gpio, reset
and ethernet drivers are also upstream.


Joachim Eastwood (5):
  clk: add lpc18xx cgu clk driver
  doc: dt: add documentation for lpc1850-cgu clk driver
  clk: add lpc18xx ccu clk driver
  doc: dt: add documentation for lpc1850-ccu clk driver
  ARM: dts: lpc18xx: add clock nodes for cgu and ccu

 .../devicetree/bindings/clock/lpc1850-ccu.txt      |  77 +++
 .../devicetree/bindings/clock/lpc1850-cgu.txt      | 131 +++++
 arch/arm/boot/dts/lpc18xx.dtsi                     |  85 ++-
 arch/arm/boot/dts/lpc4350-hitex-eval.dts           |   4 -
 drivers/clk/Makefile                               |   1 +
 drivers/clk/nxp/Makefile                           |   2 +
 drivers/clk/nxp/clk-lpc18xx-ccu.c                  | 293 ++++++++++
 drivers/clk/nxp/clk-lpc18xx-cgu.c                  | 635 +++++++++++++++++++++
 include/dt-bindings/clock/lpc18xx-ccu.h            |  74 +++
 include/dt-bindings/clock/lpc18xx-cgu.h            |  41 ++
 10 files changed, 1325 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/lpc1850-ccu.txt
 create mode 100644 Documentation/devicetree/bindings/clock/lpc1850-cgu.txt
 create mode 100644 drivers/clk/nxp/Makefile
 create mode 100644 drivers/clk/nxp/clk-lpc18xx-ccu.c
 create mode 100644 drivers/clk/nxp/clk-lpc18xx-cgu.c
 create mode 100644 include/dt-bindings/clock/lpc18xx-ccu.h
 create mode 100644 include/dt-bindings/clock/lpc18xx-cgu.h

-- 
1.8.0
