From: arno@natisbad.org (Arnaud Ebalard)
Date: Sun, 16 Nov 2014 18:36:47 +0100
Subject: [PATCHv2 0/8] arm: mvebu: add Synology DS213j and DS414 .dts files
Message-ID: <cover.1416158990.git.arno@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series adds .dts files for Synology DS213j (armada 370 2-bay NAS) and
DS414 (armada XP 4-bay NAS) devices. It is based on comments received on
a v0 submission of DS213j .dts file [1] and Andrew's comments on a v1 (
for both DS213j and DS414 .dts files) [2].

Following previous comments, I have also added in the set 5 additional
patches to:

 - add 'micron' in vendor-prefixes.txt (note: NASDAQ symbol is 'mu')
 - s/ssi/sii/ in kirkwood-synology.dtsi
 - use uart0 label in armada-xp-lenovo-ix4-300d.dts for stdout-path
 - move common UART0 and SPI0 pinctrl entries to armada-370.dtsi
 - move common Ge0/1 RGMII and SPI0 pinctrl entries to armada-xp-mv78230.dtsi

Cheers,

a+

[1]: http://thread.gmane.org/gmane.linux.drivers.devicetree/95401
[2]: http://thread.gmane.org/gmane.linux.drivers.devicetree/98830

Changes since v1:

- Added a patch to fix Seiko Instruments, Inc. prefix from "ssi" to
  "sii" for s35390 RTC chip in kirkwood-synology.dtsi as reported by
  Andrew
- Fixed DS414 and DS213j .dts files which had the same issue due to
  a blind copy-and-paste.
- Added a patch for armada-xp-lenovo-ix4-300d.dts to use uart alias
  for stdout-path, as suggested by Andrew.
- removed pinctrl properties for ethernet interface wrongly referencing
  a RGMII pin configuration: the PHY is connected using SGMII.
- moved some DS213j pinctrl entries (spi0, uart0) in armada-370.dtsi
- same thing for DS414 pinctrl entries (ge0/1, spi0) moved to
  armada-xp-mv78230.dtsi
- changed pinctrl nodes and labels to match naming convention found
  in .dtsi: pmx_*: pmx- changed to *_pin: -pin.
- same thing for DS414
- added a comment in the .dts file about DS414 being susceptible at
  boot when an USB/serial converter is connected to the UART pins.

Changes since v0:

- Added a comment at the beginning of DS213j and DS414j .dts file regarding
  the need for a recent Marvell bootloader. Arnd suggested to do a specific
  .dtb file for new and old bootloaders but I think if we follow this path
  for DS414 and DS213j, we will probably have to do it for all Armada-based
  synology NAS and possibly for other Armada 370/XP based devices. Opting
  for recent bootloaders config and having a comment is easier. It is likely
  that a user already has a recent bootloader. Otherwise, upgrade is a one
  click process anyway. If a user thinks it is easier to have two different
  .dts files in the kernel, she will still be able to push a patch.
- Added a comment in the .dts file about the bootloader screwing the kernel
  if the environment is saved.
- Kept GPL licence for .dts file
- Fixed bad naming of node and alias (_ vs -)
- Added micron vendor prefix for n25q064 flash
- Disabled SoC RTC; a Seiko S-35390A is used as main RTC
- Added comments about the purpose of each serial port
- Added stdout-path = &uart0; to help barebox. A specific patch is included
  in the series to provide labels for uart serial nodes
- Added patch for DS414 .dts file


Arnaud Ebalard (8):
  of: add "micron" vendor prefix for Micron
  arm: mvebu: fix vendor prefix typo in kirkwood-synology.dtsi
  arm: mvebu: add uartX labels for Armada SoC serial nodes
  arm: mvebu: use recently introduced uart label for stdout-path
  arm: mvebu: add common uart0 and spi0 pintcrl entries for Armada 370
  arm: mvebu: add common ge0/1 and spi0 pintcrl entries for Armada XP MV78230
  arm: mvebu: add .dts file for Synology DS213j
  arm: mvebu: add .dts file for Synology DS414

 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/boot/dts/Makefile                         |   6 +-
 arch/arm/boot/dts/armada-370-synology-ds213j.dts   | 323 ++++++++++++++++++++
 arch/arm/boot/dts/armada-370-xp.dtsi               |   5 +-
 arch/arm/boot/dts/armada-370.dtsi                  |  11 +
 arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts    |   2 +-
 arch/arm/boot/dts/armada-xp-mv78230.dtsi           |  20 ++
 arch/arm/boot/dts/armada-xp-synology-ds414.dts     | 332 +++++++++++++++++++++
 arch/arm/boot/dts/armada-xp.dtsi                   |   5 +-
 arch/arm/boot/dts/kirkwood-synology.dtsi           |   2 +-
 10 files changed, 699 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm/boot/dts/armada-370-synology-ds213j.dts
 create mode 100644 arch/arm/boot/dts/armada-xp-synology-ds414.dts

-- 
2.1.1
