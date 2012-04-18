From: jm@lentin.co.uk (Jamie Lentin)
Date: Wed, 18 Apr 2012 11:06:39 +0100
Subject: [PATCH V5 0/4] ARM: Kirkwood: Add support for DNS-320 and DNS-325
 using devicetree
Message-ID: <1334743603-8488-1-git-send-email-jm@lentin.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reworked patch for latest feedback. I'm still basing this on Jason Cooper's
tree, given how much time has passed should I be rebasing against something
else or is this still fine?

One thing I noticed is that with only the first patch applied (which no
longer calls kirkwood_nand_init) the device either locks up or serial console
dies at "Gating clock of unused units", presumably as CGC_RUNIT isn't set.
Is this something known or is it worth further investigation?

Thanks again to everyone reviewing.

Changes since v4: Convert DNS-325 & DNS-320 to access nand via devicetree
* Add initial support patch back in to address following comments
** One MACH_DLINK_KIRKWOOD_DT for all dtb files [Grant Likely, Jason Cooper]
** Drop brain-dead select "select CONFIG_MTD_OF_PARTS" [Grant Likely]
** Don't add NAND support then throw it away immediately after [Grant Likely]
* WARN when bank-width is out of range [Andrew Lunn]
* Describe purpose of MPP 41, 42 & 49

Changes since v3: Add support for DNS-320 and DNS-325 using devicetree
* Remove patches that are already merged
* Add documentation on orion_nand devicetree bindings
* Convert bank-width to be in bytes to match other properties
* Make defaults more explicit

Changes since v2: Add support for DNS-320 and DNS-325 using devicetree
* Split patches further, separating orion_nand and kirkwood changes
* dts renames: "bank-width", not "width". "okay", not "ok"
* Separate documentation out into separate patch, add references to
  partition.txt to all mtd bindings.

Changes since v1: Add support for DNS-320 and DNS-325 using devicetree
* Rebase against kirkwood_dt_for_3.4, removing premature devicetree ports.
* Move additions into a separate board-dnskw.c. It could be separated further
  into a board-dns320.c and board-dns325.c but it probably isn't worth it.
* s/marvell,/mrvl,/g
* Include an example dtb partition in documentation
* Copy structure of serial nodes to allow common options for NAND to be set
  in kirkwood.dtsi
* Simplifications in orion-nand.c

Jamie Lentin (4):
  ARM: kirkwood: Basic support for DNS-320 and DNS-325
  mtd: Add orion_nand devicetree bindings
  kirkwood: Allow nand to be configured via. devicetree
  ARM: kirkwood: Define DNS-320/DNS-325 NAND in fdt

 .../devicetree/bindings/mtd/orion-nand.txt         |   50 ++++
 arch/arm/boot/dts/kirkwood-dns320.dts              |   64 +++++
 arch/arm/boot/dts/kirkwood-dns325.dts              |   59 +++++
 arch/arm/boot/dts/kirkwood.dtsi                    |   15 +-
 arch/arm/mach-kirkwood/Kconfig                     |    8 +
 arch/arm/mach-kirkwood/Makefile                    |    1 +
 arch/arm/mach-kirkwood/Makefile.boot               |    2 +
 arch/arm/mach-kirkwood/board-dnskw.c               |  275 ++++++++++++++++++++
 arch/arm/mach-kirkwood/board-dt.c                  |    5 +
 arch/arm/mach-kirkwood/common.c                    |   12 +
 arch/arm/mach-kirkwood/common.h                    |    6 +
 drivers/mtd/nand/orion_nand.c                      |   45 +++-
 12 files changed, 539 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/orion-nand.txt
 create mode 100644 arch/arm/boot/dts/kirkwood-dns320.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-dns325.dts
 create mode 100644 arch/arm/mach-kirkwood/board-dnskw.c

-- 
1.7.9.1
