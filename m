From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu, 22 Aug 2013 11:41:51 -0300
Subject: [PATCH 0/7] Orion watchdog DT changes to support more SoCs
Message-ID: <1377182518-12554-1-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As part of my work to add watchdog support to Armada 370/XP SoCs,
here's some early patches to get early feedback.

This patchset allows to build the orion_wdt driver in any Orion
platforms.

To achieve this it's necessary to remove the need for a mach-specific,
which in turn is done by splitting the single memory resource into
three memory resources: timer control, watchdog counter and RSTOUT registers;
and handling each of this resources as independent memory resources (as they
really are).

The only drawback with this approach is the breakage of devicetree backwards
compatibility such change produces. This is an important issue, and the main
reason I'm submitting this patchset: Is it possible to introduce such
DT-binding change?

It's worth noting that a similar was proposed in July-15th [1], which received
some acceptance [2].

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2013-July/183628.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2013-July/183857.html

Thanks!

Ezequiel Garcia (7):
  watchdog: orion: Remove unneeded BRIDGE_CAUSE clear
  watchdog: orion: Make counter register a separate resource
  watchdog: orion: Make RSTOUT register a separate resource
  watchdog: orion: Allow to build in any Orion platform
  ARM: kirkwood: Update watchdog 'reg' property
  watchdog: orion: Rename device-tree binding documentation
  watchdog: orion: Update device-tree binding documentation

 .../devicetree/bindings/watchdog/marvel.txt        | 19 ------------
 .../devicetree/bindings/watchdog/orion-wdt.txt     | 24 +++++++++++++++
 arch/arm/boot/dts/kirkwood.dtsi                    |  4 ++-
 arch/arm/mach-kirkwood/include/mach/bridge-regs.h  |  1 +
 arch/arm/plat-orion/common.c                       | 11 ++++---
 drivers/watchdog/Kconfig                           |  2 +-
 drivers/watchdog/orion_wdt.c                       | 35 ++++++++++++++--------
 7 files changed, 59 insertions(+), 37 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/watchdog/marvel.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/orion-wdt.txt

-- 
1.8.1.5
