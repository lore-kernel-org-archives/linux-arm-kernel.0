From: manabian@gmail.com (Joachim Eastwood)
Date: Tue, 19 May 2015 00:35:53 +0200
Subject: [PATCH v3 0/6] Clk drivers for NXP LPC18xx family
Message-ID: <1431988559-23338-1-git-send-email-manabian@gmail.com>
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


The biggest change in v3 is the way parent names for CCU clocks are
retrieved. Previous version used names from the 'clock-output-names'
node on CGU and of_clk_get_parent_name(). In this version the clock
names has been moved into the CGU driver and are retrieved from the
CCU driver by of_clk_get() and __clk_get_name().

The of_clk_get_index function is used to map CCU branches to to the
base clocks by using the CGU ID retrieved with of_clk_get_index. An
alternative approach would be to put the base clock names directly
in the CCU driver where the CGU ID is today. See clk_branches table
in clk-lpc18xx-ccu.c. If this is the prefered way of doing this
please let me know and I'll quickly put out a new version.

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

Base support for LPC18xx is now in arm-soc next. Pinctrl, gpio
and reset drivers are also upstream.


Joachim Eastwood (6):
  clk: add lpc18xx cgu clk driver
  doc: dt: add documentation for lpc1850-cgu clk driver
  clk: add function to retrieve clk id from dt
  clk: add lpc18xx ccu clk driver
  doc: dt: add documentation for lpc1850-ccu clk driver
  ARM: dts: lpc18xx: add clock nodes for cgu and ccu

 .../devicetree/bindings/clock/lpc1850-ccu.txt      | 146 +++++
 .../devicetree/bindings/clock/lpc1850-cgu.txt      | 131 +++++
 arch/arm/boot/dts/lpc18xx.dtsi                     |  77 ++-
 arch/arm/boot/dts/lpc4350-hitex-eval.dts           |   4 -
 drivers/clk/Makefile                               |   1 +
 drivers/clk/clk.c                                  |  18 +
 drivers/clk/nxp/Makefile                           |   2 +
 drivers/clk/nxp/clk-lpc18xx-ccu.c                  | 305 ++++++++++
 drivers/clk/nxp/clk-lpc18xx-cgu.c                  | 635 +++++++++++++++++++++
 include/dt-bindings/clock/lpc18xx-ccu.h            |  74 +++
 include/dt-bindings/clock/lpc18xx-cgu.h            |  41 ++
 include/linux/clk-provider.h                       |   1 +
 12 files changed, 1417 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/lpc1850-ccu.txt
 create mode 100644 Documentation/devicetree/bindings/clock/lpc1850-cgu.txt
 create mode 100644 drivers/clk/nxp/Makefile
 create mode 100644 drivers/clk/nxp/clk-lpc18xx-ccu.c
 create mode 100644 drivers/clk/nxp/clk-lpc18xx-cgu.c
 create mode 100644 include/dt-bindings/clock/lpc18xx-ccu.h
 create mode 100644 include/dt-bindings/clock/lpc18xx-cgu.h

-- 
1.8.0
