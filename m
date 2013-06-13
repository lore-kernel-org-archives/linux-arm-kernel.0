From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Fri, 14 Jun 2013 01:45:45 +0200
Subject: [PATCH v6 00/18] SH pinctrl DT support
Message-ID: <1371167163-10507-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Here's the sixth version of the SuperH and SH Mobile pin controllers (PFC) DT
support patch set.

The patches are based on tags/renesas-next-20130613 from Simon's tree
(git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git). The result
is available in my tree at

        git://linuxtv.org/pinchartl/fbdev.git pinmux/3.10/dt

The series is pretty self-explanatory. DT bindings are added in patch 02/18,
and the following patches gradually move SoC code and board code over to the
device tree for the armadilla800eva-reference and marzen-reference boards. The
code has been tested on the two boards, but armadillo800eva has received less
testing as it can't be booted all the way to userspace with network support due
to missing DT bindings.

Comments will be very appreciated on the DT bindings (02/18). Points I'm a bit
unsure about include:

- Should the driver support pin configuration subnodes as currently
  implemented, or should the subnodes be promoted to regular pin configuration
  nodes, with clients referencing multiple nodes ?

I've dropped pinconf support from the DT bindings as the generic pinconf DT
bindings are work in progress and might not make it to v3.11, which this patch
set targets. Pinconf support will be added back later as follow-up patches.
Linus, if you're fine with the result, could you please ack 02/18 ? I will then
ask Simon to take the patches in his tree.

Changes since v5:

- Dropped generic pinconf support
- Dropped kzm9g-reference patches, as those require pinconf support

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

Laurent Pinchart (18):
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
  ARM: shmobile: marzen-reference: Move pinctrl mappings to device tree
  ARM: shmobile: marzen-reference: Add LED2-LED4 to the device tree

 .../bindings/pinctrl/renesas,pfc-pinctrl.txt       | 135 +++++++++++++++++++++
 arch/arm/boot/dts/r8a73a4.dtsi                     |   7 ++
 .../boot/dts/r8a7740-armadillo800eva-reference.dts |  34 ++++++
 arch/arm/boot/dts/r8a7740.dtsi                     |   8 ++
 arch/arm/boot/dts/r8a7778.dtsi                     |  56 +++++++++
 arch/arm/boot/dts/r8a7779-marzen-reference.dts     |  49 ++++++++
 arch/arm/boot/dts/r8a7779.dtsi                     |  76 ++++++++++++
 arch/arm/boot/dts/r8a7790.dtsi                     |  66 ++++++++++
 arch/arm/boot/dts/sh7372.dtsi                      |   8 ++
 arch/arm/boot/dts/sh73a0.dtsi                      |   8 ++
 .../board-armadillo800eva-reference.c              |  18 +--
 arch/arm/mach-shmobile/board-kzm9g-reference.c     |  27 ++---
 arch/arm/mach-shmobile/board-marzen-reference.c    |  28 -----
 drivers/pinctrl/sh-pfc/core.c                      |  65 +++++++++-
 drivers/pinctrl/sh-pfc/pinctrl.c                   | 116 ++++++++++++++++++
 15 files changed, 640 insertions(+), 61 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt

-- 
Regards,

Laurent Pinchart
