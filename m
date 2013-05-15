From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Wed, 15 May 2013 02:18:00 +0200
Subject: [PATCH v3 00/20] SH pinctrl DT support
Message-ID: <1368577100-3530-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Here's the third version of the SuperH and SH Mobile pin controllers (PFC) DT
support patch set.

The patches are based on tags/renesas-next-20130513 from Simon's tree
(git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git), the R-Car
GPIO DT bindings proposal ("[RFC/PATCH 0/2] R-Car GPIO DT bindings") and the
marzen-reference ethernet patches ("[PATCH 0/2] marzen-reference ethernet
patches") I've previously posted. The result is available in my tree at

        git://linuxtv.org/pinchartl/fbdev.git pinmux/3.9/dt

The series is pretty self-explanatory. DT bindings are added in patch 01/20,
and the following patches gradually move SoC code and board code over to the
device tree for the armadilla800eva-reference, kzm9g-reference and
marzen-reference boards. The code has been tested on the three boards, but
only kzm9g can currently boot to userspace with network support due to lack of
DT bindings or other ethernet issues on the two other boards. armadillo800eva
and marzen have thus received less testing.

Comments will be very appreciated on the DT bindings (01/20). Points I'm a bit
unsure about include:

- Should the driver support pin configuration subnodes as currently
  implemented, or should the subnodes be promoted to regular pin configuration
  nodes, with clients referencing multiple nodes ?
- Should the driver allow mixing function and configuration properties in a pin
  configuration node as currently implemented, or should it restrict the pin
  configuration nodes to either a function or one (or more) configuration(s) ?
- Should we specify common bindings for pinconf-generic instead of using
  Renesas-specific properties ? (If the answer to this question is yes, please
  help :-)).

Changes since v2:

- Added pin configuration properties
- Rewrote all arch changes

Changes since v1:

- Fixed gpio cell number 2 documentation
- Added missing gpio-controller and #gpio-cells properties to r8a7740 DT
- Split kzm9g DT patch into SoC and board patches
- Dropped pinctrl mappings move to DT

Laurent Pinchart (20):
  sh-pfc: Add DT support
  ARM: shmobile: r8a73a4: Add pin control device to device tree
  ARM: shmobile: r8a7740: Add pin control device to device tree
  ARM: shmobile: r8a7778: Add pin control device to device tree
  ARM: shmobile: r8a7778: Add GPIO controller devices to device tree
  ARM: shmobile: r8a7779: Add pin control device to device tree
  ARM: shmobile: r8a7779: Add GPIO controller devices to device tree
  ARM: shmobile: r8a7790: Add pin control device to device tree
  ARM: shmobile: r8a7790: Add GPIO controller devices to device tree
  ARM: shmobile: sh7372: Add pin control device to device tree
  ARM: shmobile: sh73a0: Add pin control device to device tree
  ARM: shmobile: armadillo-reference: Move pinctrl mappings to device
    tree
  ARM: shmobile: armadillo-reference: Add st1232 pin mappings
  ARM: shmobile: armadillo-reference: Move st1232 reset GPIO to DT
  ARM: shmobile: armadillo-reference: Add LED1-LED4 to the device tree
  ARM: shmobile: kzm9g-reference: Move pinctrl mappings to device tree
  ARM: shmobile: kzm9g-reference: Move SDHI regulators to DT
  ARM: shmobile: kzm9g-reference: Add LED1-LED4 to the device tree
  ARM: shmobile: marzen-reference: Move pinctrl mappings to device tree
  ARM: shmobile: marzen-reference: Add LED2-LED4 to the device tree

 .../bindings/pinctrl/renesas,pfc-pinctrl.txt       | 143 ++++++++++++
 arch/arm/boot/dts/r8a73a4.dtsi                     |   7 +
 .../boot/dts/r8a7740-armadillo800eva-reference.dts |  33 +++
 arch/arm/boot/dts/r8a7740.dtsi                     |   8 +
 arch/arm/boot/dts/r8a7778.dtsi                     |  50 +++++
 arch/arm/boot/dts/r8a7779-marzen-reference.dts     |  48 ++++
 arch/arm/boot/dts/r8a7779.dtsi                     |  69 ++++++
 arch/arm/boot/dts/r8a7790.dtsi                     |  59 +++++
 arch/arm/boot/dts/sh7372.dtsi                      |   8 +
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts       |  89 +++++++-
 arch/arm/boot/dts/sh73a0.dtsi                      |   8 +
 .../board-armadillo800eva-reference.c              |  18 +-
 arch/arm/mach-shmobile/board-kzm9g-reference.c     |  47 ----
 arch/arm/mach-shmobile/board-marzen-reference.c    |  28 ---
 drivers/pinctrl/sh-pfc/core.c                      |  66 +++++-
 drivers/pinctrl/sh-pfc/pinctrl.c                   | 244 +++++++++++++++++++++
 16 files changed, 829 insertions(+), 96 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt

-- 
Regards,

Laurent Pinchart
