From: jm@lentin.co.uk (Jamie Lentin)
Date: Fri, 26 Aug 2016 10:20:56 +0100
Subject: [PATCH 0/8] Convert Netgear WNR854T to devicetree
In-Reply-To: <1468679348-10522-1-git-send-email-jm@lentin.co.uk>
References: <1468679348-10522-1-git-send-email-jm@lentin.co.uk>
Message-ID: <1472203264-21089-1-git-send-email-jm@lentin.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is an attempt to resurrect the mainline WNR854T support and
convert to device tree. The major change since v0 is the embedded
ethernet switch is now functional, thanks to Andrew Lunn, making the
device actually useful. Full list of changes:

* The DT definition for the switch in this patchset has changed to
match the 88e6131 DSA driver currently in net-next, and all
now-superflous attempts at fixing up the DSA driver have been removed
from this patchset.

* Use Flash partition scheme from original netgear Linux image (but
keeping the uboot/uboot_env split) instead of the partition scheme from
the old non-DT support, which didn't match either Netgear's layout,
u-boot or openWRT. NB: I've no copy of the original flash contents
(Netgear's firmware images only contain a squashfs image of the rootfs),
so I can't confirm the other partitions are accurately named.

* Set NOR Flash bank-width to correct value

* Reassign defconfig entries pointing at CONFIG_MACH_WNR854T (old
non-DT support) to CONFIG_MACH_WNR854T_DT

* Move eth0 pinctrl definitions and assignment to
orion5x-mv88f5181.dtsi [Andrew Lunn]

* Get the copyright year right [Rob Herring]

* Reformat pinctrl docs to one-compatible-string-per-line [Rob Herring]

* Rename reset button pinctrl to pmx_reset_button [Andrew Lunn]

* Move pmx_ge pinctrl definition to SoC include [Andrew Lunn]

* Put flash partitions into their own node [Andrew Lunn]

* Make LED names standards-compliant [Andrew Lunn]

* Use standard stdout-path definition for bootargs [Andrew Lunn]

The patches are also available at https://github.com/lentinj/linux
wnr854t-support-v1 - this is based on net-next to use in the
88e6131 changes there, and applies the patch in
https://lkml.org/lkml/2016/8/3/93 to allow the device to boot.

Thanks,

Jamie Lentin (8):
  arm: orion5x: Add documentation for SoC and board bindings
  arm: orion5x: Add clk support for mv88f5181
  arm: orion5x: Generalise mv88f5181l pinctrl support for 88f5181
  arm: orion5x: Alias uart0 to serial0 for all orion5x
  arm: orion5x: Add DT include for mv88f5181
  arm: orion5x: Add DT-based support for Netgear WNR854T
  arm: orion5x: Remove old non-DT-based WNR854T support
  arm: orion5x: Configure WNR854T ethernet PHY LEDs

 .../bindings/arm/marvell/marvell,orion5x.txt       |  25 ++
 .../devicetree/bindings/clock/mvebu-core-clock.txt |   1 +
 .../bindings/pinctrl/marvell,orion-pinctrl.txt     |   4 +-
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/orion5x-mv88f5181.dtsi           |  49 ++++
 arch/arm/boot/dts/orion5x-netgear-wnr854t.dts      | 263 +++++++++++++++++++++
 arch/arm/boot/dts/orion5x.dtsi                     |   1 +
 arch/arm/configs/multi_v5_defconfig                |   2 +-
 arch/arm/configs/mvebu_v5_defconfig                |   2 +-
 arch/arm/configs/orion5x_defconfig                 |   2 +-
 arch/arm/mach-orion5x/Kconfig                      |   4 +-
 arch/arm/mach-orion5x/Makefile                     |   2 +-
 arch/arm/mach-orion5x/board-wnr854t.c              |  78 ++++++
 arch/arm/mach-orion5x/wnr854t-setup.c              | 185 ---------------
 drivers/clk/mvebu/orion.c                          |  70 ++++++
 drivers/pinctrl/mvebu/pinctrl-orion.c              |  23 +-
 16 files changed, 509 insertions(+), 203 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/marvell/marvell,orion5x.txt
 create mode 100644 arch/arm/boot/dts/orion5x-mv88f5181.dtsi
 create mode 100644 arch/arm/boot/dts/orion5x-netgear-wnr854t.dts
 create mode 100644 arch/arm/mach-orion5x/board-wnr854t.c
 delete mode 100644 arch/arm/mach-orion5x/wnr854t-setup.c

-- 
2.8.1
