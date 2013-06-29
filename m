From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Sat, 29 Jun 2013 16:04:03 -0300
Subject: [PATCH v5 00/12] MBus DT binding: A new hope
Message-ID: <1372532655-20321-1-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

See the previous version of this patchset for further context:

http://www.spinics.net/lists/arm-kernel/msg253342.html

This is a new proposal, in an attempt to fix some obscurities in
the previous MBus DT binding proposal.

In the current proposal we have now required a 'controller' property
to specify the MBus controller MMIO registers. To us this looks more
appropriate, since the MBus registers are effectively located within
the internal register region, behind the so-called internal-regs window.

Personally, I can't see any disadvantage, and the binding looks much
cleaner now. But of course I can be wrong, and I'm open to discussion.

There's another pending issue. Arnd Bergmann has required to add a
property to specify the available space within the CPU address space
for decoding windows. This property would allow to support fully
dynamic mbus window allocation.

For now, this property is intentionally missing, and I expect that
it can be added in the future, together with the full-dynamic MBus
implementation.

@Arnd, @Jason:
Given the v4 patchset didn't receive any comments but wasn't accepted either,
I'd like to know which other pending issues I'm forgetting to address.

As usual, comments and feedback more than welcome. Thanks!

Ezequiel Garcia (12):
  bus: mvebu-mbus: Factor out initialization details
  bus: mvebu-mbus: Introduce device tree binding
  bus: mvebu-mbus: Add static window allocation to the DT binding
  ARM: mvebu: Initialize MBus using the DT binding
  ARM: mvebu: Remove the harcoded BootROM window allocation
  memory: mvebu-devbus: Remove address decoding window workaround
  ARM: mvebu: Use the preprocessor on Armada 370/XP device tree files
  ARM: mvebu: Add MBus to Armada 370/XP device tree
  ARM: mvebu: Add BootROM to Armada 370/XP device tree
  ARM: mvebu: Relocate Armada 370/XP DeviceBus device tree nodes
  ARM: mvebu: Relocate Armada 370 PCIe device tree nodes
  ARM: mvebu: Relocate Armada XP PCIe device tree nodes

 .../devicetree/bindings/bus/mvebu-mbus.txt         | 256 ++++++++++++++
 arch/arm/boot/dts/armada-370-db.dts                |   5 +-
 arch/arm/boot/dts/armada-370-mirabox.dts           |  38 ++-
 arch/arm/boot/dts/armada-370-rd.dts                |   5 +-
 arch/arm/boot/dts/armada-370-xp.dtsi               | 109 +++---
 arch/arm/boot/dts/armada-370.dtsi                  | 108 +++---
 arch/arm/boot/dts/armada-xp-db.dts                 |  72 ++--
 arch/arm/boot/dts/armada-xp-gp.dts                 | 108 +++---
 arch/arm/boot/dts/armada-xp-mv78230.dtsi           | 209 ++++++------
 arch/arm/boot/dts/armada-xp-mv78260.dtsi           | 247 +++++++-------
 arch/arm/boot/dts/armada-xp-mv78460.dtsi           | 379 +++++++++++----------
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts   |  84 ++---
 arch/arm/boot/dts/armada-xp.dtsi                   |   9 +-
 arch/arm/mach-mvebu/armada-370-xp.c                |  34 +-
 arch/arm/mach-mvebu/platsmp.c                      |  25 +-
 drivers/bus/mvebu-mbus.c                           | 209 +++++++++++-
 drivers/memory/mvebu-devbus.c                      |  64 +---
 include/linux/mbus.h                               |   1 +
 18 files changed, 1186 insertions(+), 776 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/bus/mvebu-mbus.txt

-- 
1.8.1.5
