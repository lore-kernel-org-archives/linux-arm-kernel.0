From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Wed, 12 Jun 2013 00:22:29 +0200
Subject: [PATCH v5 00/22] SH pinctrl DT support
Message-ID: <1370989371-30846-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Here's the fifth version of the SuperH and SH Mobile pin controllers (PFC) DT
support patch set.

The patches are based on tags/renesas-next-20130611v2 from Simon's tree
(git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git) and the R-Car
GPIO DT bindings proposal ("[RFC/PATCH v2 0/2] R-Car GPIO DT bindings"). The
result is available in my tree at

        git://linuxtv.org/pinchartl/fbdev.git pinmux/3.10/dt

The series starts with a proposal for generic pinconf DT bindings, already
posted as "[RFC] pinctrl: generic: Add DT bindings". The rest is pretty
self-explanatory. DT bindings are added in patch 03/22, and the following
patches gradually move SoC code and board code over to the device tree for the
armadilla800eva-reference, kzm9g-reference and marzen-reference boards. The
code has been tested on the three boards, but armadillo800eva has received less
testing as it can't be booted all the way to userspace with network support due
to missing DT bindings.

Comments will be very appreciated on the DT bindings (01/22 and 03/22). Points
I'm a bit unsure about include:

- Should the driver support pin configuration subnodes as currently
  implemented, or should the subnodes be promoted to regular pin configuration
  nodes, with clients referencing multiple nodes ?
- Should the driver allow mixing function and configuration properties in a pin
  configuration node as currently implemented, or should it restrict the pin
  configuration nodes to either a function or one (or more) configuration(s) ?

I'd like to get this series in v3.11. Linus, do you think that would be
possible ? If the generic pinconf DT bindings can't make it in time I can
respin the patches with pinconf support removed, and add it back along with the
generic pinconf DT bindings for v3.12.

Changes since v4:

- Added generic pinconf bindings
- Use symbolic names for GPIO flags

Changes since v3:

- Fixed the GPIO flags description in the DT bindings documentation
- Mention the gpio-rcar driver in the DT bindings documentation for platforms
  that use it
- Removed unneeded #ifdef CONFIG_OF...#endif
- Removed unused support for platform data
- Simplified error path in sh_pfc_dt_node_to_map()
- Added gpio-ranges for r8a7778, r8a7779 and r8a7790

Changes since v2:

- Added pin configuration properties
- Rewrote all arch changes

Changes since v1:

- Fixed gpio cell number 2 documentation
- Added missing gpio-controller and #gpio-cells properties to r8a7740 DT
- Split kzm9g DT patch into SoC and board patches
- Dropped pinctrl mappings move to DT


Laurent Pinchart (22):
  pinctrl: generic: Add DT bindings
  sh-pfc: Remove support for platform data
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

 .../bindings/pinctrl/pinctrl-bindings.txt          |  29 +++
 .../bindings/pinctrl/renesas,pfc-pinctrl.txt       | 156 ++++++++++++++++
 arch/arm/boot/dts/r8a73a4.dtsi                     |   7 +
 .../boot/dts/r8a7740-armadillo800eva-reference.dts |  34 ++++
 arch/arm/boot/dts/r8a7740.dtsi                     |   8 +
 arch/arm/boot/dts/r8a7778.dtsi                     |  56 ++++++
 arch/arm/boot/dts/r8a7779-marzen-reference.dts     |  49 +++++
 arch/arm/boot/dts/r8a7779.dtsi                     |  76 ++++++++
 arch/arm/boot/dts/r8a7790.dtsi                     |  66 +++++++
 arch/arm/boot/dts/sh7372.dtsi                      |   8 +
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts       |  90 +++++++++-
 arch/arm/boot/dts/sh73a0.dtsi                      |   8 +
 .../board-armadillo800eva-reference.c              |  18 +-
 arch/arm/mach-shmobile/board-kzm9g-reference.c     |  47 -----
 arch/arm/mach-shmobile/board-marzen-reference.c    |  28 ---
 drivers/pinctrl/pinconf-generic.c                  |  94 ++++++++++
 drivers/pinctrl/pinconf.h                          |  17 ++
 drivers/pinctrl/sh-pfc/core.c                      |  65 ++++++-
 drivers/pinctrl/sh-pfc/pinctrl.c                   | 199 +++++++++++++++++++++
 19 files changed, 959 insertions(+), 96 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt

-- 
Regards,

Laurent Pinchart
